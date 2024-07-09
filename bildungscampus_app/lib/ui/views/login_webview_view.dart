import 'dart:developer';
import 'dart:io';

import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:bildungscampus_app/core/models/info/external_link.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/views/feature_view.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebViewView extends StatefulWidget {
  final String titleBackup;
  final ExternalLink? externalLink;
  final FeatureType? featureType;
  final String currentNavigation;

  const LoginWebViewView({
    super.key,
    required this.titleBackup,
    required this.externalLink,
    required this.featureType,
    required this.currentNavigation,
  });
  @override
  State<LoginWebViewView> createState() => _LoginWebViewViewState();
}

class _LoginWebViewViewState extends State<LoginWebViewView> {
  final _key = UniqueKey();
  final auth = LocalAuthentication();

  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  late final WebViewController _controller;
  late final String? url;

  final loginPageUrlPart = "user-ui-bc/login";
  final loggingUrlPart = "authz-srv/authz";

  Future<void> useBiometricWhenActivated() async {
    final navigator = Navigator.of(context);
    final userModel = context.read<UserViewModel>();
    final localized = S.of(context);
    final useBiometricLoginActivated = userModel.useBiometricLoginActivated;

    if (!useBiometricLoginActivated) {
      return;
    }

    try {
      final biometricSupported = await auth.isDeviceSupported();
      log("Biometric supported: $biometricSupported");

      if (!biometricSupported) {
        return;
      }

      final canCheckBiometric = await auth.canCheckBiometrics;
      log("Biometric supported: $canCheckBiometric");

      if (canCheckBiometric) {
        final authenticated = await auth.authenticate(
          localizedReason: localized.login_view_biometric_authenticate_reason,
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );

        if (!authenticated) {
          navigator.pushReplacementNamed(AppRouter.homeRoute);

          return;
        }
      }
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  Future<void> refreshTokenAndLoadRequest() async {
    final userViewModel = context.read<UserViewModel>();
    await userViewModel.refreshAccessTokenAndCookie();

    final headers = getHeadersFromSSoCookie(userViewModel.ssoCookie);
    log("headers: $headers");

    await _controller.loadRequest(Uri.parse(url!), headers: headers);
  }

  Map<String, String> getHeadersFromSSoCookie(String? userSsoCookie) {
    Cookie? ssoCookie = userSsoCookie != null && userSsoCookie.isNotEmpty
        ? Cookie.fromSetCookieValue(userSsoCookie)
        : null;
    Cookie? ssoCookie2 = userSsoCookie != null && userSsoCookie.isNotEmpty
        ? Cookie.fromSetCookieValue(userSsoCookie)
        : null;

    ssoCookie2?.name = "cidaas_rl";

    return userSsoCookie != null ? {'cookie': '$ssoCookie;$ssoCookie2'} : {};
  }

  @override
  void initState() {
    super.initState();

    final locale = Provider.of<UserViewModel>(context, listen: false).locale;
    url = widget.externalLink != null
        ? LocalizedTextUtils.getLocalizedText(widget.externalLink!.link, locale)
        : null;

    log('url: $url');

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            log(progress.toString());
          },
          onPageStarted: (String url) {
            log(url);
          },
          onPageFinished: (String url) {
            log(url);
            log('onPageFinished');
            isLoading.value = false;
          },
          onWebResourceError: (WebResourceError error) {
            log('web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            log('req: ${request.url}');
            log('wid: $url');
            isLoading.value = true;
            final uri = Uri.parse(url!);

            if (request.url.contains(uri.host) ||
                request.url.contains(loggingUrlPart)) {
              log("navigated");

              return NavigationDecision.navigate;
            }

            if (request.url.contains(loginPageUrlPart)) {
              Navigator.of(context).pushReplacementNamed(AppRouter.loginRoute,
                  arguments: widget.currentNavigation);

              return NavigationDecision.prevent;
            }

            log("prevent");
            return NavigationDecision.prevent;
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final appViewModel = context.read<AppViewModel>();
    final List<LocalizedText> titleList = widget.featureType != null
        ? appViewModel.getAppMenuTitle(widget.featureType!)
        : [];

    final locale = context.select((UserViewModel model) => model.locale);
    var title = LocalizedTextUtils.getLocalizedText(titleList, locale);
    if (title.isEmpty) {
      title = widget.titleBackup;
    }

    return Scaffold(
      appBar: ReusableAppBars.standardAppBar(
        context,
        title,
      ),
      body: FutureBuilder<void>(
        future: useBiometricWhenActivated(),
        builder: (context, result) {
          if (result.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return FeatureView(
            featureType: widget.featureType,
            children: [
              if (url != null)
                WebViewWidget(key: _key, controller: _controller),
              ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (_, bool isLoading, Widget? child) {
                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              if (url != null)
                FutureBuilder(
                  builder: (context, _) => const SizedBox.shrink(),
                  future: refreshTokenAndLoadRequest(),
                )
            ],
          );
        },
      ),
    );
  }
}

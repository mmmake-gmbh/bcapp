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
import 'package:url_launcher/url_launcher_string.dart';
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
  final ValueNotifier<bool> isError = ValueNotifier(false);
  late final WebViewController _controller;
  late final String? url;

  final loginPageUrlPart = "user-ui-bc/login";
  final loggingUrlPart = "authz-srv/authz";

  static const logoutHost = "bildungscampus.life";
  final logoutUrl = "docs.bildungscampus.life/display/PORTAL";
  final externalUrlDomain = "bildungscampus.hn";

  static const double minChildSize = 0.11;

  final ValueNotifier<double> _sheetPosition = ValueNotifier(minChildSize);
  final ValueNotifier<List<String>> logsValue = ValueNotifier([]);

  Future<bool> useBiometricWhenActivated() async {
    final navigator = Navigator.of(context);
    final userModel = context.read<UserViewModel>();
    final localized = S.of(context);
    final useBiometricLoginActivated = userModel.useBiometricLoginActivated;

    if (!useBiometricLoginActivated) {
      return false;
    }

    try {
      final biometricSupported = await auth.isDeviceSupported();
      log("Biometric supported: $biometricSupported");

      if (!biometricSupported) {
        return false;
      }

      final canCheckBiometric = await auth.canCheckBiometrics;
      log("Biometric can check: $canCheckBiometric");

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

          return false;
        }

        await refreshTokenAndCookie();

        return true;
      }

      return false;
    } on PlatformException catch (e) {
      log(e.toString());

      return false;
    }
  }

  Future<void> refreshTokenAndCookie() async {
    final userViewModel = context.read<UserViewModel>();
    if (userViewModel.useBiometricLoginActivated &&
        userViewModel.isAccessTokenExpired()) {
      await userViewModel.refreshAccessTokenAndCookie();
    }
  }

  Future<void> loadRequest() async {
    isError.value = false;
    final userViewModel = context.read<UserViewModel>();

    final headers = getHeadersFromSSoCookie(userViewModel.ssoCookie);
    log("headers: $headers");
    logsValue.value = [...logsValue.value, "headers: $headers"];

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

    var additionalHosts = [logoutHost];
    if (widget.externalLink != null &&
        widget.externalLink!.whitelistUrls.isNotEmpty) {
      additionalHosts = [
        ...widget.externalLink!.whitelistUrls,
        ...additionalHosts
      ];

      //log("whitelist: $additionalHosts");
    }

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
            logsValue.value = [
              ...logsValue.value,
              "onError: ${error.description}"
            ];
            isLoading.value = false;
            isError.value = true;
          },
          onNavigationRequest: (NavigationRequest request) {
            log('req: ${request.url}');
            log('wid: $url');
            logsValue.value = [...logsValue.value, "reqUrl: ${request.url}"];

            isLoading.value = true;
            final uri = Uri.parse(url!);

            if (request.url.contains(loginPageUrlPart)) {
              log('NavigationUrl found! Redirecting to login Page and logging out!');

              context
                  .read<UserViewModel>()
                  .logout(alreadyLoggedOut: true)
                  .then((logoutReturn) {
                if (mounted) {
                  Navigator.of(context).pushReplacementNamed(
                      AppRouter.loginRoute,
                      arguments: widget.currentNavigation);
                }
              });

              return NavigationDecision.prevent;
            }

            if (request.url.contains(logoutUrl)) {
              context
                  .read<UserViewModel>()
                  .logout(alreadyLoggedOut: true)
                  .then((logoutReturn) {
                if (mounted) {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRouter.homeRoute);
                }
              });

              return NavigationDecision.prevent;
            }

            if (Uri.parse(request.url).host.contains(externalUrlDomain)) {
              log("external");

              launchUrlString(request.url);

              return NavigationDecision.prevent;
            }

            if (request.url.contains(uri.host) ||
                request.url.contains(loggingUrlPart) ||
                additionalHosts.any(
                    (host) => Uri.parse(request.url).host.contains(host))) {
              log("navigated");

              return NavigationDecision.navigate;
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
      body: FutureBuilder<bool>(
        future: useBiometricWhenActivated(),
        builder: (context, result) {
          if (result.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (result.hasData && result.data == false) {
            return const Center(child: Text("Not allowed on the page!"));
          }

          return Stack(
            children: [
              FeatureView(
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
                  ValueListenableBuilder(
                    valueListenable: isError,
                    builder: (_, bool isError, Widget? child) {
                      if (isError) {
                        return const Center(
                          child: Icon(
                            Icons.error_outline,
                            size: 60,
                            color: Colors.red,
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                  if (url != null)
                    FutureBuilder(
                      builder: (context, _) => const SizedBox.shrink(),
                      future: loadRequest(),
                    )
                ],
              ),
              ValueListenableBuilder(
                valueListenable: _sheetPosition,
                builder: (context, sheetPosition, _) =>
                    DraggableScrollableSheet(
                  maxChildSize: 0.8,
                  initialChildSize: sheetPosition,
                  minChildSize: minChildSize,
                  snap: true,
                  builder: (BuildContext context,
                          ScrollController scrollController) =>
                      Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.grey.shade100,
                    child: Column(
                      children: [
                        Grabber(
                          onVerticalDragUpdate: (DragUpdateDetails details) {
                            _sheetPosition.value -= details.delta.dy / 600;
                            if (_sheetPosition.value < minChildSize) {
                              _sheetPosition.value = minChildSize;
                            }
                            if (_sheetPosition.value > 0.8) {
                              _sheetPosition.value = 0.8;
                            }
                          },
                        ),
                        Expanded(
                          child: ValueListenableBuilder(
                            valueListenable: logsValue,
                            builder: (context, logs, _) => ListView.builder(
                              itemCount: logs.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(logs[index]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class Grabber extends StatelessWidget {
  const Grabber({
    super.key,
    required this.onVerticalDragUpdate,
  });

  final ValueChanged<DragUpdateDetails> onVerticalDragUpdate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: SizedBox(
        width: double.infinity,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: 32.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}

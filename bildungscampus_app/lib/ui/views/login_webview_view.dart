import 'dart:developer';
import 'dart:io';

import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/views/feature_view.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/app_drawer.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebViewView extends StatefulWidget {
  final String titleBackup;
  final String? url;
  final FeatureType? featureType;
  final bool showDrawer;

  const LoginWebViewView(
      {super.key,
      required this.titleBackup,
      required this.url,
      required this.featureType,
      this.showDrawer = true});
  @override
  State<LoginWebViewView> createState() => _LoginWebViewViewState();
}

class _LoginWebViewViewState extends State<LoginWebViewView> {
  final _key = UniqueKey();
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  late Map<String, String> headers;
  late final WebViewController _controller;

  final loginPageUrlPart = "user-ui-bc/login";
  final loggingUrlPart = "authz-srv/authz";

  @override
  void initState() {
    super.initState();

    final userViewModel = context.read<UserViewModel>();
    log('userViewModel: ${userViewModel.ssoCookie == null}');
    Cookie? ssoCookie =
        userViewModel.ssoCookie != null && userViewModel.ssoCookie!.isNotEmpty
            ? Cookie.fromSetCookieValue(userViewModel.ssoCookie!)
            : null;
    Cookie? ssoCookie2 =
        userViewModel.ssoCookie != null && userViewModel.ssoCookie!.isNotEmpty
            ? Cookie.fromSetCookieValue(userViewModel.ssoCookie!)
            : null;

    ssoCookie2?.name = "cidaas_rl";

    headers = userViewModel.ssoCookie != null
        ? {'cookie': '$ssoCookie;$ssoCookie2'}
        : {};

    log("headers: $headers");

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
            isLoading.value = false;
          },
          onWebResourceError: (WebResourceError error) {
            log('web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            log('req: ${request.url}');
            log('wid: ${widget.url}');
            final uri = Uri.parse(widget.url!);

            if (request.url.contains(uri.host) ||
                request.url.contains(loggingUrlPart)) {
              log("navigated");

              return NavigationDecision.navigate;
            }

            if (request.url.contains(loginPageUrlPart)) {
              Navigator.of(context).pushReplacementNamed(AppRouter.loginRoute);

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
      drawer: widget.showDrawer ? const AppDrawer() : null,
      body: FeatureView(
        featureType: widget.featureType,
        children: [
          if (widget.url != null)
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
          FutureBuilder(
            builder: (context, _) => const SizedBox.shrink(),
            future: _controller.loadRequest(Uri.parse(widget.url!),
                headers: headers),
          )
        ],
      ),
    );
  }
}

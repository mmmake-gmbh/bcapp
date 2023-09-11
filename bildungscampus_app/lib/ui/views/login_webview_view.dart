import 'dart:developer';

import 'package:bildungscampus_app/ui/app_router.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/app_drawer.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebViewView extends StatefulWidget {
  final String title;
  final String url;
  final Map<String, String> headers;

  const LoginWebViewView(
      {Key? key, required this.title, required this.url, required this.headers})
      : super(key: key);
  @override
  State<LoginWebViewView> createState() => _LoginWebViewViewState();
}

class _LoginWebViewViewState extends State<LoginWebViewView> {
  final _key = UniqueKey();
  bool isLoading = true;
  late final WebViewController _controller;

  final loginPageUrlPart = "user-ui-bc/login";
  final loggingUrlPart = "authz-srv/authz";

  @override
  void initState() {
    super.initState();

    log("headers: ${widget.headers}");

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
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            log('web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            log('req: ${request.url}');
            log('wid: ${widget.url}');
            final uri = Uri.parse(widget.url);

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
      )
      ..loadRequest(Uri.parse(widget.url), headers: widget.headers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBars.standardAppBar(
        context,
        widget.title,
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          WebViewWidget(key: _key, controller: _controller),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

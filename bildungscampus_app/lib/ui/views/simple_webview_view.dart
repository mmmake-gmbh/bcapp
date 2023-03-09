import 'dart:developer';

import 'package:bildungscampus_app/ui/widgets/navigation/app_drawer.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SimpleWebViewView extends StatefulWidget {
  final String title;
  final String url;

  const SimpleWebViewView({Key? key, required this.title, required this.url})
      : super(key: key);
  @override
  State<SimpleWebViewView> createState() => _SimpleWebViewViewState();
}

class _SimpleWebViewViewState extends State<SimpleWebViewView> {
  final _key = UniqueKey();
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

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
            uri.host;
            if (request.url.contains(uri.host)) {
              log("navigated");

              return NavigationDecision.navigate;
            }
            log("prevent");
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
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

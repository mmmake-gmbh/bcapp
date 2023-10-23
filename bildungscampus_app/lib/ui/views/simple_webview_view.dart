import 'dart:developer';

import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/ui/views/feature_view.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/app_drawer.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SimpleWebViewView extends StatefulWidget {
  final String title;
  final String url;
  final Map<String, String> headers;
  final String? additionalUrl;
  final FeatureType featureType;

  const SimpleWebViewView(
      {Key? key,
      required this.featureType,
      required this.title,
      required this.url,
      required this.headers,
      this.additionalUrl})
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
            uri.host;
            if (request.url.contains(uri.host) ||
                (widget.additionalUrl != null &&
                    request.url
                        .contains(Uri.parse(widget.additionalUrl!).host))) {
              log("navigated");

              return NavigationDecision.navigate;
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
      body: FeatureView(
        featureType: widget.featureType,
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

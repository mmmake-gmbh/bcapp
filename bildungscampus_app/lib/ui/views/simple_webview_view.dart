import 'dart:developer';

import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/models/info/external_link.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/views/feature_view.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SimpleWebViewView extends StatefulWidget {
  final String title;
  final ExternalLink? externalLink;
  final Map<String, String> headers;
  final String? additionalUrl;
  final bool showDrawer;
  final FeatureType featureType;

  const SimpleWebViewView(
      {super.key,
      required this.featureType,
      required this.title,
      required this.externalLink,
      required this.headers,
      this.additionalUrl,
      this.showDrawer = true});
  @override
  State<SimpleWebViewView> createState() => _SimpleWebViewViewState();
}

class _SimpleWebViewViewState extends State<SimpleWebViewView> {
  final _key = UniqueKey();
  bool isLoading = true;
  late final WebViewController _controller;
  late final String? url;

  @override
  void initState() {
    super.initState();

    final locale = Provider.of<UserViewModel>(context, listen: false).locale;
    url = (widget.externalLink != null)
        ? LocalizedTextUtils.getLocalizedText(widget.externalLink!.link, locale)
        : null;

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
            log('wid: $url');
            final uri = Uri.parse(url!);
            uri.host;
            if (request.url.contains(uri.host) ||
                (widget.additionalUrl != null &&
                    request.url
                        .contains(Uri.parse(widget.additionalUrl!).host))) {
              log("navigated");

              return NavigationDecision.navigate;
            }
            if (widget.externalLink!.openExternalInBrowser) {
              log("open in a browser");
              launchUrlString(request.url);

              return NavigationDecision.prevent;
            }
            log("prevent");
            return NavigationDecision.prevent;
          },
        ),
      );

    if (url != null) {
      _controller.loadRequest(Uri.parse(url!), headers: widget.headers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBars.standardAppBar(
        context,
        widget.title,
      ),
      resizeToAvoidBottomInset: false,
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

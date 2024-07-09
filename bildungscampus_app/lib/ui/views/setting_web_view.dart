import 'package:bildungscampus_app/core/models/info/external_link.dart';
import 'package:bildungscampus_app/ui/views/login_webview_view.dart';
import 'package:flutter/material.dart';

class SettingWebView extends StatelessWidget {
  final ExternalLink? externalLink;
  final String? title;
  final String currentNavigation;

  const SettingWebView({
    super.key,
    required this.externalLink,
    required this.title,
    required this.currentNavigation,
  });

  @override
  Widget build(BuildContext context) {
    return LoginWebViewView(
      featureType: null,
      titleBackup: title!,
      externalLink: externalLink,
      currentNavigation: currentNavigation,
    );
  }
}

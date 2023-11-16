import 'package:bildungscampus_app/ui/views/login_webview_view.dart';
import 'package:flutter/material.dart';

class SettingWebView extends StatelessWidget {
  final String? url;
  final String? title;

  const SettingWebView({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginWebViewView(
      featureType: null,
      titleBackup: title!,
      url: url!,
      showDrawer: false,
    );
  }
}

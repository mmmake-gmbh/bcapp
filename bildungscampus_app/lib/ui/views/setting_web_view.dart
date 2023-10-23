import 'dart:io';

import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/views/login_webview_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingWebView extends StatelessWidget {
  final String? url;
  final String? title;

  const SettingWebView({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.read<UserViewModel>();
    Cookie? ssoCookie =
        userViewModel.ssoCookie != null || userViewModel.ssoCookie!.isNotEmpty
            ? Cookie.fromSetCookieValue(userViewModel.ssoCookie!)
            : null;
    Cookie? ssoCookie2 =
        userViewModel.ssoCookie != null || userViewModel.ssoCookie!.isNotEmpty
            ? Cookie.fromSetCookieValue(userViewModel.ssoCookie!)
            : null;

    ssoCookie2?.name = "cidaas_rl";

    if (url == null || title == null) {
      return const SizedBox.shrink();
    }

    return LoginWebViewView(
      featureType: FeatureType.payment,
      title: title!,
      url: url!,
      headers: {'cookie': '$ssoCookie;$ssoCookie2'},
      showDrawer: false,
    );
  }
}

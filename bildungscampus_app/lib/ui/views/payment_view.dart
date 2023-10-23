import 'dart:io';

import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/views/login_webview_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appViewModel = context.read<AppViewModel>();
    final url = appViewModel.paymentLink;

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

    if (url == null || ssoCookie == null) {
      return const SizedBox.shrink();
    }

    final titleList = appViewModel.getAppMenuTitle(FeatureType.payment);

    final locale = context.select((UserViewModel model) => model.locale);
    var title = LocalizedTextUtils.getLocalizedText(titleList, locale);
    if (title.isEmpty) {
      title = S.of(context).payment_view_title_backup;
    }

    return LoginWebViewView(
      featureType: FeatureType.payment,
      title: title,
      url: url,
      headers: {'cookie': '$ssoCookie;$ssoCookie2'},
    );
  }
}

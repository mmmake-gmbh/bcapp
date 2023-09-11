import 'package:bildungscampus_app/core/enums/app_menu_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/ui/views/simple_webview_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationMapView extends StatelessWidget {
  const LocationMapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url =
        Provider.of<AppViewModel>(context, listen: false).locationMapLink;
    final title = Provider.of<AppViewModel>(context, listen: false)
            .getAppMenuTitle(AppMenuType.locationMap) ??
        S.of(context).map_view_title_backup;
    if (url == null) {
      return const SizedBox.shrink();
    }
    return SimpleWebViewView(
      title: title,
      url: url,
      headers: const {},
    );
  }
}

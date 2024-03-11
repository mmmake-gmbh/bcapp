import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/mensa_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/ui/views/feature_view.dart';
import 'package:bildungscampus_app/ui/widgets/mensa/mensa_content.dart';
import 'package:bildungscampus_app/ui/widgets/mensa/mensa_info_dialog_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MensaView extends StatefulWidget {
  const MensaView({super.key});

  @override
  State<MensaView> createState() => _MensaViewState();
}

class _MensaViewState extends State<MensaView> {
  late final Future<void> Function() loadFuture;

  @override
  void initState() {
    super.initState();

    loadFuture = context.read<MensaViewModel>().load;
  }

  @override
  Widget build(BuildContext context) {
    final titleList =
        context.read<AppViewModel>().getAppMenuTitle(FeatureType.mensa);

    final locale = context.select((UserViewModel model) => model.locale);
    var title = LocalizedTextUtils.getLocalizedText(titleList, locale);
    if (title.isEmpty) {
      title = S.of(context).mensa_view_title_backup;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mensaBgColor,
        title: Transform.translate(
          offset: const Offset(0, -2),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final appBarHeight = AppBar().preferredSize.height;
              showDialog(
                context: context,
                builder: (context) => Dialog.fullscreen(
                  child: MensaInfoDialogContent(
                    appBarHeight: appBarHeight,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
          )
        ],
        titleSpacing: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: null,
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: loadFuture(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return FeatureView(
            featureType: FeatureType.mensa,
            children: [
              MensaContent(
                initialIndex:
                    context.read<MensaViewModel>().initialDayPlanIndex,
              )
            ],
          );
        },
      ),
    );
  }
}

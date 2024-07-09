import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/views/simple_webview_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookSearchView extends StatelessWidget {
  const BookSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.select((UserViewModel model) => model.locale);
    final externalLink = context.read<AppViewModel>().bookSearchLink;
    final titleList =
        context.read<AppViewModel>().getAppMenuTitle(FeatureType.bookSearch);

    var title = LocalizedTextUtils.getLocalizedText(titleList, locale);
    if (title.isEmpty) {
      title = S.of(context).booksearch_view_title_backup;
    }

    if (externalLink == null) {
      return const SizedBox.shrink();
    }
    return SimpleWebViewView(
      featureType: FeatureType.bookSearch,
      title: title,
      externalLink: externalLink,
      headers: const {},
    );
  }
}

import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/intro.dart';
import 'package:bildungscampus_app/core/repositories/intro/intro_repository.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';
import 'package:flutter/material.dart';

class LocalIntroRepository implements IntroRepository {
  @override
  List<Intro> getAllIntroPages(BuildContext context) {
    final pages = [
      Intro(
        title: S.of(context).intro_overview_title,
        subtitle: '',
        imagePath: AppImages.introOverview,
        imageTitle: '',
      ),
      Intro(
        title: S.of(context).intro_overview2_title,
        subtitle: '',
        imagePath: AppImages.introOverview2,
        imageTitle: '',
      ),
    ];
    return pages;
  }
}

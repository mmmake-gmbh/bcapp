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
      Intro(
        title: S.of(context).intro_parkinglot_title,
        subtitle: S.of(context).intro_parkinglot_subtitle,
        imagePath: AppImages.introParkinglot,
        imageTitle: '',
      ),
      Intro(
        title: S.of(context).intro_timetable_title,
        subtitle: S.of(context).intro_timetable_subtitle,
        imagePath: AppImages.introTimetableMonitor,
        imageTitle: '',
      ),
      Intro(
        title: S.of(context).intro_booksearch_title,
        subtitle: S.of(context).intro_booksearch_subtitle,
        imagePath: AppImages.introBookSearch,
        imageTitle: '',
      ),
      Intro(
        title: S.of(context).intro_payment_title,
        subtitle: S.of(context).intro_payment_subtitle,
        imagePath: AppImages.introPayment,
        imageTitle: '',
      ),
      Intro(
        title: S.of(context).intro_map_title,
        subtitle: S.of(context).intro_map_subtitle,
        imagePath: AppImages.introMap,
        imageTitle: '',
      ),
    ];
    return pages;
  }
}

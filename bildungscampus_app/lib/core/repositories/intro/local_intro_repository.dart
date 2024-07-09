import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/models/common/intro.dart';
import 'package:bildungscampus_app/core/models/common/intro_card.dart';
import 'package:bildungscampus_app/core/repositories/intro/intro_repository.dart';
import 'package:flutter/material.dart';

class LocalIntroRepository implements IntroRepository {
  @override
  List<Intro> getAllIntroPages(BuildContext context) {
    final pages = [
      Intro(
        title: S.of(context).intro_overview_title,
        subtitle: '',
        cards: [
          IntroCard(
              title: S.of(context).intro_view_card_siteplan_title,
              text: S.of(context).intro_view_card_siteplan_text,
              icon: Icons.map_outlined),
          IntroCard(
              title: S.of(context).intro_view_card_mensa_title,
              text: S.of(context).intro_view_card_mensa_text,
              icon: Icons.restaurant_outlined),
          IntroCard(
              title: S.of(context).intro_view_card_payment_title,
              text: S.of(context).intro_view_card_payment_text,
              icon: Icons.person_outlined),
        ],
      ),
      Intro(
        title: S.of(context).intro_overview2_title,
        subtitle: '',
        cards: [
          IntroCard(
              title: S.of(context).intro_view_card_parking_title,
              text: S.of(context).intro_view_card_parking_text,
              icon: Icons.local_parking_outlined),
          IntroCard(
              title: S.of(context).intro_view_card_monitor_title,
              text: S.of(context).intro_view_card_monitor_text,
              icon: Icons.directions_bus_outlined),
          IntroCard(
              title: S.of(context).intro_view_card_booksearch_title,
              text: S.of(context).intro_view_card_booksearch_text,
              icon: Icons.auto_stories_outlined),
        ],
      ),
    ];
    return pages;
  }
}

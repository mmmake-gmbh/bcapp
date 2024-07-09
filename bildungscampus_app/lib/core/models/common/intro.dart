import 'package:bildungscampus_app/core/models/common/intro_card.dart';

class Intro {
  final String title;
  final String subtitle;
  final List<IntroCard> cards;

  Intro({
    required this.title,
    required this.subtitle,
    required this.cards,
  });
}

import 'package:bildungscampus_app/core/models/common/intro.dart';
import 'package:flutter/material.dart';

abstract class IntroRepository {
  List<Intro> getAllIntroPages(BuildContext context);
}

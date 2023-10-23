import 'dart:ui';

import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:collection/collection.dart';

class LocalizedTextUtils {
  static String getLocalizedText(List<LocalizedText> entries, Locale? locale) {
    if (entries.isEmpty) {
      return '';
    }

    if (locale != null) {
      final currentLang = entries.firstWhereOrNull((entry) =>
          entry.lang.toLowerCase() == locale.languageCode.toLowerCase());
      if (currentLang != null) {
        return currentLang.text;
      }
    }

    final germanLang =
        entries.firstWhereOrNull((entry) => entry.lang.toLowerCase() == 'de');
    if (germanLang != null) {
      return germanLang.text;
    }

    return entries.first.text;
  }
}

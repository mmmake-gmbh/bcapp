import 'dart:ui';

import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';

class ParkingLotPriceItem {
  final String title;
  final String description;

  ParkingLotPriceItem({
    required this.title,
    required this.description,
  });

  /// Returns a new [ParkingLot] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ParkingLotPriceItem fromJson(Map<String, dynamic> json) =>
      ParkingLotPriceItem(
        title: json[r'title'],
        description: json[r'description'],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}

class ParkingLotPriceItemV2 {
  final List<LocalizedText> title;
  final List<LocalizedText> description;

  ParkingLotPriceItemV2({
    required this.title,
    required this.description,
  });

  /// Returns a new [ParkingLot] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ParkingLotPriceItemV2 fromJson(Map<String, dynamic> json) =>
      ParkingLotPriceItemV2(
        title: List<LocalizedText>.from(
            json["title"].map((x) => LocalizedText.fromJson(x))),
        description: List<LocalizedText>.from(
            json[r'description'].map((x) => LocalizedText.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": List<dynamic>.from(title.map((x) => x.toJson())),
        "description": List<dynamic>.from(description.map((x) => x.toJson())),
      };

  String getTitle(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(title, locale);
  }

  String getDescription(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(description, locale);
  }
}

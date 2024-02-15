import 'dart:ui';

import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:bildungscampus_app/core/models/parking/parkinglot_priceitem.dart';
import 'package:bildungscampus_app/core/enums/parkinglot_light.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';

class ParkingLotBase {
  final int id;
  final int carParkNo;
  final List<ParkingLotCategory> categories;
  final int totalCapacity;
  final int usedCapacity;
  final int eAutoTotalCapacity;
  final int eAutoUsedCapacity;
  final int disabledTotalCapacity;
  final int disabledUsedCapacity;

  ParkingLotBase({
    required this.id,
    required this.carParkNo,
    required this.categories,
    required this.totalCapacity,
    required this.usedCapacity,
    required this.eAutoTotalCapacity,
    required this.eAutoUsedCapacity,
    required this.disabledTotalCapacity,
    required this.disabledUsedCapacity,
  });

  int get availableCapacity {
    var currentCapacity = totalCapacity - usedCapacity;
    if (currentCapacity < 0) {
      currentCapacity = 0;
    }
    return currentCapacity;
  }

  int get eAutoAvailableCapacity {
    var currentCapacity = eAutoTotalCapacity - eAutoUsedCapacity;
    if (currentCapacity < 0) {
      currentCapacity = 0;
    }
    return currentCapacity;
  }

  int get disabledAvailableCapacity {
    var currentCapacity = disabledTotalCapacity - disabledUsedCapacity;
    if (currentCapacity < 0) {
      currentCapacity = 0;
    }
    return currentCapacity;
  }

  ParkingLotLight get currentLight {
    if (totalCapacity <= 0) {
      return ParkingLotLight.none;
    }

    final procentualCapacity = availableCapacity / totalCapacity;
    if (procentualCapacity > 0.75) {
      return ParkingLotLight.green;
    } else if (procentualCapacity < 0.3) {
      return ParkingLotLight.red;
    } else {
      return ParkingLotLight.yellow;
    }
  }

  static ParkingLotCategory decodeCategory(String value) {
    switch (value) {
      case 'students':
        return ParkingLotCategory.students;
      case 'staff':
        return ParkingLotCategory.staff;
      case 'guests':
        return ParkingLotCategory.guests;
      default:
        return ParkingLotCategory.none;
    }
  }
}

class ParkingLot extends ParkingLotBase {
  final List<LocalizedText> title;
  final List<LocalizedText> subtitle;
  final String city;
  final String street;
  final List<LocalizedText> additionalInformation;
  final List<LocalizedText> openingHours;
  final List<LocalizedText> priceHeader;
  final List<ParkingLotPriceItemV2> priceItems;

  ParkingLot({
    required super.id,
    required super.carParkNo,
    required this.title,
    required this.subtitle,
    required super.categories,
    required this.city,
    required this.street,
    required this.additionalInformation,
    required this.openingHours,
    required this.priceHeader,
    required this.priceItems,
    required super.totalCapacity,
    required super.usedCapacity,
    required super.eAutoTotalCapacity,
    required super.eAutoUsedCapacity,
    required super.disabledTotalCapacity,
    required super.disabledUsedCapacity,
  });

  /// Returns a new [ParkingLot] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ParkingLot fromJson(Map<String, dynamic> json) => ParkingLot(
        id: json[r'id'],
        carParkNo: json[r'carParkNo'],
        title: List<LocalizedText>.from(
            json["title"].map((x) => LocalizedText.fromJson(x))),
        subtitle: List<LocalizedText>.from(
            json[r'subTitle'].map((x) => LocalizedText.fromJson(x))),
        categories: (json[r'categories'] as List)
            .map((value) => ParkingLotBase.decodeCategory(value))
            .toList(),
        city: json[r'city'],
        street: json[r'street'],
        additionalInformation: List<LocalizedText>.from(
            json[r'additionalInformation']
                .map((x) => LocalizedText.fromJson(x))),
        openingHours: List<LocalizedText>.from(
            json[r'openingHours'].map((x) => LocalizedText.fromJson(x))),
        priceHeader: List<LocalizedText>.from(
            json[r'priceHeader'].map((x) => LocalizedText.fromJson(x))),
        priceItems: (json[r'priceItems'] as List)
            .map((item) => ParkingLotPriceItemV2.fromJson(item))
            .toList(),
        totalCapacity: int.tryParse(json[r'totalCapacity'].toString()) ?? 0,
        usedCapacity: int.tryParse(json[r'usedCapacity'].toString()) ?? 0,
        eAutoTotalCapacity:
            int.tryParse(json[r'eAutoTotalCapacity'].toString()) ?? 0,
        eAutoUsedCapacity:
            int.tryParse(json[r'eAutoUsedCapacity'].toString()) ?? 0,
        disabledTotalCapacity:
            int.tryParse(json[r'disabledTotalCapacity'].toString()) ?? 0,
        disabledUsedCapacity:
            int.tryParse(json[r'disabledUsedCapacity'].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "carParkNo": carParkNo,
        "title": List<dynamic>.from(title.map((x) => x.toJson())),
        "subTitle": List<dynamic>.from(subtitle.map((x) => x.toJson())),
        "categories": categories.map((e) => e.name.toLowerCase()),
        "city": city,
        "street": street,
        "additionalInformation":
            List<dynamic>.from(additionalInformation.map((x) => x.toJson())),
        "openingHours": List<dynamic>.from(openingHours.map((x) => x.toJson())),
        "priceHeader": List<dynamic>.from(priceHeader.map((x) => x.toJson())),
        "priceItems": List<dynamic>.from(priceItems.map((x) => x.toJson())),
        "totalCapacity": totalCapacity,
        "usedCapacity": usedCapacity,
        "eAutoTotalCapacity": eAutoTotalCapacity,
        "eAutoUsedCapacity": eAutoUsedCapacity,
        "disabledTotalCapacity": disabledTotalCapacity,
        "disabledUsedCapacity": disabledUsedCapacity,
      };

  String getTitle(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(title, locale);
  }

  String getSubTitle(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(subtitle, locale);
  }

  String getAdditionalInformation(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(additionalInformation, locale);
  }

  String getOpeningHours(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(openingHours, locale);
  }

  String getPriceHeader(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(priceHeader, locale);
  }
}

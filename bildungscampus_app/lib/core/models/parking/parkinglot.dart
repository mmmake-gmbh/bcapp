import 'dart:ui';

import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:bildungscampus_app/core/models/parking/parkinglot_priceitem.dart';
import 'package:bildungscampus_app/core/enums/parkinglot_light.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';
import 'package:flutter/foundation.dart';

class ParkingLotBase {
  final int id;
  final int carParkNo;
  final List<ParkingLotCategory> categories;
  final int totalCapacity;
  final int usedCapacity;

  ParkingLotBase({
    required this.id,
    required this.carParkNo,
    required this.categories,
    required this.totalCapacity,
    required this.usedCapacity,
  });

  int get availableCapacity {
    var currentCapacity = totalCapacity - usedCapacity;
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
  final String title;
  final String? subtitle;
  final String city;
  final String street;
  final String? openingHours;
  final String priceHeader;
  final List<ParkingLotPriceItem> priceItems;

  ParkingLot({
    required super.id,
    required super.carParkNo,
    required this.title,
    this.subtitle,
    required super.categories,
    required this.city,
    required this.street,
    this.openingHours,
    required this.priceHeader,
    required this.priceItems,
    required super.totalCapacity,
    required super.usedCapacity,
  });

  /// Returns a new [ParkingLot] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ParkingLot fromJson(Map<String, dynamic> json) => ParkingLot(
        id: json[r'id'],
        carParkNo: json[r'carParkNo'],
        title: json[r'title'],
        subtitle: json[r'subTitle'],
        categories: (json[r'categories'] as List)
            .map((value) => decodeCategory(value))
            .toList(),
        city: json[r'city'],
        street: json[r'street'],
        openingHours: json[r'openingHours'],
        priceHeader: json[r'priceHeader'],
        priceItems: (json[r'priceItems'] as List)
            .map((item) => ParkingLotPriceItem.fromJson(item))
            .toList(),
        totalCapacity: int.tryParse(json[r'totalCapacity'].toString()) ?? 0,
        usedCapacity: int.tryParse(json[r'usedCapacity'].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "carParkNo": carParkNo,
        "title": title,
        "subTitle": subtitle,
        "categories": categories.map((e) => describeEnum(e).toLowerCase()),
        "city": city,
        "street": street,
        "openingHours": openingHours,
        "priceHeader": priceHeader,
        "priceItems": List<dynamic>.from(priceItems.map((x) => x.toJson())),
        "totalCapacity": totalCapacity,
        "usedCapacity": usedCapacity
      };

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

class ParkingLotV2 extends ParkingLotBase {
  final List<LocalizedText> title;
  final List<LocalizedText> subtitle;
  final String city;
  final String street;
  final List<LocalizedText> openingHours;
  final List<LocalizedText> priceHeader;
  final List<ParkingLotPriceItemV2> priceItems;

  ParkingLotV2({
    required super.id,
    required super.carParkNo,
    required this.title,
    required this.subtitle,
    required super.categories,
    required this.city,
    required this.street,
    required this.openingHours,
    required this.priceHeader,
    required this.priceItems,
    required super.totalCapacity,
    required super.usedCapacity,
  });

  /// Returns a new [ParkingLot] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ParkingLotV2 fromJson(Map<String, dynamic> json) => ParkingLotV2(
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
        openingHours: List<LocalizedText>.from(
            json[r'openingHours'].map((x) => LocalizedText.fromJson(x))),
        priceHeader: List<LocalizedText>.from(
            json[r'priceHeader'].map((x) => LocalizedText.fromJson(x))),
        priceItems: (json[r'priceItems'] as List)
            .map((item) => ParkingLotPriceItemV2.fromJson(item))
            .toList(),
        totalCapacity: int.tryParse(json[r'totalCapacity'].toString()) ?? 0,
        usedCapacity: int.tryParse(json[r'usedCapacity'].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "carParkNo": carParkNo,
        "title": List<dynamic>.from(title.map((x) => x.toJson())),
        "subTitle": List<dynamic>.from(subtitle.map((x) => x.toJson())),
        "categories": categories.map((e) => describeEnum(e).toLowerCase()),
        "city": city,
        "street": street,
        "openingHours": List<dynamic>.from(openingHours.map((x) => x.toJson())),
        "priceHeader": List<dynamic>.from(priceHeader.map((x) => x.toJson())),
        "priceItems": List<dynamic>.from(priceItems.map((x) => x.toJson())),
        "totalCapacity": totalCapacity,
        "usedCapacity": usedCapacity
      };

  String getTitle(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(title, locale);
  }

  String getSubTitle(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(subtitle, locale);
  }

  String getOpeningHours(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(openingHours, locale);
  }

  String getPriceHeader(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(priceHeader, locale);
  }
}

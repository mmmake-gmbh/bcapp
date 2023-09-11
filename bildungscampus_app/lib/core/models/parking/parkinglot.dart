import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/core/models/parking/parkinglot_priceitem.dart';
import 'package:bildungscampus_app/core/enums/parkinglot_light.dart';
import 'package:flutter/foundation.dart';

class ParkingLot {
  final int id;
  final int carParkNo;
  final String title;
  final String? subtitle;
  final List<ParkingLotCategory> categories;
  final String city;
  final String street;
  final String? openingHours;
  final String priceHeader;
  final List<ParkingLotPriceItem> priceItems;
  final int totalCapacity;
  final int usedCapacity;

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

  ParkingLot({
    required this.id,
    required this.carParkNo,
    required this.title,
    this.subtitle,
    required this.categories,
    required this.city,
    required this.street,
    this.openingHours,
    required this.priceHeader,
    required this.priceItems,
    required this.totalCapacity,
    required this.usedCapacity,
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

import 'dart:ui';

import 'package:bildungscampus_app/core/models/common/localized_text.dart';
import 'package:bildungscampus_app/core/utils/localized_text_utils.dart';

class ContactInfo {
  ContactInfo({
    required this.name,
    required this.street,
    required this.city,
    required this.phone,
    required this.email,
    required this.description,
  });

  final String name;
  final String street;
  final String city;
  final String phone;
  final String email;
  final String description;

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        name: json["name"],
        street: json["street"],
        city: json["city"],
        phone: json["phone"],
        email: json["email"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "street": street,
        "city": city,
        "phone": phone,
        "email": email,
        "description": description,
      };
}

class ContactInfoV2 {
  ContactInfoV2({
    required this.name,
    required this.street,
    required this.city,
    required this.phone,
    required this.email,
    required this.description,
  });

  final String name;
  final String street;
  final String city;
  final String phone;
  final String email;
  final List<LocalizedText> description;

  factory ContactInfoV2.fromJson(Map<String, dynamic> json) => ContactInfoV2(
        name: json["name"],
        street: json["street"],
        city: json["city"],
        phone: json["phone"],
        email: json["email"],
        description: List<LocalizedText>.from(
            json["description"].map((x) => LocalizedText.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "street": street,
        "city": city,
        "phone": phone,
        "email": email,
        "description": List<dynamic>.from(description.map((x) => x.toJson())),
      };

  String getDescription(Locale? locale) {
    return LocalizedTextUtils.getLocalizedText(description, locale);
  }
}

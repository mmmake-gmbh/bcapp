import 'package:bildungscampus_app/core/models/common/localized_text.dart';

class CampusInfo {
  CampusInfo({
    required this.title,
    required this.pubDate,
    required this.longText,
  });

  final String title;
  final DateTime pubDate;
  final String longText;

  factory CampusInfo.fromJson(Map<String, dynamic> json) => CampusInfo(
        title: json["title"],
        pubDate: DateTime.parse(json["pubDate"]),
        longText: json["longText"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "pubDate": pubDate.toIso8601String(),
        "longText": longText,
      };
}

class CampusInfoV2 {
  CampusInfoV2({
    required this.title,
    required this.pubDate,
    required this.longText,
  });

  final List<LocalizedText> title;
  final DateTime pubDate;
  final List<LocalizedText> longText;

  factory CampusInfoV2.fromJson(Map<String, dynamic> json) => CampusInfoV2(
        title: List<LocalizedText>.from(
            json["title"].map((x) => LocalizedText.fromJson(x))),
        pubDate: DateTime.parse(json["pubDate"]),
        longText: List<LocalizedText>.from(
            json["longText"].map((x) => LocalizedText.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": List<dynamic>.from(title.map((x) => x.toJson())),
        "pubDate": pubDate.toIso8601String(),
        "longText": List<dynamic>.from(longText.map((x) => x.toJson())),
      };
}

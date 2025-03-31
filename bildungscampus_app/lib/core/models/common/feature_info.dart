import 'package:bildungscampus_app/core/models/common/localized_text.dart';

class FeatureInfo {
  final List<FeatureInfoSlide> slides;
  final String version;
  final bool isActive;
  final DateTime date;
  final List<LocalizedText> headline;

  FeatureInfo({
    required this.slides,
    required this.version,
    required this.isActive,
    required this.date,
    required this.headline,
  });

  factory FeatureInfo.fromJson(Map<String, dynamic> json) => FeatureInfo(
        slides: List<FeatureInfoSlide>.from(
            json["slides"].map((x) => FeatureInfoSlide.fromJson(x))),
        version: json["version"],
        isActive: json["isActive"],
        date: DateTime.parse(json["date"]),
        headline: json["headline"] != null
            ? List<LocalizedText>.from(
                json["headline"].map((x) => LocalizedText.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "slides": List<dynamic>.from(slides.map((x) => x.toJson())),
        "version": version,
        "isActive": isActive,
        "date": date.toIso8601String(),
        "headline": List<dynamic>.from(headline.map((x) => x.toJson())),
      };
}

class FeatureInfoSlide {
  final List<LocalizedText> title;
  final List<LocalizedText> text;
  final String image;

  FeatureInfoSlide({
    required this.title,
    required this.text,
    required this.image,
  });

  factory FeatureInfoSlide.fromJson(Map<String, dynamic> json) =>
      FeatureInfoSlide(
        title: List<LocalizedText>.from(
            json["title"].map((x) => LocalizedText.fromJson(x))),
        text: List<LocalizedText>.from(
            json["text"].map((x) => LocalizedText.fromJson(x))),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": List<dynamic>.from(title.map((x) => x.toJson())),
        "text": List<dynamic>.from(text.map((x) => x.toJson())),
      };
}

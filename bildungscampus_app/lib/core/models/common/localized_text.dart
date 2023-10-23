class LocalizedText {
  LocalizedText({required this.lang, required this.text});

  final String lang;
  final String text;

  factory LocalizedText.fromJson(Map<String, dynamic> json) => LocalizedText(
        lang: json["lang"],
        text: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "lang": lang,
        "value": text,
      };
}

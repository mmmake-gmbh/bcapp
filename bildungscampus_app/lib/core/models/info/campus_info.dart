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

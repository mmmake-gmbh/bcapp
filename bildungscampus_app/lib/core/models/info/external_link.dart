import 'package:bildungscampus_app/core/models/common/localized_text.dart';

class ExternalLink {
  ExternalLink({
    required this.name,
    required this.link,
    required this.openExternalInBrowser,
  });

  String name;
  List<LocalizedText> link;
  bool openExternalInBrowser;

  factory ExternalLink.fromJson(Map<String, dynamic> json) => ExternalLink(
        name: json["name"],
        link: List<LocalizedText>.from(
            json[r'link'].map((x) => LocalizedText.fromJson(x))),
        openExternalInBrowser: json[r'openExternalInBrowser'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": List<LocalizedText>.from(link.map((x) => x.toJson())),
        "openExternalInBrowser": openExternalInBrowser,
      };
}

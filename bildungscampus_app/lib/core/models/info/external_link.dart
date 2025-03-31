import 'package:bildungscampus_app/core/models/common/localized_text.dart';

class ExternalLink {
  ExternalLink({
    required this.name,
    required this.link,
    required this.openExternalInBrowser,
    required this.whitelistUrls,
  });

  String name;
  List<LocalizedText> link;
  bool openExternalInBrowser;
  List<String> whitelistUrls;

  factory ExternalLink.fromJson(Map<String, dynamic> json) => ExternalLink(
        name: json["name"],
        link: List<LocalizedText>.from(
            json[r'link'].map((x) => LocalizedText.fromJson(x))),
        openExternalInBrowser: json[r'openExternalInBrowser'],
        whitelistUrls: json[r'whitelistUrls'] != null
            ? List<String>.from(json[r'whitelistUrls'].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": List<LocalizedText>.from(link.map((x) => x.toJson())),
        "openExternalInBrowser": openExternalInBrowser,
        "whitelistUrls": whitelistUrls,
      };
}

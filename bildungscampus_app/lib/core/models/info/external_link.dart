class ExternalLink {
  ExternalLink({
    required this.name,
    required this.link,
  });

  String name;
  String link;

  factory ExternalLink.fromJson(Map<String, dynamic> json) => ExternalLink(
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
      };
}

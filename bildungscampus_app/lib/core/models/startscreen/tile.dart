class Tile {
  Tile({
    required this.type,
    required this.title,
    required this.showInMenu,
    required this.menuTitle,
    required this.menuOrder,
    required this.visible,
    this.text,
  });

  final String type;
  final String title;
  final bool showInMenu;
  final String menuTitle;
  final int menuOrder;
  final bool visible;
  final String? text;

  factory Tile.fromJson(Map<String, dynamic> json) => Tile(
        type: json["type"],
        title: json["title"],
        showInMenu: json["showInMenu"],
        menuTitle: json["menuTitle"],
        menuOrder: json["menuOrder"],
        visible: json["visible"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "showInMenu": showInMenu,
        "menuTitle": menuTitle,
        "menuOrder": menuOrder,
        "visible": visible,
        "text": text,
      };
}

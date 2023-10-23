import 'package:bildungscampus_app/core/models/common/feature_info.dart';
import 'package:bildungscampus_app/core/models/common/localized_text.dart';

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

class TileV2 {
  TileV2({
    required this.type,
    required this.title,
    required this.showInMenu,
    required this.menuTitle,
    required this.menuOrder,
    required this.visible,
    required this.text,
    required this.featureInfo,
  });

  final String type;
  final List<LocalizedText> title;
  final bool showInMenu;
  final List<LocalizedText> menuTitle;
  final int menuOrder;
  final bool visible;
  final List<LocalizedText> text;
  final FeatureInfo featureInfo;

  factory TileV2.fromJson(Map<String, dynamic> json) => TileV2(
        type: json["type"],
        title: List<LocalizedText>.from(
            json["title"].map((x) => LocalizedText.fromJson(x))),
        showInMenu: json["showInMenu"],
        menuTitle: List<LocalizedText>.from(
            json["menuTitle"].map((x) => LocalizedText.fromJson(x))),
        menuOrder: json["menuOrder"],
        visible: json["visible"],
        text: List<LocalizedText>.from(
            json["text"].map((x) => LocalizedText.fromJson(x))),
        featureInfo: FeatureInfo.fromJson(json["newFlag"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": List<dynamic>.from(title.map((x) => x.toJson())),
        "showInMenu": showInMenu,
        "menuTitle": List<dynamic>.from(menuTitle.map((x) => x.toJson())),
        "menuOrder": menuOrder,
        "visible": visible,
        "text": List<dynamic>.from(text.map((x) => x.toJson())),
        "newFlag": featureInfo.toJson(),
      };
}

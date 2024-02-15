//MensaMealPlan mensaMealPlanFromJson(String str) =>
//    MensaMealPlan.fromJson(json.decode(str));

//String mensaMealPlanToJson(MensaMealPlan data) => json.encode(data.toJson());

import 'package:bildungscampus_app/core/utils/date_utils.dart';
import 'package:bildungscampus_app/core/utils/string_utils.dart';
import 'package:intl/intl.dart';

class MensaMealPlan {
  String ort;
  List<DayPlan> tagesplan;

  MensaMealPlan({
    required this.ort,
    required this.tagesplan,
  });

  factory MensaMealPlan.fromJson(Map<String, dynamic> json) => MensaMealPlan(
        ort: json["ort"],
        tagesplan: List<DayPlan>.from(
            json["tagesplan"].map((x) => DayPlan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ort": ort,
        "tagesplan": List<dynamic>.from(tagesplan.map((x) => x.toJson())),
      };
}

class DayPlan {
  String tag;
  DateTime datum;
  List<Meal>? linie;
  String? text;

  DayPlan({
    required this.tag,
    required this.datum,
    this.linie,
    this.text,
  });

  bool isDisabled(DateTime currentDate) {
    return datum.isBeforeDate(currentDate) || !text.isEmptyOrNull();
  }

  factory DayPlan.fromJson(Map<String, dynamic> json) => DayPlan(
        tag: json["tag"],
        datum: DateFormat("dd.MM.yyyy").parse(json["datum"]),
        linie: json["linie"] == null
            ? []
            : List<Meal>.from(json["linie"]!.map((x) => Meal.fromJson(x))),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "datum": DateFormat("dd.MM.yyyy").format(datum),
        "linie": linie == null
            ? []
            : List<dynamic>.from(linie!.map((x) => x.toJson())),
        "text": text,
      };
}

class Meal {
  MealCategories ausgabe;
  List<MealInfo> gericht;

  Meal({
    required this.ausgabe,
    required this.gericht,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        ausgabe: ausgabeValues.map[json["ausgabe"]]!,
        gericht: List<MealInfo>.from(
            json["gericht"].map((x) => MealInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ausgabe": ausgabeValues.reverse[ausgabe],
        "gericht": List<dynamic>.from(gericht.map((x) => x.toJson())),
      };
}

enum MealCategories { dessert, dessertVegan, soup, meat, vegan, vegatarian }

final ausgabeValues = EnumValues({
  "Dessert": MealCategories.dessert,
  "Dessert vegan": MealCategories.dessertVegan,
  "Suppentopf": MealCategories.soup,
  "Tierisch": MealCategories.meat,
  "Vegan": MealCategories.vegan,
  "Vegetarisch": MealCategories.vegatarian
});

class MealInfo {
  String text;
  String textEn;
  String studi;
  String bed;
  String gast;
  String prodart;

  MealInfo({
    required this.text,
    required this.textEn,
    required this.studi,
    required this.bed,
    required this.gast,
    required this.prodart,
  });

  factory MealInfo.fromJson(Map<String, dynamic> json) => MealInfo(
        text: json["text"],
        textEn: json["text_en"],
        studi: json["studi"],
        bed: json["bed"],
        gast: json["gast"],
        prodart: json["prodart"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "text_en": textEn,
        "studi": studi,
        "bed": bed,
        "gast": gast,
        "prodart": prodart,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

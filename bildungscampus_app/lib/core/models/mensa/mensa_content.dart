import 'package:bildungscampus_app/core/models/mensa/mensa_forecast.dart';
import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';
import 'package:bildungscampus_app/core/models/mensa/mensa_occupancy.dart';

class MensaContent {
  MensaMealPlan menu;
  MensaForecast forecast;
  MensaOccupancy occupancy;

  MensaContent({
    required this.menu,
    required this.forecast,
    required this.occupancy,
  });

  factory MensaContent.fromJson(Map<String, dynamic> json) => MensaContent(
        menu: MensaMealPlan.fromJson(json["menu"]),
        forecast: MensaForecast.fromJson(json["forecast"]),
        occupancy: MensaOccupancy.fromJson(json["occupancy"]),
      );

  Map<String, dynamic> toJson() => {
        "menu": menu.toJson(),
        "forecast": forecast.toJson(),
        "occupancy": occupancy.toJson(),
      };
}

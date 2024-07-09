import 'package:bildungscampus_app/core/models/mensa/mensa_forecast_data.dart';

class MensaForecast {
  DateTime time;
  List<MensaForecastData> data;

  MensaForecast({
    required this.time,
    required this.data,
  });

  factory MensaForecast.fromJson(Map<String, dynamic> json) => MensaForecast(
        time: DateTime.parse(json["forecast_time"]),
        data: List<MensaForecastData>.from(
            json["forecast_data"].map((x) => MensaForecastData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "forecast_time": time,
        "forecast_data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

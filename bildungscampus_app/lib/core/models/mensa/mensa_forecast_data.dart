class MensaForecastData {
  DateTime time;
  int prediction;

  MensaForecastData({
    required this.time,
    required this.prediction,
  });

  factory MensaForecastData.fromJson(Map<String, dynamic> json) =>
      MensaForecastData(
        time: DateTime.parse(json["ds"]),
        prediction: json["prediction"],
      );

  Map<String, dynamic> toJson() => {
        "ds": time,
        "prediction": prediction,
      };
}

class WeatherApigee {
  Timeseries timeseries;

  WeatherApigee({
    required this.timeseries,
  });

  factory WeatherApigee.fromJson(Map<String, dynamic> json) => WeatherApigee(
        timeseries: Timeseries.fromJson(json["timeseries"]),
      );

  Map<String, dynamic> toJson() => {
        "timeseries": timeseries.toJson(),
      };
}

class Timeseries {
  List<Outdoortemperature> outdoortemperature;

  Timeseries({
    required this.outdoortemperature,
  });

  factory Timeseries.fromJson(Map<String, dynamic> json) => Timeseries(
        outdoortemperature: json["outdoortemperature"] != null
            ? List<Outdoortemperature>.from(json["outdoortemperature"]
                .map((x) => Outdoortemperature.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "outdoortemperature":
            List<dynamic>.from(outdoortemperature.map((x) => x.toJson())),
      };
}

class Outdoortemperature {
  int ts;
  String value;

  Outdoortemperature({
    required this.ts,
    required this.value,
  });

  factory Outdoortemperature.fromJson(Map<String, dynamic> json) =>
      Outdoortemperature(
        ts: json["ts"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "ts": ts,
        "value": value,
      };
}

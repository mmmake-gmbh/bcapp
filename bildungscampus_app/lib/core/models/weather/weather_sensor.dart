import 'package:bildungscampus_app/core/models/weather/location.dart';

class WeatherSensor {
  /// Returns a new [WeatherSensor] instance.
  WeatherSensor({
    required this.id,
    required this.name,
    required this.unit,
    required this.timestamp,
    required this.value,
    required this.sensor,
    this.location,
  });

  int id;

  String? name;

  String? unit;

  DateTime timestamp;

  double value;

  /// Weather sensor type
  WeatherSensorSensorEnum? sensor;

  Location? location;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherSensor &&
          other.id == id &&
          other.name == name &&
          other.unit == unit &&
          other.timestamp == timestamp &&
          other.value == value &&
          other.sensor == sensor &&
          other.location == location;

  @override
  int get hashCode =>
      id.hashCode +
      (name == null ? 0 : name.hashCode) +
      (unit == null ? 0 : unit.hashCode) +
      timestamp.hashCode +
      value.hashCode +
      (sensor == null ? 0 : sensor.hashCode) +
      (location == null ? 0 : location.hashCode);

  @override
  String toString() =>
      'WeatherSensor[id=$id, name=$name, unit=$unit, timestamp=$timestamp, value=$value, sensor=$sensor, location=$location]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = id;

    if (name != null) {
      json[r'name'] = name;
    }
    if (unit != null) {
      json[r'unit'] = unit;
    }
    json[r'timestamp'] = timestamp;
    json[r'value'] = value;

    if (sensor != null) {
      json[r'sensor'] = sensor;
    }
    if (location != null) {
      json[r'location'] = location;
    }
    return json;
  }

  /// Returns a new [WeatherSensor] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static WeatherSensor fromJson(Map<String, dynamic> json) => WeatherSensor(
        id: json[r'id'],
        name: json[r'name'],
        unit: json[r'unit'],
        timestamp: DateTime.parse(json[r'timestamp']),
        value: double.parse(json[r'value'].toString()),
        sensor: WeatherSensorSensorEnum.fromJson(json[r'sensor']),
        location: Location.fromJson(json[r'location']),
      );

  static List<WeatherSensor?>? listFromJson(
    List<dynamic>? json, {
    bool? emptyIsNull,
    bool? growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <WeatherSensor>[]
          : json
              .map((v) => WeatherSensor.fromJson(v))
              .toList(growable: true == growable);

  static Map<String, WeatherSensor?> mapFromJson(Map<String, dynamic>? json) {
    final map = <String, WeatherSensor?>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (String key, dynamic v) => map[key] = WeatherSensor.fromJson(v));
    }
    return map;
  }

  // maps a json object with a list of WeatherSensor-objects as value to a dart map
  static Map<String, List<WeatherSensor?>?> mapListFromJson(
    Map<String, dynamic>? json, {
    bool? emptyIsNull,
    bool? growable,
  }) {
    final Map<String, List<WeatherSensor?>?> map =
        <String, List<WeatherSensor>?>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) {
        map[key] = WeatherSensor.listFromJson(v,
            emptyIsNull: emptyIsNull, growable: growable);
      });
    }
    return map;
  }
}

/// Weather sensor type
class WeatherSensorSensorEnum {
  /// Instantiate a new enum with the provided [value].
  const WeatherSensorSensorEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherSensorSensorEnum && other.value == value;

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() => value;

  String toJson() => value;

  static const temperature = WeatherSensorSensorEnum._(r'temperature');
  static const wind = WeatherSensorSensorEnum._(r'wind');
  static const rain = WeatherSensorSensorEnum._(r'rain');
  static const light = WeatherSensorSensorEnum._(r'light');
  static const sun = WeatherSensorSensorEnum._(r'sun');

  /// List of all possible values in this [enum][WeatherSensorSensorEnum].
  static const values = <WeatherSensorSensorEnum>[
    temperature,
    wind,
    rain,
    light,
    sun,
  ];

  static WeatherSensorSensorEnum? fromJson(dynamic value) =>
      WeatherSensorSensorEnumTypeTransformer().decode(value);

  static List<WeatherSensorSensorEnum?>? listFromJson(
    List<dynamic>? json, {
    bool? emptyIsNull,
    bool? growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <WeatherSensorSensorEnum>[]
          : json
              .map((value) => WeatherSensorSensorEnum.fromJson(value))
              .toList(growable: true == growable);
}

/// Transformation class that can [encode] an instance of [WeatherSensorSensorEnum] to String,
/// and [decode] dynamic data back to [WeatherSensorSensorEnum].
class WeatherSensorSensorEnumTypeTransformer {
  const WeatherSensorSensorEnumTypeTransformer._();

  factory WeatherSensorSensorEnumTypeTransformer() =>
      _instance ??= const WeatherSensorSensorEnumTypeTransformer._();

  String encode(WeatherSensorSensorEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a WeatherSensorSensorEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WeatherSensorSensorEnum? decode(dynamic data, {bool? allowNull}) {
    switch (data) {
      case r'temperature':
        return WeatherSensorSensorEnum.temperature;
      case r'wind':
        return WeatherSensorSensorEnum.wind;
      case r'rain':
        return WeatherSensorSensorEnum.rain;
      case r'light':
        return WeatherSensorSensorEnum.light;
      case r'sun':
        return WeatherSensorSensorEnum.sun;
      default:
        if (allowNull == false) {
          throw ArgumentError('Unknown enum value to decode: $data');
        }
    }
    return null;
  }

  /// Singleton [WeatherSensorSensorEnumTypeTransformer] instance.
  static WeatherSensorSensorEnumTypeTransformer? _instance;
}

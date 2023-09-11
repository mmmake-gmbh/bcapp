class Location {
  /// Returns a new [Location] instance.
  Location({
    required this.longitude,
    required this.latitude,
    this.altitude,
  });

  double longitude;

  double latitude;

  double? altitude;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          other.longitude == longitude &&
          other.latitude == latitude &&
          other.altitude == altitude;

  @override
  int get hashCode =>
      longitude.hashCode +
      latitude.hashCode +
      (altitude == null ? 0 : altitude.hashCode);

  @override
  String toString() =>
      'Location[longitude=$longitude, latitude=$latitude, altitude=$altitude]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'longitude'] = longitude;
    json[r'latitude'] = latitude;
    if (altitude != null) {
      json[r'altitude'] = altitude;
    }
    return json;
  }

  /// Returns a new [Location] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static Location fromJson(Map<String, dynamic> json) => Location(
        longitude: double.parse(json[r'longitude'].toString()),
        latitude: double.parse(json[r'latitude'].toString()),
        altitude: double.parse(json[r'altitude'].toString()),
      );

  static List<Location> listFromJson(List<dynamic> json) =>
      json.map((v) => Location.fromJson(v)).toList();

  static Map<String, Location?> mapFromJson(Map<String, dynamic>? json) {
    final map = <String, Location?>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) => map[key] = Location.fromJson(v));
    }
    return map;
  }

  // maps a json object with a list of Location-objects as value to a dart map
  static Map<String, List<Location?>?> mapListFromJson(
      Map<String, dynamic>? json) {
    final Map<String, List<Location?>?> map = <String, List<Location>?>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) {
        map[key] = Location.listFromJson(v);
      });
    }
    return map;
  }
}

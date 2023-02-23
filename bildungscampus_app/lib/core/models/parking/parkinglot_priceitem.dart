class ParkingLotPriceItem {
  final String title;
  final String description;

  ParkingLotPriceItem({
    required this.title,
    required this.description,
  });

  /// Returns a new [ParkingLot] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static ParkingLotPriceItem fromJson(Map<String, dynamic> json) =>
      ParkingLotPriceItem(
        title: json[r'title'],
        description: json[r'description'],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}

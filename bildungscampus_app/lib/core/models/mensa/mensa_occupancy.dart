class MensaOccupancy {
  int currentOccupancy;

  MensaOccupancy({
    required this.currentOccupancy,
  });

  factory MensaOccupancy.fromJson(Map<String, dynamic> json) => MensaOccupancy(
        currentOccupancy: json["currentOccupancy"],
      );

  Map<String, dynamic> toJson() => {
        "currentOccupancy": currentOccupancy,
      };
}

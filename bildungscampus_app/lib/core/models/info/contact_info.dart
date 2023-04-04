class ContactInfo {
  ContactInfo({
    required this.name,
    required this.street,
    required this.city,
    required this.phone,
    required this.email,
    required this.description,
  });

  final String name;
  final String street;
  final String city;
  final String phone;
  final String email;
  final String description;

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        name: json["name"],
        street: json["street"],
        city: json["city"],
        phone: json["phone"],
        email: json["email"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "street": street,
        "city": city,
        "phone": phone,
        "email": email,
        "description": description,
      };
}

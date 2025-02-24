class RegistrationRegModel {
  String name;
  String email;
  String phoneNumber;
  String country;
  String city;

  RegistrationRegModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.city,
  });

  static RegistrationRegModel getInstance() {
    return RegistrationRegModel(
      name: "",
      email: "",
      phoneNumber: "",
      country: "",
      city: "",
    );
  }

  RegistrationRegModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? country,
    String? city,
  }) {
    return RegistrationRegModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'country': country,
      'city': city,
    };
  }

  factory RegistrationRegModel.fromMap(Map<String, dynamic> map) {
    return RegistrationRegModel(
        name: map['name'] as String,
        email: map['email'] as String,
        phoneNumber: map['phoneNumber'] as String,
        country: map['country'] as String,
        city: map['city'] as String);
  }
}

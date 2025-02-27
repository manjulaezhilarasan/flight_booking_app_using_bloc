class HomeReqModel {
  String from;
  String to;
  DateTime departureDate;
  int passengers;
  String travelClass;

  HomeReqModel({
    required this.from,
    required this.to,
    required this.departureDate,
    required this.passengers,
    required this.travelClass,
  });

  static HomeReqModel getInstance() {
    return HomeReqModel(
        from: "",
        to: "",
        departureDate: DateTime.now(),
        passengers: 1,
        travelClass: "Economy");
  }

  HomeReqModel copyWith({
    String? from,
    String? to,
    DateTime? departureDate,
    int? passengers,
    String? travelClass,
  }) {
    return HomeReqModel(
        from: from ?? this.from,
        to: to ?? this.to,
        departureDate: departureDate ?? this.departureDate,
        passengers: passengers ?? this.passengers,
        travelClass: travelClass ?? this.travelClass);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'departureDate': departureDate.toIso8601String(),
      'passengers': passengers,
      'travelClass': travelClass,
    };
  }

  factory HomeReqModel.fromMap(Map<String, dynamic> map) {
    return HomeReqModel(
        from: map['from'] as String,
        to: map['to'] as String,
        departureDate: DateTime.parse(map['departureDate'] as String),
        passengers: map['passengers'] as int,
        travelClass: map['travelClass'] as String);
  }
}

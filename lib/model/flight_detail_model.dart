class FlightDetailModel {
  FlightDetailModel({
    required this.name,
    required this.details,
    required this.patches,
    required this.unixDate,
    required this.flightNumber,
  });
  final String? name;
  final String? details;
  final List<String?>? patches;
  final int? unixDate;
  final int? flightNumber;

  factory FlightDetailModel.fromJson(Map<String, dynamic> json) {
    return FlightDetailModel(
      name: json["name"],
      details: json["details"] ?? "Cannot find any details about this launch",
      patches: [
        json["links"]["patch"]["small"],
        json["links"]["patch"]["large"]
      ],
      unixDate: json["date_unix"],
      flightNumber: json["flight_number"],
    );
  }
}

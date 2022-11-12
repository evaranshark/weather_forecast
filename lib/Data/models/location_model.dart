class LocationModel {
  final String name;
  final double lon;
  final double lat;

  const LocationModel(
      {required this.name, required this.lat, required this.lon});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  static List<LocationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => LocationModel.fromJson(e)).toList();
  }
}

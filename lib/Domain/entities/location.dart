class Location {
  String name;
  double? lon;
  double? lat;

  Location({required this.name, this.lon, this.lat});

  Location copyWith({
    String? name,
    double? lon,
    double? lat,
  }) =>
      Location(
        name: name ?? this.name,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
      );
}

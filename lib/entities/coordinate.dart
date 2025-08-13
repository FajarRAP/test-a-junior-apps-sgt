class Coordinate {
  const Coordinate({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      Coordinate(latitude: json['lat'], longitude: json['lon']);
}

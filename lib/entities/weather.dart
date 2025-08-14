class Weather {
  const Weather({
    required this.id,
    required this.description,
    required this.icon,
    required this.main,
  });

  final int id;
  final String description;
  final String icon;
  final String main;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'],
        description: json['description'],
        icon: json['icon'],
        main: json['main'],
      );
}

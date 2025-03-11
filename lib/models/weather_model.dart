class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final int sunrise; // Unix timestamp
  final int sunset; // Unix timestamp

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      sunrise: json['sys']['sunrise'], // Sunrise time from API
      sunset: json['sys']['sunset'], // Sunset time from API
    );
  }

  String get iconUrl => "https://openweathermap.org/img/wn/$icon@2x.png";

  bool get isDaytime {
    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000; // Convert to Unix timestamp
    return currentTime > sunrise && currentTime < sunset;
  }
}

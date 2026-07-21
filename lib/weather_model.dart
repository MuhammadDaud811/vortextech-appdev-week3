class WeatherModel {
  final List<DailyForecast> dailyForecasts;

  WeatherModel({required this.dailyForecasts});
}

class DailyForecast {
  final String date;
  final double temperature;
  final double humidity;
  final double windSpeed;
  final double maxTemp;
  final double minTemp;

  DailyForecast({
    required this.date,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.maxTemp,
    required this.minTemp,
  });
}

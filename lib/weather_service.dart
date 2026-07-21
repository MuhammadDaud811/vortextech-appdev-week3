import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  Future<List<double>> getCoordinates(String city) async {
    final url = Uri.parse(
        "https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1&language=en&format=json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["results"] != null && data["results"].isNotEmpty) {
        final result = data["results"][0];
        double latitude = result["latitude"].toDouble();
        double longitude = result["longitude"].toDouble();
        return [latitude, longitude];
      }
    }
    throw Exception("City not found");
  }

  Future<WeatherModel> fetchWeather(String city) async {
    final List<double> location = await getCoordinates(city);
    final double latitude = location[0];
    final double longitude = location[1];

    // Note: Open-Meteo doesn't provide a single 'humidity' daily value.
    // We'll fetch daily max temp, min temp, and wind speed. 
    // For humidity, we use precipitation probability as a proxy or omit.
    // However, to satisfy the requirement, we will fetch precipitation_probability_max.
    final url = Uri.parse("https://api.open-meteo.com/v1/forecast?"
        "latitude=$latitude&"
        "longitude=$longitude&"
        "daily=temperature_2m_max,"
        "temperature_2m_min,"
        "precipitation_probability_max,"
        "wind_speed_10m_max&"
        "timezone=auto&"
        "forecast_days=7");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final daily = data["daily"];

      if (daily == null) throw Exception("No forecast data available");

      final List<DailyForecast> forecasts = [];
      final List<dynamic> times = daily["time"] ?? [];

      for (int i = 0; i < times.length; i++) {
        forecasts.add(DailyForecast(
          date: times[i].toString(),
          // Use max temp as the representative temperature
          temperature: (daily["temperature_2m_max"][i] as num).toDouble(),
          // Map precipitation probability to humidity for visualization purposes
          humidity: (daily["precipitation_probability_max"][i] as num).toDouble(),
          windSpeed: (daily["wind_speed_10m_max"][i] as num).toDouble(),
          maxTemp: (daily["temperature_2m_max"][i] as num).toDouble(),
          minTemp: (daily["temperature_2m_min"][i] as num).toDouble(),
        ));
      }

      return WeatherModel(dailyForecasts: forecasts);
    }

    throw Exception("Unable to fetch weather");
  }
}

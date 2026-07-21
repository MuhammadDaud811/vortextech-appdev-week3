import 'package:flutter/material.dart';
import 'weather_model.dart';
import 'weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() {
    return _WeatherScreenState();
  }
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _service = WeatherService();
  WeatherModel? _weather;
  bool _loading = false;
  String _error = "";

  final TextEditingController _controller = TextEditingController();

  Future<void> _getWeather() async {
    if (_controller.text.isEmpty) {
      return;
    }

    setState(() {
      _loading = true;
      _error = "";
    });

    try {
      final weather = await _service.fetchWeather(_controller.text.trim());
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      setState(() {
        _error = "Error: Could not fetch weather data. Please check the city name.";
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getDayName(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
      return days[date.weekday - 1];
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getWeather,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getWeather,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(15.0),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter City Name",
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.location_city, color: Colors.white70),
                    ),
                    onSubmitted: (_) => _getWeather(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _getWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  child: const Text("Search"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_loading)
              const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
            if (_error.isNotEmpty && !_loading)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Text(
                    _error,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (_weather != null && !_loading)
              ..._weather!.dailyForecasts.asMap().entries.map((entry) {
                final index = entry.key;
                final forecast = entry.value;
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          index == 0 ? "Today - ${_getDayName(forecast.date)}" : _getDayName(forecast.date),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildWeatherDetail("Temp", "${forecast.temperature.toStringAsFixed(1)}°C"),
                            _buildWeatherDetail("Humidity", "${forecast.humidity.toStringAsFixed(0)}%"),
                            _buildWeatherDetail("Wind", "${forecast.windSpeed.toStringAsFixed(1)} km/h"),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildWeatherDetail("Max Temp", "${forecast.maxTemp.toStringAsFixed(1)}°C"),
                            _buildWeatherDetail("Min Temp", "${forecast.minTemp.toStringAsFixed(1)}°C"),
                            const SizedBox(width: 60), // Spacer for layout
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

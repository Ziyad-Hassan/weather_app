import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/weather_provider.dart';

class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.weather;

    return Scaffold(
      appBar: AppBar(
        title: Text(weather?.cityName ?? "Loading..."),
        actions: [
          // Favorite Toggle Button
          if (weather != null)
            IconButton(
              icon: Icon(
                weatherProvider.favorites.contains(weather.cityName)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                weatherProvider.toggleFavorite(weather.cityName);
              },
            )
        ],
      ),
      body: Center(
        child: weatherProvider.isLoading
            ? const CircularProgressIndicator()
            : weatherProvider.error.isNotEmpty
                ? Text(
                    weatherProvider.error,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  )
                : weather == null
                    ? const Text("No Data")
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // Weather Icon
                            Image.network(
                              'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                              width: 100,
                              height: 100,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                            // Temperature
                            Text(
                              '${weather.temperature.toStringAsFixed(1)}°',
                              style: const TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              weather.description.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 20, letterSpacing: 1.2),
                            ),
                            const SizedBox(height: 30),
                            // Detailed Metrics
                            Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    _buildInfoRow(
                                        "Feels Like", "${weather.feelsLike}°"),
                                    _buildInfoRow(
                                        "Humidity", "${weather.humidity}%"),
                                    _buildInfoRow(
                                        "Wind Speed", "${weather.windSpeed}"),
                                    _buildInfoRow(
                                        "Sunrise",
                                        _formatTime(
                                            weather.sunrise, weather.timezone)),
                                    _buildInfoRow(
                                        "Sunset",
                                        _formatTime(
                                            weather.sunset, weather.timezone)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
      ),
    );
  }

  // Helper widget to build rows
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Helper to format time
  String _formatTime(int timestamp, int timezoneOffset) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
        (timestamp + timezoneOffset) * 1000,
        isUtc: true);
    return DateFormat('hh:mm a').format(date);
  }
}
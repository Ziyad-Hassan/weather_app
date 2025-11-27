import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'weather_details_page.dart';
import 'favorites_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Helper method to handle search
  void _searchCity() {
    if (_controller.text.isNotEmpty) {
      // Fetch weather data
      Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeather(_controller.text);
      
      // Navigate to Details Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const WeatherDetailsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          // Favorites Button
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesPage()),
            ),
          ),
          // Settings Button
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            // Search Bar
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                hintText: 'e.g. Cairo, London',
                border: const OutlineInputBorder(),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min, // Important for layout
                  children: [
                    // GPS Button
                    IconButton(
                      icon: const Icon(Icons.my_location, color: Colors.blue),
                      onPressed: () {
                        Provider.of<WeatherProvider>(context, listen: false)
                            .fetchWeatherByLocation();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const WeatherDetailsPage()),
                        );
                      },
                    ),
                    // Search Button
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _searchCity,
                    ),
                  ],
                ),
              ),
              onSubmitted: (_) => _searchCity(),
            ),
          ],
        ),
      ),
    );
  }
}
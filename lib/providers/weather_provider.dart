import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import 'package:geolocator/geolocator.dart';

class WeatherProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool isOn) async {
    _isDarkMode = isOn;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isOn);
  }
  Weather? _weather;
  bool _isLoading = false;
  String _error = '';
  String _unit = 'metric'; // Default to Celsius ('metric')
  List<String> _favorites = [];

  // Getters to access private variables
  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get unit => _unit;
  List<String> get favorites => _favorites;

  // Method to fetch weather data from API
  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _error = '';
    notifyListeners(); // Update UI to show loading spinner

    try {
      _weather = await WeatherService().getWeather(city, _unit);
    } catch (e) {
      _error = "City not found or connection error.";
      _weather = null;
    }

    _isLoading = false;
    notifyListeners(); // Update UI with data or error
  }

  // Method to change temperature unit (metric/imperial)
  void setUnit(String newUnit) {
    _unit = newUnit;
    // If we have weather data displayed, refresh it with the new unit
    if (_weather != null) {
      fetchWeather(_weather!.cityName);
    }
    notifyListeners();
  }

  // Load favorites from local storage (SharedPreferences)
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load Favorites
    _favorites = prefs.getStringList('favorites') ?? [];
    
    // Load Theme (This is new)
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    
    notifyListeners();
  }

  // Add or Remove city from favorites
  Future<void> toggleFavorite(String city) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favorites.contains(city)) {
      _favorites.remove(city);
    } else {
      _favorites.add(city);
    }
    // Save the updated list to local storage
    await prefs.setStringList('favorites', _favorites);
    notifyListeners();
  }
  // Get current location and fetch weather
  Future<void> fetchWeatherByLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      // 1. Check if GPS service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // 2. Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      // 3. Get Position
      Position position = await Geolocator.getCurrentPosition();

      // 4. Fetch Weather using coordinates
      _weather = await WeatherService().getWeatherByCoordinates(
          position.latitude, position.longitude, _unit);
      
      _error = ''; // Clear errors if successful

    } catch (e) {
      _error = e.toString().replaceAll("Exception: ", ""); // Clean error message
      _weather = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
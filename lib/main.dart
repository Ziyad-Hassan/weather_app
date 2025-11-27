import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    // Initialize Provider at the top of the widget tree
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherProvider()..loadFavorites(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the provider
    final provider = Provider.of<WeatherProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Weather App',
      
      // 1. Define Light Theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, 
          brightness: Brightness.light
        ),
        useMaterial3: true,
      ),

      // 2. Define Dark Theme
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, 
          brightness: Brightness.dark 
        ),
        useMaterial3: true,
      ),

      // 3. Auto-switch based on provider
      themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: const HomePage(), // Make sure HomePage is imported
    );
  }
}
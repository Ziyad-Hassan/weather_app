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
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: 'Flutter Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // We will create HomePage in the next step
      home: const HomePage(),
    );
  }
}
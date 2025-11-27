import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.thermostat),
            title: const Text("Temperature Unit"),
            subtitle: Text(
              provider.unit == 'metric' ? "Celsius (°C)" : "Fahrenheit (°F)",
            ),
            trailing: Switch(
              value: provider.unit == 'imperial',
              activeThumbColor: Colors.blue,
              onChanged: (bool value) {
                // If true -> imperial (F), if false -> metric (C)
                provider.setUnit(value ? 'imperial' : 'metric');
              },
            ),
          ),
          const Divider(), // Line separator

          // Dark Mode Switch
          ListTile(
            leading: Icon(
              provider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            title: const Text("Dark Mode"),
            subtitle: Text(provider.isDarkMode ? "On" : "Off"),
            trailing: Switch(
              value: provider.isDarkMode,
              activeThumbColor: Colors.blue,
              onChanged: (bool value) {
                provider.toggleTheme(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
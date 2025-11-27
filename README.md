# Flutter Weather App 🌦️

A multi-page Flutter mobile application that retrieves and displays real-time weather data using the OpenWeatherMap API. Ideally built for managing weather queries, viewing details, saving favorites, and customizing settings.

## 🚀 Features

* **Real-time Weather:** Fetches current weather data by city name.
* **Detailed Metrics:** Displays Temperature, Humidity, Wind Speed, Feels Like, Sunrise, and Sunset.
* **Favorites System:** Save/Remove cities to a local favorites list using `SharedPreferences`.
* **Settings:** Toggle between Metric (°C) and Imperial (°F) units.
* **Clean Architecture:** Separated logic using Providers, Models, and Services.

## 🛠️ Setup & Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/YOUR_USERNAME/weather_app.git](https://github.com/YOUR_USERNAME/weather_app.git)
    cd weather_app
    ```

2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Configure API Key:**
    * Open `lib/services/weather_service.dart`.
    * Replace `'YOUR_API_KEY_HERE'` with your valid OpenWeatherMap API Key.
    * *Note: The API key is not included in this repo for security reasons.*

4.  **Run the App:**
    ```bash
    flutter run
    ```

## 📱 Tech Stack

* **Framework:** Flutter (Dart)
* **State Management:** Provider
* **Networking:** http
* **Local Storage:** shared_preferences
* **API:** [OpenWeatherMap Current Weather Data](https://openweathermap.org/current)

## 📸 How it Works

1.  **Search:** Enter a city name in the home screen.
2.  **View:** See detailed weather info.
3.  **Favorite:** Click the heart icon ❤️ to save the city.
4.  **Settings:** Switch units in the settings page.
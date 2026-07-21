# Weather App - Vortex Tech Internship (Week 3)

A Flutter weather application developed for the Vortex Tech App Development Internship (Week 3 - Intermediate Track). The application fetches live weather data using the Open-Meteo API and allows users to search for any city worldwide.

## Features

- Search weather information by city name.
- Live weather data using Open-Meteo APIs.
- 7-Day Weather Forecast.
- Displays:
  - Current Temperature
  - Maximum Temperature
  - Minimum Temperature
  - Wind Speed
  - Humidity (represented using precipitation probability data)
- Pull-to-refresh functionality.
- Refresh button in the AppBar.
- Loading indicator while fetching data.
- Error handling for invalid city names and network issues.
- Clean card-based UI design.
- Dark theme support.

---

## Technologies Used

- Flutter
- Dart
- HTTP Package
- Open-Meteo Weather API
- Open-Meteo Geocoding API

---

## APIs Used

### Open-Meteo Geocoding API

Used to convert the city name entered by the user into latitude and longitude coordinates.

Example:

```
https://geocoding-api.open-meteo.com/v1/search?name=Islamabad&count=1
```

### Open-Meteo Weather Forecast API

Used to fetch the 7-day weather forecast data.

Example:

```
https://api.open-meteo.com/v1/forecast?latitude=33.6844&longitude=73.0479&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max,wind_speed_10m_max&timezone=auto&forecast_days=7
```

No API key is required for either API.

---

## Project Structure

```
lib
│
├── main.dart
│
├── weather_screen.dart
│
├── weather_model.dart
│
└── weather_service.dart
```

---

## Dependencies

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter

  http: ^1.5.0
```

Then run:

```bash
flutter pub get
```

---

## How to Run the Project

1. Clone the repository.

```bash
git clone YOUR_REPOSITORY_LINK
```

2. Navigate to the project folder.

```bash
cd vortextech-appdev-week3
```

3. Install dependencies.

```bash
flutter pub get
```

4. Run the application.

```bash
flutter run
```

---

## How the Application Works

1. The user enters a city name.
2. The Geocoding API converts the city name into geographical coordinates.
3. The Weather Forecast API uses those coordinates to retrieve weather information.
4. The application displays:
   - Temperature
   - Maximum Temperature
   - Minimum Temperature
   - Wind Speed
   - Humidity Information
   - Seven Day Forecast
5. Users can refresh the weather information using:
   - The Refresh button.
   - Pull-to-refresh functionality.

---

## Assignment Requirements Covered

- Live API Integration
- HTTP Requests
- JSON Parsing
- Async Programming
- Loading Indicator
- Error Handling
- Refresh Functionality
- ListView Implementation
- Card-Based UI Design
- Stateful Widgets
- 7-Day Weather Forecast Display

---

## Notes

- This project uses completely free public APIs provided by Open-Meteo.
- No API key or authentication is required.
- The application supports weather searches for cities worldwide.
- Weather information is retrieved in real time whenever a search is performed.

---

## Author

**Muhammad Daud**

Software Engineering Student  
International Islamic University Islamabad

Vortex Tech App Development Internship 2026 - Week 3 (Intermediate Track)

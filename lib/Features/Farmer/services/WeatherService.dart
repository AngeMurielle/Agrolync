import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_agrolync_pro/Features/Farmer/models/WeatherModel.dart';

class WeatherService {
  // ============================================
  // PASTE YOUR OPENWEATHERMAP API KEY HERE
  // Get free API key at: https://openweathermap.org/api
  // ============================================
  // Using free weather API with no key requirement
  // Fallback: Use Open-Meteo API (free, no key needed)
  static const String _apiKey = 'd9882a4cb3dc51d30a0486370bcc1e57';

  // Buea, Cameroon coordinates (4.0°N, 9.75°E)
  // You can change these coordinates for different locations
  static const double _latitude = 4.0;
  static const double _longitude = 9.75;

  // Using Open-Meteo API which doesn't require an API key
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  // Memory cache for weather data
  static WeatherForecast? _cachedWeatherData;
  static DateTime? _lastFetchTime;
  static const Duration _cacheDuration = Duration(minutes: 30);

  /// Fetch weather forecast for the next 7 days
  /// Returns cached data if available and not expired
  static Future<WeatherForecast> getWeatherForecast() async {
    try {
      // Check if we have valid cached data
      if (_cachedWeatherData != null && _lastFetchTime != null) {
        final timeSinceLastFetch = DateTime.now().difference(_lastFetchTime!);
        if (timeSinceLastFetch < _cacheDuration) {
          debugPrint('WeatherService: Using cached data');
          return _cachedWeatherData!;
        }
      }

      // Make API call
      final uri = Uri.parse(
        '$_baseUrl?latitude=$_latitude&longitude=$_longitude&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=Africa/Lagos',
      );

      debugPrint('WeatherService: Fetching weather data from API...');
      final response = await http.get(uri).timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw TimeoutException('Weather API request timed out'),
          );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        _cachedWeatherData = WeatherForecast.fromJson(jsonData);
        _lastFetchTime = DateTime.now();
        debugPrint(
            'WeatherService: Successfully fetched weather data. Cache updated.');
        return _cachedWeatherData!;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw WeatherException(
          'Weather service temporarily unavailable. Please try again later.',
        );
      } else {
        throw WeatherException(
          'Failed to fetch weather: HTTP ${response.statusCode}',
        );
      }
    } on TimeoutException {
      throw WeatherException(
          'Request timed out. Please check your connection.');
    } on http.ClientException catch (e) {
      throw WeatherException('Network error: ${e.message}');
    } catch (e) {
      throw WeatherException('Error fetching weather: ${e.toString()}');
    }
  }

  /// Convert OpenWeatherMap condition codes to Material Icons
  /// See: https://openweathermap.org/weather-conditions
  static IconData getWeatherIcon(String condition) {
    final lowerCondition = condition.toLowerCase();

    switch (lowerCondition) {
      // Clear sky
      case '01d':
      case 'clear':
        return Icons.wb_sunny;

      // Few clouds
      case '02d':
      case '02n':
      case 'partly cloudy':
        return Icons.wb_cloudy;

      // Scattered clouds
      case '03d':
      case '03n':
      case 'cloudy':
        return Icons.cloud;

      // Broken clouds
      case '04d':
      case '04n':
        return Icons.cloud_queue;

      // Light rain
      case '09d':
      case '09n':
      case '10d':
      case '10n':
      case 'rainy':
      case 'rain':
        return Icons.water_drop;

      // Thunderstorm
      case '11d':
      case '11n':
      case 'thunderstorm':
        return Icons.flash_on;

      // Snow
      case '13d':
      case '13n':
      case 'snow':
        return Icons.ac_unit;

      // Mist
      case '50d':
      case '50n':
      case 'mist':
      case 'fog':
        return Icons.cloud_circle;

      default:
        return Icons.cloud;
    }
  }

  /// Get color for weather icon based on condition
  static Color getWeatherIconColor(bool isToday) {
    return isToday ? Colors.white : Colors.orange;
  }

  /// Clear the cached weather data
  static void clearCache() {
    _cachedWeatherData = null;
    _lastFetchTime = null;
  }
}

/// Custom exception for weather service errors
class WeatherException implements Exception {
  final String message;

  WeatherException(this.message);

  @override
  String toString() => message;
}

/// Timeout exception
class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);

  @override
  String toString() => message;
}

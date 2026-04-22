class WeatherDay {
  final String dayName;
  final String weatherCondition;
  final double temperatureCelsius;
  final bool isToday;
  final String weatherIcon;

  WeatherDay({
    required this.dayName,
    required this.weatherCondition,
    required this.temperatureCelsius,
    required this.isToday,
    required this.weatherIcon,
  });

  factory WeatherDay.fromJson(Map<String, dynamic> json, bool isToday) {
    return WeatherDay(
      dayName: _getDayName(json['dt'] as int),
      weatherCondition: json['weather'][0]['main'] ?? 'Unknown',
      temperatureCelsius: (json['temp']['day'] as num).toDouble(),
      isToday: isToday,
      weatherIcon: json['weather'][0]['icon'] ?? '01d',
    );
  }

  factory WeatherDay.fromOpenMeteo(
    String dateStr,
    int weatherCode,
    double tempMax,
    double tempMin,
    bool isToday,
  ) {
    return WeatherDay(
      dayName: _getDayNameFromString(dateStr),
      weatherCondition: _getWeatherConditionFromCode(weatherCode),
      temperatureCelsius: tempMax,
      isToday: isToday,
      weatherIcon: _getIconFromWeatherCode(weatherCode),
    );
  }

  static String _getDayName(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[dateTime.weekday % 7];
  }

  static String _getDayNameFromString(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
      return days[date.weekday % 7];
    } catch (e) {
      return 'N/A';
    }
  }

  static String _getWeatherConditionFromCode(int code) {
    switch (code) {
      case 0:
        return 'Clear';
      case 1:
      case 2:
        return 'Partly Cloudy';
      case 3:
        return 'Cloudy';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
      case 61:
      case 63:
      case 65:
      case 80:
      case 81:
      case 82:
        return 'Rainy';
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return 'Snow';
      case 80:
        return 'Showers';
      case 95:
      case 96:
      case 99:
        return 'Thunderstorm';
      default:
        return 'Unknown';
    }
  }

  static String _getIconFromWeatherCode(int code) {
    switch (code) {
      case 0:
        return '01d';
      case 1:
      case 2:
        return '02d';
      case 3:
        return '04d';
      case 45:
      case 48:
        return '50d';
      case 51:
      case 53:
      case 55:
      case 61:
      case 63:
      case 65:
      case 80:
      case 81:
      case 82:
        return '09d';
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return '13d';
      case 95:
      case 96:
      case 99:
        return '11d';
      default:
        return '01d';
    }
  }
}

class WeatherForecast {
  final List<WeatherDay> forecast;

  WeatherForecast({required this.forecast});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    final List<WeatherDay> weatherDays = [];

    // Check if it's Open-Meteo API response format
    if (json.containsKey('daily') && json['daily'] is Map<String, dynamic>) {
      final daily = json['daily'] as Map<String, dynamic>;
      final List<dynamic> times = daily['time'] as List<dynamic>? ?? [];
      final List<dynamic> codes = daily['weather_code'] as List<dynamic>? ?? [];
      final List<dynamic> tempMaxes =
          daily['temperature_2m_max'] as List<dynamic>? ?? [];
      final List<dynamic> tempMins =
          daily['temperature_2m_min'] as List<dynamic>? ?? [];

      for (int i = 0;
          i < (times.length > 7 ? 7 : times.length) && i < codes.length;
          i++) {
        weatherDays.add(
          WeatherDay.fromOpenMeteo(
            times[i].toString(),
            (codes[i] as num).toInt(),
            (tempMaxes.isNotEmpty ? tempMaxes[i] : 25 as num).toDouble(),
            (tempMins.isNotEmpty ? tempMins[i] : 20 as num).toDouble(),
            i == 0, // Mark first day as today
          ),
        );
      }
    } else {
      // Fallback: Try old OpenWeatherMap format
      final List<dynamic> dailyData = json['daily'] as List<dynamic>? ?? [];

      for (int i = 0; i < (dailyData.length > 7 ? 7 : dailyData.length); i++) {
        weatherDays.add(
          WeatherDay.fromJson(
            dailyData[i] as Map<String, dynamic>,
            i == 0, // Mark first day as today
          ),
        );
      }
    }

    return WeatherForecast(forecast: weatherDays);
  }
}

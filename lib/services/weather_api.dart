import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/model/forecast_model.dart';
import 'package:weatherapp/model/weather_model.dart';

class WeatherService {
  Future<WeatherResponse> getCurrentWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': '98e8dfcf4ea2319b693eb4c58b2a6018',
      'units': 'imperial'
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherResponse.fromJson(json);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<ForecastData> getforecastWeather(String city) async {
//api.openweathermap.org/data/2.5/forecast?q=london&appid=98e8dfcf4ea2319b693eb4c58b2a6018
    final queryParameters = {
      'q': city,
      'appid': '98e8dfcf4ea2319b693eb4c58b2a6018',
      'units': 'imperial'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/forecast', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ForecastData.fromJson(json);
    } else {
      throw Exception('Failed to load forecast');
    }
  }
}

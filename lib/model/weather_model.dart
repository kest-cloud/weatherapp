//
// class CountryInfo {
//   final String countryName;

//   CountryInfo({required this.countryName});

//   factory CountryInfo.fromJson(Map<String, dynamic> json) {
//     final countryName = json['country'];
//     return CountryInfo(countryName: countryName);
//   }
// }

// ignore_for_file: unnecessary_new

class WeatherCountry {
  final String countryName;

  WeatherCountry({required this.countryName});

  factory WeatherCountry.fromJson(Map<String, dynamic> json) {
    final countryName = json['country'];

    return WeatherCountry(countryName: countryName);
  }
}

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];

    return WeatherInfo(
      description: description,
      icon: icon,
    );
  }
}

class TemperatureInfo {
  final double temperature;

  TemperatureInfo({required this.temperature});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return TemperatureInfo(temperature: temperature);
  }
}

class WeatherResponse {
  final DateTime date;
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final WeatherCountry weatherCountry;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse(
      {required this.date,
      required this.weatherCountry,
      required this.cityName,
      required this.tempInfo,
      required this.weatherInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final weatherCountry = WeatherCountry.fromJson(json['sys']);

    final date =
        DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false);

    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(
        date: date,
        weatherCountry: weatherCountry,
        cityName: cityName,
        tempInfo: tempInfo,
        weatherInfo: weatherInfo);
  }
}

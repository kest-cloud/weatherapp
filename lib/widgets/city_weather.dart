// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/model/forecast_model.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/screens/forecast_weather.dart';
import 'package:weatherapp/services/weather_api.dart';

class CityWeather extends StatefulWidget {
  String cityName = 'London';
  CityWeather({Key? key, required this.cityName}) : super(key: key);

  @override
  _CityWeatherState createState() => _CityWeatherState();
}

class _CityWeatherState extends State<CityWeather> {
  final _cityTextController = TextEditingController();
  final _weatherApiClient = WeatherService();
  WeatherResponse? _weatherModel;
  ForecastData? _forecastData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: _cityTextController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "find by city name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: _search, child: Text("search")),
              ],
            ),
          ),

          //if weatherModel is not null then show weather data
          if (_weatherModel != null)
            Column(
              children: [
                Text(_weatherModel!.cityName, style: TextStyle(fontSize: 30)),
                SizedBox(height: 20),
                Text(_weatherModel!.weatherCountry.countryName,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 20),
                Image.network(
                  _weatherModel!.iconUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                Text(
                  '${_weatherModel!.tempInfo.temperature} ??F',
                  style: TextStyle(fontSize: 40),
                ),
                Text(_weatherModel!.weatherInfo.description),
                SizedBox(height: 10.0),
                Text(_weatherModel!.date.toString(),
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 15.0),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherDetailsForCity(
                                cityName: _weatherModel!.cityName)),
                      );
                    },
                    child: Text("More Weather Details for City")),
              ],
            ),
        ],
      ),
    );
  }

//mwthod to get current weather
  void _search() async {
    final _response =
        await _weatherApiClient.getCurrentWeather(_cityTextController.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _weatherModel = _response;
    });
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/screens/forecast_weather.dart';
import 'package:weatherapp/services/weather_api.dart';

import 'package:weatherapp/widgets/city_weather.dart';
import 'package:weatherapp/widgets/concert_list.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _weatherApiClient = WeatherService();
  WeatherResponse? _weatherModel;
  String concertcity = '';

//method to get current weather data
  void cityweather(String city) async {
    final _response = await _weatherApiClient.getCurrentWeather(city);
    setState(() {
      _weatherModel = _response;
    });
  }

  @override
  void initState() {
    super.initState();
    initweather();
  }

  Future<void> setWeatherData(dataa) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('data', dataa);
  }

  void getWeather() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // dataValue = prefs.getStringList('data');]

    setState(() {
      _weatherModel =
          WeatherResponse.fromJson(json.decode(prefs.getString('data')!));
    });
  }

  void initweather() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      getWeather();
    } else {
      cityweather(concertcity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
        title: Text("Weather App"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(title: 'Weather App')));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Concerts City List for Band",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("*click on the city to see current weather",
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
            ListView.builder(
                shrinkWrap: true,
                itemCount: ConcertCity.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                    child: Card(
                      child: ListTile(
                        onTap: () async {
                          cityweather(ConcertCity[index]);
                          concertcity = ConcertCity[index];
                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                        },
                        title: Text(ConcertCity[index].toString()),
                        leading: CircleAvatar(),
                      ),
                    ),
                  );
                }),
            SizedBox(height: 10),
            CityWeather(
              cityName: _weatherModel != null ? _weatherModel!.cityName : '',
            ),
            if (_weatherModel != null)
              Column(
                children: [
                  Divider(thickness: 2),
                  Text('Current Weather for Proposed City Concert'),
                  Text(_weatherModel!.cityName, style: TextStyle(fontSize: 30)),
                  SizedBox(height: 10),
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
                    '${_weatherModel!.tempInfo.temperature.toString()}??F',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(_weatherModel!.weatherInfo.description),
                  SizedBox(height: 15.0),
                  Text(_weatherModel!.date.toString(),
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
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
                  SizedBox(height: 15.0),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

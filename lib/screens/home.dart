// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/forecast_model.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/screens/forecast_weather.dart';
import 'package:weatherapp/services/weather_api.dart';
import 'package:weatherapp/widgets/city_weather.dart';
import 'package:weatherapp/widgets/concert_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _weatherApiClient = WeatherService();
  WeatherResponse? _weatherModel;
  ForecastData? _forecastData;

//method to get current weather data
  void cityweather(String city) async {
    final _response = await _weatherApiClient.getCurrentWeather(city);
    setState(() {
      _weatherModel = _response;
    });
  }

  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());

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
                        onTap: () {
                          cityweather(ConcertCity[index]);
                          print(ConcertCity[index]);
                        },
                        title: Text(ConcertCity[index].toString()),
                        leading: CircleAvatar(
                            // backgroundImage:
                            //     AssetImage('assets/${data[index].avatar}'),
                            ),
                      ),
                    ),
                  );
                }),
            SizedBox(height: 10),
            CityWeather(
              cityName: _weatherModel != null ? _weatherModel!.cityName : '',
            ),
            if (_weatherModel != null) CurrentWeather(),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:convert';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/model/forecast_model.dart';
import 'package:weatherapp/services/weather_api.dart';
import 'package:weatherapp/utils/weather_bank.dart';
import 'package:connectivity/connectivity.dart';

class WeatherDetailsForCity extends StatefulWidget {
  final String cityName;

  const WeatherDetailsForCity({Key? key, required this.cityName})
      : super(key: key);

  @override
  _WeatherDetailsForCityState createState() => _WeatherDetailsForCityState();
}

class _WeatherDetailsForCityState extends State<WeatherDetailsForCity> {
  final weatherApiClient = WeatherService();

  ForecastData _forecastData = ForecastData(daily: []);

  //method to get the weather data for the city
  void cityyweather(String city) async {
    final _res = await weatherApiClient.getforecastWeather(widget.cityName);
    setState(() {
      _forecastData = _res;
    });
    setWeatherData(json.encode(_forecastData.toJsonList()));
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
      _forecastData = ForecastData.fromJson(
          {'list': List.from(json.decode(prefs.getString('data')!))});
    });
  }

  void initweather() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      getWeather();
    } else {
      cityyweather(widget.cityName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.cityName + " City"),
      ),

      //if forecatedata is null then show loading else show data
      body: _forecastData == null
          ? Container(
              child: Center(
                child: Text('Loading...'),
              ),
            )
          : Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      initweather();
                    },
                    child: Text("This is Weather info for " +
                        widget.cityName +
                        " City every three hours")),

                //if forecatedata is null then show loading else show data

                _forecastData.daily.length != null
                    ? Container(
                        width: MediaQuery.of(context).size.width * 4,
                        height: MediaQuery.of(context).size.height / 4,
                        child: ListView.builder(
                            itemCount: _forecastData.daily.length >= 40
                                ? 40
                                : _forecastData.daily.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Card(
                                  color: Colors.teal,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            "${_forecastData.daily[index].temp.toString()} °F",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20)),
                                        SizedBox(height: 10),
                                        Text(
                                            _forecastData
                                                .daily[index].description,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0)),
                                        SizedBox(height: 10),
                                        Text(
                                            DateFormat('EEEE').format(
                                                _forecastData
                                                    .daily[index].date),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontStyle: FontStyle.italic)),
                                        Text(
                                            DateFormat('MMMM d, yyyy').format(
                                                _forecastData
                                                    .daily[index].date),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontStyle: FontStyle.italic)),
                                        Text(
                                            DateFormat('kk:mm').format(
                                                _forecastData
                                                    .daily[index].date),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontStyle: FontStyle.italic)),

                                        // DateFormat("MMMM d").format(date)
                                      ],
                                    ),
                                  ),
                                )),
                      )
                    : Container(
                        child: Center(
                          child: Text('Loading...'),
                        ),
                      ),
              ]),
            ),
    );
  }
}

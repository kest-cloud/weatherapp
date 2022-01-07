// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weatherapp/model/forecast_model.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/services/weather_api.dart';

class WeatherDetailsForCity extends StatefulWidget {
  final String cityName;

  const WeatherDetailsForCity({Key? key, required this.cityName})
      : super(key: key);

  @override
  _WeatherDetailsForCityState createState() => _WeatherDetailsForCityState();
}

class _WeatherDetailsForCityState extends State<WeatherDetailsForCity> {
  WeatherService? _weatherService;
  ForecastData? _forecastData;
  WeatherData? _weatherData;
  WeatherResponse? _weatherModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityName),
      ),
      body: _weatherModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(_weatherData!.name,
                              style: TextStyle(color: Colors.black12)),
                          SizedBox(height: 10),
                          Text(_weatherModel!.weatherCountry.countryName,
                              style: TextStyle(fontSize: 15)),
                          Text(_weatherModel!.tempInfo.temperature.toString(),
                              style: const TextStyle(color: Colors.black12)),
                          Image.network(_weatherModel!.iconUrl),
                          Text(_weatherModel!.weatherInfo.description,
                              style: TextStyle(color: Colors.white)),
                          Text(_weatherModel!.date.toString(),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: new Icon(Icons.refresh),
                        tooltip: 'Refresh',
                        onPressed: () => null,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              _forecastData != null
                  ? ListView.builder(
                      itemCount: _forecastData!.list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => WeatherItem(
                          weather: _forecastData!.list.elementAt(index)))
                  : Container(),
            ])),
    );
  }
}

class WeatherItem extends StatefulWidget {
  WeatherItem({Key? key, weather}) : super(key: key);

  @override
  _WeatherItemState createState() => _WeatherItemState();
}

class _WeatherItemState extends State<WeatherItem> {
  WeatherService? _weatherService;
  ForecastData? _forecastData;
  WeatherData? _weatherData;
  WeatherResponse? _weatherModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200.0,
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(_weatherData!.name,
                              style: TextStyle(color: Colors.black)),
                          Text(_weatherModel!.weatherCountry.countryName,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 24.0)),
                          Text(_weatherModel!.tempInfo.temperature.toString(),
                              style: TextStyle(color: Colors.black)),
                          Image.network(
                            _weatherModel!.iconUrl,
                            height: 100,
                            width: 100,
                          ),
                          Text(_weatherModel!.weatherInfo.description,
                              style: TextStyle(color: Colors.black)),
                          Text(_weatherModel!.date.toString(),
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final weatherApiClient = WeatherService();

  ForecastData _forecastData = ForecastData(daily: []);

  // late WeatherResponse _weatherModel = WeatherResponse(
  //   cityName: _weatherModel.cityName,
  //   tempInfo: _weatherModel.tempInfo,
  //   weatherInfo: _weatherModel.weatherInfo,
  //   weatherCountry: _weatherModel.weatherCountry,
  //   date: _weatherModel.date,
  // );

  void cityyweather(String city) async {
    final _response = await weatherApiClient.getCurrentWeather(widget.cityName);

    final _res = await weatherApiClient.getforecastWeather(widget.cityName);

    setState(() {
      // _weatherModel = _response;
      _forecastData = _res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.cityName),
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
                      cityyweather(widget.cityName);
                    },
                    child: Text(
                        "Get " + widget.cityName + " iWeather for five days")),

                //if forecatedata is null then show loading else show data
                _forecastData.daily.length != null
                    ? Container(
                        width: MediaQuery.of(context).size.width * 4,
                        height: MediaQuery.of(context).size.height / 4,
                        child: ListView.builder(
                            itemCount: _forecastData.daily.length >= 20
                                ? 20
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

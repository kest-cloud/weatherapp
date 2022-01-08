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
        title: Text(widget.cityName),
      ),
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
                    child: Text("Get Weather for five days")),
                _forecastData.daily.length != null
                    ? Container(
                        width: MediaQuery.of(context).size.width * 4,
                        height: MediaQuery.of(context).size.height / 5,
                        child: ListView.builder(
                            itemCount: _forecastData.daily.length >= 5
                                ? 5
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
                                            _forecastData.daily[index].temp
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.black)),
                                        // Text(_weatherModel!.weatherCountry.countryName,
                                        //     style: TextStyle(
                                        //         color: Colors.black, fontSize: 24.0)),
                                        // Text(_weatherModel!.tempInfo.temperature.toString(),
                                        //     style: TextStyle(color: Colors.black)),
                                        // Image.network(
                                        //   _weatherModel!.iconUrl,
                                        //   height: 100,
                                        //   width: 100,
                                        // ),
                                        Text(
                                            _forecastData
                                                .daily[index].description,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0)),
                                        Text(
                                            _forecastData.daily[index].date
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.black)),
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

// //"${getDateFromTimestamp(_forcast.daily[index].dt)}"

// class WeatherItem extends StatefulWidget {
//   WeatherItem({Key? key, weather}) : super(key: key);

//   @override
//   _WeatherItemState createState() => _WeatherItemState();
// }

// class _WeatherItemState extends State<WeatherItem> {
//   final ForecastData _forecastData = ForecastData(daily: []);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Container(
//             height: 200.0,
//             child: ListView.builder(
//                 itemCount: _forecastData.daily.length >= 5
//                     ? 5
//                     : _forecastData.daily.length,
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemBuilder: 
//     );
//   }
// }




// Expanded(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //       Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           children: <Widget>[
                  //             ElevatedButton(
                  //                 onPressed: () {
                  //                   cityyweather(widget.cityName);
                  //                 },
                  //                 child: Text("Get Weather for five days")),
                  //             Text(_weatherModel.cityName,
                  //                 style: TextStyle(color: Colors.black12)),
                  //             SizedBox(height: 10),
                  //             Text(_weatherModel.weatherCountry.countryName,
                  //                 style: TextStyle(fontSize: 15)),
                  //             Text(_weatherModel.tempInfo.temperature.toString(),
                  //                 style: const TextStyle(color: Colors.black12)),
                  //             Image.network(_weatherModel.iconUrl),
                  //             Text(_weatherModel.weatherInfo.description,
                  //                 style: TextStyle(color: Colors.white)),
                  //             Text(_weatherModel.date.toString(),
                  //                 style: TextStyle(fontSize: 20)),
                  //           ],
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: IconButton(
                  //           icon: Icon(Icons.refresh),
                  //           tooltip: 'Refresh',
                  //           onPressed: () => null,
                  //           color: Colors.blue,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
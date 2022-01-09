// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:weatherapp/model/forecast_model.dart';

// class UserSimplePreferences {
//   static SharedPreferences _preferences =
//       SharedPreferences.getInstance() as SharedPreferences;

//   static const _keyforecastData = 'forecastData';

//   static Future init() async =>
//       _preferences = await SharedPreferences.getInstance();

//   static Future setForecastData(List<dynamic> data) async {
//     await _preferences.setStringList(
//         _keyforecastData, data.map((e) => jsonEncode(e)).toList());
//   }

//   static List<dynamic> getForecastData() => _preferences
//       .getStringList(_keyforecastData)!
//       .map((e) => ForecastData.fromJson(json.decode(e)))
//       .toList();
// }





// //  static Future setUsername(String username) async =>
// //       await _preferences.setString(_keyUsername, username);

// //   static String getUsername() => _preferences.getString(_keyUsername);
class Daily {
  final int rawDate;
  final DateTime date;
  final num temp;
  final String description;

  Daily(
      {required this.date,
      required this.temp,
      required this.description,
      required this.rawDate});

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      rawDate: json['dt'],
      date:
          DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      temp: json['main']['temp'],
      description: json['weather'][0]['description'],
    );
  }

  Map toJson() {
    return {
      'dt': rawDate,
      'main': {'temp': temp},
      'weather': [
        {'description': description}
      ]
    };
  }
}

class ForecastData {
  late final List<Daily> daily;

  ForecastData({required this.daily});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    print(json);
    List dailyData = json['list'];

    List<Daily> daily = <Daily>[];

    for (var item in dailyData) {
      var day = Daily.fromJson(item);
      daily.add(day);
    }

    return ForecastData(daily: daily);
  }

  List<Map> toJsonList() {
    return daily.map((e) => e.toJson()).toList();
  }
}

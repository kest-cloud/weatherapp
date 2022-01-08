class Daily {
  final DateTime date;
  final num temp;
  final String description;

  Daily({required this.date, required this.temp, required this.description});

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      date:
          DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      temp: json['main']['temp'],
      description: json['weather'][0]['description'],
    );
  }
}

class ForecastData {
  final List<Daily> daily;

  ForecastData({required this.daily});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    List dailyData = json['list'];

    List<Daily> daily = <Daily>[];

    for (var item in dailyData) {
      var day = Daily.fromJson(item);
      daily.add(day);
    }

    return ForecastData(daily: daily);
  }
}

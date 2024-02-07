import 'dart:convert';

import 'package:http/http.dart';

class Worker {
  String location;

  // Constructor
  Worker({required this.location}) {
    location = this.location;
  }

  int temp = 0;
  String humidity = "";
  String airSpeed =
      ""; // Updated variable name to follow Dart naming conventions
  String description = "";
  String main = "";
  String icon = "";

  // Method to fetch data
  Future<void> getData() async {
    try {
      Response response = await get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=d30e4401f8bc49e986173b0fcb2e1489"),
      );
      Map<String, dynamic> data = jsonDecode(response.body);

      // Getting temperature and humidity
      Map<String, dynamic> tempData = data['main'];
      double getHumidity = tempData['humidity'].toDouble(); //%
      double getTemp =
          tempData['temp'].toDouble() - 273.15; //kalvin to farenhight

      // Getting air speed
      Map<String, dynamic> getWind = data['wind'];
      double getAirSpeed =
          getWind['speed'].toDouble() / 0.27777777777778; //m/s to km/h

      // Getting description
      List<dynamic> getWeatherData = data['weather'];
      Map<String, dynamic> getWeatherMainData = getWeatherData[0];
      String getMainDes = getWeatherMainData['main'];
      String getDesc = getWeatherMainData['description'];
      icon = getWeatherMainData['icon'];

      // Assigning weather
      temp = getTemp.toInt(); //C
      humidity = getHumidity.toString(); //%
      airSpeed = getAirSpeed.toString(); //km/hr
      description = getDesc;
      main = getMainDes;
    } catch (e) {
      //temp = "Can't get weather";
      humidity = "N/A";
      airSpeed = "N/A";
      description = "Can't get weather";
      main = "N/A";
      icon = "03n";
    }
  }
}

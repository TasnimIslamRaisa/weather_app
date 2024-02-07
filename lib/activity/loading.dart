import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/worker/worker.dart';

class Loading extends StatefulWidget {
  //const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String city = "Chittagong";
  late String temp;
  late String humidity;
  late String airSpeed;
  late String description;
  late String main;
  late String icon;
  // Method to fetch data
  void fetchData(String city) async {
    Worker instance = Worker(location: city);
    await instance.getData();

    temp = instance.temp.toString();
    humidity = instance.humidity;
    description = instance.description;
    airSpeed = instance.airSpeed;
    main = instance.main;
    icon = instance.icon;
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'temp': temp,
      'humidity': humidity,
      'description': description,
      'airSpeed': airSpeed,
      'main': main,
      'icon': icon,
      'city': city,
    });
  }

  @override
  void initState() {
    super.initState();
    // Call the method to fetch data
  }

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic>? search =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;
    //city = search["searchText"];
    if (search != null && search.isNotEmpty) {
      city = search["searchText"];
    }

    fetchData(city);

    //fetchData(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 180,
                ),
                Image.asset("image/weather_logo.png", height: 200, width: 200),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Weather App",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 170,
                    ),
                    Icon(
                      Icons.copyright_outlined,
                      size: 12,
                      color: Colors.white,
                    ),
                    Text(
                      "Made By Raisa",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SpinKitWave(
                  color: Colors.white,
                  size: 30.0,
                )
              ]),
        ),
      ),
      backgroundColor: Colors.blue.shade500,
    );
  }
}

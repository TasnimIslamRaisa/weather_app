import 'dart:math';
import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  late String city;
  late String temp;
  late String humidity;
  late String airSpeed;
  late String description;
  late String main;
  late String icon;

  @override
  void initState() {
    super.initState();

    print("init state");
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print("set state call");
  }

  @override
  Widget build(BuildContext context) {
    var cityName = ['Chittagong', 'Dhaka', 'Rajshahi'];
    final _random = new Random();
    var city = cityName[_random.nextInt(cityName.length)];
    //data retreive before return
    Map<dynamic, dynamic> info =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;

    temp = info['temp'] as String;
    humidity = info['humidity'] as String;
    description = info['description'] as String;
    airSpeed = info['airSpeed'] as String;
    main = info['main'] as String;
    icon = info['icon'] as String;
    city = info['city'] as String;
    if (temp == "N/A") {
      print("N/A");
    } else {
      temp = info['temp'] as String;
      airSpeed = info['airSpeed'] as String;
    }
    return Scaffold(
      //impt : bottom error fixed
      resizeToAvoidBottomInset: false,
      // //how to generate solid color on appBar
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.white10,
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          // ignore: avoid_unnecessary_containers
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // stops: [
              //   0, 1, //orange will be 10% of the body
              //   0.5 //pink will be 50% of the body
              // ],
              colors: [
                const Color.fromRGBO(255, 255, 255, 1),
                Colors.blueAccent
              ],
            )),
            child: Column(children: <Widget>[
              Container(
                //Search Container
                // color: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 8),
                // ignore: prefer_const_constructors
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      //when tap on search bar
                      onTap: () {
                        if ((searchController.text).replaceAll(" ", "") == "") {
                          print("Blank search");
                        }
                        {
                          Navigator.pushReplacementNamed(context, "/loading",
                              arguments: {
                                "searchText": searchController.text,
                              });
                          print(searchController.text);
                        }
                      },
                      child: Container(
                          // padding: ,
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          child: Icon(Icons.search)),
                    ),
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search $city",
                        border: InputBorder.none,
                      ),
                    )),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      padding: EdgeInsets.all(28),
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Row(
                        children: [
                          Image.network(
                              "https://openweathermap.org/img/wn/$icon@2x.png"),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                description,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "In $city",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      padding: EdgeInsets.all(60),
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.thermostat),
                          Row(
                            children: [
                              SizedBox(
                                width: 35,
                              ),
                              Text(
                                temp,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 90),
                              ),
                              Text(
                                "C",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 70),
                              )
                            ],
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      padding: EdgeInsets.all(30),
                      height: 200,
                      margin: EdgeInsets.fromLTRB(30, 0, 10, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.sunny_snowing),
                            ],
                          ),
                          SizedBox(height: 22),
                          Text(
                            double.parse(airSpeed).toStringAsFixed(2),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                            ),
                          ),
                          Text("Km/hr"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      padding: EdgeInsets.all(30),
                      height: 200,
                      margin: EdgeInsets.fromLTRB(10, 0, 30, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.water_drop_sharp),
                            ],
                          ),
                          SizedBox(height: 22),
                          Text(
                            humidity,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 30),
                          ),
                          Text("Percent"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Made by Raisa"),
                      Text("Data provided by Openweathermap.org"),
                    ],
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}

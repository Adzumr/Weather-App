import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;

const apiKey = 'ccc00165de8167fbef1e32dc45387785';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var latitude;
  var longtitude;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Location location = Location();
  void getLocation() async {
    await location.getCurrentLocation();
    latitude = location.latitude;
    longtitude = location.longitude;
    getData();
  }

  void getData() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longtitude&appid=$apiKey');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var decodedData = jsonDecode(jsonData);

      var condition = decodedData["weather"][0]["id"];
      var cityName = decodedData["name"];
      var temperature = decodedData["main"]["temp"];
      var weatherDescription = decodedData["weather"][0]["description"];

      print(condition);
      print(cityName);
      print(temperature);
      print(weatherDescription);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text("Get Location"),
        ),
      ),
    );
  }
}

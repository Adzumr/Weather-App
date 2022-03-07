import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
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
  WeatherFactory weatherFactory =
      WeatherFactory(apiKey, language: Language.ENGLISH);

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
    weatherData();
  }

  void weatherData() async {
    Weather weather =
        await weatherFactory.currentWeatherByLocation(latitude, longtitude);
    print(weather.areaName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            weatherData();
          },
          child: const Text("Get Location"),
        ),
      ),
    );
  }
}

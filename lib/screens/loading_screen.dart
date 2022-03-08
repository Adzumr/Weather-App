import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;

const _apiKey = 'ccc00165de8167fbef1e32dc45387785';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late WeatherFactory weatherFactory;
  double? latitude, longtitude;
  var cityName;
  var country;
  var temperature;

  @override
  void initState() {
    super.initState();
    getLocation();
    weatherFactory = WeatherFactory(_apiKey, language: Language.ENGLISH);
  }

  Location location = Location();
  void getLocation() async {
    await location.getCurrentLocation();
    latitude = location.latitude;
    longtitude = location.longitude;
    weatherData();
  }

  void weatherData() async {
    Weather weather = await weatherFactory.currentWeatherByLocation(
        latitude ?? 25.0, longtitude ?? 25.0);

    cityName = weather.areaName;
    country = weather.country;
    temperature = weather.temperature;
    print(weather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListTile(
          title: Text(country ?? "Network Error"),
          subtitle: Text(cityName ?? "Network Error"),
          trailing: Text(temperature.toString()),
        ),
      ),
    );
  }
}

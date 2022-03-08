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

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    Weather weather = await weatherFactory.currentWeatherByLocation(
        location.latitude, location.longitude);

    setState(() {
      cityName = weather.areaName ?? 'Reolad';
      country = weather.country ?? 'Reload';
      temperature = weather.temperature;
    });
    print(weather);
    // weatherData();
  }

  // void weatherData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListTile(
          title: Text(country ?? "Network Error"),
          subtitle: Text(cityName ?? "Network Error"),
          trailing: Text(temperature.toString()),
          leading: TextButton(
            child: const Text("Reload"),
            onPressed: () => getLocation(),
          ),
        ),
      ),
    );
  }
}

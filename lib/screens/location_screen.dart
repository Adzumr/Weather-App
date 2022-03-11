import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/services/weatherModel.dart';

class LocationScreen extends StatefulWidget {
  final Weather locationWeather;

  const LocationScreen({required this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherFactory weatherFactory =
      WeatherFactory('ccc00165de8167fbef1e32dc45387785');
  WeatherModel weatherModel = WeatherModel();
  dynamic weatherIcon;
  dynamic condition;
  dynamic temperature;
  dynamic cityName;
  dynamic country;
  dynamic description;
  dynamic searchCityName;
  dynamic date;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  Future searchedCity({required String resultName}) async {
    Weather weather = await weatherFactory.currentWeatherByCityName(resultName);
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true && weather.areaName != null) {}
    setState(() {
      if (weather.areaName != null) {
        condition = weather.weatherConditionCode;
        cityName = weather.areaName;
        country = weather.country;
        description = weather.weatherDescription;
        weatherIcon = weatherModel.getWeatherIcon(condition);
        date = weather.date;
        dynamic extractedTemp = weather.temperature.toString();
        var temp = extractedTemp.replaceAll(RegExp(r'[^0-9]'), '');

        if (temp.length >= 1) {
          temp = temp.substring(0, temp.length - 1);
          temperature = int.parse(temp ?? "0");
        }
      } else {
        condition = 0;
        cityName = "";
        country = "";
        description = "";
        weatherIcon = "";
        date = DateTime.now();
      }
    });
  }

  void updateUI(Weather weatherData) async {
    setState(() {
      if (weatherData == true) {
        condition = 0;
        cityName = "";
        country = "";
        description = "";
        weatherIcon = "";
        date = DateTime.now().toString();
        return;
      }
      condition = weatherData.weatherConditionCode;
      cityName = weatherData.areaName;
      country = weatherData.country;
      description = weatherData.weatherDescription;
      date = weatherData.date;
      weatherIcon = weatherModel.getWeatherIcon(condition);

      try {
        dynamic extractedTemp = weatherData.temperature.toString();
        var temp = extractedTemp.replaceAll(RegExp(r'[^0-9]'), '');

        if (temp.length >= 1) {
          temp = temp.substring(0, temp.length - 1);
          temperature = int.parse(temp ?? "0");
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                onSubmitted: (value) {
                  setState(() {
                    searchCityName = value;
                    searchedCity(resultName: searchCityName);
                  });
                },
                autofocus: false,
                keyboardType: TextInputType.streetAddress,
                toolbarOptions: const ToolbarOptions(
                  selectAll: true,
                  copy: true,
                  cut: true,
                  paste: true,
                ),
                showCursor: true,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    hintText: "Search City",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
              Column(
                children: [
                  Text(
                    cityName,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    country,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Text(
                "$temperature°",
                style: const TextStyle(
                  fontSize: 120,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    weatherIcon,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  updateUI(widget.locationWeather);
                },
                child: const Icon(
                  Icons.replay,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

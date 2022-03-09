import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/services/weatherModel.dart';

class LocationScreen extends StatefulWidget {
  final Weather locationWeather;

  const LocationScreen({required this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  @override
  Widget build(BuildContext context) {
    Weather weatherResult = widget.locationWeather;
    dynamic condition = weatherResult.weatherConditionCode;
    print(condition);
    dynamic temperature;
    dynamic weatherIcon = weatherModel.getWeatherIcon(condition);

    try {
      dynamic extractedTemp = weatherResult.temperature.toString();
      var temp = extractedTemp.replaceAll(new RegExp(r'[^0-9]'), '');

      if (temp.length >= 1) {
        temp = temp.substring(0, temp.length - 1);

        temperature = int.parse(temp ?? "0");
        print(temperature);
      }
    } catch (e) {
      log(e.toString());
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const TextField(
                autofocus: false,
                keyboardType: TextInputType.streetAddress,
                toolbarOptions: ToolbarOptions(
                  selectAll: true,
                  copy: true,
                  cut: true,
                  paste: true,
                ),
                showCursor: true,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
              Column(
                children: [
                  Text(
                    weatherResult.areaName.toString() +
                        "," +
                        weatherResult.country.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    DateTime.now().minute.toString(),
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
                    weatherIcon,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    weatherResult.weatherDescription.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
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

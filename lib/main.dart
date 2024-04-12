import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/screens/home_screen.dart';

void main() async {
  runApp(
    const WeatherForecastApp(),
  );
  sharedPreferences = await SharedPreferences.getInstance();
}

SharedPreferences? sharedPreferences;

class WeatherForecastApp extends StatelessWidget {
  const WeatherForecastApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Forecast',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

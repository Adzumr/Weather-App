import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/location.dart';

const _apiKey = 'ccc00165de8167fbef1e32dc45387785';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherFactory weatherFactory =
      WeatherFactory(_apiKey, language: Language.ENGLISH,);

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    Weather weather = await weatherFactory.currentWeatherByLocation(
        location.latitude, location.longitude);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weather);
    }));
    // weatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: const CircularProgressIndicator(
            color: Colors.green,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

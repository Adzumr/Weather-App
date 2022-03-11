import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
      WeatherFactory(_apiKey, language: Language.ENGLISH);
  bool? connectionChecker;
  @override
  void initState() {
    super.initState();

    getLocation();
  }

  void getLocation() async {
    connectionChecker = await InternetConnectionChecker().hasConnection;
    if (connectionChecker == true) {
      Location location = Location();
      await location.getCurrentLocation();

      Weather weather = await weatherFactory.currentWeatherByLocation(
          location.latitude, location.longitude);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: weather);
      })).timeout(const Duration(
        seconds: 15,
      ));
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              connectionChecker == true
                  ? const Text(
                      "No Internet Connection",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(""),
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                  backgroundColor: Colors.white,
                ),
              ),
              connectionChecker == true
                  ? TextButton(
                      onPressed: () {
                        getLocation();
                      },
                      child: const Text("Retry"),
                    )
                  : const Text("")
            ],
          ),
        ),
      ),
    );
  }
}

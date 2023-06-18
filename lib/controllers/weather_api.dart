import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/models/weather_model.dart';

import '../utils/constant.dart';

class WeatherController extends GetxController {
  bool? isLoading = false;
  double? latitude;
  double? longitude;
  // String? dafultCity = "Gombe";
  WeatherModel? weatherModel;
  Future<WeatherModel?> weatherByLocation({
    double? latitude,
    double? longitude,
  }) async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$openWeatherKey';

    try {
      isLoading = true;
      final response = await http
          .get(
            Uri.parse(
              apiUrl,
            ),
          )
          .timeout(
            const Duration(
              seconds: 10,
            ),
          );
      if (response.statusCode == 200) {
        debugPrint("Response: ${response.body}");
        weatherModel = WeatherModel.fromJson(jsonDecode(response.body));
        debugPrint("City: ${weatherModel!.name}");
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } on Exception catch (e) {
      Get.snackbar("Error", "$e");
    } finally {
      isLoading = false;
    }
    return weatherModel;
  }

  Future<WeatherModel?> weatherByName({
    String? city,
  }) async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$openWeatherKey';
    // String apiUrl =
    //     'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$openWeatherKey';

    try {
      isLoading = true;
      final response = await http
          .get(
            Uri.parse(
              apiUrl,
            ),
          )
          .timeout(
            const Duration(
              seconds: 10,
            ),
          );
      if (response.statusCode == 200) {
        weatherModel = WeatherModel.fromJson(jsonDecode(response.body));
        debugPrint("City: ${weatherModel!.name}");
        // dafultCity = weatherModel!.name;
      } else {
        Get.snackbar("Error", "Failed to fetch weather data");
        debugPrint("Failed to fetch weather data");
        throw Exception('Failed to fetch weather data');
      }
    } on Exception catch (e) {
      Get.snackbar("Error", "$e");
    } finally {
      isLoading = false;
    }
    return weatherModel;
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    latitude = await Geolocator.getCurrentPosition().then((value) {
      return value.latitude;
    });
    longitude = await Geolocator.getCurrentPosition().then((value) {
      return value.longitude;
    });
    return await Geolocator.getCurrentPosition();
  }
}

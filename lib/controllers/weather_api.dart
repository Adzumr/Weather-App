import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/controllers/location_handler.dart';
import 'package:weather_forecast/models/weather_model.dart';

import '../utils/constant.dart';
import 'permission_handler.dart';

class WeatherController extends GetxController {
  bool? isLoading = false;
  double? latitude = 10.2897;
  double? longitude = 11.1673;
  String? dafultCity = "Gombe";
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
        dafultCity = weatherModel!.name;
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

  Future<void> getLocation() async {
    try {
      bool hasLocationPermission =
          await Permissions.requestLocationPermission();
      if (hasLocationPermission) {
        await LocationService().getLocation().then((value) async {
          latitude = value!.latitude!;
          longitude = value.longitude!;
          return null;
        });
      } else {
        debugPrint('Location permission not granted');
        throw Exception('Location permission not granted');
      }
    } on Exception catch (e) {
      Get.snackbar(
        "Error",
        "$e",
      );
    }
  }
}

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_forecast/screens/about.dart';
import 'package:weather_forecast/utils/app_colors.dart';
import 'package:weather_forecast/utils/app_fonts.dart';
import 'package:weather_forecast/utils/app_images.dart';
import 'package:weather_forecast/utils/unit_converter.dart';

import '../controllers/weather_api.dart';
import 'widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  final weatherController = Get.put(WeatherController());
  bool? isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    await weatherController.getLocation();
    await weatherController.weatherByLocation(
      latitude: weatherController.latitude,
      longitude: weatherController.longitude,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: isLoading!
            ? const LoadingWidget()
            : Container(
                padding: const EdgeInsets.all(20),
                height: screenSize.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.logo),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimSearchBar(
                            autoFocus: false,
                            rtl: false,
                            width: screenSize.width * .75,
                            textController: searchController,
                            onSuffixTap: () {
                              setState(() {
                                searchController.clear();
                              });
                            },
                            onSubmitted: (value) async {
                              setState(() {
                                isLoading = true;
                              });

                              await weatherController.weatherByName(
                                city: value,
                              );
                              setState(() {
                                isLoading = false;
                              });
                            },
                          ),
                          IconButton(
                            color: AppColors.whiteColor,
                            onPressed: () {
                              Get.to(() => const AboutScreen());
                            },
                            icon: const Icon(
                              Icons.settings,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${weatherController.weatherModel!.name}, ${weatherController.weatherModel!.sys!.country!}",
                        style: AppFonts.headingStyle,
                      ),
                      RichText(
                        text: TextSpan(
                          text:
                              "${UnitConverter.kelvinToCelsius(kelvin: weatherController.weatherModel!.main!.temp!).truncate()}",
                          style: AppFonts.subHeadingStyle,
                          children: [
                            TextSpan(
                              text: '°C',
                              style: AppFonts.subHeadingStyle.copyWith(
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Min: ${UnitConverter.kelvinToCelsius(kelvin: weatherController.weatherModel!.main!.tempMin!).truncate()}°C',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppFonts.smallBody,
                          ),
                          Text(
                            'Max: ${UnitConverter.kelvinToCelsius(kelvin: weatherController.weatherModel!.main!.tempMax!).truncate()}°C',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppFonts.smallBody,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        weatherController.weatherModel!.weather![0].main!,
                        style: AppFonts.bodyStyle,
                      ),
                      Text(
                        weatherController
                            .weatherModel!.weather![0].description!,
                        style: AppFonts.smallBody,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Wind Speed: ${weatherController.weatherModel!.wind!.speed!} km/h',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppFonts.bodyStyle,
                      ),
                      Text(
                        'Humidity: ${weatherController.weatherModel!.main!.humidity!}%',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppFonts.bodyStyle,
                      ),
                      Text(
                        'Sunrise: ${UnitConverter.formatTime(weatherController.weatherModel!.sys!.sunrise!)}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppFonts.bodyStyle,
                      ),
                      Text(
                        'Sunset: ${UnitConverter.formatTime(weatherController.weatherModel!.sys!.sunset!)}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppFonts.bodyStyle,
                      ),
                      Text(
                        'Feels Like: ${UnitConverter.kelvinToCelsius(kelvin: weatherController.weatherModel!.main!.feelsLike!).truncate()}°C',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppFonts.bodyStyle,
                      ),
                      Text(
                        'Pressure: ${weatherController.weatherModel!.main!.pressure!} hPa',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppFonts.bodyStyle,
                      ),
                      Text(
                        'Visibility: ${weatherController.weatherModel!.visibility! / 1000} km',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppFonts.bodyStyle,
                      ),
                      Text(
                        'Clouds: ${weatherController.weatherModel!.clouds!.all!} %',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppFonts.bodyStyle,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

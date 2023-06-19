import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_forecast/utils/app_colors.dart';
import 'package:weather_forecast/utils/app_fonts.dart';

import '../utils/app_images.dart';
import 'widgets/about_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(width: 20),
              Text(
                "Project information",
                textAlign: TextAlign.center,
                style: AppFonts.bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.purpleBlue,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Image(
                        image: AssetImage(AppImages.kashere),
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      const AboutWidget(
                        title: "Topic",
                        content: "Design and Implementation of a Weather",
                      ),
                      const AboutWidget(
                        title: "Name",
                        content: "Sabiu Isyaku",
                      ),
                      const AboutWidget(
                        title: "Matric Number",
                        content: "FUKD/SCI/19/COM/0301",
                      ),
                      const AboutWidget(
                        title: "Project supervisor",
                        content: "Mr. O.S Dada",
                      ),
                      const AboutWidget(
                        title: "School",
                        content: "FEDERAL UNIVERSITY KASHERE",
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.purpleBlue,
                          foregroundColor: AppColors.whiteColor,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

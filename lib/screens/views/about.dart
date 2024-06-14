import 'package:flutter/material.dart';
import 'package:weather_forecast/main.dart';
import 'package:weather_forecast/utils/app_colors.dart';
import 'package:weather_forecast/utils/app_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    enabled = sharedPreferences!.getBool("notification") ?? false;
    super.initState();
  }

  bool? enabled;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(),
                  Text(
                    "Settings",
                    textAlign: TextAlign.center,
                    style: AppFonts.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.purpleBlue,
                    ),
                  ),
                  const Opacity(
                    opacity: 0,
                    child: BackButton(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: Text(
                      "Notification",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Switch.adaptive(
                      value: enabled!,
                      onChanged: (value) {
                        setState(
                          () {
                            enabled = value;
                            sharedPreferences!.setBool(
                              "Notification",
                              value,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // ListTile(
                  //   title: Text(
                  //     "Policy",
                  //     style: Theme.of(context).textTheme.titleLarge,
                  //   ),
                  //   trailing: Icon(
                  //     Icons.adaptive.arrow_forward,
                  //   ),
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     "Support",
                  //     style: Theme.of(context).textTheme.titleLarge,
                  //   ),
                  //   trailing: Icon(
                  //     Icons.adaptive.arrow_forward,
                  //   ),
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     "Account",
                  //     style: Theme.of(context).textTheme.titleLarge,
                  //   ),
                  //   trailing: Icon(
                  //     Icons.adaptive.arrow_forward,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

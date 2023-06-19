import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({
    required this.title,
    required this.content,
    super.key,
  });
  final String? title, content;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "$title:",
          textAlign: TextAlign.center,
          style: AppFonts.titleStyle.copyWith(
            color: AppColors.purpleBlue,
          ),
        ),
        Text(
          "$content",
          textAlign: TextAlign.center,
          style: AppFonts.bodyStyle.copyWith(
            color: AppColors.purpleBlue,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

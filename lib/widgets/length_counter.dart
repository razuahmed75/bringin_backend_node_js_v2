import 'package:flutter/material.dart';
import '../res/app_font.dart';
import '../res/color.dart';

class LengthCounter extends StatelessWidget {
  final String firstText, secondText;
  const LengthCounter(
      {super.key, required this.firstText, required this.secondText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: firstText,
                style: Styles.bodyMedium.copyWith(color: AppColors.mainColor),
              ),
              TextSpan(
                text: secondText,
                style: Styles.bodyMedium,
              ),
            ],
          ),
        )
      ],
    );
  }
}

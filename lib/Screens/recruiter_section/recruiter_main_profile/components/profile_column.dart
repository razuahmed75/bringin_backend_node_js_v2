import 'package:bringin/res/app_font.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileColumn extends StatelessWidget {
  final String firstText;
  final String secondText;

  const ProfileColumn(
      {super.key, required this.firstText, required this.secondText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(firstText, style: Styles.bodySmallSemiBold),
        const Gap(12),
        Text(secondText, style: Styles.smallText3),
      ],
    );
  }
}

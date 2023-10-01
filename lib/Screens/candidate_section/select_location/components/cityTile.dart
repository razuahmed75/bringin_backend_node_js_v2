import 'package:flutter/material.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/dimensions.dart';

class PopularCityTile extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const PopularCityTile(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(113),
      height: height(30),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: width(10)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius(12)),
        border: Border.all(width: 0.4, color: AppColors.mainColor),
      ),
      child: Text(
        text,
        style: Styles.bodyMedium1.copyWith(color: textColor),
      ),
    );
  }
}

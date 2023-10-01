import 'package:flutter/material.dart';
import '../res/color.dart';
import '../res/dimensions.dart';
import 'app_button.dart';

class BottomNavWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const BottomNavWidget({super.key, this.onTap,  this.text="Save & Next"});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
            left: width(15), right: width(15), bottom: height(10)),
        child: AppButton(
          text: text,
          textSize: font(18),
          borderRadius: BorderRadius.circular(radius(9)),
          borderColor: Colors.transparent,
          textColor: AppColors.scaffoldColor,
          bgColor: AppColors.mainColor,
          onTap: onTap,
        ),
      ),
    );
  }
}

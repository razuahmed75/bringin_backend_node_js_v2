import 'package:flutter/material.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? borderColor;
  final Color? bgColor;
  final Color? splashColor;
  final Color? highLightColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? textSize;
  final FontWeight? fontWeight;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onTap;
  final bool isLoading;

  const AppButton({
    super.key,
    this.text = "empty",
    required this.onTap,
    this.textColor = const Color(0xFF000000),
    this.borderRadius,
    this.bgColor = AppColors.mainColor,
    this.buttonWidth,
    this.buttonHeight,
    this.textSize,
    this.fontWeight = FontWeight.w600,
    this.borderColor,
    this.splashColor,
    this.highLightColor, 
    this.isLoading=false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth ?? width(220),
      height: buttonHeight ?? Dimensions.buttonHeight,
      child: MaterialButton(
        splashColor: splashColor ?? AppColors.hintColor.withOpacity(0.1),
        highlightColor: highLightColor ?? Colors.transparent,
        disabledColor: AppColors.buttonColor,
        elevation: 0,
        highlightElevation: 0.5,
        onPressed: onTap,
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(radius(6)),
          side: BorderSide(
            width: 1,
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: isLoading? Center(child: CircularProgressIndicator(color: AppColors.mainColor,)): Text(text,
            style: Styles.bodyLargeSemiBold.copyWith(
                color: textColor, fontSize: textSize,fontWeight: fontWeight)),
      ),
    );
  }
}

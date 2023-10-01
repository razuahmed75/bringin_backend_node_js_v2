import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'color.dart';

class Dimensions {
  static double screenHeight = Get.height;
  static double screenWidth = Get.width;
  static double mockupHeight = 800;
  static double mockupWidth = 360;

  /// APP DEFAULT RADIUS
  static BorderRadius kRadius = BorderRadius.circular(radius(9));

  /// MY RESUME VIEWER PAGE'S SHADOW
  static List<BoxShadow> resumeVieweShadowList = [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(.5),
            blurRadius: 5,
            spreadRadius: .5,
            offset: Offset(0, 3), 
          ),
        ];
                  

  /// APP DEFAULT CONTAINER DECORATION
  static BoxDecoration kDecoration = BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: Dimensions.kRadius,
          border: Border.all(color: AppColors.borderColor.withOpacity(.6),
          width: .25
        )
    );

  /// APP HORIZONTAL PADDING
  static EdgeInsets kDefaultPadding = EdgeInsets.symmetric(horizontal: width(15));

  /// APP GAP AFTER APPBAR
  static Gap kDefaultgapTop = const Gap(15);

  /// APP BUTTON DEFAULT HEIGHT
  static double buttonHeight = height(48);
}

/// DYNAMIC HEIGHT
double height(double inputHeight) {
  double screenHeight = Dimensions.screenHeight;
  double mockupHeight = Dimensions.mockupHeight;

  var x = mockupHeight / inputHeight;
  var y = screenHeight / x;
  return y;
}

/// DYNAMIC WIDTH
double width(double inputwidth) {
  double screenWidth = Dimensions.screenWidth;
  double mockupWidth = Dimensions.mockupWidth;

  var x = mockupWidth / inputwidth;
  var y = screenWidth / x; 
  return y;
}

/// DYNAMIC FONT
double font(double inputFont) {
  double screenHeight = Dimensions.screenHeight;
  double mockupHeight = Dimensions.mockupHeight;

  var x = mockupHeight / inputFont;
  var y = screenHeight / x;
  return y;
}

/// DYNAMIC RADIUS
double radius(double inputRadius) {
  double screenHeight = Dimensions.screenHeight;
  double mockupHeight = Dimensions.mockupHeight;

  var x = mockupHeight / inputRadius;
  var y = screenHeight / x;
  return y;
}

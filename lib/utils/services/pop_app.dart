import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/services.dart';
import '../../res/color.dart';

class PopApp {
  static DateTime? currentBackPressTime;

  static Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Helpers().showToastMessage(
        msg: "Press again to exit",
        bgColor: AppColors.whiteColor,
        textColor: AppColors.blackColor,
      );
      return Future.value(false);
    } else {
      SystemNavigator.pop();
      return Future.value(true);
    }
  }
}
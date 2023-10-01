
import 'package:bringin/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../res/color.dart';
import '../../res/constants/image_path.dart';

class Helpers {
  /// hide keyboard automatically when click anywhere in screen
  static hideKeyboard() {
    return FocusManager.instance.primaryFocus?.unfocus();
  }
  /// APP LOADER
  static appLoader({double? heights}){
   return Container(
    height: heights ?? Dimensions.screenHeight*.6,
    width: Dimensions.screenWidth,
    child: Center(
      child: SpinKitThreeBounce(
      color: Colors.black,
      size: height(25),
      ),
    ),
  );
  }
  static appLoader2(){
   return SpinKitThreeBounce(
    color: Colors.black,
    size: height(25),
    );
  }
  /// SHOW VALIDATION ERROR DIALOG
  showValidationErrorDialog({
    String errorText = "Field must not be empty!",
    String title = "Warning!",
    int durationTime = 3,
    Widget? icon,
    Widget? titleText,
    Widget? messageText,
  }) {
    Get.snackbar(
      title,
      titleText: titleText,
      icon: icon ?? Padding(
        padding: EdgeInsets.only(left: width(15),top: height(20)),
        child: SvgPicture.asset(AppImagePaths.warning),
      ), 
      errorText,
      messageText: messageText,
      colorText: AppColors.whiteColor,
      backgroundColor: AppColors.mainColor,
      duration: Duration(seconds: durationTime),
    );
  }

  /// SHOW SUCCESS TOAST MESSAGE
  showToastMessage({
    String msg = "Successfully Signed In",
    Color? bgColor = AppColors.blackColor,
    Color? textColor = AppColors.whiteColor,
    ToastGravity? gravity = ToastGravity.BOTTOM,
  }) {
    return Fluttertoast.showToast(
        msg: msg,
        backgroundColor: bgColor,
        textColor: textColor,
        gravity: gravity);
  }

  static showAlartMessage({String msg = "Sorry, something went wrong",ToastGravity? gravity}) {
    return Fluttertoast.showToast(
      msg: msg,
      backgroundColor: AppColors.scaffoldColor,
      textColor: AppColors.blackColor,
      gravity: gravity,
    );
  }
  
  /// SHOW WARNING SNACKBAR
  static showWarningMessage({
    required context,
    String title = 'An Error Occured!',
    String message =
        'The phone number should be start without "0" (zero) and only within 10 digits.',
  }) {

  }
}


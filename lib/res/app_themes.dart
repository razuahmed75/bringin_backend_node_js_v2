import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color.dart';

var LightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.whiteColor,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  // useMaterial3: true,
  highlightColor: Colors.grey.shade200,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: AppColors.whiteColor,
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: AppColors.mainColor.withOpacity(.4),
    cursorColor: AppColors.mainColor.withOpacity(.4),
    selectionHandleColor: AppColors.mainColor.withOpacity(0.4),
  ),


 
   
);

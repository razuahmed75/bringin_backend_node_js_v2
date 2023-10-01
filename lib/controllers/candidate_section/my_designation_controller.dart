import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDesignationController extends GetxController{
  static MyDesignationController get to => Get.find();
  var textFieldCtrlr = TextEditingController();
  var selectedDesignation = "".obs;

   @override
  void onInit() {
    textFieldCtrlr.addListener(() {
      update();
    });
    super.onInit();
  }
  @override
  void dispose() {
    textFieldCtrlr.dispose();
    super.dispose();
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CareerMileStoneController extends GetxController{
  static CareerMileStoneController get to => Get.find();
  var textFieldCtrlr = TextEditingController();
  var selectedAccomplishment = "".obs;
   var characterLength = 0.obs;
}
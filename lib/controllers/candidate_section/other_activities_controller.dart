import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherActivitiesController extends GetxController{
  static OtherActivitiesController get to => Get.find();
  var textFieldCtrlr = TextEditingController();
  var selectedActivitiesValue = "".obs;
  var characterLength = 0.obs;
}
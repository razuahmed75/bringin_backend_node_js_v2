import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DutiesAndResponsibilitiesController extends GetxController{
  static DutiesAndResponsibilitiesController get to => Get.find();
  var textFieldCtrlr = TextEditingController();
  var selectedResponsibilities = "".obs;
  var characterLength = 0.obs;
}
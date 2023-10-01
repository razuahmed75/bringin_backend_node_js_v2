import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepartmentController extends GetxController{
  static DepartmentController get to => Get.find();
  var textFieldCtrlr = TextEditingController();
  var selectedDepartment = "".obs;
  
  @override
  void onInit() {
    textFieldCtrlr.addListener(() => update());
    super.onInit();
  }
  @override
  void dispose() {
    textFieldCtrlr.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    textFieldCtrlr.dispose();
    super.onClose();
  }
}
import 'dart:convert';

import 'package:bringin/Http/get.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/services/helpers.dart';

class RecruiterIdentyVerifyController extends GetxController {

  @override
  void onInit() {
    emailTextEditingCtrlr.addListener(()=> update());
    linkedinTextEditingCtrlr.addListener(()=> update());
    super.onInit();
  }
  @override
  void onClose() {
    emailTextEditingCtrlr.dispose();
    linkedinTextEditingCtrlr.dispose();
    super.onClose();
  }
  @override
  void dispose() {
    emailTextEditingCtrlr.dispose();
    linkedinTextEditingCtrlr.dispose();
    super.dispose();
  }
  var isLoading = false.obs;
  var isBack = false.obs;

  /// VERIFY LINKEDIN PROFILE
  var linkedinTextEditingCtrlr = TextEditingController();

  /// VERIFY WITH WORK EMAIL
  var emailTextEditingCtrlr = TextEditingController();
  Future<void> postEmailAndLinkEdin(
      {required Map<String, dynamic>? data}) async {
    isLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.recruiterIdentyVerifyUrl, fields: data)
        .then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        print(value.body);
        isLoading.value = false;
        isBack.value = true;
      } else {
        isLoading.value = false;
        Helpers().showToastMessage(msg: jsonDecode(value.body)['message']);
        print(value.body);
      }
    });
  }
}

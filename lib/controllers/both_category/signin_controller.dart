import 'dart:convert';

import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Http/get.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/routes/route_helper.dart';

class SignInController extends GetxController with Helpers {
  final phoneFieldController = TextEditingController();
  var isLoading = false.obs;

  /// SIGN IN METHOD
  postSignIn({Map<String, String>? fields}) async {
    isLoading.value = true;
    print("posting...");
    await Httphelp.post(ENDPOINT_URL: AppConstants.signInUrl, fields: fields)
        .then((value) {
      if (value.statusCode == 200) {
        print(value.body);
        phoneFieldController.clear();
        Helpers().showToastMessage(msg: jsonDecode(value.body)['message']);
        Helpers.hideKeyboard();
        isLoading.value = false;
        Get.toNamed(RouteHelper.getOtpRoute());
      } else {
        isLoading.value = false;
        Helpers().showToastMessage(msg: "Something went wrong");
        print("not success" + value.body);
      }
    });
  }
}

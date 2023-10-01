import 'dart:convert';

import 'package:bringin/Http/get.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

import '../../Hive/hive.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/services/helpers.dart';
import '../../utils/services/keys.dart';

class UnderVerification extends GetxController {
  RxBool isLoading = false.obs;
  var verificationController = TextEditingController();
  Future<void> underverify(String code) async {
    isLoading.value = true;
    var data = await Httphelp.post(
        ENDPOINT_URL: AppConstants.underverificationUrl,
        fields: {'otp': '${code}'});
    if (data.statusCode != 200) {
      isLoading.value = false;
      Helpers().showToastMessage(msg: jsonDecode(data.body)['message']);
    } else {
      isLoading.value = false;
      HiveHelp.write(Keys.isRecruiterCompanyDocVerified, true);
      HiveHelp.write(Keys.isRecruiterProfileBasicCompleted, true);
      Get.offAllNamed(RouteHelper.getBottomNavRoute());
      Helpers().showToastMessage(msg: jsonDecode(data.body)['message']);
    }
  }
}

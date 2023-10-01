
import 'package:bringin/res/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Http/get.dart';
import 'candidate_edit_main_profile_controller.dart';

class CandidateEmailEditController extends GetxController {
  CandidateEditMainProfileController profileInfoCtrlr = Get.find();
  var emailEditingCtrlr = TextEditingController();
  var isLoading = false.obs;

  Future<void> postEmail({required Map<String, String>? data}) async {
    isLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.candidateProfileUpdateUrl, fields: data)
        .then((data) {
      if (data.statusCode == 200) {
        CandidateEditMainProfileController.to.getProfileInfo();
        if (profileInfoCtrlr.isInfoLoading == false &&
            profileInfoCtrlr.profileInfoList.isNotEmpty) {
          Get.back();
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        print(data);
      }
    });
  }

  @override
  void onInit() {
    emailEditingCtrlr.addListener(() {
      update();
    });
    emailEditingCtrlr.text = profileInfoCtrlr.profileInfoList.isEmpty
        ? ""
        : profileInfoCtrlr.profileInfoList[0].email ?? "";
    super.onInit();
  }

  @override
  void dispose() {
    emailEditingCtrlr.dispose();
    super.dispose();
  }
}

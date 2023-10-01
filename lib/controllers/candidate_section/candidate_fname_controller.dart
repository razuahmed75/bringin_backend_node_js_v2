import 'package:bringin/Http/get.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'candidate_edit_main_profile_controller.dart';

class CandidateFNameController extends GetxController {
  CandidateEditMainProfileController profileInfoCtrlr = Get.find();
  var fNameEditingCtrlr = TextEditingController();

  var isLoading = false.obs;

  Future<void> postPhone({required Map<String, String>? fields}) async {
    isLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.candidateProfileUpdateUrl, fields: fields)
        .then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        isLoading.value = false;
        CandidateEditMainProfileController.to.getProfileInfo();
        if (profileInfoCtrlr.isInfoLoading == false &&
            profileInfoCtrlr.profileInfoList.isNotEmpty) {
          Get.back();
        }
      } 
      else {
        isLoading.value = false;
        print(data.body);
      }
    });
  }

  @override
  void onInit() {
    fNameEditingCtrlr.addListener(() {
      update();
    });
    fNameEditingCtrlr.text = profileInfoCtrlr.profileInfoList.isEmpty
        ? ""
        : profileInfoCtrlr.profileInfoList[0].fastname ?? "";
    super.onInit();
  }

  @override
  void dispose() {
    fNameEditingCtrlr.dispose();
    super.dispose();
  }
}


import 'package:bringin/res/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Http/get.dart';
import 'candidate_edit_main_profile_controller.dart';

class CandidateLNameController extends GetxController {
  CandidateEditMainProfileController profileInfoCtrlr = Get.find();
  var lNameEditingCtrlr = TextEditingController();
  var isLoading = false.obs;

  Future<void> postLastName({required Map<String, String>? fields}) async {
    isLoading.value = true;
    await  Httphelp.post(
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
    lNameEditingCtrlr.addListener(() {
      update();
    });
    lNameEditingCtrlr.text = profileInfoCtrlr.profileInfoList.isEmpty
        ? ""
        : profileInfoCtrlr.profileInfoList[0].lastname ?? "";
    super.onInit();
  }

  @override
  void dispose() {
    lNameEditingCtrlr.dispose();
    super.dispose();
  }
}

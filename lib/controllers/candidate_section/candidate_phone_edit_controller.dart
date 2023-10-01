
import 'package:bringin/res/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Http/get.dart';
import 'candidate_edit_main_profile_controller.dart';


class CandidatePhoneEditController extends GetxController{
  CandidateEditMainProfileController profileInfoCtrlr = Get.find();
  var phoneEditingCtrlr = TextEditingController();
  var isLoading = false.obs;

  Future<void> postPhone({required  Map<String, String>? data})async{
    isLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.candidateProfileUpdateUrl, fields: data).then((data){
      if(data.statusCode == 200){
        isLoading.value = false;
        profileInfoCtrlr.getProfileInfo();
        Get.back();
      }
      else{
        isLoading.value = false;
        print(data);
      }
      
    });
  }
   @override
  void onInit() {
    phoneEditingCtrlr.text = profileInfoCtrlr.profileInfoList.isEmpty
    ? "" : profileInfoCtrlr.profileInfoList[0].secoundnumber!.substring(1,profileInfoCtrlr.profileInfoList[0].secoundnumber!.length);
    super.onInit();
  }
  @override
  void dispose() {
    phoneEditingCtrlr.dispose();
    super.dispose();
  }
  @override
  void onClose() {
    phoneEditingCtrlr.dispose();
    super.dispose();
  }
}
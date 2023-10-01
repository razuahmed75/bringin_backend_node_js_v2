import 'dart:convert';
import 'package:bringin/Http/get.dart';
import 'package:bringin/controllers/candidate_section/candidate_main_profile_controller.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/constants/app_constants.dart';
import 'my_resume_controller.dart';

class AboutMeController extends GetxController {
  static AboutMeController get to => Get.find();

  var textEditingController = TextEditingController();
  var characterLength = 0.obs;
  var isShowing = false.obs;
  var exampleIndex = 0.obs;
  var isLoading = false.obs;
  
  slideExample() {
    if (exampleIndex.value < 4) {
        exampleIndex.value += 1;
      } 
    else if (exampleIndex.value == 4) {
        exampleIndex.value = 0;
      }
    update();
  }

 Future postAboutMe({required Map<String, dynamic>? data}) async{
  isLoading.value = true;

  await Httphelp.post(ENDPOINT_URL: AppConstants.aboutMeUrl, fields: data).then((value){
    if(value.statusCode == 200){
      textEditingController.clear();
      Helpers.hideKeyboard();
      Get.back();
      MyResumeController.to.getMyResume();
      CandidateMainProfileController.to.getCandidateInfo();
      print(value.body);
      Helpers().showToastMessage(msg: "Successfully updated");
      isLoading.value = false;
    } 
    else{
      isLoading.value = false;
      Helpers().showToastMessage(msg: jsonDecode(value.body)['message']);
      print(value);

    }
  });
  }

}
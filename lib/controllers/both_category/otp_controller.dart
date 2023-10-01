import 'dart:async';
import 'dart:convert';
import 'package:bringin/models/both_category/otp_model.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Hive/hive.dart';
import '../../Http/get.dart';
import '../../Screens/candidate_section/edit_main_profile/candidate_Edit_MainProfile_Screen.dart';
import '../../models/both_category/otp_post_model.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/routes/route_helper.dart';
import '../../utils/services/keys.dart';
import '../candidate_section/candidate_edit_main_profile_controller.dart';

class OtpController extends GetxController with Helpers {
  var textFieldCtrlr = TextEditingController();
  var codeValue = "".obs;
  var isLoading = false.obs;

  CandidateEditMainProfileController candidateEditMainProfileController =
      Get.find<CandidateEditMainProfileController>();

  /// VERIFYING PHONE BY OTP
  postOtp({required OtpPostModel fields}) async {
    var isRecruiter = HiveHelp.read(Keys.isRecruiter);
    isLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.otpUrl, fields: fields.toJson())
        .then((value) async {
      if (value.statusCode == 200) {
        print("response is: " + value.body);
        var otpdata = OtpModel.fromJson(jsonDecode(value.body));
        HiveHelp.write(Keys.authToken, otpdata.token);
        print(otpdata.token);
        if (isRecruiter == true) {
          if (HiveHelp.read(Keys.isRecruiterProfileBasicCompleted) == true &&
              HiveHelp.read(Keys.isRecruiterCompanyDocVerified) == false) {
            Get.offAllNamed(RouteHelper.getRecruiterJobPostRoute());
          } else if (HiveHelp.read(Keys.isRecruiterCompanyDocVerified) ==
              true) {
            Get.offNamed(RouteHelper.getBottomNavRoute());
          } else {
            Get.offAllNamed(RouteHelper.getRecruiterEditMainProfileRoute());
          }

          // Get.toNamed(RouteHelper.getRecruiterEditMainProfileRoute());
        } else {
          // Get.toNamed(RouteHelper.getCandidateCareerPrefRoute());
          if (otpdata.seekerprofile == false) {
            // Get.toNamed(RouteHelper.getCandidateEditMainProfileRoute());
            Get.off(CandidateEditMainProfileScreen(loginhome: true));
          } else if (otpdata.carearpre == 0) {
            HiveHelp.write(Keys.isCandidateProfileBasicCompleted, true);
            Get.toNamed(RouteHelper.getCandidateCareerPrefRoute());
          } else {
            HiveHelp.write(Keys.isCandidateProfileBasicCompleted, true);
            HiveHelp.write(Keys.isCandidateJobPrefCompleted, true);
            Get.toNamed(RouteHelper.getBottomNavRoute());
          }
        }

        showToastMessage();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Helpers().showToastMessage(msg: value.body);
        print(value.body);
      }
    });
  }
  

  ///COUNT DOWN TIMER
  RxInt counter = 60.obs;
  late Timer timer;
  RxBool isStartTimer = false.obs;
  Duration duration = Duration(seconds: 1); 

  void startTimer(){
    timer = Timer.periodic(duration, (timer) {
      if(counter.value > 0){
        counter.value -= 1;
        isStartTimer.value = true;
      }else{
        timer.cancel();
        counter.value = 60;
        isStartTimer.value = false;
      }
     });
  }
}

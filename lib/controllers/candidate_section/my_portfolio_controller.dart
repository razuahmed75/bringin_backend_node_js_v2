import 'dart:convert';

import 'package:bringin/Http/get.dart';
import 'package:bringin/controllers/candidate_section/my_resume_controller.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'candidate_main_profile_controller.dart';

class MyPortfolioController extends GetxController {
  static MyPortfolioController get to => Get.find();

  final textFieldController = TextEditingController();
  final MyResumeController myResumeController = Get.put(MyResumeController());
  var characterLen = 0.obs;
  var inputText = "".obs;
  var islodder = false.obs;

  @override
  void onInit() {
    textFieldController.addListener(()=>update());
    super.onInit();
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  void onClose(){
    super.onClose();
    textFieldController.dispose();
  }
   
  /// POST PORTFOLIO
  Future<void> postPortfolio({required Map<String, dynamic>? data}) async {
    islodder.value = true;
    await Httphelp.post(ENDPOINT_URL: AppConstants.myPortfolioUrl, fields: data).then((data) {
      islodder.value = false;
      if (data.statusCode == 200) {
        MyResumeController.to.getMyResume();
        CandidateMainProfileController.to.getCandidateInfo();
        Helpers.showAlartMessage(msg: "Successfully added");
        print(data.body);
        Get.back();
      }else{
        print(data.body);
        Helpers.showAlartMessage(msg: jsonDecode(data.body)['message']);
      }
    });
  }
  
  /// UPDATE EDUCATION
  Future<void> updatePortfolio({String? id,Map<String, dynamic>? data}) async {
    islodder.value = true;
    await Httphelp.post(
      ENDPOINT_URL: AppConstants.portfolioUpdateUrl+"/$id",
      fields: data,
      type: 'PATCH'
    ).then((data) {
      if (data.statusCode == 200) {
        islodder.value = false;
        Helpers.showAlartMessage(msg: "Successfully updated");
        MyResumeController.to.getMyResume();
        Get.back();
        print(data.body);
      } else {
        islodder.value = false;
        Helpers.showAlartMessage(msg: "Something went wrong");
        print(data.body);
      }
    });
  }
  
  /// DELETE SINGLE PORTFOLIO
  RxBool isDeleting = false.obs;
  Future<void> deleteSinglePortfolio({required id}) async {
    isDeleting.value = true;
    String queryUrl = "${AppConstants.deleteSinglePortfolioUrl}" + "?id=$id";
    await Httphelp.delete(ENDPOINT_URL: queryUrl).then((data) {
      if(data.statusCode==200){
        Helpers().showToastMessage(msg: "Successfully deleted");
        MyResumeController.to.getMyResume();
        CandidateMainProfileController.to.getCandidateInfo();
        Get.back();
        isDeleting.value = false;
      }
      else{
        Helpers().showToastMessage(msg: jsonDecode(data.body)['message']);
        isDeleting.value = false;
        print(data.body);
      }
    });
  }
}

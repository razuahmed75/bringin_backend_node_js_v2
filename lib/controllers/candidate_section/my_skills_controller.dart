import 'dart:convert';
import 'package:bringin/Http/get.dart';
import 'package:bringin/controllers/candidate_section/my_resume_controller.dart';
import 'package:bringin/models/candidate_section/candidate_job_pref_sec/skill_model.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'candidate_main_profile_controller.dart';

class MySkillsController extends GetxController {
  static MySkillsController get to => Get.find();
  
  var characterLen = 0.obs;
  var textFieldController = TextEditingController();
  RxList<String> selectedSkill = <String>[].obs;
  RxList<DefaultSkillsModel> defaultSkillList = <DefaultSkillsModel>[].obs;
  var isLodding = false.obs;

  /// GET METHOD OF MY SKILLS
  Future getDefaultSkill({String? categoryId}) async {
    isLodding.value = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.defaultSkillUrl+"?categoryid=$categoryId")
        .then((value) {
      isLodding.value = false;
      defaultSkillList.value=[];
      if(value.statusCode==200){
      if(jsonDecode(value.body) != null){
          defaultSkillList.value = defaultSkillsModelFromJson(value.body);
        }
      }
      else{
        defaultSkillList.value=[];
        print(value.body);
      }
    });
  }
  
  
  /// POST METHOD OF MY SKILLS
  var isskillUpdating = false.obs;
  Future postskills(SkillUpdateModel skillUpdateModel) async {
    isskillUpdating.value = true;
    await Httphelp.post(
      ENDPOINT_URL: AppConstants.skillUrl,
      fields: skillUpdateModel.toJson(),
    ).then((data) {
      isskillUpdating.value = false;
      print(data.body);
      if (data.statusCode == 200) {
        MyResumeController.to.getMyResume();
        CandidateMainProfileController.to.getCandidateInfo();
        Get.back();
        Helpers.showAlartMessage(msg: "Successfully added");
        print("success" +jsonDecode(data.body)['message'].toString());
      } else {
        MyResumeController.to.getMyResume();
        Get.back();
        Helpers.showAlartMessage(msg: "Successfully added");
        print(data.body);
      }
    });
  }
   
   removeSkills(index) {
      if(selectedSkill.length > 1){
        selectedSkill.removeAt(index);
        selectedSkill.refresh();
        print("from allLIst: "+ selectedSkill.toString());
      }
      else{
        Helpers.showAlartMessage(
          msg: "At least 1 skill should be added.",
          gravity: ToastGravity.CENTER,
        );
      }
    }
   onSaved(isUserFromJobPostPage) async{
    if(isUserFromJobPostPage == true){               
      print("from listId: "+ selectedSkill.toString());
      Get.back();
    }
    else{
    if(selectedSkill.isNotEmpty){
        SkillUpdateModel skillUpdateModel = SkillUpdateModel(
          skill: selectedSkill,
        );
        await postskills(skillUpdateModel);
        selectedSkill.clear();
    }else{
      Helpers.showAlartMessage(msg:"Please select your skills",gravity: ToastGravity.CENTER);
    }
    }
  
}
   selectSkill(defaultSkill){
    if(selectedSkill.length < 5){
      if(!selectedSkill.contains(
        defaultSkill)){
          selectedSkill.add(
            defaultSkill
          );
      }else{
        Helpers.showAlartMessage(msg: "Already selected this skill",gravity: ToastGravity.CENTER);
      }
    }else{
      Helpers.showAlartMessage(msg: "You can select up to 5 skills",gravity: ToastGravity.CENTER);
    }
    selectedSkill.refresh();
  }
}
List<DefaultSkillsModel> defaultSkillsModelFromJson(String str) => List<DefaultSkillsModel>.from(json.decode(str).map((x) => DefaultSkillsModel.fromJson(x)));
class DefaultSkillsModel {
  String? sId;
  String? functionalname;

  DefaultSkillsModel({this.sId, this.functionalname});

  DefaultSkillsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    functionalname = json['functionalname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['functionalname'] = this.functionalname;
    return data;
  }
}







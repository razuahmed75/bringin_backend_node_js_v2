// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'package:bringin/Http/get.dart';
import 'package:bringin/controllers/candidate_section/my_resume_controller.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Hive/hive.dart';
import '../../models/both_category/subject_list_model.dart';
import '../../models/candidate_section/educational_qualification_post_model.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/services/keys.dart';
import 'candidate_main_profile_controller.dart';
import 'education_level_controller.dart';
import 'other_activities_controller.dart';

class EducationController extends GetxController {
  static EducationController get to => Get.find();
  var institueName = "".obs;

    var selectedStartTimeMonth = "";
    var selectedStartTimeYear = "";
    var selectedEndTimeMonth = "";
    var selectedEndTimeYear = "";

  /// GET START DATE VALUE
  var selectedStartTime = "".obs;
  var selectedEndTime = "".obs;

  /// GET START DATE INDEX
  var selectedStartTimeMonthIndex = 0.obs;
  var selectedStartTimeYearIndex = 0.obs;
  var selectedEndTimeMonthIndex = 0.obs;
  var selectedEndTimeYearIndex = 0.obs;

  var instituteNameController = TextEditingController();
  var subjectnameController = TextEditingController();

  var isinstituelodding = false.obs;
  var issubjectlodding = false.obs;

  /// FORMAT STARTED WORKING AND DOB VALUE FROM APP UI
  var formattedStartDateFromUi;
  var formattedEndDateFromUi;

  /// GET SUBJECT NAMES
  var subjectTextField = TextEditingController();
  RxString subjectInputText = "".obs;
  RxString selectedSubjectName = "".obs;
  RxString selectedSubjectId = "".obs;
  RxBool isGettingSubjectName = false.obs;
  RxList<SubjectListModel> subjectList = <SubjectListModel>[].obs;
  Future<void> getSubjectaName({required String degreeId}) async{
    isGettingSubjectName.value = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.subjectListUrl+"?digreeid=$degreeId").then((value){
      subjectList.value=[];
      if(value.statusCode==200){
        isGettingSubjectName.value = false;
        subjectList.value = subjectListModelFromJson(value.body);
      }
      else{
        isGettingSubjectName.value = false;
        print(value.body);
        subjectList.value=[];
      }
    });
  }

  /// SEARCH SUBJECTS
  RxList<SubjectListModel> searchedSubjectList = <SubjectListModel>[].obs;
  searchSubjects(String query){
    searchedSubjectList.value = subjectList.value.where((e) => 
    e.name!.toLowerCase().contains(query.toLowerCase())).toList();
  }

  /// GET SINGLE EDUCATION QUALIFICATION
  void getSingleEducationData({int? index}){
    var educationList = MyResumeController.to.myresume!.education![index!];
    /// ADDING API VALUE TO THE EDUCATION FIELD
      institueName.value = educationList.institutename == null ? "" : educationList.institutename ?? "";
      instituteNameController.text = educationList.institutename == null ? "" : educationList.institutename ?? "";
      EducationLevelController.to.selectedDegree.value =
        educationList.digree == null ? "" : educationList.digree!.name ?? "";
      EducationLevelController.to.selectedEducationLevel.value =
        educationList.digree == null ? "" : educationList.digree!.education!.name ?? "";
      EducationLevelController.to.selectedDegreeId.value =
        educationList.digree == null ? "0" : educationList.digree!.id ?? "";
      selectedSubjectName.value = educationList.subject == null ? "" : educationList.subject!.name ?? "";
      selectedSubjectId.value = educationList.subject== null ? "" : educationList.subject!.id ?? ""; 
      subjectnameController.text = educationList.subject== null ? "" : educationList.subject!.name ?? ""; 

      /// START DATE
      DateTime startDate = educationList.startdate!;
      selectedStartTime.value = DateFormat('MMMM yyyy').format(startDate);
      formattedStartDateFromUi = educationList.startdate.toString();

      /// END DATE
      DateTime endDate = educationList.enddate!;
      selectedEndTime.value = DateFormat('MMMM yyyy').format(endDate);
      
      formattedEndDateFromUi = educationList.enddate.toString();

      if(educationList.type == 2){
        HiveHelp.write(Keys.isGradeSelected,false);
        selectedDivisionValue.value = educationList.grade ?? "";
      }else if(educationList.type == 1){
        HiveHelp.write(Keys.isGradeSelected,true);
        userResultFormate.value = educationList.gradetype ?? "";
        gradeTextFieldController.text = educationList.grade ?? "";
        selectedGradeValue.value = educationList.grade ?? "";
      }
      OtherActivitiesController.to.selectedActivitiesValue.value =
         educationList.otheractivity == null ? "" : educationList.otheractivity!;
      OtherActivitiesController.to.textFieldCtrlr.text =
         educationList.otheractivity == null ? "" : educationList.otheractivity!;
      OtherActivitiesController.to.characterLength.value =
         OtherActivitiesController.to.textFieldCtrlr.text.length;
  }
  
  /// RESET SINGLE EDUCATION QUALIFICATION
  void resetSingleEducationData(){
      instituteNameController.clear();
      subjectnameController.clear();
      gradeTextFieldController.clear();
      OtherActivitiesController.to.textFieldCtrlr.clear();
      
      institueName.value = "";
      EducationLevelController.to.selectedDegree.value = "";
      EducationLevelController.to.selectedEducationLevel.value ="";
      EducationLevelController.to.selectedDegreeId.value = "";
      selectedSubjectName.value = "";
      selectedSubjectId.value = "";

      selectedStartTime.value = "";
      formattedStartDateFromUi = "";
      selectedEndTime.value = "";
      formattedEndDateFromUi = "";
      selectedStartTimeMonthIndex.value = 0;
      selectedStartTimeYearIndex.value = 0;
      selectedEndTimeMonthIndex.value = 0;
      selectedEndTimeYearIndex.value = 0;

      selectedDivisionValue.value = "";
      userResultFormate.value = "";
      OtherActivitiesController.to.selectedActivitiesValue.value = "";
  }

  /// DELETE SINGLE EDUCATION QUALIFICATINO
  RxBool isDeleting = false.obs;
  Future<void> deleteSingleEducationQuali({required id}) async {
    print("Deleting.............");
    isDeleting.value = true;
    String queryUrl = "${AppConstants.deleteSingleEduQuaUrl}" + "?id=$id";
    await Httphelp.delete(ENDPOINT_URL: queryUrl).then((data) {
      if(data.statusCode==200){
        Helpers().showToastMessage(msg: "Successfully deleted");
        MyResumeController.to.getMyResume();
        Get.back();
        isDeleting.value = false;
      }
      else{
        isDeleting.value = false;
        Helpers().showToastMessage(msg: "Something went wrong");
        print(data.body);
      }
     
    });
  }

  /// POST EDUCATION
  var isEducationLoading = false.obs;
  Future<void> postEducationQualification(
      {required EducationQualificationPostModel? data}) async {
    isEducationLoading.value = true;
    await Httphelp.post(
      ENDPOINT_URL: AppConstants.educationQualificationUrl,
      fields: data!.toJson(),
    ).then((data) {
      if(data.statusCode == 200){
        print(data.body);
        resetSingleEducationData();
        MyResumeController.to.getMyResume();
        CandidateMainProfileController.to.getCandidateInfo();
        Helpers().showToastMessage(msg: "Successfully added");
        Get.back();
        isEducationLoading.value = false;
      }else{
        isEducationLoading.value = false;
        Helpers().showToastMessage(msg: jsonDecode(data.body)['message']);
        print(data.body);
      }
    });
  }
  
  /// UPDATE EDUCATION
  Future<void> updateEducation({String? id,EducationQualificationPostModel? data}) async {
    isEducationLoading.value = true;
    await Httphelp.post(
      ENDPOINT_URL: AppConstants.educationUpdateUrl+"?id=$id",
      fields: data!.toJson(),
    ).then((data) {
      if (data.statusCode == 200) {
        isEducationLoading.value = false;
        Helpers.showAlartMessage(msg: "Successfully updated");
        resetSingleEducationData();
        MyResumeController.to.getMyResume();
        Get.back();
        print(data.body);
      } else {
        isEducationLoading.value = false;
        Helpers.showAlartMessage(msg: "Something went wrong");
        print(data.body);
      }
    });
  }

  /// GRADE AND DIVISION
  var tabControllerIndex = 0;
  var selectedGradeIndex = "".obs;
  var selectedDivisionIndex = "".obs;
  var userResultFormate = "".obs;
  var gradeTextFieldController = TextEditingController();
  var selectedGradeValue = "".obs;
  var selectedDivisionValue = "".obs;

  List<String> gradeList = [
    "CGPA",
    "GPA",
  ];

  List<String> divisionList = [
    "1st",
    "2nd",
    "3rd",
  ];

  @override
  void onInit() {
    instituteNameController.addListener(() => update());
    super.onInit();
  }

  @override
  void dispose() {
    instituteNameController.dispose();
    super.dispose();
  }
}


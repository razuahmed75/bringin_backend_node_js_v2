// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:bringin/Http/get.dart';
import 'package:bringin/controllers/candidate_section/my_resume_controller.dart';
import 'package:bringin/controllers/candidate_section/career_milestone_controller.dart';
import 'package:bringin/controllers/candidate_section/duties_and_responsibility_controller.dart';
import 'package:bringin/controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/both_category/work_experience_post_model.dart';
import '../../res/constants/app_constants.dart';
import '../both_category/expertise_area_controller.dart';
import 'candidate_main_profile_controller.dart';
import 'department_controller.dart';
import 'industry_controller.dart';
import 'my_designation_controller.dart';

class WorkExperienceController extends GetxController {
  static WorkExperienceController get to => Get.find();

  MyResumeController myResumeController = Get.put(MyResumeController());
  var internValue = false.obs;
  var hideInformValue = false.obs;
  RxString selectedCompanyName = "".obs;

  /// GET VALUE
  var selectedStartTime = "".obs;
  var selectedEndTime = "".obs;

  /// GET INDEX
  var selectedStartTimeMonthIndex = 0.obs;
  var selectedStartTimeYearIndex = 0.obs;
  var selectedEndTimeMonthIndex = 0.obs;
  var selectedEndTimeYearIndex = 0.obs;

  var isLoading = false.obs;

  /// FORMAT STARTED WORKING AND DOB VALUE FROM APP UI
  var formattedStartDateFromUi;
  var formattedEndDateFromUi;

  /// POST WORK EXPERIENCE
  Future<void> postWorkExperience(
      WorkExperiencePostModel workExperiencePostModel) async {
    isLoading.value = true;
    await Httphelp.post(
      ENDPOINT_URL: AppConstants.myWorkExperienceUrl,
      fields: workExperiencePostModel.toJson(),
    ).then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        Helpers().showToastMessage(msg: "Successfully added");
        resetSingleWorkExps();
        MyResumeController.to.getMyResume();
        CandidateMainProfileController.to.getCandidateInfo();
        Get.back();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Helpers().showToastMessage(msg: jsonDecode(data.body)['message']);
        print(data.body);
      }
    });
  }

  /// UPDATE WORK EXPERIENCE
  Future<void> updateWorkExp(
      {String? id, WorkExperiencePostModel? workExperiencePostModel}) async {
    isLoading.value = true;
    await Httphelp.post(
      ENDPOINT_URL: AppConstants.workExpUpdateUrl + "?id=$id",
      fields: workExperiencePostModel!.toJson(),
    ).then((data) {
      if (data.statusCode == 200) {
        MyResumeController.to.getMyResume();
        isLoading.value = false;
        Helpers.showAlartMessage(msg: "Successfully updated");
        resetSingleWorkExps();
        Get.back();
        print(data.body);
      } else {
        isLoading.value = false;
        Helpers.showAlartMessage(msg: "Something went wrong");
        print(data.body);
      }
    });
  }

  /// GET SINGLE WORK EXPERIENCE
  void getSingleWorkExps({required int? index}) {
    var workExpList = MyResumeController.to.myresume!.workexperience![index!];
    WorkExperienceController.to.selectedCompanyName.value =
        workExpList.companyname!;
    RecruiterEditMainProfileController
        .to.companyNameSearchController.value.text = workExpList.companyname!;
    IndustryControler.to.categoryId.value =
        workExpList.category == null ? "" : workExpList.category!.id!;
    IndustryControler.to.jobIndustryName.value =
        workExpList.category == null ? "" : workExpList.category!.categoryname!;

    /// START DATE
    var startDate = workExpList.startdate;
    DateTime parsedStartDateTime = startDate!;

    /// PARSE DATE_TIME FROM STRING
    selectedStartTime.value =
        DateFormat('MMM yyyy').format(parsedStartDateTime);

    /// FORMATE VALUE

    /// THIS VALUE IS FOR EDITING SINGLE WORK EXP
    DateFormat inputFormat1 = DateFormat("MMM yyyy");
    DateTime dateTime1 = inputFormat1.parse(selectedStartTime.value);
    DateFormat outputFormat1 = DateFormat("yyyy-MM-dd");
    formattedStartDateFromUi = outputFormat1.format(dateTime1);

    /// END DATE
    var endDate = workExpList.enddate;
    DateTime parsedEndDateTime = endDate!;

    /// PARSE DATE_TIME FROM STRING
    selectedEndTime.value = endDate.year > DateTime.now().year ? "Present" : DateFormat('MMM yyyy').format(parsedEndDateTime);
    
    /// FORMATE VALUE

    /// THIS VALUE IS FOR EDITING SINGLE WORK EXP
    DateFormat inputFormat2 = DateFormat("MMM yyyy");
    // DateTime dateTime2 = inputFormat2.parse(selectedEndTime.value);
        DateTime dateTime2 = inputFormat2.parse(DateFormat('MMM yyyy').format(parsedEndDateTime));
    DateFormat outputFormat2 = DateFormat("yyyy-MM-dd");
    formattedEndDateFromUi = outputFormat2.format(dateTime2);

    ExpertiseAreaController.to.selectedFuncationalNameValue.value =
        workExpList.expertisearea == null
            ? ""
            : workExpList.expertisearea!.functionalname!;
    ExpertiseAreaController.to.selectValueFunctionalNameId.value =
        workExpList.expertisearea == null
            ? ""
            : workExpList.expertisearea!.id!;
    MyDesignationController.to.selectedDesignation.value =
        workExpList.designation ?? "";
    MyDesignationController.to.textFieldCtrlr.text =
        workExpList.designation ?? "";
    DepartmentController.to.selectedDepartment.value =
        workExpList.department ?? "";
    DepartmentController.to.textFieldCtrlr.text = workExpList.department ?? "";
    DutiesAndResponsibilitiesController.to.selectedResponsibilities.value =
        workExpList.dutiesandresponsibilities ?? "";
    DutiesAndResponsibilitiesController.to.textFieldCtrlr.text =
        workExpList.dutiesandresponsibilities ?? "";
    DutiesAndResponsibilitiesController.to.characterLength.value =
        DutiesAndResponsibilitiesController.to.textFieldCtrlr.text.length;
    CareerMileStoneController.to.selectedAccomplishment.value =
        workExpList.careermilestones ?? "";
    CareerMileStoneController.to.textFieldCtrlr.text =
        workExpList.careermilestones ?? "";
    CareerMileStoneController.to.characterLength.value =
        CareerMileStoneController.to.textFieldCtrlr.text.length;
    internValue.value = workExpList.workintern ?? false;
    hideInformValue.value = workExpList.hidedetails ?? false;
  }

  /// RESET SINGLE WORK EXPERIENCE
  void resetSingleWorkExps() {
    CareerMileStoneController.to.textFieldCtrlr.clear();
    MyDesignationController.to.textFieldCtrlr.clear();
    DepartmentController.to.textFieldCtrlr.clear();
    DutiesAndResponsibilitiesController.to.textFieldCtrlr.clear();
    RecruiterEditMainProfileController.to.companyNameSearchController.value
        .clear();

    WorkExperienceController.to.selectedCompanyName.value = "";
    IndustryControler.to.categoryId.value = "";
    IndustryControler.to.jobIndustryName.value = "";

    /// START DATE
    selectedStartTime.value = "";
    formattedStartDateFromUi = "";
    selectedEndTime.value = "";
    formattedEndDateFromUi = "";

    ExpertiseAreaController.to.selectedFuncationalNameValue.value = "";
    ExpertiseAreaController.to.selectValueFunctionalNameId.value = "";
    MyDesignationController.to.selectedDesignation.value = "";
    DepartmentController.to.selectedDepartment.value = "";
    DutiesAndResponsibilitiesController.to.selectedResponsibilities.value = "";
    CareerMileStoneController.to.selectedAccomplishment.value = "";
    internValue.value = false;
    hideInformValue.value = false;
  }

  /// DELETE SINGLE WORK EXPERIENCE
  RxBool isDeleting = false.obs;
  Future<void> deleteSingleWorkExps({required id}) async {
    print("Deleting..........");
    isDeleting.value = true;
    String queryUrl = "${AppConstants.deleteSingleWorkExpUrl}" + "?id=$id";
    await Httphelp.delete(ENDPOINT_URL: queryUrl).then((data) {
      if (data.statusCode == 200) {
        /// clear data
        selectedStartTime.value = "";
        selectedEndTime.value = "";

        Helpers().showToastMessage(msg: "Successfully deleted");

        MyResumeController.to.getMyResume();
        Get.back();
        isDeleting.value = false;
      } else {
        Helpers().showToastMessage(msg: "Something went wrong");
        isDeleting.value = false;
        print(data.body);
      }
    });
  }
}

// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'package:bringin/Http/get.dart';
import 'package:bringin/controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../Hive/hive.dart';
import '../../models/recruiter_section/job_title_model.dart';
import '../../models/recruiter_section/recruiter_experience_model.dart';
import '../../models/recruiter_section/recruiter_job_post_model.dart';
import '../../res/color.dart';
import '../../utils/routes/route_helper.dart';
import '../../utils/services/keys.dart';
import '../both_category/expertise_area_controller.dart';
import '../candidate_section/candidate_career_pref_controller.dart';
import '../candidate_section/education_level_controller.dart';
import '../candidate_section/my_skills_controller.dart';
import 'company_registration_controller.dart';
import 'job_post_preview_controller.dart';

class RecruiterJobPostController extends GetxController {
  static RecruiterJobPostController get to => Get.find();

  /// JOB TITLE
  RxList<JobTitleArea> jobTitleList = <JobTitleArea>[].obs;
  var isjobTitleLodding = false.obs;
  RxBool isTapped = false.obs;
  var selectJobTitleName = "".obs;
  Future<void> getJobTitle({String? userInput}) async {
    isjobTitleLodding.value = true;
    await Httphelp.get(
            ENDPOINT_URL: AppConstants.jobTitleUrl + "?search=$userInput")
        .then((value) {
      jobTitleList.value = [];
      isjobTitleLodding.value = false;
      isTapped.value = true;
      if (value.statusCode == 200) {
        jobTitleList.value = jobTitleAreaFromJson(value.body);
      } else {
        jobTitleList.value = [];
      }
      update();
    });
  }

  /// JOB DESCRIPTION
  var textFieldController = TextEditingController();
  var selectedJobDescriptionVal = "".obs;

  /// JOB RECUIREMENTS
  var initialExpIndex = 0.obs;
  var initialEducationIndex = 0.obs;
  var selectedExperienceVal = "".obs;
  var selectedExperienceId = "0".obs;
  var selectedEducationVal = "".obs;
  var selectedEducationId = "".obs;

  /// IS REMOTE
  var isRemote = false.obs;

  /// GET EXPERIENCE LIST
  List<RecruiterExperienceModel> experienceList = <RecruiterExperienceModel>[];
  var isExpLoading = false;
  Future<void> getExperience() async {
    isExpLoading = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.experienceListUrl)
        .then((data) {
      experienceList = [];
      var datas = jsonDecode(data.body);
      for (var i in datas) {
        experienceList.add(RecruiterExperienceModel.fromJson(i));
      }
      isExpLoading = false;
      update();
    });
  }

  /// POST A NEW JOB
  CandidateCareerPrefController _candidateJobPrefController =
      Get.find<CandidateCareerPrefController>();
  EducationLevelController educationLevelController =
      Get.find<EducationLevelController>();
  ExpertiseAreaController functilnalAreaController =
      Get.find<ExpertiseAreaController>();
  RecruiterEditMainProfileController recruiterProfileInfoController =
      Get.find<RecruiterEditMainProfileController>();
  MySkillsController mySkillsController = Get.find<MySkillsController>();

  var isLoading = false.obs;

  Future<void> postNewJob({required RecruiterJobPostModel? data}) async {
    isLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.recruiterJobPostUrl,
            fields: data!.toJson())
        .then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        isLoading.value = false;
        HiveHelp.write(Keys.jobPostId, jsonDecode(data.body)['jobid']);
        Get.toNamed(RouteHelper.getSuccessfullyJobPostedRoute());
        Helpers().showToastMessage(
          gravity: ToastGravity.CENTER,
          msg: "Job posted successfully",
          bgColor: AppColors.scaffoldColor,
          textColor: AppColors.blackColor,
        );
        resetJobPostValue();
      } else {
        isLoading.value = false;
        print(data.body);
        Helpers.showAlartMessage(msg: jsonDecode(data.body)['message']);
      }
    });
  }

  /// GET SINGEL JOB DETAILS VALUE
  void getSingleJobPostValue() {
    /// GET VALUE FOR UPDATING THE JOB POST
    var jobData = JobPostPreviewController.to.jobList[0];

    double lat = jobData.jobLocation == null || jobData.jobLocation!.lat! == 0
        ? jobData.company!.cLocation!.lat!.toDouble()
        : jobData.jobLocation!.lat!.toDouble();
    double lon = jobData.jobLocation == null || jobData.jobLocation!.lon! == 0
        ? jobData.company!.cLocation!.lon!.toDouble()
        : jobData.jobLocation!.lon!.toDouble();
    CompanyRegistrationController.to.latUpdate(lat, lon);
    CompanyRegistrationController.to.companyaddress =
        jobData.jobLocation == null ||
                jobData.jobLocation!.formetAddress!.isEmpty
            ? jobData.company!.cLocation!.formetAddress!
            : jobData.jobLocation!.formetAddress!;
    CompanyRegistrationController.to.selectedLocationId.value =
        jobData.jobLocation == null
            ? jobData.company!.cLocation!.divisiondata!.id!
            : jobData.jobLocation!.divisiondata!.id!;
    CompanyRegistrationController.to.selectedLocation.value =
        jobData.jobLocation == null
            ? jobData.company!.cLocation!.divisiondata!.divisionname! +
                ", " +
                jobData.company!.cLocation!.divisiondata!.cityid!.name!
            : jobData.jobLocation!.divisiondata!.divisionname! +
                ", " +
                jobData.jobLocation!.divisiondata!.cityid!.name!;
    CompanyRegistrationController.to.selectedOptionLocation.value =
        jobData.jobLocation == null
            ? jobData.company!.cLocation!.locationoptional!
            : jobData.jobLocation!.locationoptional!;

    selectJobTitleName.value = jobData.jobTitle ?? "";
    selectedJobDescriptionVal.value = jobData.jobDescription ?? "";
    textFieldController.text = jobData.jobDescription ?? "";
    selectedEducationId.value =
        jobData.education == null ? "" : jobData.education!.id ?? "";
    selectedEducationVal.value =
        jobData.education == null ? "" : jobData.education!.name ?? "";
    selectedExperienceId.value =
        jobData.experience == null ? "0" : jobData.experience!.id ?? "";
    selectedExperienceVal.value =
        jobData.experience == null ? "" : jobData.experience!.name ?? "";
    isRemote.value = jobData.remote ?? false;

    HiveHelp.write(Keys.recruiterCompanyName, jobData.company!.legalName);
    CandidateCareerPrefController.to.jobTypeId.value =
        jobData.jobtype == null ? "" : jobData.jobtype!.id ?? "";
    CandidateCareerPrefController.to.jobTypeVal.value =
        jobData.jobtype == null ? "" : jobData.jobtype!.worktype ?? "";
    CandidateCareerPrefController.to.minSalaryId.value =
        jobData.salary == null ? "" : jobData.salary!.minSalary!.id ?? "";
    CandidateCareerPrefController.to.maxSalaryId.value =
        jobData.salary == null ? "" : jobData.salary!.maxSalary!.id ?? "";
    CandidateCareerPrefController.to.minSalaryVal.value = jobData.salary == null
        ? ""
        : jobData.salary!.minSalary!.type == 0
            ? "Negotiable"
            : jobData.salary!.minSalary!.salary.toString() + "K";
    CandidateCareerPrefController.to.maxSalaryVal.value = jobData.salary == null
        ? ""
        : jobData.salary!.maxSalary!.type == 0
            ? "Negotiable"
            : jobData.salary!.maxSalary!.salary.toString() + "K";
    CandidateCareerPrefController.to.currencyVal.value =
        jobData.salary == null ? "" : jobData.salary!.minSalary!.currency ?? "";
    ExpertiseAreaController.to.selectValueFunctionalNameId.value =
        jobData.experticeArea == null ? "" : jobData.experticeArea!.id ?? "";
    ExpertiseAreaController.to.selectedFuncationalNameValue.value =
        jobData.experticeArea == null
            ? ""
            : jobData.experticeArea!.functionalname ?? "";
    ExpertiseAreaController.to.categoryId.value = jobData.experticeArea == null
        ? ""
        : jobData.experticeArea!.categoryid ?? "";
    HiveHelp.write(Keys.recruiterCompanyAddr,
        jobData.company!.cLocation!.formetAddress.toString());
    MySkillsController.to.selectedSkill.value =
        List.generate(jobData.skill!.length, (index) => jobData.skill![index]);
  }

  /// RESET VALUE
  void resetJobPostValue() {
    /// CLEAR JOB POST VALUE AFTER POSTED
    selectJobTitleName.value = "";
    selectedJobDescriptionVal.value = "";
    selectedEducationVal.value = "";
    CompanyRegistrationController.to.selectedLocation.value = "";
    CompanyRegistrationController.to.selectedLocationId.value = "";
    CompanyRegistrationController.to.selectedOptionLocation.value = "";
    CompanyRegistrationController.to.companyaddress = "";

    textFieldController.clear();

    /// job description controller

    selectedExperienceVal.value = "";
    _candidateJobPrefController.minSalaryVal.value = "";
    _candidateJobPrefController.maxSalaryVal.value = "";
    _candidateJobPrefController.minSalaryId.value = "";
    _candidateJobPrefController.maxSalaryId.value = "";
    functilnalAreaController.selectedFuncationalNameValue.value = "";
    functilnalAreaController.categoryId.value = "";

    mySkillsController.selectedSkill.value = [];
    mySkillsController.selectedSkill.value = [];
    isRemote.value = false;
  }
}

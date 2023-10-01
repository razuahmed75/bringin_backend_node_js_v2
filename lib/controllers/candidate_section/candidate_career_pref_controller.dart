import 'dart:convert';
import 'package:bringin/Http/get.dart';
import 'package:bringin/controllers/candidate_section/my_resume_controller.dart';
import 'package:bringin/controllers/candidate_section/select_location_controller.dart';
import 'package:bringin/models/candidate_section/candidate_job_pref_sec/expected_salary_model.dart';
import 'package:bringin/models/candidate_section/candidate_job_pref_sec/job_preference_model.dart';
import 'package:bringin/models/candidate_section/candidate_job_pref_sec/job_type_model.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:get/get.dart';
import '../../Hive/hive.dart';
import '../../res/color.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/routes/route_helper.dart';
import '../../utils/services/keys.dart';
import '../both_category/expertise_area_controller.dart';
import '../both_category/job_industry_controller.dart';
import 'job_controll.dart';

class CandidateCareerPrefController extends GetxController {
  static CandidateCareerPrefController get to => Get.find();
  List<ExpectedSalaryModel> expectedSalaryList = <ExpectedSalaryModel>[].obs;
  List<JobTypeModel> jobTypeList = <JobTypeModel>[].obs;
  var jobTypeVal = "".obs;
  var minSalaryVal = "".obs;
  var maxSalaryVal = "".obs;
  var currencyVal = "".obs;
  var minSalaryId = "".obs;
  var maxSalaryId = "".obs;
  var jobTypeId = "".obs;
  var jobTypeSelectedIndex = 0.obs;
  var initialMinIndex = 0.obs;
  var initialMaxIndex = 0.obs;
  var mainIndex = 0.obs;
  var jobTypeErrorBorderClr = AppColors.buttonColor.obs;
  var salaryErrorBorderClr = AppColors.buttonColor.obs;
  var isLoading = false.obs;
  var isLoaded = true.obs;
  

  /// GET EXPECTED SALARY
  Future<void> getExpectedSalary() async {
    isLoading.value = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.expectedSalaryUrl)
        .then((data) {
      expectedSalaryList = [];
      if (data.statusCode == 200) {
          isLoading.value = false;
         expectedSalaryList = expectedSalaryModelFromJson(data.body);
      } else {
        expectedSalaryList=[];
        isLoading.value = false;
      }
    });
  }

  /// GET JOB TYPE
  Future<void> getJobType() async {
    isLoading.value = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.jobTypeUrl).then((data) {
      jobTypeList = [];
      if (data.statusCode == 200) {
        for (var i in jsonDecode(data.body)) {
          jobTypeList.add(JobTypeModel.fromJson(i));
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        jobTypeList = [];
      }
    });
  }

  /// POST JOB PREFERENCE
  var isJobPrefPosting = false.obs;
  Future<void> postCandidateJobPref(
      {JobPreferenceModelPost? jobPreferenceData}) async {
    isJobPrefPosting.value = true;
    await Httphelp.post(
      ENDPOINT_URL: AppConstants.candidateSaveJobPrefUrl,
      fields: jobPreferenceData!.toJson(),
    ).then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        isJobPrefPosting.value = false;
        HiveHelp.write(Keys.isCandidateJobPrefCompleted, true);
        Helpers.showAlartMessage(msg: "Successfully added");
        resetSingleCareerPref();
        if (HiveHelp.read(Keys.isSeekerFromJobPage) == true) {
          Get.put(JobControll()).getfnctionalarea();
          Get.back();
          HiveHelp.remove(Keys.isSeekerFromJobPage);
        }
        if (HiveHelp.read(Keys.isSeekerFromMainProfilePage) == true) {
          MyResumeController.to.getMyResume();
          Get.back();
        } else {
          Get.put(JobControll()).getfnctionalarea();
          Get.put(JobControll()).tabload();
          Get.toNamed(RouteHelper.getBottomNavRoute());
        }
      } else {
        isJobPrefPosting.value = false;
        Helpers.showAlartMessage(msg: jsonDecode(data.body)['message']);
        print(data.body);
      }
    });
  }

  /// UPDATE CAREER PREFERENCE
  Future<void> updateCandidateCareerPref(
      {String? id, JobPreferenceModelPost? jobPreferenceData}) async {
    isJobPrefPosting.value = true;
    await Httphelp.post(
      ENDPOINT_URL: AppConstants.careerPrefUpdateUrl + "?id=$id",
      fields: jobPreferenceData!.toJson(),
    ).then((data) {
      if (data.statusCode == 200) {
        isJobPrefPosting.value = false;
        Helpers.showAlartMessage(msg: "Successfully updated");
        resetSingleCareerPref();
        MyResumeController.to.getMyResume();
        Get.put(JobControll()).getfnctionalarea();
        Get.put(JobControll()).tabload();
        Get.back();
        print(data.body);
      } else {
        isJobPrefPosting.value = false;
        Helpers.showAlartMessage(msg: "Something went wrong");
        print(data.body);
      }
    });
  }

  /// GET SINGLE CAREER_PREF
  var jobIndustryController = Get.put(JobIndustryController());
  var functilnalAreaController = Get.put(ExpertiseAreaController());
  var selectLocationController = Get.put(SelectLocationController());
  void getSingleCareerPref({int? index}) {
    var singleCareerPref = MyResumeController.to.myresume!.careerPreference![index!];

    jobIndustryController.selectedlist.value = List.generate(
        singleCareerPref.category!.length, (i) => singleCareerPref.category![i].id!);
    functilnalAreaController.selectedFuncationalNameValue.value =
        singleCareerPref.functionalarea == null
            ? ""
            : singleCareerPref.functionalarea!.functionalname ?? "";
    functilnalAreaController.selectValueFunctionalNameId.value =
        singleCareerPref.functionalarea == null
            ? ""
            : singleCareerPref.functionalarea!.id ?? "";

    selectLocationController.selectedDivisionId.value =
        singleCareerPref.division == null || singleCareerPref.division!.cityid == null
            ? ""
            : singleCareerPref.division!.id ?? "";
    selectLocationController.selectedDivision.value =
        singleCareerPref.division == null || singleCareerPref.division!.cityid == null
            ? ""
            : singleCareerPref.division!.cityid!.name ?? "";
    selectLocationController.selectedCityValue.value =
        singleCareerPref.division == null
            ? ""
            : singleCareerPref.division!.divisionname ?? "";

    jobTypeVal.value =
        singleCareerPref.jobtype == null ? "" : singleCareerPref.jobtype!.worktype ?? "";
    jobTypeId.value =
        singleCareerPref.jobtype == null ? "" : singleCareerPref.jobtype!.id ?? "";
    minSalaryVal.value =
        singleCareerPref.salaray == null || singleCareerPref.salaray!.minSalary == null ? "" : singleCareerPref.salaray!.minSalary!.type == 0 ? singleCareerPref.salaray!.minSalary!.salary! : "${singleCareerPref.salaray!.minSalary!.salary ?? ""}" + "K";
    maxSalaryVal.value =
        singleCareerPref.salaray == null || singleCareerPref.salaray!.maxSalary == null ? "" : singleCareerPref.salaray!.maxSalary!.type == 0 ? singleCareerPref.salaray!.minSalary!.salary! : "${singleCareerPref.salaray!.maxSalary!.salary ?? ""}" + "K";
    currencyVal.value =
        singleCareerPref.salaray == null || singleCareerPref.salaray!.minSalary == null ? "" : singleCareerPref.salaray!.minSalary!.currency ?? "";
    minSalaryId.value = singleCareerPref.salaray == null || singleCareerPref.salaray!.minSalary == null ? "" : singleCareerPref.salaray!.minSalary!.id ?? "";
    maxSalaryId.value = singleCareerPref.salaray == null || singleCareerPref.salaray!.maxSalary == null ? "" : singleCareerPref.salaray!.maxSalary!.id ?? "";
  }

  /// REST SINGLE CAREER_PREF
  void resetSingleCareerPref() {
    jobIndustryController.selectedlist.value = [];
    functilnalAreaController.selectedFuncationalNameValue.value = "";
    functilnalAreaController.selectValueFunctionalNameId.value = "";
    functilnalAreaController.selectValueFuncationNamePath.value = "";

    functilnalAreaController.functionalAreaErrorBorderClr.value = AppColors.appBorder;
    jobIndustryController.industryErrorBorderClr.value = AppColors.appBorder;
    selectLocationController.locationErrorBorderClr.value = AppColors.appBorder;
    jobTypeErrorBorderClr.value = AppColors.appBorder;
    salaryErrorBorderClr.value = AppColors.appBorder;

    selectLocationController.selectedDivisionId.value = "";
    selectLocationController.selectedDivision.value = "";
    selectLocationController.selectedCityValue.value = "";

    jobTypeVal.value = "";
    jobTypeId.value = "";
    minSalaryVal.value = "";
    maxSalaryVal.value = "";
    currencyVal.value = "";
    minSalaryId.value = "";
    maxSalaryId.value = "";
  }

  var isDeleting = false.obs;
  Future deletejobpreferance({required id}) async {
    print(HiveHelp.read(Keys.authToken));
    print(id);
    isDeleting.value = true;
    var data = await Httphelp.delete(
        ENDPOINT_URL: "${AppConstants.deleteSingleJobPrefUrl}?id=$id");
    if (data.statusCode == 200) {
      MyResumeController.to.getMyResume();
      Get.back();
      Helpers().showToastMessage(msg: "Successfully deleted");
      isDeleting.value = false;
      print(data.body);
    } else {
      isDeleting.value = false;
      Helpers().showToastMessage(msg: jsonDecode(data.body)['message']);
      print(data.body);
    }
  }
}



import 'dart:convert';
import 'dart:developer';
import 'package:bringin/Http/get.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Hive/hive.dart';
import '../../Hive/hive_collection_var.dart';
import '../../models/Filter/filter.dart';
import '../../models/Recruiter_profile_details/recruiter_profile_details.dart';
import '../../models/candidate_section/candidate_job_pref_sec/seeker_functional_area_model.dart';
import '../../models/candidate_section/post_job_filter_model.dart';
import '../../models/candidate_section/view_saved_jobs_model.dart';
import '../../models/recruiter_section/job_post_preview_model.dart';
import '../../models/recruiter_section/single_recruiter_details_model.dart';
import '../../res/constants/app_constants.dart';
import '../upload_file/report_ss_upload_controller.dart';
import 'candidate_main_profile_controller.dart';
import 'job_filter_controller.dart';
import 'my_resume_controller.dart';

class JobControll extends GetxController {
  static JobControll get to => Get.find();

  bool loading = true;
  bool jobloading = false;
  final resumecontroll = Get.find<MyResumeController>();
  List<String> tablist = [];
  int tabindex = 0;
  var joblistfilterdata = <JobPreviewModel?>[].obs;
  var joblistfilter = false.obs;

  List<SeekerFunctionalAreaModel> functionalarea = [];
  var jobfunctionindex = 0.obs;

  Future getfnctionalarea() async {
    loading = true;
    print("getting functi.....");
    var response =
        await Httphelp.get(ENDPOINT_URL: AppConstants.seekerFunctionalAreaUrl);
    functionalarea = seekerFunctionalAreaModelFromJson(response.body);
    await tabload();
    loading = false;
    update();
  }

  Future tabload() async {
    tablist.clear();
    tablist.add("Jobs Opening");
    var tabdata = List.generate(
        functionalarea.length,
        (index) => functionalarea[index].functionalarea == null
            ? ""
            : functionalarea[index].functionalarea!.functionalname.toString());
    tablist.addAll(tabdata);
    update();
  }

  void tabindexchange(int index) {
    tabindex = index;
    update();
  }

  // List<JobPreviewModel?> joblist = [];
  List<JobPreviewModel?> searchjob = [];
  var tabIndex = 0;
  var isLocationFilter = false.obs;
  Future<List<JobPreviewModel?>?> getjoblist(
      {int? index,
      String? location,
      String? divisionId,
      String? divisionName,
      String? type = "All"}) async {
    List<JobPreviewModel?>? joblist = [];
    print("$index------------num index");

    jobloading = true;
    if (index == 0) {
      joblist = await _getjobforyou();
      isLocationFilter.value = false;
    } else if (type == "0") {
      joblist = await getNearbyJobs(
          fAreaId: functionalarea[index! - 1].functionalarea!.id!,
          divisionName: divisionName!);
      isLocationFilter.value = true;
    } else if (type == "1") {
      joblist = await getLatestJob(
          fAreaId: functionalarea[index! - 1].functionalarea!.id!);
      isLocationFilter.value = true;
    } else if (type == "2") {
      joblist = await getJobByLocation(
          fAreaId: functionalarea[index! - 1].functionalarea!.id!,
          divisionId: divisionId!);
      isLocationFilter.value = true;
    } else {
      joblist = await _jobycategory(
          areaid: functionalarea[index! - 1].functionalarea!.id!);
      isLocationFilter.value = false;
    }
    jobloading = false;
    return joblist;
  }

  List<JobPreviewModel?> filteredJob = [];
  Future getJobByLocation(
      {required String fAreaId, required String divisionId}) async {
    print("getting job by location");
    var response = await Httphelp.get(
        ENDPOINT_URL: "/functional_jobfilter" +
            "?type=2&functionalarea=$fAreaId&divisionid=$divisionId");
    if (response.statusCode == 200) {
      filteredJob = jobPreviewModelFromJson(response.body);
    } else {
      return [];
    }
    update();
  }

  var divisionName = "".obs;
  Future getNearbyJobs(
      {required String fAreaId, required String divisionName}) async {
    print("getting latest jobs");
    var response = await Httphelp.get(
        ENDPOINT_URL: "/functional_jobfilter" +
            "?type=0&functionalarea=$fAreaId&divisionid=$divisionName");
    if (response.statusCode == 200) {
      filteredJob = jobPreviewModelFromJson(response.body);
    } else {
      return [];
    }
    update();
  }

  Future getLatestJob({required String fAreaId}) async {
    print("getting latest jobs");
    var response = await Httphelp.get(
        ENDPOINT_URL:
            "/functional_jobfilter" + "?type=1&functionalarea=$fAreaId");
    if (response.statusCode == 200) {
      filteredJob = jobPreviewModelFromJson(response.body);
    } else {
      return [];
    }
    update();
  }

  Future<List<JobPreviewModel?>?> _getjobforyou() async {
    var response = await Httphelp.get(
        ENDPOINT_URL: AppConstants.jobforyou + "?functionalarea=0");

    if (response.statusCode == 200) {
      return jobPreviewModelFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<List<JobPreviewModel?>?> _jobycategory(
      {required String areaid}) async {
    try {
      var response = await Httphelp.get(
          ENDPOINT_URL: AppConstants.jobforyou + "?functionalarea=$areaid");

      if (response.statusCode == 200) {
        return jobPreviewModelFromJson(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<JobPreviewModel?>?> getjoblistFilteredData({
    PostJobFilterModel? fields,
  }) async {
    print("Filtering your data=============");
    var response = await Httphelp.post(
        ENDPOINT_URL: AppConstants.jobFilterUrl, fields: fields!.toJson());

    if (response.statusCode == 200) {
      JobFilterController.to.resetFilterValue();
      return jobPreviewModelFromJson(response.body);
    } else {
      return [];
    }
  }

  /// CLEAR RECENT SEARCH
  clearAll() {
    recentBox.clear();
    update();
  }

  /// JOB SEARCH
  RxBool isSearching = false.obs;
  RxBool isSearchTapped = false.obs;
  var selectedCityName = "".obs;
  var jobTitleField = TextEditingController();
  var jobLocationField = TextEditingController();
  var selectedDivision = "";

  Future jobSearch(String jobTitle, String location) async {
    isSearching.value = true;
    var searchdata = await Httphelp.get(
        ENDPOINT_URL:
            AppConstants.seekerjobsearch + "?search=$jobTitle&city=$location");
    searchjob.clear();
    isSearchTapped.value = true;
    if (searchdata.statusCode == 200) {
      isSearching.value = false;
      print(searchdata.body);
      searchjob = jobPreviewModelFromJson(searchdata.body);
    } else {
      isSearching.value = false;
      searchjob = [];
    }
  }

  /// convert the verifyAt time
  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    final format = DateFormat('MMMM d, yyyy');
    return format.format(parsedDate);
  }

  /// JOB VIEW COUNT
  Future<void> jobViewCount({Map<String, dynamic>? fields}) async {
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.jobViewCountUrl, fields: fields)
        .then((value) {
      if (value.statusCode == 200) {
        print(value.body);
      } else {
        print(value.body);
      }
    });
  }

  /// JOB DETAILS
  List<JobPreviewModel> jobdetails = [];
  Future getobdetails({required String jobid}) async {
    jobdetails.clear();
    var data = await Httphelp.get(
        ENDPOINT_URL: "${AppConstants.jobDetailsUrl}" "?jobid=$jobid");
    if (data.statusCode == 200) {
      jobdetails.add(JobPreviewModel.fromJson(jsonDecode(data.body)));
    } else {
      jobdetails = [];
    }
    update();
  }

  /// SAVE AND UNSAVE JOBS
  RxBool isSavingJob = false.obs;
  Future<void> saveJob({required String jobId}) async {
    isSavingJob.value = true;
    print("Saving jobs................");
    await Httphelp.post(
        ENDPOINT_URL: AppConstants.saveAndUnsavejobUrl,
        fields: {"jobid": jobId}).then((data) {
      print(data.body);
      if (data.statusCode == 200) {
        if (jsonDecode(data.body)['message'] == "Job saved successfully") {
          HiveHelp.write(jobId.toString(), jobId);
          CandidateMainProfileController.to.getCandidateInfo();
        } else {
          HiveHelp.remove(jobId.toString());
          CandidateMainProfileController.to.getCandidateInfo();
        }

        isSavingJob.value = false;
        Helpers().showToastMessage(
            gravity: ToastGravity.CENTER,
            msg: jsonDecode(data.body)['message']);
      } else {
        isSavingJob.value = false;
        Helpers().showToastMessage(
            gravity: ToastGravity.CENTER,
            msg: jsonDecode(data.body)['message']);
      }
    });
    update();
  }

  /// VIEW SAVED JOBS
  RxBool isLoading = false.obs;
  List<ViewSavedJobsModel> allSavedJobList = [];
  Future<void> getAllSavedJobs() async {
    isLoading.value = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.viewSavedJobsUrl)
        .then((data) {
      allSavedJobList = [];
      if (data.statusCode == 200) {
        allSavedJobList = viewSavedJobsModelFromJson(data.body);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        allSavedJobList = [];
      }
      update();
    });
  }

  /// WHO VIEWED ME
  var whoViewedMeList = <JobPreviewModel?>[].obs;
  Future<void> getWhoViewedMe() async {
    log("getting who viewed me data...");
    isLoading.value = true;
    await Httphelp.get(
            ENDPOINT_URL: AppConstants.whoViewedMeUrl + "?isrecruiter=false")
        .then((data) {
      whoViewedMeList.value = [];
      isLoading.value = false;
      if (data.statusCode == 200) {
        whoViewedMeList.value = jobPreviewModelFromJson(data.body);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        whoViewedMeList.value = [];
      }
    });
  }

  /// VIEWED JOBS HISTORY
  var viewedJobList = <JobPreviewModel?>[].obs;
  Future<void> getViewedJobs() async {
    isLoading.value = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.viewedJobsUrl).then((data) {
      viewedJobList.value = [];
      isLoading.value = false;
      if (data.statusCode == 200) {
        viewedJobList.value = jobPreviewModelFromJson(data.body);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        viewedJobList.value = [];
      }
    });
  }

  /// CV SENT JOBS HISTORY
  var cvSentHistoryList = <JobPreviewModel?>[].obs;
  Future<void> getCvSentHistory() async {
    isLoading.value = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.cvSentHistoryUrl)
        .then((data) {
      cvSentHistoryList.value = [];
      isLoading.value = false;
      if (data.statusCode == 200) {
        cvSentHistoryList.value = jobPreviewModelFromJson(data.body);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        cvSentHistoryList.value = [];
      }
    });
  }

  /// TOTAL CHAT HISTORY
  var totalChatHistoryList = <JobPreviewModel?>[].obs;
  Future<void> getTotalChatHistory({String? id}) async {
    log("getting total chat history data...");
    isLoading.value = true;
    await Httphelp.get(
            ENDPOINT_URL:
                AppConstants.totalChatHistoryUrl + "?id=$id&recruiter=false")
        .then((data) {
      totalChatHistoryList.value = [];
      isLoading.value = false;
      if (data.statusCode == 200) {
        totalChatHistoryList.value = jobPreviewModelFromJson(data.body);
        print(totalChatHistoryList);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        totalChatHistoryList.value = [];
      }
    });
  }

  /// WHO SAVED ME
  List<JobPreviewModel?> whoSavedMeList = [];
  Future<void> getWhoSavedMe() async {
    isLoading.value = true;
    await Httphelp.get(
            ENDPOINT_URL: AppConstants.whoSavedMeUrl + "?isrecruiter=false")
        .then((data) {
      whoSavedMeList = [];
      isLoading.value = false;
      if (data.statusCode == 200) {
        whoSavedMeList = jobPreviewModelFromJson(data.body);
        log(whoSavedMeList.toString());
        isLoading.value = false;
      } else {
        isLoading.value = false;
        whoSavedMeList = [];
      }
    });
  }

  /// REPORT A JOB
  RxBool isReporting = false.obs;
  Future<void> reportJob(
      {required Map<String, String>? data, String? path}) async {
    isReporting.value = true;
    print("Reporting from seeker section.................");
    await Httphelp.report(
            ENDPOINT_URL: AppConstants.reportJobUrl, fields: data, path: path)
        .then((value) {
      if (value.statusCode == 200) {
        print(value.body);
        Helpers().showToastMessage(msg: "Report Submitted");

        /// CLEAR REPORT CONTROLLER VALUE AFTER SUBMITTED A REPORT
        ReportController.to.candidateSelectedItems.clear();
        ReportController.to.textFeildController.value.clear();
        ReportController.to.result = null;
        Get.back();
        isReporting.value = false;
      } else {
        isReporting.value = false;
        print(value);
        Helpers().showToastMessage(msg: jsonDecode(value.body)['message']);
      }
    });
  }

  // job filter

  JobFilter? jobFilter;

  Future getjobfilter() async {
    var data = await Httphelp.get(ENDPOINT_URL: "/job_filter");
    jobFilter = jobFilterFromJson(data.body);
    update();
  }

  Future filterjob({Map<String, dynamic>? fields}) async {
    var data = await Httphelp.post(ENDPOINT_URL: "/job_filter", fields: fields);
    if (data.statusCode == 200) {
      joblistfilterdata.value = jobPreviewModelFromJson(data.body);
    } else {
      joblistfilterdata.value = [];
    }
  }

  List<SingleRecruiterDetailsModel> singleRecruiterDetailsList = [];
  Future<void> getSingleRecruiterDetails({String? id}) async {
    isLoading.value = true;
    singleRecruiterDetailsList = [];
    await Httphelp.get(
            ENDPOINT_URL: AppConstants.recruiterDetailsUrl + "?id=$id")
        .then((value) {
      isLoading.value = false;
      if (value.statusCode == 200) {
        singleRecruiterDetailsList
            .add(SingleRecruiterDetailsModel.fromJson(jsonDecode(value.body)));
      } else {
        singleRecruiterDetailsList = [];
      }
    });
  }

  Recruiterprofiledetails? recruiterprofiledetails;
  bool recruiterprofileload = false;
  Future recruiterprofileview(String recruiterid) async {
    recruiterprofileload = true;
    var data = await Httphelp.get(
        ENDPOINT_URL: "/recruiter_profilebyid?id=${recruiterid}");

    if (data.statusCode == 200) {
      recruiterprofiledetails = recruiterprofiledetailsFromJson(data.body);
    } else {
      log(data.body);
    }
    recruiterprofileload = false;
    update();
  }


}

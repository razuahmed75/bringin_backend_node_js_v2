import 'dart:convert';
import 'dart:developer';
import 'package:bringin/Hive/hive_collection_var.dart';
import 'package:bringin/Http/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../Hive/hive.dart';
import '../../models/candidate_section/CandidateList/candidatelist_model.dart';
import '../../models/candidate_section/Candidate_Fnctionarea/candidate_functionarea.dart';
import '../../models/recruiter_section/post_candidate_filter_model.dart';
import '../../models/save_candidate_model.dart';
import '../../models/single_candidate_details_model.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/services/helpers.dart';
import '../upload_file/report_ss_upload_controller.dart';
import 'job_filter_controller.dart';

class CandidateControll extends GetxController {
  static CandidateControll get to => Get.find();

  List<Candidatefunctionalarea> candidatefunctionalarea = [];

  var candidatetabindex = 0.obs;
  var candidatefilter = false.obs;
  var candidatefilterdata = <Candidatelist>[].obs;

  List<String> tablist = [];

  Future getcandidatefunctionalarea() async {
    var response =
        await Httphelp.get(ENDPOINT_URL: AppConstants.getfunctionalAreaUrl);

    if (response.statusCode == 200) {
      candidatefunctionalarea = candidatefunctionalareaFromJson(response.body);
      tablist.clear();
      tablist.add("Candidates for you");
      tablist.addAll(List.generate(
        candidatefunctionalarea.length,
        (index) =>
            candidatefunctionalarea[index].experticeArea!.functionalname!,
      ));
    } else {
      candidatefunctionalarea = [];
    }
    update();
  }

  /// ADD FUNCTIONAL AREA
  RxBool isLoading = false.obs;
  Future<void> addFunctionalArea({Map<String, dynamic>? data}) async {
    isLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.addfunctionalAreaUrl, fields: data)
        .then((value) async {
      if (value.statusCode == 200) {
        await getcandidatefunctionalarea();

        isLoading.value = false;
        print(value.body);
      } else {
        isLoading.value = false;
        print(value.body);
      }
    });
  }

  Future savecandidateprofile(
      {String? seekerid, Map<String, dynamic>? fields}) async {
    var data =
        await Httphelp.post(ENDPOINT_URL: "/candidate_save", fields: fields);
    print(data.body);
    if (data.statusCode == 200) {
      if (jsonDecode(data.body)['message'] == "Candidate saved successfully") {
        HiveHelp.write(seekerid!, seekerid);
      } else {
        HiveHelp.remove(seekerid!);
      }
      Helpers().showToastMessage(
          msg: jsonDecode(data.body)['message'], gravity: ToastGravity.CENTER);
    } else {
      Helpers().showToastMessage(msg: "Something went wrong");
    }
    update();
  }

  List<Savecandidate> savecandidateList = [];

  Future viewsavecandidate() async {
    var data = await Httphelp.get(ENDPOINT_URL: "/candidate_save");
    savecandidateList.clear();
    if (data.statusCode == 200) {
      for (var i in jsonDecode(data.body)) {
        savecandidateList.add(Savecandidate.fromJson(i));
      }
    } else {
      savecandidateList = [];
    }
    update();
  }

  List<Candidatelist> totalChatHistoryList = <Candidatelist>[].obs;
  Future<void> getTotalChatHistory({String? id}) async {
    log("getting total chat history data...");
    isLoading.value = true;
    await Httphelp.get(
            ENDPOINT_URL:
                AppConstants.totalChatHistoryUrl + "?id=$id&recruiter=true")
        .then((data) {
      totalChatHistoryList = [];
      isLoading.value = false;
      if (data.statusCode == 200) {
        totalChatHistoryList = candidatelistFromJson(data.body);
        print(totalChatHistoryList);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        totalChatHistoryList = [];
      }
    });
  }

  var tabIndex = 0.obs;
  var isCandidateFilter = false.obs;
  Future<List<Candidatelist>?> loadcandidate(
      {int? index,
      String? location,
      String? divisionId,
      String? fAreaId,
      String? type = "All"}) async {
    if (index == 0) {
      isCandidateFilter.value = false;
      return await getcandidateforyou();
    } else if (type == "0") {
      isCandidateFilter.value = true;
      return await getcandidategetNearbyLocation(
          fAreaId: candidatefunctionalarea[index! - 1].experticeArea!.id!,
          location: location!);
    } else if (type == "1") {
      isCandidateFilter.value = true;
      return await getLatestCandidate(
          fAreaId: candidatefunctionalarea[index! - 1].experticeArea!.id!);
    } else if (type == "2") {
      isCandidateFilter.value = true;
      return await getcandidategetbyLocation(
          fAreaId: candidatefunctionalarea[index! - 1].experticeArea!.id!,
          divisionid: divisionId!);
    } else {
      isCandidateFilter.value = false;
      return await getcandidategetbyfun(
          candidatefunctionalarea[index! - 1].experticeArea!.id!);
    }
  }

  Future<List<Candidatelist>?> getcandidateforyou() async {
    var data = await Httphelp.get(
        ENDPOINT_URL: AppConstants.getCandidateListUrl + "?functionalareaid=0");
    return candidatelistFromJson(data.body);
  }

  Future<List<Candidatelist>?> getcandidategetbyfun(String funcionalid) async {
    var data = await Httphelp.get(
        ENDPOINT_URL: AppConstants.getCandidateListUrl +
            "?functionalareaid=$funcionalid");
    return candidatelistFromJson(data.body);
  }

  List<Candidatelist> candidateFilterList = <Candidatelist>[].obs;
  var divisionName = "".obs;
  Future getcandidategetbyLocation(
      {required String fAreaId, required String divisionid}) async {
    print("getting candidate by location");
    var data = await Httphelp.get(
        ENDPOINT_URL: AppConstants.functionarea_candidatefilter +
            "?type=1&functionalarea=$fAreaId&divisionid=$divisionid");
    if (data.statusCode == 200) {
      candidateFilterList = candidatelistFromJson(data.body);
    } else {
      candidateFilterList = [];
    }
    update();
  }

  Future getcandidategetNearbyLocation(
      {required String fAreaId, required String location}) async {
    print("getting nearby candidates");
    var data = await Httphelp.get(
        ENDPOINT_URL: AppConstants.functionarea_candidatefilter +
            "?type=0&functionalarea=$fAreaId&division=$location");
    if (data.statusCode == 200) {
      candidateFilterList = candidatelistFromJson(data.body);
    } else {
      candidateFilterList = [];
    }
    update();
  }

  Future getLatestCandidate({required String fAreaId}) async {
    print("getting latest candidates");
    var data = await Httphelp.get(
        ENDPOINT_URL: AppConstants.functionarea_candidatefilter +
            "?type=2&functionalarea=$fAreaId");
    if (data.statusCode == 200) {
      candidateFilterList = candidatelistFromJson(data.body);
    } else {
      candidateFilterList = [];
    }
    update();
  }

  /// CANDIDATE FILTER
  Future<List<Candidatelist>?> getCandidatelistFilteredData({
    PostCandidateFilterModel? fields,
  }) async {
    List<Candidatelist> candidatelist = [];
    print("Filtering your data=============");
    var response = await Httphelp.post(
        ENDPOINT_URL: AppConstants.candidateFilterUrl,
        fields: fields!.toJson());
    var data = jsonDecode(response.body);
    // candidatelist.clear();
    if (response.statusCode == 200) {
      print(data);
      JobFilterController.to.resetFilterValue();
      for (var i in data) {
        candidatelist.add(Candidatelist.fromJson(i));
      }
      return candidatelist;
    } else {
      return candidatelist;
    }
  }

  /// CLEAR RECENT SEARCH
  void clearAll() {
    recentBox2.clear();
    update();
  }

  /// CANDIDATE SEARCH
  var isSearching = false.obs;
  RxBool isSearchTapped = false.obs;
  RxList<Candidatelist> searchcandidatelist = <Candidatelist>[].obs;
  var candidateNameField = TextEditingController();
  var candidateLocationField = TextEditingController();
  var candidatelocationid = "";
  Future candidateSearch(String jobTitle, String location) async {
    isSearching.value = true;
    print("isSercing....");
    var searchdata = await Httphelp.get(
        ENDPOINT_URL: AppConstants.candidateSearchUrl +
            "?name=$jobTitle&location=$location");
    searchcandidatelist.clear();
    isSearchTapped.value = true;
    if (searchdata.statusCode == 200) {
      isSearching.value = false;
      searchcandidatelist.value = candidatelistFromJson(searchdata.body);
    } else {
      isSearching.value = false;
      searchcandidatelist.value = [];
    }
  }

  /// REPORT A CANDIDATE
  var selectedCategoryIndex = 0.obs;
  ReportController reportController = Get.find<ReportController>();
  RxBool isReporting = false.obs;
  Future<void> reportCandidate(
      {required Map<String, String>? data, String? path}) async {
    isReporting.value = true;
    print("Reporting from recruiter section.................");
    await Httphelp.report(
            ENDPOINT_URL: AppConstants.candidateReportUrl,
            fields: data,
            path: path)
        .then((value) {
      if (value.statusCode == 200) {
        print(value.body);
        Helpers().showToastMessage(msg: "Report Submitted");

        /// CLEAR REPORT CONTROLLER VALUE AFTER SUBMITTED A REPORT
        reportController.recruiterSelectedItems.clear();
        reportController.textFeildController.value.clear();
        reportController.result = null;
        Get.back();
        isReporting.value = false;
      } else {
        isReporting.value = false;
        print(value.body);
        Helpers().showToastMessage(msg: jsonDecode(value.body)['message']);
      }
    });
  }

  /// CANDIDATE VIEW COUNT
  Future<void> candidateViewCount({Map<String, dynamic>? fields}) async {
    await Httphelp.post(
        ENDPOINT_URL: AppConstants.candidateViewCountUrl, fields: fields);
  }
  // candidate filter

  Future candidate_filter({Map<String, dynamic>? fields}) async {
    var data =
        await Httphelp.post(ENDPOINT_URL: "/candidate_filter", fields: fields);
    candidatefilterdata.value = candidatelistFromJson(data.body);
    candidatefilter.value = true;
  }

  /// WHO VIEWED ME
  List<Candidatelist> whoViewedMeList = [];
  Future getWhoViewedMe() async {
    log("getting who viewed me data...");
    isLoading.value = true;
    await Httphelp.get(
            ENDPOINT_URL: AppConstants.whoViewedMeUrl + "?isrecruiter=true")
        .then((data) {
      whoViewedMeList = [];
      isLoading.value = false;
      if (data.statusCode == 200) {
        whoViewedMeList = candidatelistFromJson(data.body);
        log(whoViewedMeList.toString());
        isLoading.value = false;
      } else {
        isLoading.value = false;
        whoViewedMeList = [];
      }
    });
  }

  /// WHO SAVED ME
  List<Candidatelist> whoSavedMeList = [];
  Future<void> getWhoSavedMe() async {
    log("getting who saved me data...");
    isLoading.value = true;
    await Httphelp.get(
            ENDPOINT_URL: AppConstants.whoSavedMeUrl + "?isrecruiter=true")
        .then((data) {
      whoSavedMeList = [];
      isLoading.value = false;
      if (data.statusCode == 200) {
        whoSavedMeList = candidatelistFromJson(data.body);
        log(whoSavedMeList.toString());
        isLoading.value = false;
      } else {
        isLoading.value = false;
        whoSavedMeList = [];
      }
    });
  }

  /// SINGLE CANDIDATE DETAILS
  List<SingleCandidateDetailsModel> singleCandidateList = [];
  Future<void> getCandidateDetails({String? candidateId}) async {
    isLoading.value = true;
    await Httphelp.get(
            ENDPOINT_URL: AppConstants.candidateDetailsUrl + "?id=$candidateId")
        .then((data) {
      singleCandidateList = [];
      isLoading.value = false;
      if (data.statusCode == 200) {
        singleCandidateList
            .add(SingleCandidateDetailsModel.fromJson(jsonDecode(data.body)));
        isLoading.value = false;
      } else {
        isLoading.value = false;
        singleCandidateList = [];
      }
    });
  }
}

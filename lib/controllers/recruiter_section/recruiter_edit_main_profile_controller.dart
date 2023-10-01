// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:bringin/Http/get.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Hive/hive.dart';
import '../../models/recruiter_section/recruiter_company_name_model.dart';
import '../../models/recruiter_section/recruiter_edit_main_profile_post_model.dart';
import '../../models/recruiter_section/recruiter_profile_info_model.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/routes/route_helper.dart';
import '../../utils/services/keys.dart';

class RecruiterEditMainProfileController extends GetxController {
  static RecruiterEditMainProfileController get to => Get.find();

  var fNameController = TextEditingController().obs;
  var lNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var designationController = TextEditingController().obs;
  var companyNameSearchController = TextEditingController().obs;
  var selectedFName = "".obs;
  var selectedLName = "".obs;
  var selectedDesignation = "".obs;
  var selectedEmail = "".obs;
  var selectedCompanyName = "".obs;
  var isLoading = false.obs;
  var iscompanyLodding = false.obs;

  /// GET RECRUITER PROFILE INFO
  var photoUrl;
  
  int packageRemainingDays = 0;
  /// GET PACKAGE REMAINING DAYS IN PAYMENT HISTORY PAGE
  getRemainingDays(start,end){
    // int startTimestamp = start;
    // int endTimestamp = end;

    // DateTime startDate = DateTime.fromMillisecondsSinceEpoch(startTimestamp);
    // DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endTimestamp);

    Duration remainingDuration = end.difference(DateTime.now());
    packageRemainingDays = remainingDuration.inDays;
  }

  List<RecruiterProfileInfoModel> recruiterProfileInfoList =
      <RecruiterProfileInfoModel>[];
  RxList<Notification> notificationList = <Notification>[].obs;
  Future getRecruiterProfileInfoList() async {
    isLoading.value = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.getrecruiterProfileInfoUrl)
        .then((data) {
      if (data.statusCode == 200) {
        recruiterProfileInfoList = [];
        notificationList.value = [];
        if(kDebugMode){
          print("got data...");
        }
        recruiterProfileInfoList
            .add(RecruiterProfileInfoModel.fromJson(jsonDecode(data.body)));
        photoUrl = recruiterProfileInfoList[0].image;
        if(recruiterProfileInfoList[0].other!.package != null){
          getRemainingDays(recruiterProfileInfoList[0].other!.package!.starddate,recruiterProfileInfoList[0].other!.package!.enddate);
        }
        String companyId = recruiterProfileInfoList[0].companyname == null
            ? ""
            : recruiterProfileInfoList[0].companyname!.sId!;
        String companyAddr = recruiterProfileInfoList[0].companyname == null ||
                recruiterProfileInfoList[0].companyname!.cLocation == null
            ? ""
            : recruiterProfileInfoList[0]
                .companyname!
                .cLocation!
                .formetAddress!;
        HiveHelp.write(Keys.recruiterCompanyId, companyId);
        HiveHelp.write(Keys.recruiterCompanyAddr, companyAddr);
        HiveHelp.write(Keys.currentuserid, recruiterProfileInfoList[0].sId);
        HiveHelp.write(Keys.isrecruiterverified,
            recruiterProfileInfoList[0].other!.profileVerify);

        /// get notfication detail
        for (var i in recruiterProfileInfoList) {
          notificationList.add(Notification(
            push: i.other!.notification!.pushNotification,
            whatsapp: i.other!.notification!.whatsappNotification,
            sms: i.other!.notification!.smsNotification,
            job: i.other!.notification!.jobRecommandation,
          ));
        }
        isLoading.value = false;
        update();
      } else {
        print(data.body);
        notificationList.value = [];
        isLoading.value = false;
        update();
      }
    });
  }

  /// UPDATE RECRUITER PROFILE INFO
  var isInfoLoading = false.obs;
  Future postRecruiterProfileinfo(
      {required RecruiterEditMainProfilePostModel? data}) async {
    isInfoLoading.value = true;
    print(data!.toJson());
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.recruiterMainProfileUpdateUrl,
            fields: data.toJson())
        .then((data) async {
      if (data.statusCode == 200) {
        print(data.body);
        isInfoLoading.value = false;
        await getRecruiterProfileInfoList();
        if (HiveHelp.read(Keys.isMainProfileEdit) == true) {
          Get.offAllNamed(RouteHelper.getBottomNavRoute());
        } else {
          if (recruiterProfileInfoList[0].other!.profileVerify == true) {
            HiveHelp.write(Keys.isRecruiterCompanyDocVerified, true);

            Get.offAllNamed(RouteHelper.getBottomNavRoute());
          } else if(recruiterProfileInfoList[0].other!.profileOtherDocupload == true) {
Get.offAllNamed(RouteHelper.getUnderVerificationRoute(),arguments: ["documents", false]);
          } 
          else {
            Get.offAllNamed(RouteHelper.getRecruiterJobPostRoute());
          }
        }

        // if (HiveHelp.read(Keys.isrecruiterverified) == "1") {
        //   HiveHelp.write(Keys.isRecruiterCompanyDocVerified, true);
        // }

        // HiveHelp.read(Keys.isMainProfileEdit) == true
        //     ? Get.toNamed(RouteHelper.getRecruiterMainProfileRoute())
        //     : HiveHelp.read(Keys.isrecruiterverified) == "1"
        //         ? Get.offAll(BottomNavLayout())
        //         : HiveHelp.read(Keys.isrecruiterunderverify) == null
        //             ? Get.offAllNamed(RouteHelper.getRecruiterJobPostRoute())
        //             : HiveHelp.read(Keys.isrecruiterunderverify)
        //                 ? Get.offAll(UnderVerificationScreen())
        //                 : Get.offAllNamed(
        //                     RouteHelper.getRecruiterJobPostRoute());
        HiveHelp.write(Keys.isRecruiterProfileBasicCompleted, true);

        /// IF THE RECRUITER BASIC PROFILE INFO COMPLETED OR NOT
      } else {
        isInfoLoading.value = false;
        Helpers().showToastMessage(msg: "Something went wrong");
        print(data.body);
      }
    });
  }

  /// GET COMPANY LIST
  RxList<RecruiterCompanyListModel> recruiterCompanyList =
      <RecruiterCompanyListModel>[].obs;
  RxBool isTapped = false.obs;
  Future searchCompanyName({Map<String, String>? fields}) async {
    iscompanyLodding.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.companyNameUrl, fields: fields)
        .then((value) {
      recruiterCompanyList.value = [];
      iscompanyLodding.value = false;
      isTapped.value = true;
      if (value.statusCode == 200) {
        print(value.body);
        for (var i in jsonDecode(value.body)) {
          recruiterCompanyList.value.add(RecruiterCompanyListModel.fromJson(i));
        }
      } else {
        iscompanyLodding.value = false;
        isTapped.value = true;
        print(value.body);
        recruiterCompanyList.value = [];
      }
    });
  }

  @override
  void onInit() {
    fNameController.value.addListener(() => update());
    lNameController.value.addListener(() => update());
    designationController.value.addListener(() => update());
    emailController.value.addListener(() => update());
    companyNameSearchController.value.addListener(() => update());
    super.onInit();
  }

  @override
  void onClose() {
    fNameController.value.dispose();
    lNameController.value.dispose();
    designationController.value.dispose();
    emailController.value.dispose();
    companyNameSearchController.value.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    fNameController.value.dispose();
    lNameController.value.dispose();
    designationController.value.dispose();
    emailController.value.dispose();
    companyNameSearchController.value.dispose();
    super.dispose();
  }
}

class Notification {
  bool? push, whatsapp, sms, job;
  Notification({this.push, this.whatsapp, this.sms, this.job});
}

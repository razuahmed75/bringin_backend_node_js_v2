import 'dart:convert';
import 'dart:developer';

import 'package:bringin/Http/get.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Hive/hive.dart';
import '../../models/candidate_section/candidate_profile_info_model.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/services/keys.dart';

var kAssetRootImg = "assets/seeker_default_avatar";

class CandidateEditMainProfileController extends GetxController {
  static CandidateEditMainProfileController get to => Get.find();

  /// LOADER
  var isLoading = false.obs;

  /// DEFAULT AVATAR LIST
  List<String> defaultAvatarList = <String>[
    "$kAssetRootImg/default_av1.png",
    "$kAssetRootImg/default_av2.png",
    "$kAssetRootImg/default_av3.png",
    "$kAssetRootImg/default_av4.png",
    "$kAssetRootImg/default_av5.png",
    "$kAssetRootImg/default_av6.png",
    "$kAssetRootImg/default_av7.png",
    "$kAssetRootImg/default_av8.png",
    "$kAssetRootImg/default_av9.png",
    "$kAssetRootImg/default_av10.png",
    "$kAssetRootImg/default_av11.png",
    "$kAssetRootImg/default_av12.png",
    "$kAssetRootImg/default_av13.png",
    "$kAssetRootImg/default_av14.png",
  ];

  /// MONTHS LIST
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  /// FORMAT STARTED WORKING AND DOB VALUE FROM APP UI
  var formattedDateFromUi;
  dynamic formatDateTimeFromUi(String dateStr) {
    DateFormat format = DateFormat('MMMM yyyy');
    DateTime dateTime = format.parse(dateStr);
    formattedDateFromUi = DateFormat('yyy-MM-dd').format(dateTime);
    print("formattedDateFromUi" + "$formattedDateFromUi");
    return formattedDateFromUi;
  }

  /// GENDER POST METHOD
  var genderIndex = 0.obs;
  var isGenLoading = false.obs;
  Future<void> postGender({required Map<String, String>? data}) async {
    isGenLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.candidateProfileUpdateUrl, fields: data)
        .then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        getProfileInfo();
        Get.back();
        isGenLoading.value = false;
      } else {
        isGenLoading.value = false;
        print(data.body);
      }
    });
  }

  /// EXPERIENCE LEVEL POST METHOD
  var experienceLevelIndex = 0.obs;
  var isExpLoading = false.obs;
  Future<void> postExperienceLevel({required Map<String, String>? data}) async {
    isExpLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.candidateProfileUpdateUrl, fields: data)
        .then((data) {
      if (data.statusCode == 200) {
        print(data);
        getProfileInfo();
        if (isInfoLoading == false && profileInfoList.isNotEmpty) {
          Get.back();
          isExpLoading.value = false;
        }
      } else {
        isExpLoading.value = false;
        print(data);
      }
    });
  }

  /// STARTED WORKING POST METHOD
  var selectedWorkingMonthIndex = 0.obs;
  var selectedWorkingYearIndex = 0.obs;
  var selectedStartedWorkingMonth = "July".obs;
  var selectedStartedWorkingYear = "2015".obs;
  Future<void> postStartedWorking({required Map<String, String>? data}) async {
    isLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.candidateProfileUpdateUrl, fields: data)
        .then((data) {
      if (data.statusCode == 200) {
        print(data);
        getProfileInfo();
        if (isInfoLoading == false && profileInfoList.isNotEmpty) {
          Get.back();
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }

  /// MY DATE OF BIRTH POST METHOD
  var selectedDobMonthIndex = 0.obs;
  var selectedDobYearIndex = 0.obs;
  var selectedDOBMonth = "July".obs;
  var selectedDOBYear = "2000".obs;
  Future<void> postDOB({required Map<String, String>? data}) async {
    isLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.candidateProfileUpdateUrl, fields: data)
        .then((data) {
      if (data.statusCode == 200) {
        print(data);
        getProfileInfo();
        if (isInfoLoading == false && profileInfoList.isNotEmpty) {
          Get.back();
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    });
  }

  /// GET PROFILE INFO
  var isInfoLoading = true;
  List<CandidateProfileInfoModel> profileInfoList =
      <CandidateProfileInfoModel>[];
  var photoUrl;
  var formattedStartedWorking = "".obs;
  var formattedDob = "".obs;
  var ismainScreenLodder = false.obs;
  Future getProfileInfo() async {
    ismainScreenLodder.value = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.candidateProfileInfoUrl)
        .then((data) {
      profileInfoList = [];
      profileInfoList
          .add(CandidateProfileInfoModel.fromJson(jsonDecode(data.body)));
      print("got profile data " + profileInfoList.length.toString());
      log(data.body);
      photoUrl = profileInfoList[0].image;
      HiveHelp.write(Keys.currentuserid, profileInfoList[0].id);
      isInfoLoading = false;
      ismainScreenLodder.value = false;
      update();
    });
  }
}

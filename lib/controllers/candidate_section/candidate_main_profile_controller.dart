import 'dart:convert';

import 'package:bringin/Http/get.dart';
import 'package:get/get.dart';
import '../../models/candidate_section/candidate_main_profile_model.dart';
import '../../res/constants/app_constants.dart';

class CandidateMainProfileController extends GetxController {
  static CandidateMainProfileController get to => Get.find();

  RxList<CandidateProfileModel> candidateProfileList =
      <CandidateProfileModel>[].obs;
  RxList<Notification> notificationList = <Notification>[].obs;
  var isLoading = false.obs;

  // @override
  // void onInit() {
  //   getCandidateInfo();
  //   super.onInit();
  // }

  Future getCandidateInfo() async {
    isLoading.value = true;
    Httphelp.get(ENDPOINT_URL: AppConstants.candidateInfoUrl).then((data) {
      candidateProfileList.value = [];
      notificationList.value = [];
      isLoading.value = false;
      if (data.statusCode == 200) {
        candidateProfileList
            .add(CandidateProfileModel.fromJson(jsonDecode(data.body)));

        for (var i in candidateProfileList) {
          notificationList.add(Notification(
            push: i.other!.notification!.pushNotification,
            whatsapp: i.other!.notification!.whatsappNotification,
            sms: i.other!.notification!.smsNotification,
            job: i.other!.notification!.jobRecommandation,
          ));
        }
        update();
      } else {
        candidateProfileList.value = [];
        notificationList.value = [];
        update();
      }
      update();
    });
  }
}

class Notification {
  bool? push, whatsapp, sms, job;
  Notification({this.push, this.whatsapp, this.sms, this.job});
}

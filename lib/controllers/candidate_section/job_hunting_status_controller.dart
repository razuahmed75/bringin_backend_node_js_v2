import 'dart:convert';

import 'package:bringin/controllers/candidate_section/my_resume_controller.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:get/get.dart';
import '../../Http/get.dart';
import '../../res/constants/app_constants.dart';
import '../../res/constants/image_path.dart';
import 'candidate_main_profile_controller.dart';


class JobHuntingStatusController extends GetxController {
  static JobHuntingStatusController get to => Get.find();

  RxInt statusSelectedIndex = 0.obs;
  RxInt moreStatusSelectedIndex = 0.obs;
  RxBool switchVal = false.obs;

  List<String> statusTextList = <String>[
    "Proactively Seeking",
    "Informally Exploring",
  ];
  List<String> statusEmojiList = <String>[
    AppImagePaths.emoji_white,
    AppImagePaths.emoji_blue,
  ];
  List<String> jobMoreStatusList = <String>[
    "Join Instantly",
    "1 week notice period",
    "2 week notice period",
    "2 week+ notice period",
  ];
  var candidateInfoController = Get.put(CandidateMainProfileController());
  /// POST JOB STATUS
  var isLoading = false.obs;
  Future<void> postJosStatus({required Map<String, dynamic>? fields}) async{
    isLoading.value = true;
    await Httphelp.post(
      ENDPOINT_URL: AppConstants.jobSearchingStatusUrl, fields: fields).then((value){
        if(value.statusCode == 200){
          print(value.body);
          candidateInfoController.getCandidateInfo();
          MyResumeController.to.getMyResume();
          Get.back();
          isLoading.value = false;
        }else{
          isLoading.value = false;
          Helpers().showToastMessage(msg: jsonDecode(value.body)['message']);
          print(value.body);
        }
      });
  }

}

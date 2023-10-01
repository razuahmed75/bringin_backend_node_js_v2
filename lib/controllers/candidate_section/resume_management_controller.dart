import 'dart:convert';

import 'package:bringin/Http/get.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:get/get.dart';
import '../../models/candidate_section/upload_resume_list.dart';

class ResumeManagementController extends GetxController {
  static ResumeManagementController get to => Get.find();

  RxList<Uploadresumelist> uploadresumelist = <Uploadresumelist>[].obs;
  RxInt statusCode = 0.obs;
  var formattedDate;
  var isLoading = false;
  Future getallresume() async {
    isLoading = true;
    print("Getting resumes.................");
    var response =
        await Httphelp.get(ENDPOINT_URL: AppConstants.candidateUploadResumeUrl);
    var data = jsonDecode(response.body);
    uploadresumelist.clear();
    if (response.statusCode == 200) {
      // statusCode.value = 200;
      for(var i in data){
        uploadresumelist.add(Uploadresumelist.fromJson(i));
      }
    } else {
      // statusCode.value = 0;
      uploadresumelist.value = [];
    }
    isLoading = false;
    update();
  }

  var isDeletingResume = false;
  Future resumedelete(String id) async {
    print("Deleting resumes.................");
    isDeletingResume = true;
    await Httphelp.delete(ENDPOINT_URL: "${AppConstants.candidateUploadResumeUrl}?id=$id")
        .then((value) {
      isDeletingResume = false;
      if(value.statusCode==200){
        getallresume();
      }
      else{
        Helpers().showToastMessage(msg: jsonDecode(value.body)['message']);
      }
    });
  }
}

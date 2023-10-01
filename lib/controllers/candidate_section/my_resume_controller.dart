// ignore_for_file: invalid_use_of_protected_member


import 'package:bringin/Http/get.dart';
import 'package:get/get.dart';
import '../../models/Resume/myresume.dart';
import '../../res/constants/app_constants.dart';
import 'my_skills_controller.dart';

class MyResumeController extends GetxController {
  static MyResumeController get to => Get.find();
  var isresumeLoading = false.obs;
  var isVisible = true;
  RxBool isMyResumeEmpty = false.obs;
  Myresume? myresume;

  MySkillsController mySkillsController = Get.put(MySkillsController());




  Future getMyResume() async {
    isresumeLoading.value = true;
    print("getting data...");
    var resumedata = await Httphelp.get(ENDPOINT_URL: AppConstants.myResumeUrl);
    if(resumedata.statusCode==200){
      myresume = myresumeFromJson(resumedata.body);
    }else{
      isMyResumeEmpty.value = true;
    }
    isresumeLoading.value = false;
    update();
  }

}

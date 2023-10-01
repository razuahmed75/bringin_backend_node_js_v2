
import 'package:bringin/widgets/app_popup_dialog.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Hive/hive.dart';
import '../../Screens/candidate_section/bottom_nav/bottom_nav_layout.dart';
import '../../utils/services/keys.dart';

class BottomNavController extends GetxController {
  
  void goToInitialPage(){
    pageController.jumpToPage(0);
    pageindex = 0;
    update();
  }

  var isRecruiter = HiveHelp.read(Keys.isRecruiter);
  
    Future<bool?> showwarning(context) async {
      AppPopupDialog().showPopup(
        context: context,
        onOkPress: () async {
            SystemNavigator.pop();
          },
        onCancelPress: () => Get.back(),
      );
      return null;
    
  }
}

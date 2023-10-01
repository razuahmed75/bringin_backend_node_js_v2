import 'dart:async';

import 'package:bringin/utils/routes/route_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../Hive/hive.dart';
import '../../Screens/candidate_section/edit_main_profile/candidate_Edit_MainProfile_Screen.dart';
import '../../utils/services/keys.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // late Animation<double> animation;
  // late AnimationController controller;
  void goToTransparentView() {
    changeSystemColor(Colors.transparent);

    /// IF THE USER IS AUTHENTICATED
    if (HiveHelp.read(Keys.authToken) != null) {
      /// IF THE USER ROLE IS RECRUITER
      if (HiveHelp.read(Keys.isRecruiter) == true) {
        if (HiveHelp.read(Keys.isRecruiterProfileBasicCompleted) == true &&
            HiveHelp.read(Keys.isRecruiterCompanyDocVerified) == false) {
          Get.offAllNamed(RouteHelper.getRecruiterJobPostRoute());
        } else if (HiveHelp.read(Keys.isRecruiterProfileBasicCompleted) ==
                true &&
            HiveHelp.read(Keys.isRecruiterCompanyDocVerified) == true) {
          Get.offNamed(RouteHelper.getBottomNavRoute());
        } else {
          Get.offAllNamed(RouteHelper.getRecruiterEditMainProfileRoute());
        }
      }

      /// IF THE USER ROLE IS SEEKER
      else {
        if (HiveHelp.read(Keys.isCandidateProfileBasicCompleted) == true &&
            HiveHelp.read(Keys.isCandidateJobPrefCompleted) == false) {
          Get.offAllNamed(RouteHelper.getCandidateCareerPrefRoute());
        } else if (HiveHelp.read(Keys.isCandidateJobPrefCompleted) == true &&
            HiveHelp.read(Keys.isCandidateProfileBasicCompleted) == true) {
          Get.offAllNamed(RouteHelper.getBottomNavRoute());
        } else {
          Get.off(CandidateEditMainProfileScreen(loginhome: true));
        }
      }
    }

    /// IF NOT AUTHENTICATED
    else {
      Get.offAllNamed(RouteHelper.getLoginSelectRoute())?.then((result) {
        changeSystemColor(Colors.transparent);
      });
    }
  }

  void changeSystemColor(Color color) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: color,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    //   statusBarColor: color,
    //   systemNavigationBarDividerColor: color,
    //   statusBarIconBrightness: Brightness.dark,
    // ));
  }

  late StreamSubscription _sub;

  Future<void> initUniLinks() async {
    // ... check initialLink

    // Attach a listener to the stream
    _sub = linkStream.listen((String? link) {
      // Parse the link and warn the user, if it is not correct
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }

  @override
  void onInit() {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("74463dd2-b8de-4624-a679-0221b4b0af85");
    initUniLinks();
    //  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    //   if (kDebugMode) {
    //     print("Accepted permission: $accepted");
    //   }
    // });
    // controller =
    //     AnimationController(vsync: this, duration: Duration(seconds: 3))
    //       ..forward();
    // animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    Future.delayed(
      const Duration(seconds: 1),
      () => goToTransparentView(),
    );
    super.onInit();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }
}

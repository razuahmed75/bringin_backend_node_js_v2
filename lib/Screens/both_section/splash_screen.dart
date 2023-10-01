import 'package:bringin/controllers/both_category/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controllers/candidate_section/candidate_edit_main_profile_controller.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final currentprofileinfo = Get.put(CandidateEditMainProfileController());
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: AppColors.mainColor,
    //   statusBarColor: AppColors.blackColor,
    //   systemNavigationBarDividerColor: AppColors.mainColor,
    // ));
    
    SplashScreenController _splashScreenController = Get.find();
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.mainColor,
     
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 220.h),
          // logo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ScaleTransition(
              //   scale: _splashScreenController.animation,
              //   child:
              Container(
                alignment: Alignment.center,
                width: 99.w,
                height: 100.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/icons/splash_logo.png"),
                      fit: BoxFit.fitHeight),
                ),
              ),
              // ),
            ],
          ),
          const Gap(25),
          Text("Bringin",
              style: Styles.largeTitle.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor,
              )),
          Spacer(),

          // Instant Chat - Hire Direct
          Text("Instant Chat - Hire Direct!",
              style: Styles.smallTitle.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
                fontSize: 20.sp,
              )),
          SizedBox(height: 100.h),

          // // Bringin Technologies Ltd.
          // Text("Bringin Technologies Ltd.",
          //  style: Styles.smallTitle.copyWith(
          //   fontWeight: FontWeight.w500,
          //   color: AppColors.whiteColor,
          // )),
        ],
      ),
    );
  }
}

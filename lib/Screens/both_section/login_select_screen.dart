import 'package:bringin/res/app_font.dart';
import 'package:bringin/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import '../../Hive/hive.dart';
import '../../res/constants/image_path.dart';
import '../../res/dimensions.dart';
import '../../utils/services/keys.dart';
import '../../widgets/app_button.dart';
import '../../widgets/image_and_text.dart';

class LoginSelectScreen extends StatelessWidget {
  const LoginSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Choose Your Role",
          style: Styles.largeTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Dimensions.kDefaultgapTop,

              ImageAndText(
                isSeeker: true,
                alignment: Alignment.topLeft,
                imagePath: AppImagePaths.jobSeeker,
                text: "Looking\nfor a Job?",
                botton: AppButton(
                    buttonWidth: 200.w,
                    buttonHeight: 38.h,
                    fontWeight: FontWeight.w500,
                    bgColor: AppColors.mainColor.withOpacity(.8),
                    borderColor: Colors.transparent,
                    text: "Join as Job Seeker",
                    textColor: AppColors.whiteColor,
                    textSize: 16.sp,
                    onTap: () {
                      HiveHelp.write(
                        Keys.isRecruiter,
                        false,
                      );
                      print("isRecruiter: " +
                          HiveHelp.read(Keys.isRecruiter).toString());
                      Get.toNamed(
                        RouteHelper.getSignInRoute(),
                      );
                    }),
              ),
              const Gap(90),

              // Join as Recruiter
              ImageAndText(
                isSeeker: false,
                alignment: Alignment.topRight,
                imagePath: AppImagePaths.recruiter,
                text: "Need Candidate\nInstantly?",
                botton: AppButton(
                  text: "Join as Recruiter",
                  textColor: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                  textSize: 16.sp,
                  buttonWidth: 200.w,
                  buttonHeight: 38.h,
                  bgColor: AppColors.mainColor.withOpacity(.8),
                  onTap: () => dialog(),
                  borderColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dialog() {
    return Get.defaultDialog(
      radius: 10,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      titlePadding: EdgeInsets.zero,
      title: "",
      content: Container(
        width: double.maxFinite,
        padding: Dimensions.kDefaultPadding,
        child: Column(
          children: [
            Container(
              width: height(160),
              height: height(160),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(AppImagePaths.recruiter),
                fit: BoxFit.fitHeight,
              )),
            ),
            const Gap(10),
            Text("Hi, I am a Recruiter.", style: Styles.bodyMediumSemiBold),
            const Gap(20),
            Text(
              "Welcome, Dear Recruiter! Let's proceed to post a job and engage in direct conversations with job seekers.",
              textAlign: TextAlign.center,
              style: Styles.bodyMedium2,
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// GO
                Expanded(
                  child: AppButton(
                    buttonHeight: height(40),
                    text: "Cancel",
                    bgColor: Color(0xffE7E7E7),
                    onTap: () => Get.back(),
                  ),
                ),
                const Gap(15),

                /// CANCEL
                Expanded(
                  child: AppButton(
                    text: "Proceed",
                    textColor: AppColors.whiteColor,
                    onTap: () {
                      Get.back();
                      Get.toNamed(RouteHelper.getSignInRoute());
                      HiveHelp.write(Keys.isRecruiter, true);
                    },
                    buttonHeight: height(40),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

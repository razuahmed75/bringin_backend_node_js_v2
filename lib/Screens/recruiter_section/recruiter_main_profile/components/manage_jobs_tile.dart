import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Hive/hive.dart';
import '../../../../controllers/recruiter_section/recruiter_job_post_controller.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/dimensions.dart';
import '../../../../utils/services/keys.dart';
import '../../job_post/recruiter_job_post_screen.dart';

class ManageJobsTile extends StatelessWidget {
  final void Function()? onTap;
  const ManageJobsTile({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(3),
      child: Ink(
        height: Dimensions.buttonHeight,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: width(15)),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.appBorder,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Image.asset("assets/icon2/job_manage.png",height: 25.h,width:25.h),
            SizedBox(width: 10.w),
            Text("Manage Jobs", style: Styles.bodyMedium1),
            Spacer(),
            InkWell(
              onTap: () {
                Get.to(RecruiterJobPostScreen(isprofile: true));
                HiveHelp.write(Keys.isRecruiterNewJoined, false);
                RecruiterJobPostController.to.resetJobPostValue();
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor.withOpacity(.6),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Text("Post a New Job",
                      style: Styles.bodySmall1.copyWith(
                        color: AppColors.whiteColor,
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}

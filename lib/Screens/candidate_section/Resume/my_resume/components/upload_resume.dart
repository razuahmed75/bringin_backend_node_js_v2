// ignore_for_file: must_be_immutable

import 'package:bringin/Hive/hive.dart';
import 'package:bringin/controllers/candidate_section/resume_management_controller.dart';
import 'package:bringin/controllers/upload_file/upload_avator_controller.dart';
import 'package:bringin/controllers/upload_file/upload_recruiter_document.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/color.dart';
import '../../../../../res/constants/image_path.dart';
import '../../../../../res/dimensions.dart';
import '../../../../../utils/services/keys.dart';
import '../../../edit_main_profile/components/candidate_profile_dialog.dart';
import '../../resume_management.dart';

class UploadResume extends StatelessWidget {
  UploadResume({super.key});
  UploadAvatorController uploadAvatorController =
      Get.find<UploadAvatorController>();
  UploadRecruiterDocumentController uploadDocumentController =
      Get.find<UploadRecruiterDocumentController>();
  var resumeManagementControll = Get.put(ResumeManagementController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetBuilder<ResumeManagementController>(
          builder: (controller) {
            // if (MyResumeController.to.myresume!.userid == null) {
            //   return SizedBox();
            // }
            if (HiveHelp.read(Keys.isUploadeRealAvatar) == true) {
              return SizedBox();
            }
            if(HiveHelp.read(Keys.isUploadeRealAvatar) == false && controller.uploadresumelist.isNotEmpty){
              return Container(
                width: Dimensions.screenWidth * .5,
                height: height(90),
                child: _buildUploadButton(
                  text: "Upload your real avatar",
                  iconPath: AppImagePaths.real_avatar,
                  onUploadPressed: () {
                    Get.toNamed(RouteHelper.getCandidateEditMainProfileRoute());
                    CandidateProfileInfoDialog.buildUploadDialog(context);
                  }
                      
                ),
              );
            }
            return Expanded(
              child: _buildUploadButton(
                text: "Upload your real avatar",
                iconPath: AppImagePaths.real_avatar,
                onUploadPressed: () {
                    Get.toNamed(RouteHelper.getCandidateEditMainProfileRoute());
                    CandidateProfileInfoDialog.buildUploadDialog(context);
                  }
              ),
            );
          },
        ),
        const Gap(20),
        // GetBuilder<ResumeManagementController>(
        //   builder: (controller) {
            Obx((){
              if (HiveHelp.read(Keys.isUploadeRealAvatar) == true &&
                    resumeManagementControll.uploadresumelist.isEmpty) {
              return Container(
                width: Dimensions.screenWidth * .5,
                height: height(90),
                child: _buildUploadButton(
                    text: "Upload your CV/Resume",
                    iconPath: AppImagePaths.resume,
                    onUploadPressed: () {
                      // uploadDocumentController.uploadResume();
                      Get.to(() => Resume_management());
                    }),
              );
            }  if (resumeManagementControll.uploadresumelist.isNotEmpty) {
              return SizedBox();
            }
            return Expanded(
              child: _buildUploadButton(
                  text: "Upload your CV/Resume",
                  iconPath: AppImagePaths.resume,
                  onUploadPressed: () {
                    // uploadDocumentController.uploadResume();
                    Get.to(() => Resume_management());
                  }),
            );
            }),
        //   },
        // )
      ],
    );
  }

  Widget _buildUploadButton({
    required String text,
    iconPath,
    required void Function()? onUploadPressed,
  }) {
    return Container(
      padding: EdgeInsets.all(height(10)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(radius(6)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(text, style: Styles.bodySmall1)),
              const Gap(15),
              SvgPicture.asset(
                iconPath,
                height: height(24),
                width: height(24),
              )
            ],
          ),
          const Gap(12),
          InkWell(
            onTap: onUploadPressed,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width(20), vertical: height(6)),
              decoration: BoxDecoration(
                color: AppColors.mainColor.withOpacity(.4),
                borderRadius: BorderRadius.circular(radius(28)),
              ),
              child: Text("Upload", style: Styles.bodySmall1),
            ),
          ),
        ],
      ),
    );
  }
}

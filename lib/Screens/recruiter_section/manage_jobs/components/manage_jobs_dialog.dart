import 'package:bringin/res/dimensions.dart';
import 'package:bringin/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../controllers/recruiter_section/managejob_controll.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';

class ManageJobDialog {
  static var managejobcontrol = Get.put(ManagejobControll());
  static dialog({bool? isCloseJob, String? jobId, context}) {
    return Get.defaultDialog(
      radius: 20,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      titlePadding: EdgeInsets.zero,
      title: "",
      content: Container(
        width: double.maxFinite,
        padding: Dimensions.kDefaultPadding,
        child: Column(
          children: [
            const Gap(10),
            // delete icon
            Image.asset(
              AppImagePaths.deleteIcon,
              height: height(70),
              width: height(70),
            ),
            const Gap(15),

            // Are you sure you want to delete?
            isCloseJob == true
                ? Text("Are you sure you want to close this job?",
                    style: Styles.bodyLarge)
                : Text("Are you sure you want to delete permenantly?",
                    style: Styles.bodyLarge),
            const Gap(15),

            // cancel, delete
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// cancel
                Expanded(
                  child: AppButton(
                    text: "Cancel",
                    bgColor: Color(0xffE7E7E7),
                    onTap: () => Get.back(),
                  ),
                ),
                const Gap(30),

                /// delete or close
                Expanded(
                  child: AppButton(
                    text: isCloseJob == true ? "Close" : "Delete",
                    bgColor: AppColors.deleteButtonColor,
                    textColor: AppColors.whiteColor,
                    onTap: () async {
                      if (isCloseJob == true) {
                        print("job id is: " + jobId.toString());
                        managejobcontrol.closejob(
                            jobId: jobId, fields: {"job_status_type": 2});
                        Get.back();
                        Get.find<ManagejobControll>().dialog(context);
                        await Future.delayed(Duration(seconds: 4));
                        Get.back();
                      } else {
                        managejobcontrol.deleteJob(jobId!);
                        Get.back();
                      }
                    },
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

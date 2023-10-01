import 'package:bringin/utils/services/bindings/bindings_controllers_list.dart';
import 'package:bringin/widgets/app_popup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_bar.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/image_path.dart';
import '../../../res/dimensions.dart';
import '../../../utils/services/keys.dart';
import '../../../widgets/app_button.dart';
import '../../Hive/hive.dart';
import '../candidate_section/bottom_nav/bottom_nav_layout.dart';

class SwitchProfileScreen extends StatelessWidget {
   SwitchProfileScreen({super.key});

  SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    var isRecruiter = HiveHelp.read(Keys.isRecruiter);
    return Scaffold(
      appBar: appBarWidget(
          title: "Switch Your Profile",
          onBackPressed: () => Get.back(),
          actions: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Center(
            child: Column(
              children: [
                Dimensions.kDefaultgapTop,
                const Gap(16),

                Container(
                  width: height(160),
                  height: height(160),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      isRecruiter
                          ? AppImagePaths.recruiter
                          : AppImagePaths.jobSeeker,
                    ),
                    fit: BoxFit.cover,
                  )),
                ),
                const Gap(10),

                /// you are currently a job seeker
                Text(
                    isRecruiter
                        ? "You are currently a Recruiter"
                        : "You are currently a Job Seeker.",
                    style: Styles.bodyLarge),

                const Gap(15),
                Container(
                  height: .5,
                  width: width(233),
                  color: AppColors.borderColor,
                ),
                const Gap(15),

                /// do you need to hire someone?
                Text(
                    isRecruiter
                        ? "Are you seeking for a job now?"
                        : "Do you want to hire someone?",
                    style: Styles.bodyLargeMedium),

                const Gap(15),

                /// switch to recruiter
                Obx(
                  () => AppButton(
                      text: isRecruiter
                          ? settingsController.isLoading.value
                              ? "Switching..."
                              : "Switch to Job Seeker"
                          : settingsController.isLoading.value
                              ? "Switching..."
                              : "Switch to Recruiter",
                      textColor: AppColors.whiteColor,
                      buttonWidth: width(248),
                      onTap: () {
                        AppPopupDialog().showPopup(
                            context: context,
                            description:
                                "Are you sure want to switch  profile?",
                            buttonOkText: "OK",
                            onCancelPress: () => Get.back(),
                            onOkPress: () async {
                              await SettingsController.to.switchAccout(
                                  isRecruiter: isRecruiter ? 1 : 0);
                              refreshBottomNavIndex();
                            });
                      }),
                ),
                const Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

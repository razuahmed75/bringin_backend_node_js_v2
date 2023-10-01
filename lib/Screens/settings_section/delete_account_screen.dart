import 'package:bringin/Hive/hive.dart';
import 'package:bringin/controllers/both_category/settings_controller.dart';
import 'package:bringin/controllers/candidate_section/candidate_edit_main_profile_controller.dart';
import 'package:bringin/controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import 'package:bringin/res/app_font.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../res/color.dart';
import '../../utils/services/keys.dart';
import '../../widgets/app_button.dart';
import '../../widgets/custom_expand_text_field.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (HiveHelp.read(Keys.isRecruiter) == true) {
      RecruiterEditMainProfileController.to.getRecruiterProfileInfoList();
    }
    if (HiveHelp.read(Keys.isRecruiter) == false) {
      CandidateEditMainProfileController.to.getProfileInfo();
    }
    return Scaffold(
      appBar: appBarWidget(
          title: "",
          actions: [],
          onBackPressed: () {
            Get.back();
          }),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            children: [
              Text(
               HiveHelp.read(Keys.isRecruiter) ?
                'Please tell us why you want to delete your Recruiter account permanently?'
                : 'Please tell us why you want to delete your Seeker account permanently?',
                style: Styles.subTitle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: font(15),
                ),
              ),
              const Gap(15),
              CustomExpandTextField(
                maxHeight: 150,
                minHeight: 150,
                autofocus: false,
                controller:
                    SettingsController.to.deleteAccountEditingController,
                onChanged: (v) {
                  SettingsController.to.val.value = v;
                },
                hinText:
                    "Please help us to improve, describe the reason in details.",
              ),
              const Gap(10),
              Row(
                children: [
                  Obx(() => Expanded(
                        child: AppButton(
                          text: "Continue",
                          textColor: AppColors.whiteColor,
                          onTap: SettingsController.to.val.value.isEmpty ? null : () {
                            SettingsController.to.dialog(context);
                          },
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

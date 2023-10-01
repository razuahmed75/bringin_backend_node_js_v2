import 'dart:typed_data';
import 'package:bringin/widgets/cupertino_picker_middle_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../controllers/candidate_section/candidate_edit_main_profile_controller.dart';
import '../../../../../../controllers/recruiter_section/recruiter_job_post_controller.dart';
import '../../../../../../controllers/upload_file/upload_avator_controller.dart';
import '../../../../../../res/app_font.dart';
import '../../../../../../res/color.dart';
import '../../../../../../res/dimensions.dart';
import '../../../../../../widgets/header_widget.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../../utils/services/helpers.dart';

class CandidateProfileInfoDialog {
  static CandidateEditMainProfileController candidateEditMainProfileController =
      Get.find<CandidateEditMainProfileController>();
  static UploadAvatorController uploadAvatorController =
      Get.find<UploadAvatorController>();
  static List genderList = [
    "Male",
    "Female",
  ];

  static Future<dynamic> genderDialog(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        elevation: 0,
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: width(20), right: width(20), top: height(12)),
                child: HeaderWidget(
                  onBackPressed: () => Get.back(),
                  onSavePressed: () {
                    candidateEditMainProfileController.postGender(data: {
                      "gender": genderList[
                          candidateEditMainProfileController.genderIndex.value],
                    });
                  },
                  margin: EdgeInsets.zero,
                  middleText: "Gender",
                  isArrow: false,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: width(210),
                    height: height(200),
                    margin: EdgeInsets.only(bottom: height(20)),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: AppColors.mainColor.withOpacity(.25),
                        borderRadius: BorderRadius.circular(radius(20)),
                      ),
                      child: ListWheelScrollView(
                          perspective: 0.01,
                          itemExtent: height(33),
                          useMagnifier: true,
                          magnification: 1.2,
                          controller: FixedExtentScrollController(
                              initialItem: candidateEditMainProfileController
                                  .genderIndex.value),
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (int index) {
                            candidateEditMainProfileController
                                .genderIndex.value = index;
                          },
                          children: genderList.map((gender) {
                            return Obx(
                              () => Text(
                                gender,
                                style: Styles.bodyLarge.copyWith(
                                  color: genderList.indexOf(gender) ==
                                          candidateEditMainProfileController
                                              .genderIndex.value
                                      ? AppColors.blackColor
                                      : AppColors.blackOpacity70,
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),

                  /// LOADER
                  Obx(() {
                    return candidateEditMainProfileController.isGenLoading.value
                        ? Helpers.appLoader2()
                        : SizedBox();
                  }),

                  /// midle divider
                  Padding(
                    padding: EdgeInsets.only(bottom: height(30)),
                    child: CuperTinoMiddleDivider(
                      color: Colors.white,
                      topDvdrMrgnBtm: 16,
                      btmDvdrMrgnTop: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<dynamic> experienceLevelDialog(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        elevation: 0,
        content: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<RecruiterJobPostController>(builder: (_) {
                return Container(
                  margin: EdgeInsets.only(
                      left: width(20), right: width(20), top: height(12)),
                  child: HeaderWidget(
                    onBackPressed: () => Get.back(),
                    onSavePressed: RecruiterJobPostController.to.isExpLoading
                        ? null
                        : () {
                            print(RecruiterJobPostController
                                .to
                                .experienceList[
                                    candidateEditMainProfileController
                                        .experienceLevelIndex.value]
                                .sId
                                .toString());
                            candidateEditMainProfileController
                                .postExperienceLevel(data: {
                              "experiencedlevel": RecruiterJobPostController
                                  .to
                                  .experienceList[
                                      candidateEditMainProfileController
                                          .experienceLevelIndex.value]
                                  .sId!,
                            });
                          },
                    margin: EdgeInsets.zero,
                    middleText: "Experience",
                    isArrow: false,
                  ),
                );
              }),
              Stack(
                alignment: Alignment.center,
                children: [
                  GetBuilder<RecruiterJobPostController>(builder: (_) {
                    if (RecruiterJobPostController.to.isExpLoading) {
                      return SizedBox(
                          width: width(310),
                          height: height(180),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Helpers.appLoader2(),
                                ],
                              ),
                            ],
                          ));
                    }
                    return Container(
                      width: width(220),
                      height: height(220),
                      margin: EdgeInsets.only(bottom: height(20)),
                      decoration: BoxDecoration(
                        // color: AppColors.mainColor.withOpacity(.25),
                        borderRadius: BorderRadius.circular(radius(20)),
                      ),
                      child: ListWheelScrollView(
                          perspective: 0.01,
                          itemExtent: height(35),
                          useMagnifier: true,
                          magnification: 1.2,
                          controller: FixedExtentScrollController(
                              initialItem: candidateEditMainProfileController
                                  .experienceLevelIndex.value),
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (int index) {
                            candidateEditMainProfileController
                                .experienceLevelIndex.value = index;
                          },
                          children: RecruiterJobPostController.to.experienceList
                              .map((experience) {
                            return Obx(
                              () => Text(
                                experience.name!,
                                style: Styles.bodyLarge.copyWith(
                                  color: RecruiterJobPostController
                                              .to.experienceList
                                              .indexOf(experience) ==
                                          candidateEditMainProfileController
                                              .experienceLevelIndex.value
                                      ? AppColors.blackColor
                                      : AppColors.blackOpacity70,
                                ),
                              ),
                            );
                          }).toList()),
                    );
                  }),

                  /// LOADER
                  Obx(() {
                    return candidateEditMainProfileController.isExpLoading.value
                        ? Helpers.appLoader2()
                        : SizedBox();
                  }),

                  /// midle divider
                  Padding(
                    padding: EdgeInsets.only(bottom: height(30)),
                    child: CuperTinoMiddleDivider(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// upload photo dialog
  static Future<dynamic> buildUploadDialog(BuildContext context) {
    return showGeneralDialog(
      transitionDuration: Duration(milliseconds: 300),
      barrierLabel: '',
      context: context,
      barrierDismissible: true,
      pageBuilder: (context, animation1, animation2) {
        return Text('PAGE BUILDER');
      },
      barrierColor: AppColors.blackColor.withOpacity(0.70),
      transitionBuilder: (context, a1, a2, child) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius(9))),
              insetPadding: EdgeInsets.zero,
              elevation: 0,
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        uploadAvatorController.uploadCamaraProfile();
                        Get.back();
                      },
                      title: Text("Take a Selfie", style: Styles.bodyMedium1),
                    ),
                    ListTile(
                      onTap: () {
                        uploadAvatorController.getAvator();
                        Get.back();
                      },
                      title: Text("Upload From Gallery",
                          style: Styles.bodyMedium1),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Get.bottomSheet(
                          backgroundColor: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(radius(18))),
                          ),
                          Container(
                            height: height(380),
                            padding: Dimensions.kDefaultPadding,
                            margin: EdgeInsets.symmetric(vertical: height(15)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Wrap(
                                  spacing: 30,
                                  runSpacing: 15,
                                  children: [
                                    ...List.generate(
                                        candidateEditMainProfileController
                                            .defaultAvatarList.length, (index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          ByteData imageBytes =
                                              await rootBundle.load(
                                                  candidateEditMainProfileController
                                                          .defaultAvatarList[
                                                      index]);
                                          List<int> imageData =
                                              imageBytes.buffer.asUint8List();
                                          await uploadDefaultAvater(imageData);
                                          Get.back();
                                        },
                                        child: Container(
                                          width: height(60),
                                          height: height(60),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  candidateEditMainProfileController
                                                          .defaultAvatarList[
                                                      index]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      title: Text("Select From Default",
                          style: Styles.bodyMedium1),
                    ),
                    ListTile(
                      onTap: () => Get.back(),
                      title: Text("Cancel", style: Styles.bodyMedium1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

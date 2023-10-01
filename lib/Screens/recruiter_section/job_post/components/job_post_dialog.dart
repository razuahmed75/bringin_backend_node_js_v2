
import 'package:bringin/models/candidate_section/education_level_model.dart';
import 'package:bringin/models/recruiter_section/recruiter_experience_model.dart';
import 'package:bringin/widgets/cupertino_picker_middle_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/candidate_section/education_level_controller.dart';
import '../../../../controllers/recruiter_section/recruiter_job_post_controller.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/dimensions.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../widgets/header_widget.dart';

class JobPostDialog {
  static RecruiterJobPostController recruiterJobPostController = Get.find<RecruiterJobPostController>();
  static EducationLevelController educationLevelController = Get.find<EducationLevelController>();
  static var selectedExperienceVal = "";
  static var selectedEducationVal = "";
  static var selectedExperienceId = "0";
  static var selectedEducationId = "0";
  /// experience
  static buildExperienceBottomShit() {
    Get.bottomSheet(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius(18))),
        ),
        Container(
          height: height(270),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// header
              HeaderWidget(
                onBackPressed: () => Get.back(),
                onSavePressed: () {
                  recruiterJobPostController.selectedExperienceVal.value = selectedExperienceVal;
                  recruiterJobPostController.selectedExperienceId.value = selectedExperienceId;
                  print(recruiterJobPostController.selectedExperienceVal.value);
                  print(recruiterJobPostController.selectedExperienceId.value);
                  Get.back();
                },
                middleText: "Required Experience",
                margin: EdgeInsets.symmetric(horizontal: width(22), vertical: height(16)),
                isArrow: false,
              ),

              Stack(
                alignment: Alignment.center,
                children: [
                  GetBuilder<RecruiterJobPostController>(builder: (_){
                    if(recruiterJobPostController.isExpLoading){
                      return SizedBox(
                        height: height(150),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Helpers.appLoader2(),
                          ],
                        ),
                      );
                    }else if(recruiterJobPostController.experienceList.isEmpty){
                     return Center(child: Text("Not Found"));
                    }
                    return Container(
                      height: height(200),
                      width: Dimensions.screenWidth-100,
                      decoration: BoxDecoration(
                          // color: AppColors.mainColor.withOpacity(.25),
                        borderRadius:
                            BorderRadius.circular(radius(20)),
                      ),
                      child: ListWheelScrollView(
                          perspective: 0.01,
                          itemExtent: height(30),
                          useMagnifier: true,
                          magnification: 1.2,
                          controller: FixedExtentScrollController(initialItem:  recruiterJobPostController
                                              .initialExpIndex.value
                                          ),
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            recruiterJobPostController.initialExpIndex.value = index;
                            selectedExperienceVal = recruiterJobPostController.experienceList[index].name!;
                            selectedExperienceId = recruiterJobPostController.experienceList[index].sId!;
                          },
                          children: recruiterJobPostController.experienceList.map((RecruiterExperienceModel e){
                            selectedExperienceVal = recruiterJobPostController.experienceList[recruiterJobPostController.initialExpIndex.value].name!;
                            selectedExperienceId = recruiterJobPostController.experienceList[recruiterJobPostController.initialExpIndex.value].sId!;
                            return  Obx(()=>Text(
                                        "${e.name}",
                                        style: Styles.bodyLargeMedium.copyWith(
                                          fontWeight: recruiterJobPostController.experienceList.indexOf(e)==recruiterJobPostController.initialExpIndex.value
                                              ? FontWeight.w500
                                              : FontWeight.w400,
                                          color: recruiterJobPostController.experienceList.indexOf(e)==recruiterJobPostController.initialExpIndex.value
                                              ? AppColors.blackColor
                                              : AppColors.blackOpacity70,
                                        ),
                                      ),
                            );
                          }).toList(),
                        ),
                    );
                  }),

                  /// middle indicator box
                  Padding(
                    padding: EdgeInsets.only(bottom: height(10)),
                    child: CuperTinoMiddleDivider(
                      color: AppColors.whiteColor,
                      btmDvdrMrgnTop: 18,
                      topDvdrMrgnBtm: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
  /// education
  static buildEducationBottomShit() {
    Get.bottomSheet(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius(18))),
        ),
        Container(
          height: height(270),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// header
              HeaderWidget(
                onBackPressed: () => Get.back(),
                onSavePressed: () {
                  recruiterJobPostController.selectedEducationVal.value = selectedEducationVal;
                  recruiterJobPostController.selectedEducationId.value = selectedEducationId;
                  print(recruiterJobPostController.selectedEducationVal.value);
                  print(recruiterJobPostController.selectedEducationId.value);
                  Get.back();
                },
                middleText: "Education",
                margin: EdgeInsets.symmetric(horizontal: width(22), vertical: height(16)),
                isArrow: false,
              ),

              Stack(
                alignment: Alignment.center,
                children: [
                  GetBuilder<EducationLevelController>(builder: (_){
                    if(educationLevelController.isLoading){
                      return SizedBox(
                        height: height(150),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Helpers.appLoader2(),
                          ],
                        ),
                      );
                    }
                    return Container(
                      height: height(200),
                      width: Dimensions.screenWidth-100,
                      decoration: BoxDecoration(
                          // color: AppColors.mainColor.withOpacity(.25),
                        borderRadius:
                            BorderRadius.circular(radius(20)),
                      ),
                      child: ListWheelScrollView(
                          perspective: 0.01,
                          itemExtent: height(30),
                          useMagnifier: true,
                          magnification: 1.2,
                          controller: FixedExtentScrollController(initialItem:  recruiterJobPostController
                                              .initialEducationIndex.value
                                          ),
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            recruiterJobPostController.initialEducationIndex.value = index;
                            selectedEducationVal = educationLevelController.educationLevelList[index].name!;
                            selectedEducationId = educationLevelController.educationLevelList[index].id!;
                          },
                          children:  educationLevelController.educationLevelList.map((EducationLevelModel e){
                            // selectedEducationVal = e.name!;
                            // selectedEducationId = e.id!;
                            selectedEducationVal = educationLevelController.educationLevelList[recruiterJobPostController.initialEducationIndex.value].name!;
                            selectedEducationId = educationLevelController.educationLevelList[recruiterJobPostController.initialEducationIndex.value].id!;
                            return  Obx(()=>Text(
                                        "${e.name}",
                                        style: Styles.bodyLargeMedium.copyWith(
                                          fontWeight: educationLevelController.educationLevelList.indexOf(e)==recruiterJobPostController.initialEducationIndex.value
                                              ? FontWeight.w500
                                              : FontWeight.w400,
                                          color: educationLevelController.educationLevelList.indexOf(e)==recruiterJobPostController.initialEducationIndex.value
                                              ? AppColors.blackColor
                                              : AppColors.blackOpacity70,
                                        ),
                                      ),
                            );
                          }).toList(),
                        ),
                    );
                  }),

                  /// middle indicator box
                  Padding(
                    padding: EdgeInsets.only(bottom: height(10)),
                    child: CuperTinoMiddleDivider(
                      color: AppColors.whiteColor,
                      btmDvdrMrgnTop: 18,
                      topDvdrMrgnBtm: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_bottom_nav_widget.dart';
import 'package:intl/intl.dart';
import '../../Hive/hive.dart';
import '../../controllers/candidate_section/candidate_edit_main_profile_controller.dart';
import '../../controllers/candidate_section/education_level_controller.dart';
import '../../controllers/candidate_section/education_controller.dart';
import '../../controllers/candidate_section/my_resume_controller.dart';
import '../../controllers/candidate_section/other_activities_controller.dart';
import '../../models/candidate_section/educational_qualification_post_model.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/dimensions.dart';
import '../../utils/routes/route_helper.dart';
import '../../utils/services/helpers.dart';
import '../../utils/services/keys.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_popup_dialog.dart';
import '../../widgets/experience_tile.dart';
import '../../widgets/header_widget.dart';

class EducationScreen extends StatelessWidget {
  final String? educationId;
   EducationScreen({super.key, this.educationId});
  EducationLevelController educationLevelController = Get.find();
    EducationController educationCtrlr = Get.find();
    OtherActivitiesController otherActivitiesController = Get.find();
    CandidateEditMainProfileController candidateProfileInfoController =
        Get.find();
    final myResumeController = Get.find<MyResumeController>();
  @override
  Widget build(BuildContext context) {
    
    var currentYear = DateTime.now().year.toString().substring(2);
    int indexedYear = int.parse(currentYear);
    return WillPopScope(
      onWillPop: (){
       return onBackPressed(context);
      },
      child: Scaffold(
        appBar: appBarWidget(
            title: "Education",
            onBackPressed: () {
              onBackPressed(context);
            },
            actions: []),
        body: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDefaultgapTop,
    
              /// educational qualifications
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                        vertical: height(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Institute Name
                        Obx(
                          () => ExperienceTile(
                            onPressed: () {
                              Get.toNamed(RouteHelper.getInstituteNameRoute());
                            },
                            firstText: "Institute Name",
                            maxLines: 1,
                            secondText: educationCtrlr.institueName.isEmpty
                                ? "e.g. Dhaka International University"
                                : educationCtrlr.institueName.value,
                            secondTextColor: educationCtrlr.institueName.isEmpty
                                ? AppColors.hintColor
                                : AppColors.blackColor,
                          ),
                        ),
    
                        // Educational Level
                        Obx(
                          () => ExperienceTile(
                            onPressed: () {
                              print(HiveHelp.read(Keys.authToken));
                              if (educationLevelController
                                  .educationLevelList.isEmpty) {
                                educationLevelController.getEducationLevel();
                                Get.toNamed(RouteHelper.getEducationLevelRoute());
                              } else {
                                Get.toNamed(RouteHelper.getEducationLevelRoute());
                              }
                            },
                            maxLines: 1,
                            firstText: "Educational Level",
                            secondText: educationLevelController
                                    .selectedDegree.value.isEmpty
                                ? "e.g. Doctorate - M.Phil"
                                : "${educationLevelController.selectedEducationLevel.value}" +
                                    " - " +
                                    educationLevelController.selectedDegree.value,
                            secondTextColor: educationLevelController
                                    .selectedDegree.value.isEmpty
                                ? AppColors.hintColor
                                : AppColors.blackColor,
                          ),
                        ),
    
                        // Subject (Major In)
                        Obx(
                          () => educationLevelController
                                  .selectedDegree.value.isEmpty
                              ? SizedBox()
                              : ExperienceTile(
                                  onPressed: () {
                                    Get.toNamed(
                                        RouteHelper.getFieldOfStudyRoute());
                                  },
                                  maxLines: 1,
                                  firstText: "Subject (Major In)",
                                  secondText: educationCtrlr
                                          .selectedSubjectName.value.isEmpty
                                      ? "e.g. Economics"
                                      : educationCtrlr.selectedSubjectName.value,
                                  secondTextColor: educationCtrlr
                                          .selectedSubjectName.value.isEmpty
                                      ? AppColors.hintColor
                                      : AppColors.blackColor,
                                ),
                        ),
    
                        // Start - End
                        Obx(

                          () => ExperienceTile(
                            onStartPressed: () {
                              Get.bottomSheet(
                                  backgroundColor: AppColors.whiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(radius(18))),
                                  ),
                                  Container(
                                    height: height(280),
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(radius(18))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        HeaderWidget(
                                          onBackPressed: () => Get.back(),
                                          onSavePressed: () {
                                            educationCtrlr.selectedStartTime
                                                .value = educationCtrlr
                                                    .selectedStartTimeMonth +
                                                " ${educationCtrlr.selectedStartTimeYear}";
                                            String dateStr = educationCtrlr
                                                .selectedStartTime.value;
                                            DateFormat format =
                                                DateFormat('MMMM yyyy');
                                            DateTime dateTime =
                                                format.parse(dateStr);
                                            educationCtrlr
                                                    .formattedStartDateFromUi =
                                                DateFormat('yyy-MM-dd')
                                                    .format(dateTime);
                                            print(educationCtrlr
                                                .formattedStartDateFromUi);
                                            Get.back();
                                          },
                                          middleText: "Start Time",
                                          isArrow: false,
                                          margin: EdgeInsets.symmetric(
                                            vertical: height(20),
                                            horizontal: width(10),
                                          ),
                                        ),
                                        Container(
                                          height: height(200),
                                          width: width(220),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            // color: AppColors.mainColor
                                            //     .withOpacity(.25),
                                            borderRadius:
                                                BorderRadius.circular(radius(20)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                width: width(120),
                                                child: CupertinoPicker(
                                                  useMagnifier: true,
                                                  magnification: 1.3,
                                                  selectionOverlay: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.transparent,
                                                        border: Border(
                                                            bottom: BorderSide(
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                            top: BorderSide(
                                                                color: AppColors
                                                                    .whiteColor))),
                                                  ),
                                                  scrollController:
                                                      FixedExtentScrollController(
                                                          initialItem: educationCtrlr
                                                                  .selectedStartTimeMonthIndex
                                                                  .value +
                                                              6),
                                                  itemExtent: height(30),
                                                  onSelectedItemChanged:
                                                      (int index) {
                                                    educationCtrlr
                                                        .selectedStartTimeMonthIndex
                                                        .value = index;
                                                    educationCtrlr
                                                            .selectedStartTimeMonth =
                                                        candidateProfileInfoController
                                                            .months[index];
                                                  },
                                                  children: List<Widget>.generate(
                                                      candidateProfileInfoController
                                                          .months
                                                          .length, (int index) {
                                                    educationCtrlr
                                                            .selectedStartTimeMonth =
                                                        candidateProfileInfoController
                                                                .months[
                                                            educationCtrlr
                                                                .selectedStartTimeMonthIndex
                                                                .value];
                                                    return Center(
                                                      child: Text(
                                                        candidateProfileInfoController
                                                            .months[index],
                                                        style: Styles.bodyMedium1,
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
    
                                              /// middle divider
                                              // Container(
                                              //   width: width(12),
                                              //   height: height(2),
                                              //   color: AppColors.blackColor,
                                              // ),
                                              SizedBox(
                                                width: width(100),
                                                child: CupertinoPicker(
                                                  useMagnifier: true,
                                                  magnification: 1.3,
                                                  selectionOverlay: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.transparent,
                                                        border: Border(
                                                            bottom: BorderSide(
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                            top: BorderSide(
                                                                color: AppColors
                                                                    .whiteColor))),
                                                  ),
                                                  scrollController:
                                                      FixedExtentScrollController(
                                                          initialItem: educationCtrlr
                                                                  .selectedStartTimeYearIndex
                                                                  .value +
                                                              45),
                                                  itemExtent: height(30),
                                                  onSelectedItemChanged:
                                                      (int index) {
                                                    educationCtrlr
                                                        .selectedStartTimeYearIndex
                                                        .value = index;
                                                    educationCtrlr
                                                            .selectedStartTimeYear =
                                                        "${1970 + index}";
                                                  },
                                                  children: List<Widget>.generate(
                                                      31 + indexedYear,
                                                      (int index) {
                                                    educationCtrlr
                                                            .selectedStartTimeYear =
                                                        "${1970 + educationCtrlr.selectedStartTimeYearIndex.value + 45}";
                                                    return Center(
                                                      child: Text(
                                                        '${1970 + index}',
                                                        style: Styles.bodyMedium1,
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                            onEndPressed: () {
                              Get.bottomSheet(
                                  backgroundColor: AppColors.whiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(radius(18))),
                                  ),
                                  Container(
                                    height: height(280),
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(radius(18))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        HeaderWidget(
                                          onBackPressed: () => Get.back(),
                                          onSavePressed: () {
                                            int nowyear = DateTime.now().year;
                                            educationCtrlr.selectedEndTime
                                                .value = educationCtrlr
                                                        .selectedEndTimeMonth +
                                                    " ${educationCtrlr.selectedEndTimeYear}";
                                            String dateStr = educationCtrlr
                                                .selectedEndTime.value;
                                            String prasentformet = educationCtrlr
                                                    .selectedEndTimeMonth +
                                                " ${int.parse(educationCtrlr.selectedEndTimeYear)}";
                                            DateFormat format =
                                                DateFormat('MMMM yyyy');
                                            DateTime dateTime = format.parse(
                                                int.parse(educationCtrlr
                                                            .selectedEndTimeYear) >
                                                        nowyear
                                                    ? prasentformet
                                                    : dateStr);
                                            educationCtrlr
                                                    .formattedEndDateFromUi =
                                                DateFormat('yyy-MM-dd')
                                                    .format(dateTime);
                                            // print(educationCtrlr.formattedEndDateFromUi);
                                            print(educationCtrlr
                                                .selectedEndTimeYear);
                                            print(prasentformet);
                                            Get.back();
                                          },
                                          middleText: "End Time",
                                          isArrow: false,
                                          margin: EdgeInsets.symmetric(
                                            vertical: height(20),
                                            horizontal: width(10),
                                          ),
                                        ),
                                        Container(
                                          height: height(200),
                                          width: width(220),
                                          decoration: BoxDecoration(
                                            color: AppColors.mainColor
                                                .withOpacity(.25),
                                            borderRadius:
                                                BorderRadius.circular(radius(20)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                width: width(120),
                                                child: CupertinoPicker(
                                                  useMagnifier: true,
                                                  magnification: 1.3,
                                                  selectionOverlay: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.transparent,
                                                        border: Border(
                                                            bottom: BorderSide(
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                            top: BorderSide(
                                                                color: AppColors
                                                                    .whiteColor))),
                                                  ),
                                                  // selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                                                  //   background: Colors.transparent,
                                                  // ),
                                                  scrollController:
                                                      FixedExtentScrollController(
                                                          initialItem: educationCtrlr
                                                                  .selectedEndTimeMonthIndex
                                                                  .value +
                                                              6),
                                                  itemExtent: height(30),
                                                  onSelectedItemChanged:
                                                      (int index) {
                                                    educationCtrlr
                                                        .selectedEndTimeMonthIndex
                                                        .value = index;
                                                    educationCtrlr
                                                            .selectedEndTimeMonth =
                                                        candidateProfileInfoController
                                                            .months[index];
                                                  },
                                                  children: List<Widget>.generate(
                                                      candidateProfileInfoController
                                                          .months
                                                          .length, (int index) {
                                                    educationCtrlr
                                                            .selectedEndTimeMonth =
                                                        candidateProfileInfoController
                                                                .months[
                                                            educationCtrlr
                                                                .selectedEndTimeMonthIndex
                                                                .value];
                                                    return Center(
                                                      child: Text(
                                                        candidateProfileInfoController
                                                            .months[index],
                                                        style: Styles.bodyMedium1,
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
    
                                              /// middle divider
                                              // Container(
                                              //   width: width(12),
                                              //   height: height(2),
                                              //   color: AppColors.blackColor,
                                              // ),
                                              SizedBox(
                                                width: width(100),
                                                child: CupertinoPicker(
                                                  useMagnifier: true,
                                                  magnification: 1.3,
                                                  selectionOverlay: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.transparent,
                                                        border: Border(
                                                            bottom: BorderSide(
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                            top: BorderSide(
                                                                color: AppColors
                                                                    .whiteColor))),
                                                  ),
                                                  scrollController:
                                                      FixedExtentScrollController(
                                                          initialItem: educationCtrlr
                                                                  .selectedEndTimeYearIndex
                                                                  .value +
                                                              49),
                                                  itemExtent: height(30),
                                                  onSelectedItemChanged:
                                                      (int index) {
                                                    educationCtrlr
                                                        .selectedEndTimeYearIndex
                                                        .value = index;
                                                    educationCtrlr
                                                            .selectedEndTimeYear =
                                                        "${1970 + index}";
                                                  },
                                                  children: List<Widget>.generate(
                                                      41 + indexedYear,
                                                      (int index) {
                                                    educationCtrlr
                                                            .selectedEndTimeYear =
                                                        "${1970 + educationCtrlr.selectedEndTimeYearIndex.value + 49}";
                                                    return Center(
                                                      child: Text(
                                                        '${1970 + index}',
                                                        style: Styles.bodyMedium1,
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                            isStartWorkingSection: true,
                            firstText: "Duration",
                            secondText:
                                educationCtrlr.selectedStartTime.value.isEmpty
                                    ? "e.g. May 2019"
                                    : "${educationCtrlr.selectedStartTime.value}",
                            secondTextColor:
                                educationCtrlr.selectedStartTime.value.isEmpty
                                    ? AppColors.hintColor
                                    : AppColors.blackColor,
                            thirdText:
                                educationCtrlr.selectedEndTime.value.isEmpty
                                    ? "e.g. April 2023"
                                    : "${educationCtrlr.selectedEndTime.value}",
                            thirdTextColor:
                                educationCtrlr.selectedEndTime.value.isEmpty
                                    ? AppColors.hintColor
                                    : AppColors.blackColor,
                          ),
                        ),
    
                        // Grade
                        Obx(
                          () => ExperienceTile(
                            onPressed: () {
                              Get.toNamed(RouteHelper.getGradeAndDivisionRoute());
                            },
                            maxLines: 1,
                            firstText: "Grade/Division",
                            secondText: HiveHelp.read(Keys.isGradeSelected) ==
                                    true
                                ? educationCtrlr.userResultFormate.value.isEmpty
                                    ? "e.g. GPA 3.12"
                                    : "${educationCtrlr.userResultFormate.value} " +
                                        educationCtrlr.selectedGradeValue.value
                                : educationCtrlr
                                        .selectedDivisionValue.value.isEmpty
                                    ? "e.g. 2nd"
                                    : educationCtrlr.selectedDivisionValue.value,
                            secondTextColor:
                                educationCtrlr.userResultFormate.value.isEmpty &&
                                        educationCtrlr
                                            .selectedDivisionValue.value.isEmpty
                                    ? AppColors.hintColor
                                    : AppColors.blackColor,
                          ),
                        ),
    
                        // Other Activities (optional)
                        Obx(
                          () => ExperienceTile(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            onPressed: () =>
                                Get.toNamed(RouteHelper.getOtherActivityRoute()),
                            firstText: "Other Activities (optional)",
                            secondText: otherActivitiesController
                                    .selectedActivitiesValue.value.isEmpty
                                ? "e.g. Extra curriculam"
                                : otherActivitiesController
                                    .selectedActivitiesValue.value,
                            secondTextColor: otherActivitiesController
                                    .selectedActivitiesValue.value.isEmpty
                                ? AppColors.hintColor
                                : AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: GetBuilder<EducationController>(builder: (controll) {
          return Obx(
            () => SafeArea(
              child: Row(
                children: [
                  myResumeController.myresume == null ||
                          myResumeController.myresume!.education == null
                      ? SizedBox()
                      : HiveHelp.read(Keys.isEducationDeleteOption) == true &&
                              myResumeController.myresume!.education!.length > 1
                          ? Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: width(15), bottom: height(10)),
                                child: AppButton(
                                  text: educationCtrlr.isDeleting.value
                                      ? "Deleting..."
                                      : "Delete",
                                  onTap: educationCtrlr.isDeleting.value ? null : () {
                                    educationCtrlr.deleteSingleEducationQuali(
                                        id: educationId);
                                  },
                                  textColor: AppColors.jobClosedColor,
                                  bgColor: Colors.transparent,
                                  borderColor: AppColors.borderColor,
                                ),
                              ),
                            )
                          : SizedBox(),
                  myResumeController.myresume == null ||
                          myResumeController.myresume!.education == null
                      ? Gap(0)
                      : Gap(HiveHelp.read(Keys.isEducationDeleteOption) == true &&
                              myResumeController.myresume!.education!.length > 1
                          ? 10
                          : 0),
                  Expanded(
                    child: BottomNavWidget(
                        text: controll.isEducationLoading.value == true
                            ? "Saving..."
                            : HiveHelp.read(Keys.isEducationDeleteOption) == true
                                ? "Save"
                                : "Save & Next",
                        onTap: controll.isEducationLoading.value ? null : () {
                          if (educationCtrlr.institueName.value.isEmpty) {
                            Helpers().showToastMessage(
                                msg: "Institute name is required.",
                                gravity: ToastGravity.CENTER);
                          } else if (educationLevelController
                              .selectedDegree.value.isEmpty) {
                            Helpers().showToastMessage(
                                msg: "Educational Level is required.",
                                gravity: ToastGravity.CENTER);
                          } else if (educationCtrlr
                              .selectedSubjectName.value.isEmpty) {
                            Helpers().showToastMessage(
                                msg: "Subject/Major is required.",
                                gravity: ToastGravity.CENTER);
                          } else if (educationCtrlr
                                  .selectedStartTime.value.isEmpty ||
                              educationCtrlr.selectedEndTime.value.isEmpty) {
                            Helpers().showToastMessage(
                                msg: "Start & End Time is required.",
                                gravity: ToastGravity.CENTER);
                          } else if (educationCtrlr
                                  .userResultFormate.value.isEmpty &&
                              educationCtrlr.selectedDivisionValue.value.isEmpty) {
                            Helpers().showToastMessage(
                                msg: "Grade is required.",
                                gravity: ToastGravity.CENTER);
                          } else {
                            /// check, start date and end date value should not be minus(-) value or negative value
                            List<String> parts1 = educationCtrlr.selectedStartTime.split(" ");
                            List<String> parts2 = educationCtrlr.selectedEndTime.split(" ");
                            var startYear;
                            var endYear;
                            if(parts1.length == 2){
                              startYear = parts1[1];
                            }
                            if(parts2.length == 2){
                              endYear = parts2[1];
                            }
                            if(int.parse(endYear) < int.parse(startYear)){
                              Helpers().showValidationErrorDialog(
                                durationTime: 5,
                                messageText: Text("The end time must be greater than the start time and should not be a negative value.",
                                style: TextStyle(color: Colors.white),));
                            }else{
                              final educationQualificationModel =
                                EducationQualificationPostModel(
                              institutename: educationCtrlr.institueName.value,
                              digree: educationLevelController
                                  .selectedDegreeId.value
                                  .toString(),
                              startdate: educationCtrlr.formattedStartDateFromUi,
                              enddate: educationCtrlr.formattedEndDateFromUi,
                              subject: educationCtrlr.selectedSubjectId.value,
                              grade: HiveHelp.read(Keys.isGradeSelected) == true
                                  ? educationCtrlr.selectedGradeValue.value
                                  : educationCtrlr.selectedDivisionValue.value,
                              gradetype: HiveHelp.read(Keys.isGradeSelected) == true
                                  ? educationCtrlr.userResultFormate.value
                                  : "Division",
                              type: HiveHelp.read(Keys.isGradeSelected) == true
                                  ? 1
                                  : 2,
                              otheractivity: otherActivitiesController
                                  .selectedActivitiesValue.value,
                            );
                            HiveHelp.read(Keys.isEducationDeleteOption) == true
                                ? educationCtrlr.updateEducation(
                                    data: educationQualificationModel,
                                    id: educationId)
                                : educationCtrlr.postEducationQualification(
                                    data: educationQualificationModel);
                            }
                          }
                        }),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
    onBackPressed(context) {
            if(HiveHelp.read(Keys.isEducationDeleteOption) == false){
              if(educationCtrlr.institueName.value.isNotEmpty ||
                educationLevelController.selectedDegree.value.isNotEmpty || 
                educationCtrlr.selectedStartTime.value.isNotEmpty || 
                educationCtrlr.selectedEndTime.value.isNotEmpty ||
                educationCtrlr.userResultFormate.value.isNotEmpty ||
                educationCtrlr.selectedDivisionValue.value.isNotEmpty ||
                otherActivitiesController.selectedActivitiesValue.value.isNotEmpty){
                AppPopupDialog().showPopup(
                  context: context,
                  isTitle: true,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  titleText: "Authorization Request",
                  description: "The content has not been saved yet, do you want to exit?",
                  descriptionStyle: Styles.bodySmall2,
                  buttonOkText: "Exit anyway",
                  bRadius: 3,
                  insetPadding: Dimensions.kDefaultPadding,
                  buttonOkColor: Colors.transparent,
                  buttonOkTextColor: AppColors.mainColor,
                  buttonCancelColor: Colors.transparent,
                  buttonCancelTextColor: AppColors.blackColor.withOpacity(.5),
                  onOkPress: (){
                    Get.back();
                    Get.back();
                  },
                  onCancelPress: () => Get.back(),
                );
              }else{
                Get.back();
              }
            }
            else{
              Get.back();
            }
          }
}

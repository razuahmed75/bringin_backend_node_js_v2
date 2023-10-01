// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'package:bringin/models/candidate_section/candidate_job_pref_sec/job_preference_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/widgets/app_bottom_nav_widget.dart';
import '../../../Hive/hive.dart';
import '../../../controllers/candidate_section/candidate_career_pref_controller.dart';
import '../../../controllers/both_category/expertise_area_controller.dart';
import '../../../../../controllers/both_category/job_industry_controller.dart';
import '../../../../../controllers/candidate_section/select_location_controller.dart';
import '../../../../../res/color.dart';
import '../../../../../res/dimensions.dart';
import '../../../controllers/candidate_section/my_resume_controller.dart';
import '../../../res/app_font.dart';
import '../../../res/constants/image_path.dart';
import '../../../utils/services/keys.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_popup_dialog.dart';
import '../../../widgets/sellect_botton2.dart';
import 'components/job_pref_dialog.dart';

class CandidateCareerPrefScreen extends StatefulWidget {
  final bool? edit;
  final String? jovpreid;
  final int? jobprelength;
  CandidateCareerPrefScreen(
      {super.key, this.edit = false, this.jovpreid, this.jobprelength});

  @override
  State<CandidateCareerPrefScreen> createState() =>
      _CandidateCareerPrefScreenState();
}

class _CandidateCareerPrefScreenState extends State<CandidateCareerPrefScreen> {
  final MyResumeController myResumeController = Get.put(MyResumeController());
  JobIndustryController jobIndustryController = Get.find();
  CandidateCareerPrefController candidateJobPrefController = Get.find();
  ExpertiseAreaController functilnalAreaController = Get.find();
  SelectLocationController selectLocationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onBackPressed(context);
      },
      child: Scaffold(
        appBar: appBarWidget(
          title: "Career Preferences",
          onBackPressed: () {
            onBackPressed(context);
          },
          actions: [],
        ),
        body: Padding(
          padding: Dimensions.kDefaultPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("What type of job are you looking for?",
                      style: Styles.bodyMedium2),
                ),
                const Gap(14),

                /// job industry
                Obx(
                  () => (SelectionButton2(
                    title: "Expected Job Industry",
                    img: "assets/images/Group 11378.png",
                    onTap: () {
                      if (jobIndustryController
                          .popularJobIndustryList.isEmpty) {
                        jobIndustryController.getPopularJobIndustry();
                        Get.toNamed(RouteHelper.getJobIndustryRoute());
                      } else {
                        Get.toNamed(RouteHelper.getJobIndustryRoute());
                      }
                    },
                    text: jobIndustryController.selectedlist.value.isEmpty
                        ? "e.g. 2 Industry Added"
                        : jobIndustryController.selectedlist.value.length
                                .toString() +
                            " Industry Added",
                    textColor: jobIndustryController.selectedlist.value.isEmpty
                        ? AppColors.hintColor
                        : AppColors.blackColor,
                    borderColor:
                        jobIndustryController.selectedlist.value.isEmpty
                            ? jobIndustryController.industryErrorBorderClr.value
                            : AppColors.appBorder,
                    borderWidth:
                        jobIndustryController.selectedlist.value.isEmpty
                            ? 1
                            : .25,
                  )),
                ),
                const Gap(10),

                /// expertise area
                Obx(
                  () => SelectionButton2(
                    title: "Expertise Area",
                    isFunctionalArea: true,
                    img: AppImagePaths.expertise_area,
                    onTap: () {
                      if (functilnalAreaController.functionalAreaList.isEmpty) {
                        functilnalAreaController.getFunctionalArea();
                        Get.toNamed(RouteHelper.getExpertiseAreaRoute());
                      } else {
                        Get.toNamed(RouteHelper.getExpertiseAreaRoute());
                      }
                    },
                    text: functilnalAreaController
                            .selectedFuncationalNameValue.value.isEmpty
                        ? "e.g. IT-Mobile App-Java"
                        : functilnalAreaController
                            .selectedFuncationalNameValue.value,
                    textColor: functilnalAreaController
                            .selectedFuncationalNameValue.value.isEmpty
                        ? AppColors.hintColor
                        : AppColors.blackColor,
                    subtext: functilnalAreaController
                        .selectValueFuncationNamePath.value,
                    borderColor: functilnalAreaController
                            .selectedFuncationalNameValue.value.isEmpty
                        ? functilnalAreaController
                            .functionalAreaErrorBorderClr.value
                        : AppColors.appBorder,
                    borderWidth: functilnalAreaController
                            .selectedFuncationalNameValue.value.isEmpty
                        ? 1
                        : .25,
                  ),
                ),
                const Gap(10),

                /// job location
                Obx(
                  () => SelectionButton2(
                    title: "Expected Job Location",
                    img: AppImagePaths.job_location,
                    onTap: () {
                      if (selectLocationController.allLocationList.isEmpty) {
                        selectLocationController.getAllLocation();
                        Get.toNamed(RouteHelper.getSelectLocationRoute());
                      } else {
                        Get.toNamed(RouteHelper.getSelectLocationRoute());
                      }
                    },
                    text: selectLocationController
                            .selectedCityValue.value.isEmpty
                        ? "Uttara, Dhaka"
                        : "${selectLocationController.selectedCityValue.value}, " +
                            selectLocationController.selectedDivision.value,
                    textColor:
                        selectLocationController.selectedCityValue.value.isEmpty
                            ? AppColors.hintColor
                            : AppColors.blackColor,
                    borderColor: selectLocationController
                            .selectedCityValue.value.isEmpty
                        ? selectLocationController.locationErrorBorderClr.value
                        : AppColors.appBorder,
                    borderWidth:
                        selectLocationController.selectedCityValue.value.isEmpty
                            ? 1
                            : .25,
                  ),
                ),
                const Gap(10),

                /// job type
                Obx(
                  () => SelectionButton2(
                    title: "Job Type",
                    img: AppImagePaths.job_type,
                    onTap: () async {
                      if (candidateJobPrefController.jobTypeList.isEmpty) {
                        candidateJobPrefController.getJobType();
                        CareerPrefDialog.buildJobType(context);
                      } else {
                        CareerPrefDialog.buildJobType(context);
                      }
                    },
                    text: candidateJobPrefController.jobTypeVal.value.isEmpty
                        ? "e.g. Full-Time"
                        : candidateJobPrefController.jobTypeVal.value,
                    textColor:
                        candidateJobPrefController.jobTypeVal.value.isEmpty
                            ? AppColors.hintColor
                            : AppColors.blackColor,
                    borderColor: candidateJobPrefController
                            .jobTypeVal.value.isEmpty
                        ? candidateJobPrefController.jobTypeErrorBorderClr.value
                        : AppColors.appBorder,
                    borderWidth:
                        candidateJobPrefController.jobTypeVal.value.isEmpty
                            ? 1
                            : .25,
                  ),
                ),
                const Gap(10),

                /// expected salary
                Obx(
                  () => SelectionButton2(
                    title: "Expected Salary",
                    img: AppImagePaths.expected_salary,
                    onTap: () {
                      log(HiveHelp.read(Keys.authToken));
                      if (candidateJobPrefController
                          .expectedSalaryList.isEmpty) {
                        candidateJobPrefController.getExpectedSalary();
                        CareerPrefDialog.buildExpectedSalaryShit(
                            context: context, isFromJobPost: false);
                      } else {
                        CareerPrefDialog.buildExpectedSalaryShit(
                            context: context, isFromJobPost: false);
                      }
                    },
                    text: candidateJobPrefController
                                .minSalaryVal.value.isEmpty ||
                            candidateJobPrefController
                                .maxSalaryVal.value.isEmpty
                        ? "e.g. 30K-39K BDT"
                        : candidateJobPrefController.minSalaryVal.value ==
                                    "Negotiable" &&
                                candidateJobPrefController.maxSalaryVal.value ==
                                    "Negotiable"
                            ? "Negotiable"
                            : "${candidateJobPrefController.minSalaryVal.value}" +
                                " - " +
                                "${candidateJobPrefController.maxSalaryVal.value} " +
                                "${candidateJobPrefController.currencyVal.value}",
                    textColor:
                        candidateJobPrefController.minSalaryVal.value.isEmpty ||
                                candidateJobPrefController
                                    .maxSalaryVal.value.isEmpty ||
                                candidateJobPrefController
                                    .maxSalaryVal.value.isEmpty
                            ? AppColors.hintColor
                            : AppColors.blackColor,
                    borderColor: candidateJobPrefController
                            .minSalaryVal.value.isEmpty
                        ? candidateJobPrefController.salaryErrorBorderClr.value
                        : AppColors.appBorder,
                    borderWidth:
                        candidateJobPrefController.minSalaryVal.value.isEmpty
                            ? 1
                            : .25,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: widget.edit == true &&
                myResumeController.myresume!.careerPreference!.length > 1
            ? SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Container(
                          padding: EdgeInsets.only(
                              left: width(15), bottom: height(10)),
                          child: AppButton(
                            text: candidateJobPrefController.isDeleting.value
                                ? "Deleting..."
                                : "Delete",
                            onTap: candidateJobPrefController.isDeleting.value
                                ? null
                                : () {
                                    candidateJobPrefController
                                        .deletejobpreferance(
                                            id: widget.jovpreid!);
                                  },
                            textColor: AppColors.jobClosedColor,
                            bgColor: Colors.transparent,
                            borderColor: AppColors.borderColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => BottomNavWidget(
                          text:
                              candidateJobPrefController.isJobPrefPosting.value
                                  ? "Saving..."
                                  : "Save",
                          onTap: candidateJobPrefController
                                  .isJobPrefPosting.value
                              ? null
                              : () {
                                  JobPreferenceModelPost _jobPreferenceData =
                                      JobPreferenceModelPost(
                                    category: jobIndustryController
                                        .selectedlist.value,
                                    functionalarea: functilnalAreaController
                                        .selectValueFunctionalNameId.value,
                                    jobtype: candidateJobPrefController
                                        .jobTypeId.value,
                                    division: selectLocationController
                                        .selectedDivisionId.value,
                                    salaray: Salaray(
                                      minSalary: candidateJobPrefController
                                          .minSalaryId.value,
                                      maxSalary: candidateJobPrefController
                                          .maxSalaryId.value,
                                    ),
                                  );
                                  candidateJobPrefController
                                      .updateCandidateCareerPref(
                                    jobPreferenceData: _jobPreferenceData,
                                    id: widget.jovpreid!,
                                  );
                                },
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Obx(
                () => SafeArea(
                  child: BottomNavWidget(
                      text: candidateJobPrefController.isJobPrefPosting.value
                          ? "Saving..."
                          : widget.edit == true
                              ? "Save"
                              : "Save & Next",
                      onTap: candidateJobPrefController.isJobPrefPosting.value
                          ? null
                          : () {
                              if (jobIndustryController
                                  .selectedlist.value.isEmpty) {
                                jobIndustryController.industryErrorBorderClr
                                    .value = AppColors.jobClosedColor;
                              } else if (functilnalAreaController
                                  .selectedFuncationalNameValue.value.isEmpty) {
                                functilnalAreaController
                                    .functionalAreaErrorBorderClr
                                    .value = AppColors.jobClosedColor;
                              } else if (candidateJobPrefController
                                  .jobTypeVal.value.isEmpty) {
                                candidateJobPrefController.jobTypeErrorBorderClr
                                    .value = AppColors.jobClosedColor;
                              } else if (selectLocationController
                                  .selectedCityValue.value.isEmpty) {
                                selectLocationController.locationErrorBorderClr
                                    .value = AppColors.jobClosedColor;
                              } else if (candidateJobPrefController
                                  .minSalaryVal.value.isEmpty) {
                                candidateJobPrefController.salaryErrorBorderClr
                                    .value = AppColors.jobClosedColor;
                              } else {
                                JobPreferenceModelPost _jobPreferenceData =
                                    JobPreferenceModelPost(
                                        category: jobIndustryController
                                            .selectedlist.value,
                                        functionalarea: functilnalAreaController
                                            .selectValueFunctionalNameId.value,
                                        jobtype: candidateJobPrefController
                                            .jobTypeId.value,
                                        division: selectLocationController
                                            .selectedDivisionId.value,
                                        salaray: Salaray(
                                          minSalary: candidateJobPrefController
                                              .minSalaryId.value,
                                          maxSalary: candidateJobPrefController
                                              .maxSalaryId.value,
                                        ));
                                widget.edit == true
                                    ? candidateJobPrefController
                                        .updateCandidateCareerPref(
                                        jobPreferenceData: _jobPreferenceData,
                                        id: widget.jovpreid!,
                                      )
                                    : candidateJobPrefController
                                        .postCandidateJobPref(
                                        jobPreferenceData: _jobPreferenceData,
                                      );
                                HiveHelp.write(
                                    Keys.isCandidateJobPrefCompleted, true);

                                print(selectLocationController
                                    .selectedDivisionId.value);
                              }
                            }),
                ),
              ),
      ),
    );
  }

  onBackPressed(context) {
    if (widget.edit == false) {
      if (jobIndustryController.selectedlist.value.isNotEmpty ||
          functilnalAreaController
              .selectedFuncationalNameValue.value.isNotEmpty ||
          selectLocationController.selectedCityValue.value.isNotEmpty ||
          candidateJobPrefController.jobTypeVal.value.isNotEmpty ||
          candidateJobPrefController.maxSalaryVal.value.isNotEmpty) {
        AppPopupDialog().showPopup(
          context: context,
          isTitle: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          titleText: "Authorization Request",
          description:
              "The content has not been saved yet, do you want to exit?",
          descriptionStyle: Styles.bodySmall2,
          buttonOkText: "Exit anyway",
          bRadius: 3,
          insetPadding: Dimensions.kDefaultPadding,
          buttonOkColor: Colors.transparent,
          buttonOkTextColor: AppColors.mainColor,
          buttonCancelColor: Colors.transparent,
          buttonCancelTextColor: AppColors.blackColor.withOpacity(.5),
          onOkPress: () {
            Get.back();
            Get.back();
          },
          onCancelPress: () => Get.back(),
        );
      } else {
        Get.back();
      }
    } else {
      Get.back();
    }
  }
}

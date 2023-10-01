// ignore_for_file: invalid_use_of_protected_member

import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/utils/services/keys.dart';
import 'package:bringin/Screens/recruiter_section/manage_jobs/components/manage_jobs_dialog.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/experience_tile.dart';
import 'package:bringin/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';
import '../../../Hive/hive.dart';
import '../../../controllers/recruiter_section/managejob_controll.dart';
import '../../../controllers/recruiter_section/map_controll.dart';
import '../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../../models/recruiter_section/job_post_update_model.dart';
import '../../../models/recruiter_section/recruiter_job_post_model.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/image_path.dart';
import '../../../res/constants/strings.dart';
import '../../../utils/services/bindings/bindings_controllers_list.dart';
import '../../../widgets/app_bottom_nav_widget.dart';
import '../../../widgets/app_switch.dart';
import '../../../widgets/build_contact_dialog.dart';
import '../../candidate_section/career_pref/components/job_pref_dialog.dart';
import '../../candidate_section/my_skill_screen.dart';
import 'components/job_post_dialog.dart';
import 'components/job_recuirement_tile.dart';

class RecruiterJobPostScreen extends StatefulWidget {
  final bool? isEditJobPost;
  final String? jobId;
  final bool? isprofile;
  RecruiterJobPostScreen(
      {super.key,
      this.isprofile = false,
      this.isEditJobPost = false,
      this.jobId});

  @override
  State<RecruiterJobPostScreen> createState() => _RecruiterJobPostScreenState();
}

class _RecruiterJobPostScreenState extends State<RecruiterJobPostScreen> {
  LatLng? _initialPosition;
  LocationResult? result;

  final mapcontroll = Get.put(MapControll());

  CompanyRegistrationController companyRegistrationController =
      Get.find<CompanyRegistrationController>();
  ManagejobControll managejobControll = Get.put(ManagejobControll());
  RecruiterEditMainProfileController recruiterEditMainProfileController =
      Get.put(RecruiterEditMainProfileController());

  // Future location() async {
  //   await mapcontroll.determinePosition();
  //   _initialPosition = LatLng(
  //     mapcontroll.position!.latitude,
  //     mapcontroll.position!.longitude,
  //   );
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  // void showPlacePicker(BuildContext context) async {
  //   result = await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => PlacePicker(
  //         kGoogleApiKey,
  //         defaultLocation: _initialPosition,
  //       ),
  //     ),
  //   );
  //   setState(() {});

  //   // Handle the result in your way
  //   print("city: " + "${result!.city!.name}");
  //   print("division: " + "${result!.administrativeAreaLevel1!.name}");
  //   companyRegistrationController.addcompanyaddress(
  //     result!.formattedAddress!,
  //     result!.latLng!,
  //     result!.city!.name!,
  //     result!.administrativeAreaLevel1!.name!.split(" ").first,
  //   );
  // }

  // @override
  // void initState() {
  //   location();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    CandidateCareerPrefController candidateJobPrefController =
        Get.find<CandidateCareerPrefController>();
    RecruiterJobPostController recruiterJobPostController =
        Get.find<RecruiterJobPostController>();
    EducationLevelController educationLevelController =
        Get.find<EducationLevelController>();
    ExpertiseAreaController functilnalAreaController =
        Get.find<ExpertiseAreaController>();
    MySkillsController mySkillsController = Get.find<MySkillsController>();
    return Scaffold(
      appBar: _buildAppBar(
          context,
          managejobControll,
          recruiterJobPostController,
          candidateJobPrefController,
          functilnalAreaController),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDefaultgapTop,

              /// post a full-time job
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Row(
                        children: [
                          Text(
                              "Post a ${candidateJobPrefController.jobTypeVal.value.isEmpty ? "Full-Time" : candidateJobPrefController.jobTypeVal.value} Job",
                              style: Styles.smallTitle),
                        ],
                      )),

                  /// Switch Job Type
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          if (widget.isEditJobPost == true) {
                            Helpers().showValidationErrorDialog(
                              title: "",
                              errorText: "",
                              icon: Container(
                                margin: EdgeInsets.only(left: width(15)),
                                child: SvgPicture.asset(AppImagePaths.warning),
                              ),
                              messageText: Text(
                                  "Job type can't be change after job\npost",
                                  style: Styles.bodyMedium1.copyWith(
                                    color: AppColors.whiteColor,
                                  )),
                            );
                          } else {
                            if (candidateJobPrefController
                                .jobTypeList.isEmpty) {
                              CareerPrefDialog.buildJobType(context);
                              candidateJobPrefController.getJobType();
                            } else {
                              CareerPrefDialog.buildJobType(context);
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height(6)),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icon2/switch2.png",
                                height: 16.h,
                                width: 16.h,
                              ),
                              const Gap(12),
                              Text("Switch Job Type", style: Styles.bodySmall),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(10),

              /// job post field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// job title
                  Obx(
                    () => ExperienceTile(
                      onPressed: () {
                        if (widget.isEditJobPost == true) {
                          Helpers().showValidationErrorDialog(
                            title: "",
                            errorText: "",
                            icon: Container(
                              margin: EdgeInsets.only(left: width(15)),
                              child: SvgPicture.asset(AppImagePaths.warning),
                            ),
                            messageText:
                                Text("Job title can't be change after job post",
                                    style: Styles.bodyMedium1.copyWith(
                                      color: AppColors.whiteColor,
                                    )),
                          );
                        } else {
                          Get.toNamed(RouteHelper.getJobTitleRoute());
                        }
                      },
                      firstText: "Job Title",
                      secondText: recruiterJobPostController
                              .selectJobTitleName.value.isEmpty
                          ? "e.g. Backend Developer"
                          : recruiterJobPostController.selectJobTitleName.value,
                      secondTextColor: recruiterJobPostController
                              .selectJobTitleName.value.isEmpty
                          ? AppColors.hintColor
                          : AppColors.blackColor,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),

                  // Expertise Area
                  Obx(
                    () => ExperienceTile(
                      onPressed: () {
                        if (widget.isEditJobPost == true) {
                          Helpers().showValidationErrorDialog(
                            title: "",
                            errorText: "",
                            icon: Container(
                              margin: EdgeInsets.only(
                                  left: width(15), top: height(15)),
                              child: SvgPicture.asset(AppImagePaths.warning),
                            ),
                            messageText: Text(
                                "Expertise area can't be change after\njob post",
                                style: Styles.bodyMedium1.copyWith(
                                  color: AppColors.whiteColor,
                                )),
                          );
                        } else {
                          if (functilnalAreaController
                              .functionalAreaList.isEmpty) {
                            functilnalAreaController.getFunctionalArea();
                            Get.toNamed(RouteHelper.getExpertiseAreaRoute());
                          } else {
                            Get.toNamed(RouteHelper.getExpertiseAreaRoute());
                          }
                        }
                      },
                      firstText: "Expertise Area",
                      secondText: functilnalAreaController
                              .selectedFuncationalNameValue.value.isEmpty
                          ? "Mobile App - Java"
                          : functilnalAreaController
                              .selectedFuncationalNameValue.value,
                      secondTextColor: functilnalAreaController
                              .selectedFuncationalNameValue.value.isEmpty
                          ? AppColors.hintColor
                          : AppColors.blackColor,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),

                  // Job Descriptions
                  Obx(
                    () => ExperienceTile(
                      onPressed: () => Get.toNamed(
                        RouteHelper.getJobDescriptionRoute(),
                      ),
                      firstText: "Job Descriptions",
                      secondText: recruiterJobPostController
                              .selectedJobDescriptionVal.value.isEmpty
                          ? "Describe key responsibilities, skills..."
                          : recruiterJobPostController
                              .selectedJobDescriptionVal.value,
                      secondTextColor: recruiterJobPostController
                              .selectedJobDescriptionVal.value.isEmpty
                          ? AppColors.hintColor
                          : AppColors.blackColor,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const Gap(10),

                  /// Job Requirements
                  Text("Job Requirements", style: Styles.bodyMedium3),
                  const Gap(12),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          color: AppColors.appBorder,
                          width: .4,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// EXPERIENCE
                        Obx(
                          () => JobRecuirementTile(
                            onTap: () {
                              if (recruiterJobPostController
                                  .experienceList.isEmpty) {
                                recruiterJobPostController.getExperience();
                                JobPostDialog.buildExperienceBottomShit();
                              } else {
                                JobPostDialog.buildExperienceBottomShit();
                              }
                            },
                            firstText: "Experience",
                            secondText: recruiterJobPostController
                                    .selectedExperienceVal.value.isEmpty
                                ? "Select"
                                : recruiterJobPostController
                                    .selectedExperienceVal.value,
                            firstTextColor: recruiterJobPostController
                                    .selectedExperienceVal.value.isEmpty
                                ? AppColors.blackColor
                                : AppColors.hintColor,
                            secondTextColor: recruiterJobPostController
                                    .selectedExperienceVal.value.isEmpty
                                ? AppColors.hintColor
                                : AppColors.blackColor,
                          ),
                        ),

                        /// EDUCATION
                        Obx(
                          () => JobRecuirementTile(
                            onTap: () {
                              if (educationLevelController
                                  .educationLevelList.isEmpty) {
                                educationLevelController.getEducationLevel();
                                JobPostDialog.buildEducationBottomShit();
                              } else {
                                JobPostDialog.buildEducationBottomShit();
                              }
                            },
                            firstText: "Education",
                            secondText: recruiterJobPostController
                                    .selectedEducationVal.value.isEmpty
                                ? "Select"
                                : recruiterJobPostController
                                    .selectedEducationVal.value,
                            firstTextColor: recruiterJobPostController
                                    .selectedEducationVal.value.isEmpty
                                ? AppColors.blackColor
                                : AppColors.hintColor,
                            secondTextColor: recruiterJobPostController
                                    .selectedEducationVal.value.isEmpty
                                ? AppColors.hintColor
                                : AppColors.blackColor,
                          ),
                        ),

                        /// EXPECTED SALARY
                        Obx(
                          () => JobRecuirementTile(
                            onTap: () {
                              if (candidateJobPrefController
                                  .expectedSalaryList.isEmpty) {
                                candidateJobPrefController.getExpectedSalary();
                                CareerPrefDialog.buildExpectedSalaryShit(
                                    context: context, isFromJobPost: true);
                              } else {
                                CareerPrefDialog.buildExpectedSalaryShit(
                                    context: context, isFromJobPost: true);
                              }
                            },
                            firstText: "Salary",
                            secondText: candidateJobPrefController
                                    .minSalaryVal.value.isEmpty
                                ? "Select"
                                : candidateJobPrefController
                                                .minSalaryVal.value ==
                                            "Negotiable" &&
                                        candidateJobPrefController
                                                .maxSalaryVal.value ==
                                            "Negotiable"
                                    ? "Negotiable"
                                    : candidateJobPrefController
                                            .minSalaryVal.value +
                                        "-" +
                                        candidateJobPrefController
                                            .maxSalaryVal.value +
                                        " ${candidateJobPrefController.currencyVal.value}",
                            firstTextColor: candidateJobPrefController
                                    .minSalaryVal.value.isEmpty
                                ? AppColors.blackColor
                                : AppColors.hintColor,
                            secondTextColor: candidateJobPrefController
                                    .minSalaryVal.value.isEmpty
                                ? AppColors.hintColor
                                : AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(25),

                  // Required Location
                  GetBuilder<CompanyRegistrationController>(builder: (_) {
                    return InkWell(
                      onTap: () =>
                          Get.toNamed(RouteHelper.getCompanyLocationRoute()),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Required Location",
                                style: Styles.bodyMedium3),
                            const Gap(10),
                            Text(
                                recruiterEditMainProfileController
                                        .recruiterProfileInfoList.isEmpty
                                    ? ""
                                    : recruiterEditMainProfileController
                                        .recruiterProfileInfoList[0]
                                        .companyname!
                                        .legalName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.bodyLarge),
                            const Gap(5),
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => Text(
                                      companyRegistrationController
                                              .selectedLocation.value.isEmpty
                                          ? recruiterEditMainProfileController
                                                  .recruiterProfileInfoList
                                                  .isEmpty
                                              ? ""
                                              : recruiterEditMainProfileController
                                                      .recruiterProfileInfoList[
                                                          0]
                                                      .companyname!
                                                      .cLocation!
                                                      .divisiondata!
                                                      .divisionname! +
                                                  ", " +
                                                  recruiterEditMainProfileController
                                                      .recruiterProfileInfoList[
                                                          0]
                                                      .companyname!
                                                      .cLocation!
                                                      .divisiondata!
                                                      .cityid!
                                                      .name!
                                          : companyRegistrationController
                                              .selectedLocation.value,
                                      // result == null
                                      //     ? companyRegistrationController
                                      //             .companyaddress.isNotEmpty
                                      //         ? companyRegistrationController
                                      //             .companyaddress
                                      //         : recruiterEditMainProfileController
                                      //                 .recruiterProfileInfoList
                                      //                 .isEmpty
                                      //             ? ""
                                      //             : recruiterEditMainProfileController
                                      //                 .recruiterProfileInfoList[0]
                                      //                 .companyname!
                                      //                 .cLocation!
                                      //                 .formetAddress!
                                      //     : result!.formattedAddress!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.bodyLarge,
                                    ),
                                  ),
                                ),
                                const Gap(20),
                                SvgPicture.asset(
                                  AppImagePaths.arrowForwardIcon,
                                  height: height(13),
                                  width: height(13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const Gap(20),

                  // Required Skills (optional)
                  Padding(
                    padding: EdgeInsets.only(bottom: height(15)),
                    child: InkWell(
                      onTap: () {
                        if (functilnalAreaController.categoryId.value.isEmpty) {
                          Helpers().showToastMessage(
                            msg: "Please select expertise area first",
                            gravity: ToastGravity.CENTER,
                          );
                        } else {
                          Get.to(() => MySkillScreen(
                                isUserFromJobPostPage: true,
                                categoryId:
                                    functilnalAreaController.categoryId.value,
                              ));
                        }
                      },
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius(6)),
                        ),
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Required Skills (optional)",
                                  style: Styles.bodyMedium3),
                              mySkillsController.selectedSkill.isEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Set Various Skills",
                                            style: Styles.bodyLarge),
                                        SvgPicture.asset(
                                          AppImagePaths.arrowForwardIcon,
                                          height: height(13),
                                          width: height(13),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Dimensions.screenWidth - 100,
                                          child: Wrap(
                                            children: [
                                              ...List.generate(
                                                  mySkillsController
                                                      .selectedSkill
                                                      .value
                                                      .length, (index) {
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                        mySkillsController
                                                            .selectedSkill
                                                            .value[index],
                                                        style:
                                                            Styles.bodyLarge),
                                                    const Gap(5),
                                                    Text(
                                                        mySkillsController
                                                                        .selectedSkill
                                                                        .value[
                                                                    index] ==
                                                                mySkillsController
                                                                    .selectedSkill
                                                                    .value
                                                                    .last
                                                            ? ""
                                                            : ".",
                                                        style: Styles.bodyLarge
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    const Gap(5),
                                                  ],
                                                );
                                              }).toList()
                                            ],
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          AppImagePaths.arrowForwardIcon,
                                          height: height(13),
                                          width: height(13),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Text(AppStrings.recruiterJobPostDes,
                      style: Styles.bodySmall2),
                  const Gap(20),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: widget.isEditJobPost == true
              ? Dimensions.screenHeight * 0.19
              : Dimensions.screenHeight * 0.13,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.isEditJobPost == true) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icon2/remotejob.png",
                        height: 26.h,
                      ),
                      const Gap(15),
                      Text("This is a remote job", style: Styles.bodyMedium),
                      Spacer(),
                      Obx(
                        () => AppSwitch(
                          value: recruiterJobPostController.isRemote.value,
                          onChanged: (bool? val) {
                            recruiterJobPostController.isRemote.value = val!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Text("Already Hired?",
                    style: Styles.bodyLargeSemiBold.copyWith(
                      color: AppColors.mainColor,
                    )),
                Row(
                  children: [
                    Expanded(
                      child: BottomNavWidget(
                        text: "Close This Job",
                        onTap: () {
                          ManageJobDialog.dialog(
                              isCloseJob: true,
                              jobId: widget.jobId,
                              context: context);
                          print(widget.jobId);
                        },
                      ),
                    ),
                  ],
                ),
              ] else ...[
                /// This is a remote job
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icon2/remotejob.png",
                        height: 26.h,
                      ),
                      const Gap(15),
                      Text("This is a remote job", style: Styles.bodyMedium),
                      Spacer(),
                      Obx(
                        () => AppSwitch(
                          value: recruiterJobPostController.isRemote.value,
                          onChanged: (bool? val) {
                            recruiterJobPostController.isRemote.value = val!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => BottomNavWidget(
                            text: recruiterJobPostController.isLoading.value
                                ? "Posting..."
                                : "Post Now",
                            onTap: recruiterJobPostController.isLoading.value
                                ? null
                                : () {
                                    print(HiveHelp.read(Keys.authToken));
                                    if (recruiterJobPostController
                                        .selectJobTitleName.value.isEmpty) {
                                      Helpers().showToastMessage(
                                          gravity: ToastGravity.CENTER,
                                          msg: "Job title is required");
                                    } else if (functilnalAreaController
                                        .selectedFuncationalNameValue
                                        .value
                                        .isEmpty) {
                                      Helpers().showToastMessage(
                                          gravity: ToastGravity.CENTER,
                                          msg: "Expertise Area is required");
                                    } else if (recruiterJobPostController
                                        .selectedJobDescriptionVal
                                        .value
                                        .isEmpty) {
                                      Helpers().showToastMessage(
                                          gravity: ToastGravity.CENTER,
                                          msg: "Job Description is required");
                                    } else if (recruiterJobPostController
                                        .selectedEducationVal.value.isEmpty) {
                                      Helpers().showToastMessage(
                                          gravity: ToastGravity.CENTER,
                                          msg: "Education is required");
                                    } else if (recruiterJobPostController
                                        .selectedExperienceVal.value.isEmpty) {
                                      Helpers().showToastMessage(
                                          gravity: ToastGravity.CENTER,
                                          msg: "Experience is required");
                                    } else if (candidateJobPrefController
                                        .minSalaryVal.value.isEmpty) {
                                      Helpers().showToastMessage(
                                          gravity: ToastGravity.CENTER,
                                          msg: "Salary is required");
                                    } else {
                                      final data = RecruiterJobPostModel(
                                          companyname:
                                              recruiterEditMainProfileController
                                                  .recruiterProfileInfoList[0]
                                                  .companyname!
                                                  .legalName,
                                          jobTitle: recruiterJobPostController
                                              .selectJobTitleName.value,
                                          experticeArea: functilnalAreaController
                                              .selectValueFunctionalNameId
                                              .value,
                                          company:
                                              recruiterEditMainProfileController
                                                  .recruiterProfileInfoList[0]
                                                  .companyname!
                                                  .sId,
                                          jobtype: candidateJobPrefController
                                                  .jobTypeId.value.isEmpty
                                              ? "649a8d1196d89e33a061cace"
                                              : candidateJobPrefController
                                                  .jobTypeId.value,
                                          jobDescription:
                                              "${recruiterJobPostController.selectedJobDescriptionVal.value}",
                                          education: recruiterJobPostController
                                              .selectedEducationId.value,
                                          experience: recruiterJobPostController
                                              .selectedExperienceId.value,
                                          salary: Salary(
                                            minSalary:
                                                candidateJobPrefController
                                                    .minSalaryId.value,
                                            maxSalary:
                                                candidateJobPrefController
                                                    .maxSalaryId.value,
                                          ),
                                          jobLocation: JobLocation(
                                            // lat: result!.latLng!.latitude,
                                            // lon: result!.latLng!.longitude,
                                            // city: result!.city!.name!,
                                            // formetAddress: result!.formattedAddress,
                                            lat: companyRegistrationController
                                                        .latlng !=
                                                    null
                                                ? companyRegistrationController
                                                    .latlng!.latitude
                                                : recruiterEditMainProfileController
                                                        .recruiterProfileInfoList
                                                        .isEmpty
                                                    ? 0.0
                                                    : recruiterEditMainProfileController
                                                        .recruiterProfileInfoList[
                                                            0]
                                                        .companyname!
                                                        .cLocation!
                                                        .lat,
                                            lon: companyRegistrationController
                                                        .latlng !=
                                                    null
                                                ? companyRegistrationController
                                                    .latlng!.longitude
                                                : recruiterEditMainProfileController
                                                        .recruiterProfileInfoList
                                                        .isEmpty
                                                    ? 0.0
                                                    : recruiterEditMainProfileController
                                                        .recruiterProfileInfoList[
                                                            0]
                                                        .companyname!
                                                        .cLocation!
                                                        .lon,
                                            formetAddress: companyRegistrationController
                                                        .companyaddress ==
                                                    ""
                                                ? recruiterEditMainProfileController
                                                        .recruiterProfileInfoList
                                                        .isEmpty
                                                    ? ""
                                                    : recruiterEditMainProfileController
                                                        .recruiterProfileInfoList[
                                                            0]
                                                        .companyname!
                                                        .cLocation!
                                                        .formetAddress
                                                : companyRegistrationController
                                                    .companyaddress,

                                            locationoptional: companyRegistrationController
                                                    .selectedOptionLocation
                                                    .value
                                                    .isEmpty
                                                ? recruiterEditMainProfileController
                                                        .recruiterProfileInfoList
                                                        .isEmpty
                                                    ? ""
                                                    : recruiterEditMainProfileController
                                                        .recruiterProfileInfoList[
                                                            0]
                                                        .companyname!
                                                        .cLocation!
                                                        .locationoptional
                                                : companyRegistrationController
                                                    .selectedOptionLocation
                                                    .value,
                                            divisiondata: companyRegistrationController
                                                    .selectedLocationId
                                                    .value
                                                    .isEmpty
                                                ? recruiterEditMainProfileController
                                                        .recruiterProfileInfoList
                                                        .isEmpty
                                                    ? ""
                                                    : recruiterEditMainProfileController
                                                        .recruiterProfileInfoList[
                                                            0]
                                                        .companyname!
                                                        .cLocation!
                                                        .divisiondata!
                                                        .id
                                                : companyRegistrationController
                                                    .selectedLocationId.value,
                                          ),
                                          skill: MySkillsController
                                              .to.selectedSkill,
                                          remote: recruiterJobPostController
                                              .isRemote.value);
                                      recruiterJobPostController.postNewJob(
                                          data: data);
                                      print(HiveHelp.read(Keys.authToken));
                                    }
                                  }),
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context,
      ManagejobControll manageJobController,
      RecruiterJobPostController recruiterJobPostController,
      CandidateCareerPrefController candidateJobPrefController,
      ExpertiseAreaController functilnalAreaController) {
    return appBarWidget(
      title: "",
      onBackPressed: () => Get.back(),
      actions: [
        InkWell(
          onTap: () => buildContactDialog(context),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Need Help?",
              textAlign: TextAlign.center,
              style: Styles.bodySmall1.copyWith(
                color: AppColors.mainColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Gap(widget.isEditJobPost == true ? 130 : 30),
        if (!widget.isprofile! && widget.isEditJobPost == false) const Gap(100),
        if (!widget.isprofile! && widget.isEditJobPost == false)
          Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (recruiterEditMainProfileController
                          .recruiterProfileInfoList[0]
                          .other!
                          .companyDocupload ==
                      true) {
                    Get.toNamed(
                      RouteHelper.getRecruiterIdentityVerifyRoute(),
                    );
                  } else {
                    Get.toNamed(
                      RouteHelper.getCompanyVerificationRoute(),
                    );
                  }
                },
                child: Container(
                  width: width(92),
                  height: height(30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    "Post Later",
                    style: Styles.bodyMedium2.copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        if (widget.isEditJobPost == true)
          Stack(
            alignment: Alignment.center,
            children: [
              SaveButton(onSavePressed: () {
                print(HiveHelp.read(Keys.authToken));
                if (recruiterJobPostController
                    .selectJobTitleName.value.isEmpty) {
                  Helpers().showToastMessage(
                      gravity: ToastGravity.CENTER,
                      msg: "Job title is required");
                } else if (functilnalAreaController
                    .selectedFuncationalNameValue.value.isEmpty) {
                  Helpers().showToastMessage(
                      gravity: ToastGravity.CENTER,
                      msg: "Expertise Area is required");
                } else if (recruiterJobPostController
                    .selectedJobDescriptionVal.value.isEmpty) {
                  Helpers().showToastMessage(
                      gravity: ToastGravity.CENTER,
                      msg: "Job Description is required");
                } else if (recruiterJobPostController
                    .selectedEducationVal.value.isEmpty) {
                  Helpers().showToastMessage(
                      gravity: ToastGravity.CENTER,
                      msg: "Education is required");
                } else if (recruiterJobPostController
                    .selectedExperienceVal.value.isEmpty) {
                  Helpers().showToastMessage(
                      gravity: ToastGravity.CENTER,
                      msg: "Experience is required");
                } else if (candidateJobPrefController
                    .minSalaryVal.value.isEmpty) {
                  Helpers().showToastMessage(
                      gravity: ToastGravity.CENTER, msg: "Salary is required");
                } else {
                  final data = JobPostUpdateModel(
                    companyname: recruiterEditMainProfileController
                        .recruiterProfileInfoList[0].companyname!.legalName,
                    jobTitle:
                        recruiterJobPostController.selectJobTitleName.value,
                    experticeArea: functilnalAreaController
                        .selectValueFunctionalNameId.value,
                    company: recruiterEditMainProfileController
                        .recruiterProfileInfoList[0].companyname!.sId,
                    jobtype: candidateJobPrefController.jobTypeId.value == ""
                        ? "649a8d1196d89e33a061cace"
                        : candidateJobPrefController.jobTypeId.value,
                    jobDescription:
                        "${recruiterJobPostController.selectedJobDescriptionVal.value}",
                    education:
                        recruiterJobPostController.selectedEducationId.value,
                    experience:
                        recruiterJobPostController.selectedExperienceId.value,
                    salary: Expected_Salary(
                      minSalary: candidateJobPrefController.minSalaryId.value,
                      maxSalary: candidateJobPrefController.maxSalaryId.value,
                    ),
                    jobLocation: Job_Location(
                      lat: companyRegistrationController.latlng != null
                          ? companyRegistrationController.latlng!.latitude
                          : recruiterEditMainProfileController
                                  .recruiterProfileInfoList.isEmpty
                              ? 0.0
                              : recruiterEditMainProfileController
                                  .recruiterProfileInfoList[0]
                                  .companyname!
                                  .cLocation!
                                  .lat,
                      lon: companyRegistrationController.latlng != null
                          ? companyRegistrationController.latlng!.longitude
                          : recruiterEditMainProfileController
                                  .recruiterProfileInfoList.isEmpty
                              ? 0.0
                              : recruiterEditMainProfileController
                                  .recruiterProfileInfoList[0]
                                  .companyname!
                                  .cLocation!
                                  .lon,
                      formetAddress:
                          companyRegistrationController.companyaddress == ""
                              ? recruiterEditMainProfileController
                                      .recruiterProfileInfoList.isEmpty
                                  ? ""
                                  : recruiterEditMainProfileController
                                      .recruiterProfileInfoList[0]
                                      .companyname!
                                      .cLocation!
                                      .formetAddress
                              : companyRegistrationController.companyaddress,
                      locationoptional: companyRegistrationController
                              .selectedOptionLocation.value.isEmpty
                          ? recruiterEditMainProfileController
                                  .recruiterProfileInfoList.isEmpty
                              ? ""
                              : recruiterEditMainProfileController
                                  .recruiterProfileInfoList[0]
                                  .companyname!
                                  .cLocation!
                                  .locationoptional
                          : companyRegistrationController
                              .selectedOptionLocation.value,
                      divisiondata: companyRegistrationController
                              .selectedLocationId.value.isEmpty
                          ? recruiterEditMainProfileController
                                  .recruiterProfileInfoList.isEmpty
                              ? ""
                              : recruiterEditMainProfileController
                                  .recruiterProfileInfoList[0]
                                  .companyname!
                                  .cLocation!
                                  .divisiondata!
                                  .id
                          : companyRegistrationController
                              .selectedLocationId.value,
                    ),
                    skill: MySkillsController.to.selectedSkill,
                    remote: recruiterJobPostController.isRemote.value,
                    jobStatusType: 1,
                  );
                  managejobControll.updateJobPost(
                      data: data, jobId: widget.jobId);
                  print(HiveHelp.read(Keys.authToken));
                }
              }),
            ],
          ),
        const Gap(15),
      ],
    );
  }
}

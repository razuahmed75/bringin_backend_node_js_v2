import 'package:bringin/controllers/candidate_section/my_resume_controller.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:bringin/Screens/candidate_section/Resume/resume_management.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../controllers/candidate_section/candidate_edit_main_profile_controller.dart';
import '../../../../controllers/candidate_section/candidate_main_profile_controller.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/dimensions.dart';
import '../../../../widgets/build_contact_dialog.dart';
import '../../../../widgets/main_profile_tile.dart';
import '../../../../widgets/selection_button.dart';
import '../../cv_sent_history_screen.dart';
import '../../saved_jobs_screen.dart';
import '../../candidate_total_chat_history_screen.dart';
import '../../viewed_jobs_screen.dart';

class CandidateMainProfileScreen extends StatefulWidget {
  CandidateMainProfileScreen({super.key});

  @override
  State<CandidateMainProfileScreen> createState() =>
      _CandidateMainProfileScreenState();
}

class _CandidateMainProfileScreenState
    extends State<CandidateMainProfileScreen> {
  final candidateprofile = Get.find<CandidateMainProfileController>();
  getData() async {
    await candidateprofile.getCandidateInfo();
    await CandidateEditMainProfileController.to.getProfileInfo();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  CandidateEditMainProfileController candidateEditMainProfileController =
      Get.find<CandidateEditMainProfileController>();
  MyResumeController resumeController = Get.put(MyResumeController());

  @override
  Widget build(BuildContext context) {
    MyResumeController resumeController = Get.put(MyResumeController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Dimensions.kDefaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Dimensions.kDefaultgapTop,

                /// name and profile pic
                profileinfo(),

                /// Profile Completion
                SizedBox(height: 5.h),
                _profileCompletion(onTap: () {
                  // MyResumeController.to.getMyResume();
                  Get.toNamed(RouteHelper.getMyResumeRoute());
                }),

                const Gap(8),

                /// Job Preference button
                SelectionButton(
                  img: "assets/icon2/Group 11415.png",
                  isArrowIcon: false,
                  onTap: () {
                    resumeController.getMyResume();
                    CandidateMainProfileController.to.getCandidateInfo();
                    Get.toNamed(RouteHelper.getCareerPreferenceRoute());
                  },
                  text: "Career Preferences",
                ),
                const Gap(8),

                /// Saved Jobs
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: height(8), horizontal: width(16)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius(6)),
                      color: AppColors.whiteColor,
                      border:
                          Border.all(color: AppColors.appBorder, width: .5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Upload Resume
                      MainProfileTile(
                        onTap: () => Get.to(() => Resume_management()),
                        iconPath: "assets/icon2/manage_cv.svg",
                        text: "Manage your CV",
                        additionalText: "",
                      ),
                      const Gap(5),

                      // saved jobs
                      MainProfileTile(
                        onTap: () =>
                            Get.toNamed(RouteHelper.getFavoriteJobsRoute()),
                        iconPath: "assets/icon2/save_candidate.svg",
                        text: "Favorite Jobs",
                        // img: "assets/icon2/Group2.png",
                        additionalText: "",
                      ),
                      const Gap(5),

                      // Greetings
                      MainProfileTile(
                        onTap: () =>
                            Get.toNamed(RouteHelper.getWelcomeMessageRoute()),
                        iconPath: "assets/icon2/greating.svg",
                        text: "Welcome Message",
                        additionalText: "",
                      ),
                      const Gap(5),

                      // Switch
                      MainProfileTile(
                        onTap: () =>
                            Get.toNamed(RouteHelper.getSwitchProfileRoute()),
                        iconPath: "assets/icon2/switch.svg",
                        text: "Switch Profile",
                        additionalText: "Switch to Recrtuiter",
                      ),
                      const Gap(5),

                      // Settings
                      MainProfileTile(
                        onTap: () =>
                            Get.toNamed(RouteHelper.getSettingsRoute()),
                        iconPath: "assets/icon2/setting.svg",
                        text: "Settings",
                        additionalText: "",
                      ),
                      const Gap(5),

                      // Contact Us
                      MainProfileTile(
                        onTap: () => buildContactDialog(context),
                        iconPath: "assets/icon2/contact.svg",
                        text: "Contact our Team",
                        additionalText: "",
                      ),
                    ],
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileCompletion({onTap}) {
    return GetBuilder<CandidateMainProfileController>(builder: (controller) {
      return InkWell(
        onTap: onTap,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.appBorder, width: .5),
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Row(
            children: [
              SizedBox(width: 10.w),
              Container(
                height: candidateprofile.candidateProfileList.isEmpty
                    ? 89.h
                    : candidateprofile.candidateProfileList[0].other == null
                        ? 0
                        : candidateprofile.candidateProfileList[0].other!
                                    .incomplete ==
                                0
                            ? 100.h
                            : 89.h,
                width: 211.w,
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profile Setup:",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          candidateprofile.candidateProfileList.isEmpty
                              ? Text("")
                              : Text(
                                  candidateprofile
                                              .candidateProfileList[0].other ==
                                          null
                                      ? ""
                                      : candidateprofile.candidateProfileList[0]
                                                  .other!.incomplete ==
                                              0
                                          ? "The profile has been fully updated and is now comprehensive."
                                          : "Profile has ${candidateprofile.candidateProfileList[0].other!.incomplete!} areas for improvement...",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                          SizedBox(height: 2.h),
                          // Conta
                          Container(
                            height: 15.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                              color: Color(0xFF454545).withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 9.r,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    CircularPercentIndicator(
                      animationDuration: 1000,
                      lineWidth: 3,
                      animation: true,
                      radius: 30.r,
                      percent: candidateprofile.candidateProfileList.isNotEmpty
                          ? candidateprofile.candidateProfileList[0].other
                                          ?.complete !=
                                      null &&
                                  candidateprofile.candidateProfileList[0].other
                                          ?.totalStep !=
                                      null
                              ? candidateprofile.candidateProfileList[0].other!
                                          .complete! >
                                      7
                                  ? 1 / 7
                                  : candidateprofile.candidateProfileList[0]
                                          .other!.complete! /
                                      candidateprofile.candidateProfileList[0]
                                          .other!.totalStep!
                              : 0.0
                          : 0.0,
                      progressColor: AppColors.mainColor,
                      center: Text(
                        candidateprofile.candidateProfileList.isEmpty
                            ? "0%"
                            : '${((candidateprofile.candidateProfileList[0].other!.complete! / candidateprofile.candidateProfileList[0].other!.totalStep!) * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mainColor),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Image.asset(AppImagePaths.candidatejobProfile,
                  width: 80.w, height: 90.h, fit: BoxFit.fitHeight)
            ],
          ),
        ),
      );
    });
  }

  Widget profileinfo() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 11.w, top: 15.h),
          child: Row(
            children: [
              /// photo
              GetBuilder<CandidateEditMainProfileController>(builder: (_) {
                return GestureDetector(
                  onTap: () => Get.toNamed(
                      RouteHelper.getCandidateEditMainProfileRoute()),
                  child: Container(
                      margin: EdgeInsets.only(right: width(10)),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                          image: candidateEditMainProfileController
                                  .profileInfoList.isEmpty
                              ? DecorationImage(
                                  image: AssetImage(AppImagePaths.profile),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    candidateEditMainProfileController
                                                .photoUrl ==
                                            null
                                        ? "https://www.w3schools.com/howto/img_avatar.png"
                                        : AppConstants.imgurl +
                                            "${candidateEditMainProfileController.photoUrl}",
                                  ),
                                  fit: BoxFit.cover,
                                  onError: (error, stackTrace) =>
                                      Icon(Icons.error, size: height(64)),
                                )),
                      height: height(64),
                      width: height(64)),
                );
              }),
              SizedBox(width: 0.w),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// name
                    GetBuilder<CandidateEditMainProfileController>(
                        builder: (_) {
                      return Text(
                        candidateEditMainProfileController
                                .profileInfoList.isEmpty
                            ? ""
                            : "${candidateEditMainProfileController.profileInfoList[0].fastname ?? ''} " +
                                "${candidateEditMainProfileController.profileInfoList[0].lastname ?? ''}",
                        overflow: TextOverflow.ellipsis,
                        style: Styles.largeTitle.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }),

                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: () {
                        // resumeController.getMyResume();
                        Get.toNamed(RouteHelper.getMyResumeRoute());
                      },
                      child: Row(
                        children: [
                          Text("Edit Profile", style: Styles.bodySmall1),
                          const Gap(5),
                          Image.asset(
                            AppImagePaths.editIcon,
                            width: width(14),
                            height: height(14),
                            fit: BoxFit.fitHeight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Gap(7),
        GetBuilder<CandidateMainProfileController>(builder: (_) {
          return Obx(
            () => Container(
              width: 330.w,
              padding: EdgeInsets.all(11.h),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.appBorder, width: .5),
                  borderRadius: BorderRadius.circular(6.r)),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: candidateprofile.candidateProfileList.isEmpty
                        ? null
                        : () => Get.to(() => ViewedJobsScreen()),
                    child: Container(
                      child: profilebox(
                          name: "Viewed Jobs",
                          value:
                              "${candidateprofile.candidateProfileList.isEmpty ? "0" : candidateprofile.candidateProfileList[0].other!.viewjob}"),
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: candidateprofile.candidateProfileList.isEmpty
                        ? null
                        : () => Get.to(() => CvSentHistoryScreen()),
                    child: Container(
                      child: profilebox(
                          name: "CV Sent",
                          value:
                              "${candidateprofile.candidateProfileList.isEmpty ? "0" : candidateprofile.candidateProfileList[0].other!.cvsend}"),
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: candidateprofile.candidateProfileList.isEmpty
                        ? null
                        : () => Get.to(() => CandidateTotalChatHistoryScreen(
                              id: candidateprofile.candidateProfileList[0].id,
                            )),
                    child: profilebox(
                        name: "Total Chats",
                        value:
                            "${candidateprofile.candidateProfileList.isEmpty ? "0" : candidateprofile.candidateProfileList[0].other!.totalchat}"),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: candidateprofile.candidateProfileList.isEmpty
                        ? null
                        : () => Get.to(() => SavedJobsScreen()),
                    child: Container(
                      child: profilebox(
                          name: "Saved Jobs",
                          value:
                              "${candidateprofile.candidateProfileList.isEmpty ? "0" : candidateprofile.candidateProfileList[0].other!.savejob}"),
                    ),
                  ))
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget profilebox({required String name, required String value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$value",
            style: Styles.bodySmallSemiBold),
        Text("$name",
            style: Styles.bodySmall3.copyWith(fontSize: font(13)))
      ],
    );
  }
}

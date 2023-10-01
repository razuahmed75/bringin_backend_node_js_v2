// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:bringin/res/constants/app_constants.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/widgets/app_bottom_nav_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../controllers/candidate_section/candidate_edit_main_profile_controller.dart';
import '../../../../../controllers/recruiter_section/recruiter_job_post_controller.dart';
import '../../../../../models/candidate_section/candidate_profile_info_model.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/color.dart';
import '../../../../../res/constants/image_path.dart';
import '../../../../../res/dimensions.dart';
import '../../../../../utils/services/helpers.dart';
import '../../../../../utils/services/keys.dart';
import '../../../../../widgets/header_widget.dart';
import '../../../../../widgets/profile_info_tile.dart';
import '../../../Hive/hive.dart';
import '../../../controllers/both_category/push_notification_controller.dart';
import '../../../controllers/both_category/settings_controller.dart';
import 'components/candidate_profile_dialog.dart';

class CandidateEditMainProfileScreen extends StatelessWidget {
  bool loginhome;
  int? carearpre;
  bool? isSwitchBack;
  CandidateEditMainProfileScreen(
      {super.key,
      this.loginhome = false,
      this.carearpre,
      this.isSwitchBack = false});

  @override
  Widget build(BuildContext context) {
    var currentYear = DateTime.now().year.toString().substring(2);
    int indexedYear = int.parse(currentYear);
    CandidateEditMainProfileController candidateEditMainProfileController =
        Get.find<CandidateEditMainProfileController>();
    candidateEditMainProfileController.getProfileInfo();
    PushNotificationController.to.getUserId();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: isSwitchBack == true
            ? SizedBox(
                height: 0,
                width: 0,
              )
            : Text("Edit Profile", style: Styles.smallTitle),
        actions: [
          isSwitchBack == false
              ? SizedBox(
                  height: 0,
                  width: 0,
                )
              : SvgPicture.asset(
                  "assets/icon2/switch.svg",
                  height: height(17),
                ),
          isSwitchBack == false
              ? SizedBox(
                  height: 0,
                  width: 0,
                )
              : TextButton(
                  onPressed: () async {
                    await SettingsController.to.switchAccout(isRecruiter: 0);
                  },
                  child: Text(
                    "Switch Back",
                    style: Styles.bodySmallSemiBold.copyWith(
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
          Gap(isSwitchBack == true ? 20 : 0),
        ],
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isSwitchBack == true
                ? Align(
                    child: Text("Edit Profile", style: Styles.smallTitle),
                  )
                : SizedBox(),
            Dimensions.kDefaultgapTop,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<CandidateEditMainProfileController>(builder: (_) {
                  return GestureDetector(
                    onTap: () {
                      log(HiveHelp.read(Keys.authToken));
                      CandidateProfileInfoDialog.buildUploadDialog(context);
                    },
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
                              : candidateEditMainProfileController.photoUrl ==
                                      null
                                  ? DecorationImage(
                                      image: AssetImage(AppImagePaths.profile),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        AppConstants.imgurl +
                                            "${candidateEditMainProfileController.photoUrl}",
                                      ),
                                      fit: BoxFit.cover,
                                      onError: (error, stackTrace) =>
                                          Icon(Icons.error, size: height(75)),
                                    ),
                        ),
                        height: height(75),
                        width: height(75),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomRight,
                          children: [
                            IconButton(
                              onPressed: () {
                                CandidateProfileInfoDialog.buildUploadDialog(
                                    context);
                              },
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                AppImagePaths.photo_upload,
                                height: height(21),
                                width: height(21),
                              ),
                            ),
                          ],
                        )),
                    // Container(
                    //     margin: EdgeInsets.only(right: width(10)),
                    //     width: height(75),
                    //     height: height(75),
                    //     decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(height(75) / 2),
                    //     color: Colors.grey.shade200,
                    //     image: candidateEditMainProfileController.profileInfoList.isEmpty ?
                    //     DecorationImage(
                    //             image: AssetImage(AppImagePaths.profile),
                    //             fit: BoxFit.cover,
                    //           ) : candidateEditMainProfileController
                    //                 .profileInfoList[0].image ==
                    //             null
                    //         ? DecorationImage(
                    //             image: AssetImage(AppImagePaths.profile),
                    //             fit: BoxFit.cover,
                    //           )
                    //         : DecorationImage(
                    //             image: NetworkImage(AppConstants.imgurl +
                    //                 "${candidateEditMainProfileController.photoUrl}"),
                    //             fit: BoxFit.cover,
                    //           )),
                    //       child: Stack(
                    //         alignment: Alignment.bottomRight,
                    //         children: [
                    //           IconButton(
                    //             onPressed: () {
                    //               CandidateProfileInfoDialog.buildUploadDialog(
                    //                   context);
                    //             },
                    //             constraints: BoxConstraints(),
                    //             padding: EdgeInsets.zero,
                    //             icon: SvgPicture.asset(
                    //               AppImagePaths.photo_upload,
                    //               height: height(21),
                    //               width: height(21),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //         ),
                  );
                }),
                // })
              ],
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Name
                GetBuilder<CandidateEditMainProfileController>(builder: (_) {
                  return ProfileInfoTile(
                    onPressed: () =>
                        Get.toNamed(RouteHelper.getCandidateFNameRoute()),
                    firstText: "First Name",
                    secondText: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? ""
                        : candidateEditMainProfileController
                                .profileInfoList[0].fastname ??
                            "e.g. Rony",
                    secondTextColor: candidateEditMainProfileController
                            .profileInfoList.isNotEmpty
                        ? candidateEditMainProfileController
                                    .profileInfoList[0].fastname ==
                                null
                            ? AppColors.hintColor
                            : AppColors.blackColor
                        : AppColors.hintColor,
                    iconPath: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppImagePaths.arrowForwardIcon
                        : candidateEditMainProfileController
                                    .profileInfoList[0].fastname ==
                                null
                            ? AppImagePaths.arrowForwardIcon
                            : AppImagePaths.validated,
                    iconColor: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppColors.blackColor.withOpacity(.4)
                        : candidateEditMainProfileController
                                    .profileInfoList[0].fastname ==
                                null
                            ? AppColors.blackColor.withOpacity(.4)
                            : AppColors.mainColor,
                  );
                }),
                const Gap(10),

                // Last Name
                GetBuilder<CandidateEditMainProfileController>(builder: (_) {
                  return ProfileInfoTile(
                    onPressed: () =>
                        Get.toNamed(RouteHelper.getCandidateLNameRoute()),
                    firstText: "Last Name",
                    secondText: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? ""
                        : candidateEditMainProfileController
                                .profileInfoList[0].lastname ??
                            "e.g. Hosen",
                    secondTextColor: candidateEditMainProfileController
                            .profileInfoList.isNotEmpty
                        ? candidateEditMainProfileController
                                    .profileInfoList[0].lastname ==
                                null
                            ? AppColors.hintColor
                            : AppColors.blackColor
                        : AppColors.hintColor,
                    iconPath: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppImagePaths.arrowForwardIcon
                        : candidateEditMainProfileController
                                    .profileInfoList[0].lastname ==
                                null
                            ? AppImagePaths.arrowForwardIcon
                            : AppImagePaths.validated,
                    iconColor: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppColors.blackColor.withOpacity(.4)
                        : candidateEditMainProfileController
                                    .profileInfoList[0].lastname ==
                                null
                            ? AppColors.blackColor.withOpacity(.4)
                            : AppColors.mainColor,
                  );
                }),
                const Gap(10),

                // Gender
                GetBuilder<CandidateEditMainProfileController>(builder: (_) {
                  return ProfileInfoTile(
                    onPressed: () {
                      CandidateProfileInfoDialog.genderDialog(context);
                    },
                    firstText: "Gender",
                    secondText: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? ""
                        : candidateEditMainProfileController
                                .profileInfoList[0].gender ??
                            "e.g. Male",
                    secondTextColor: candidateEditMainProfileController
                            .profileInfoList.isNotEmpty
                        ? candidateEditMainProfileController
                                    .profileInfoList[0].gender ==
                                null
                            ? AppColors.hintColor
                            : AppColors.blackColor
                        : AppColors.hintColor,
                    iconPath: AppImagePaths.dropdownIcon,
                    iconColor: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppColors.blackColor.withOpacity(.4)
                        : candidateEditMainProfileController
                                    .profileInfoList[0].gender ==
                                null
                            ? AppColors.blackColor.withOpacity(.4)
                            : null,
                    heights: height(7),
                    widths: height(7),
                  );
                }),
                const Gap(10),

                // Experience Level
                GetBuilder<CandidateEditMainProfileController>(builder: (_) {
                  return ProfileInfoTile(
                    onPressed: () {
                      if (RecruiterJobPostController
                          .to.experienceList.isEmpty) {
                        RecruiterJobPostController.to.getExperience();
                        CandidateProfileInfoDialog.experienceLevelDialog(
                            context);
                      } else {
                        CandidateProfileInfoDialog.experienceLevelDialog(
                            context);
                      }
                    },
                    firstText: "Experience Level",
                    secondText: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? ""
                        : candidateEditMainProfileController
                                        .profileInfoList[0].experiencedlevel ==
                                    null ||
                                candidateEditMainProfileController
                                        .profileInfoList[0]
                                        .experiencedlevel!
                                        .name ==
                                    null
                            ? "e.g. Fresher"
                            : candidateEditMainProfileController
                                .profileInfoList[0].experiencedlevel!.name,
                    secondTextColor: candidateEditMainProfileController
                            .profileInfoList.isNotEmpty
                        ? candidateEditMainProfileController
                                        .profileInfoList[0].experiencedlevel ==
                                    null ||
                                candidateEditMainProfileController
                                        .profileInfoList[0]
                                        .experiencedlevel!
                                        .name ==
                                    null
                            ? AppColors.hintColor
                            : AppColors.blackColor
                        : AppColors.hintColor,
                    iconPath: AppImagePaths.dropdownIcon,
                    iconColor: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppColors.blackColor.withOpacity(.4)
                        : candidateEditMainProfileController
                                    .profileInfoList[0].experiencedlevel ==
                                null
                            ? AppColors.blackColor.withOpacity(.4)
                            : null,
                    heights: height(7),
                    widths: height(7),
                  );
                }),
                const Gap(10),

                // Started Working
                GetBuilder<CandidateEditMainProfileController>(builder: (_) {
                  return ProfileInfoTile(
                    onPressed: () {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                HeaderWidget(
                                  onBackPressed: () => Get.back(),
                                  onSavePressed: () {
                                    String dateStr =
                                        "${candidateEditMainProfileController.selectedStartedWorkingMonth.value} " +
                                            "${candidateEditMainProfileController.selectedStartedWorkingYear.value}";
                                    candidateEditMainProfileController
                                        .formatDateTimeFromUi(dateStr);
                                    candidateEditMainProfileController
                                        .postStartedWorking(data: {
                                      "startedworking":
                                          candidateEditMainProfileController
                                              .formattedDateFromUi,

                                      /// formatted the value as date time
                                    });
                                  },
                                  middleText: "Started Working",
                                  isArrow: false,
                                  margin: EdgeInsets.symmetric(
                                    vertical: height(20),
                                    horizontal: width(10),
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: height(200),
                                      width: width(220),
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
                                                      initialItem:
                                                          candidateEditMainProfileController
                                                                  .selectedWorkingMonthIndex
                                                                  .value +
                                                              6),
                                              itemExtent: height(30),
                                              onSelectedItemChanged:
                                                  (int index) {
                                                candidateEditMainProfileController
                                                    .selectedWorkingMonthIndex
                                                    .value = index;
                                                candidateEditMainProfileController
                                                        .selectedStartedWorkingMonth
                                                        .value =
                                                    candidateEditMainProfileController
                                                        .months[index];
                                              },
                                              children: List<Widget>.generate(
                                                  candidateEditMainProfileController
                                                      .months
                                                      .length, (int index) {
                                                return Center(
                                                  child: Text(
                                                    candidateEditMainProfileController
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
                                                      initialItem:
                                                          candidateEditMainProfileController
                                                                  .selectedWorkingYearIndex
                                                                  .value +
                                                              45),
                                              itemExtent: height(30),
                                              onSelectedItemChanged:
                                                  (int index) {
                                                candidateEditMainProfileController
                                                    .selectedWorkingYearIndex
                                                    .value = index;
                                                candidateEditMainProfileController
                                                    .selectedStartedWorkingYear
                                                    .value = "${1970 + index}";
                                              },
                                              children: List<Widget>.generate(
                                                  31 + indexedYear,
                                                  (int index) {
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
                                    Obx(
                                      () => candidateEditMainProfileController
                                              .isLoading.value
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Helpers.appLoader2(),
                                              ],
                                            )
                                          : SizedBox(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                    },
                    firstText: "Started Working",
                    secondText: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? ""
                        : candidateEditMainProfileController
                                    .profileInfoList[0].startedworking ==
                                null
                            ? "e.g. January 2019"
                            : DateFormat('MMM yyyy').format(
                                candidateEditMainProfileController
                                    .profileInfoList[0].startedworking!),
                    iconPath: AppImagePaths.dropdownIcon,
                    iconColor: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppColors.blackColor.withOpacity(.4)
                        : candidateEditMainProfileController
                                    .profileInfoList[0].startedworking ==
                                null
                            ? AppColors.blackColor.withOpacity(.4)
                            : null,
                    secondTextColor: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppColors.hintColor
                        : candidateEditMainProfileController
                                    .profileInfoList[0].startedworking ==
                                null
                            ? AppColors.hintColor
                            : AppColors.blackColor,
                    heights: height(7),
                    widths: height(7),
                  );
                }),
                const Gap(10),

                //Date of Birth
                GetBuilder<CandidateEditMainProfileController>(builder: (_) {
                  return ProfileInfoTile(
                      firstText: "Date of Birth",
                      secondText: candidateEditMainProfileController
                              .profileInfoList.isEmpty
                          ? ""
                          : candidateEditMainProfileController
                                      .profileInfoList[0].deatofbirth ==
                                  null
                              ? "e.g. August 2000"
                              : DateFormat('MMM yyyy').format(
                                  candidateEditMainProfileController
                                      .profileInfoList[0].deatofbirth!),
                      iconPath: AppImagePaths.dropdownIcon,
                      iconColor: candidateEditMainProfileController
                              .profileInfoList.isEmpty
                          ? AppColors.blackColor.withOpacity(.4)
                          : candidateEditMainProfileController
                                      .profileInfoList[0].deatofbirth ==
                                  null
                              ? AppColors.blackColor.withOpacity(.4)
                              : null,
                      secondTextColor: candidateEditMainProfileController
                              .profileInfoList.isEmpty
                          ? AppColors.hintColor
                          : candidateEditMainProfileController
                                      .profileInfoList[0].deatofbirth ==
                                  null
                              ? AppColors.hintColor
                              : AppColors.blackColor,
                      heights: height(7),
                      widths: height(7),
                      onPressed: () {
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
                                      String dateStr =
                                          "${candidateEditMainProfileController.selectedDOBMonth.value} " +
                                              "${candidateEditMainProfileController.selectedDOBYear.value}";
                                      candidateEditMainProfileController
                                          .formatDateTimeFromUi(dateStr);
                                      candidateEditMainProfileController
                                          .postDOB(data: {
                                        "deatofbirth":
                                            candidateEditMainProfileController
                                                .formattedDateFromUi,
                                      });
                                    },
                                    middleText: "My Date of Birth",
                                    isArrow: false,
                                    margin: EdgeInsets.symmetric(
                                      vertical: height(20),
                                      horizontal: width(10),
                                    ),
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: height(200),
                                            width: width(220),
                                            decoration: BoxDecoration(
                                              // color: AppColors.mainColor
                                              //     .withOpacity(.25),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      radius(20)),
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
                                                          color: Colors
                                                              .transparent,
                                                          border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                color: AppColors
                                                                    .whiteColor,
                                                              ),
                                                              top: BorderSide(
                                                                  color: AppColors
                                                                      .whiteColor))),
                                                    ),
                                                    scrollController:
                                                        FixedExtentScrollController(
                                                            initialItem:
                                                                candidateEditMainProfileController
                                                                        .selectedDobMonthIndex
                                                                        .value +
                                                                    6),
                                                    itemExtent: height(30),
                                                    onSelectedItemChanged:
                                                        (int index) {
                                                      candidateEditMainProfileController
                                                          .selectedDobMonthIndex
                                                          .value = index;
                                                      candidateEditMainProfileController
                                                              .selectedDOBMonth
                                                              .value =
                                                          candidateEditMainProfileController
                                                              .months[index];
                                                    },
                                                    children: List<
                                                            Widget>.generate(
                                                        candidateEditMainProfileController
                                                            .months.length,
                                                        (int index) {
                                                      return Center(
                                                        child: Text(
                                                          candidateEditMainProfileController
                                                              .months[index],
                                                          style: Styles
                                                              .bodyMedium1,
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),

                                                /// middle divider
                                                // Container(
                                                //   width: width(12),
                                                //   height: height(2),
                                                //   color: AppColors
                                                //       .blackColor,
                                                // ),
                                                SizedBox(
                                                  width: width(100),
                                                  child: CupertinoPicker(
                                                    useMagnifier: true,
                                                    magnification: 1.3,
                                                    selectionOverlay: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                color: AppColors
                                                                    .whiteColor,
                                                              ),
                                                              top: BorderSide(
                                                                  color: AppColors
                                                                      .whiteColor))),
                                                    ),
                                                    scrollController:
                                                        FixedExtentScrollController(
                                                            initialItem:
                                                                candidateEditMainProfileController
                                                                        .selectedDobYearIndex
                                                                        .value +
                                                                    30),
                                                    itemExtent: height(30),
                                                    onSelectedItemChanged:
                                                        (int index) {
                                                      candidateEditMainProfileController
                                                          .selectedDobYearIndex
                                                          .value = index;
                                                      candidateEditMainProfileController
                                                              .selectedDOBYear
                                                              .value =
                                                          "${1960 + index}";
                                                    },
                                                    children:
                                                        List<Widget>.generate(
                                                            41 + indexedYear,
                                                            (int index) {
                                                      return Center(
                                                        child: Text(
                                                          '${1960 + index}',
                                                          style: Styles
                                                              .bodyMedium1,
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Obx(
                                            () =>
                                                candidateEditMainProfileController
                                                        .isLoading.value
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Helpers.appLoader2(),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        );
                      });
                }),
                const Gap(10),

                // Mobile Number
                GetBuilder<CandidateEditMainProfileController>(builder: (_) {
                  return ProfileInfoTile(
                    // onPressed: () => null,
                    onPressed: () =>
                        Get.toNamed(RouteHelper.getCandidatePhoneNumberRoute()),
                    firstText: "Mobile Number",
                    secondText: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? ""
                        : candidateEditMainProfileController
                                .profileInfoList[0].secoundnumber ??
                            "",
                    iconPath: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppImagePaths.arrowForwardIcon
                        : candidateEditMainProfileController
                                    .profileInfoList[0].number ==
                                null
                            ? AppImagePaths.arrowForwardIcon
                            : AppImagePaths.validated,
                    iconColor: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppColors.blackColor.withOpacity(.4)
                        : candidateEditMainProfileController
                                    .profileInfoList[0].number ==
                                null
                            ? AppColors.blackColor.withOpacity(.4)
                            : AppColors.mainColor,
                  );
                }),
                const Gap(10),

                //Email Address
                GetBuilder<CandidateEditMainProfileController>(builder: (_) {
                  return ProfileInfoTile(
                    onPressed: () =>
                        Get.toNamed(RouteHelper.getCandidateEmailRoute()),
                    firstText: "Email Address",
                    secondText: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? ""
                        : candidateEditMainProfileController
                                .profileInfoList[0].email ??
                            "e.g. hello@bringin.io",
                    secondTextColor: candidateEditMainProfileController
                            .profileInfoList.isNotEmpty
                        ? candidateEditMainProfileController
                                    .profileInfoList[0].email ==
                                null
                            ? AppColors.hintColor
                            : AppColors.blackColor
                        : AppColors.blackColor,
                    iconPath: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppImagePaths.arrowForwardIcon
                        : candidateEditMainProfileController
                                    .profileInfoList[0].email ==
                                null
                            ? AppImagePaths.arrowForwardIcon
                            : AppImagePaths.validated,
                    iconColor: candidateEditMainProfileController
                            .profileInfoList.isEmpty
                        ? AppColors.blackColor.withOpacity(.4)
                        : candidateEditMainProfileController
                                    .profileInfoList[0].email ==
                                null
                            ? AppColors.blackColor.withOpacity(.4)
                            : AppColors.mainColor,
                  );
                }),
                const Gap(40),
              ],
            ),
          ],
        )
            //   ;
            // }),
            ),
      ),
      bottomNavigationBar:
          GetBuilder<CandidateEditMainProfileController>(builder: (_) {
        if (loginhome) {
          return BottomNavWidget(
            onTap: () {
              if (nextpageenable(
                  candidateEditMainProfileController.profileInfoList[0])) {
                // chatcontroll.usercreateandupdate(
                //     details: candidateEditMainProfileController
                //         .profileInfoList[0]);

                HiveHelp.write(Keys.isCandidateProfileBasicCompleted, true);
                HiveHelp.write(Keys.isCandidateJobPrefCompleted, false);
                Get.offNamed(RouteHelper.getCandidateCareerPrefRoute());
              }
            },
          );
        } else {
          return SizedBox(
            height: 1,
            width: 1,
          );
        }
      }),
    );
  }

  bool nextpageenable(CandidateProfileInfoModel details) {
    if (details.fastname == null) {
      Helpers().showValidationErrorDialog(errorText: "First name is required");
      return false;
    } else if (details.lastname == null) {
      Helpers().showValidationErrorDialog(errorText: "Last name is required");
      return false;
    } else if (details.gender == null) {
      Helpers().showValidationErrorDialog(errorText: "Gender is required");
      return false;
    } else if (details.experiencedlevel == null ||
        details.experiencedlevel!.name == null) {
      Helpers()
          .showValidationErrorDialog(errorText: "Experience Level is required");
      return false;
    } else if (details.startedworking == null) {
      Helpers().showValidationErrorDialog(
          errorText: "Started working date is required");
      return false;
    } else if (details.deatofbirth == null) {
      Helpers()
          .showValidationErrorDialog(errorText: "Date of Birth is required");
      return false;
    } else if (details.number == null) {
      Helpers()
          .showValidationErrorDialog(errorText: "Phone number is required");
      return false;
    } else if (details.email == null) {
      Helpers().showValidationErrorDialog(errorText: "Email is required");
      return false;
    } else if (details.image == null) {
      Helpers()
          .showValidationErrorDialog(errorText: "Profile photo is required");
      return false;
    } else {
      HiveHelp.write(Keys.isProfileBasicCompleted, true);

      ///CHECK, IS BASIC USER INFO COMPLETED OR NOT
      return true;
    }
  }
}

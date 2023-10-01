// ignore_for_file: invalid_use_of_protected_member
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_bottom_nav_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../Hive/hive.dart';
import '../../../controllers/both_category/settings_controller.dart';
import '../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../../models/recruiter_section/recruiter_edit_main_profile_post_model.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/app_constants.dart';
import '../../../res/constants/image_path.dart';
import '../../../res/dimensions.dart';
import '../../../utils/services/keys.dart';
import '../../../widgets/profile_info_tile.dart';
import '../../candidate_section/edit_main_profile/components/candidate_profile_dialog.dart';

class RecruiterEditMainProfileScreen extends StatelessWidget {
  final int? companyid;
  final bool? isSwitchBack;
  RecruiterEditMainProfileScreen(
      {super.key, this.companyid, this.isSwitchBack = false});

  // final chatcontroll = Get.put(RecruiterChatControll());

  @override
  Widget build(BuildContext context) {
    RecruiterEditMainProfileController recruiterProfileInfoController =
        Get.find<RecruiterEditMainProfileController>();
    recruiterProfileInfoController.getRecruiterProfileInfoList();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding: EdgeInsets.only(left: width(8)),
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(
            AppImagePaths.arrowBackIcon,
            width: width(16),
            height: width(16),
          ),
        ),
        elevation: 0,
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
                    await SettingsController.to.switchAccout(isRecruiter: 1);
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
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(9.r)),
            child: Column(
              children: [
                Dimensions.kDefaultgapTop,
                Center(
                  child: Text("My Professional Profile as a Recruiter",
                      textAlign: TextAlign.center, style: Styles.smallTitle),
                ),
                const Gap(3),
                HiveHelp.read(Keys.isMainProfileEdit) == true
                    ?

                    /// if the user tap from main profile
                    SizedBox()
                    : Text("Introduce Yourself to Candidate.",
                        style: Styles.bodyMedium2),
                const Gap(10),

                // upload profile photo section
                GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
                  if (_.recruiterProfileInfoList.isEmpty) {
                    return SizedBox();
                  }
                  return Column(
                    children: [
                      InkResponse(
                        radius: 25,
                        onTap: () {
                          CandidateProfileInfoDialog.buildUploadDialog(context);
                          print(HiveHelp.read(Keys.authToken));
                        },
                        child: _.recruiterProfileInfoList.isNotEmpty &&
                                _.recruiterProfileInfoList[0].image != null
                            ? Container(
                                height: 80.h,
                                width: 80.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300],
                                    image: _.recruiterProfileInfoList[0]
                                                .image ==
                                            null
                                        ? DecorationImage(
                                            image: AssetImage(
                                                "assets/icon2/candidate_profile_photo.png"),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              AppConstants.imgurl +
                                                  _.recruiterProfileInfoList[0]
                                                      .image!,
                                            ),
                                            fit: BoxFit.cover,
                                            onError: (error, stackTrace) =>
                                                Icon(Icons.error,
                                                    size: height(80)),
                                          )),
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Positioned(
                                        bottom: height(5),
                                        right: height(5),
                                        child: SvgPicture.asset(
                                          AppImagePaths.photo_upload,
                                          height: height(21),
                                          width: height(21),
                                        )),
                                  ],
                                ),
                              )
                            : Image.asset(
                                "assets/icon2/candidate_profile_photo.png",
                                height: 80.h,
                                width: 80.h,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const Gap(10),
                      Text("Choose a photo or select an avatar",
                          style: Styles.subTitle),
                    ],
                  );
                }),
                const Gap(25),

                // user info section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Name
                    GetBuilder<RecruiterEditMainProfileController>(
                        builder: (_) {
                      if (recruiterProfileInfoController
                          .recruiterProfileInfoList.isEmpty) {
                        return Obx(
                          () => ProfileInfoTile(
                            onPressed: null,
                            firstText: "First Name",
                            secondText: recruiterProfileInfoController
                                    .selectedFName.value.isEmpty
                                ? "e.g. Rony"
                                : recruiterProfileInfoController
                                    .selectedFName.value,
                            secondTextColor: recruiterProfileInfoController
                                    .selectedFName.value.isEmpty
                                ? AppColors.hintColor
                                : AppColors.blackColor,
                            iconPath: AppImagePaths.arrowForwardIcon,
                            iconColor: AppColors.blackColor.withOpacity(.4),
                          ),
                        );
                      }
                      return Obx(
                        () => ProfileInfoTile(
                          onPressed: () => Get.toNamed(
                              RouteHelper.getEditProfileInfoRoute(),
                              arguments: {
                                "title": "First Name",
                                "controller": recruiterProfileInfoController
                                    .fNameController.value,
                                "hinText": "e.g. Rony Hosen"
                              }),
                          firstText: "First Name",
                          secondText: recruiterProfileInfoController
                                  .selectedFName.value.isEmpty
                              ? recruiterProfileInfoController
                                      .recruiterProfileInfoList[0].firstname ??
                                  "e.g. Rony"
                              : recruiterProfileInfoController
                                  .selectedFName.value,
                          secondTextColor: recruiterProfileInfoController
                                          .recruiterProfileInfoList[0]
                                          .firstname ==
                                      null &&
                                  recruiterProfileInfoController
                                      .selectedFName.value.isEmpty
                              ? AppColors.hintColor
                              : AppColors.blackColor,
                          iconPath: recruiterProfileInfoController
                                  .selectedFName.value.isEmpty
                              ? recruiterProfileInfoController
                                          .recruiterProfileInfoList[0]
                                          .firstname ==
                                      null
                                  ? AppImagePaths.arrowForwardIcon
                                  : AppImagePaths.validated
                              : AppImagePaths.validated,
                          iconColor: recruiterProfileInfoController
                                  .selectedFName.value.isEmpty
                              ? recruiterProfileInfoController
                                          .recruiterProfileInfoList[0]
                                          .firstname ==
                                      null
                                  ? AppColors.blackColor.withOpacity(.4)
                                  : null
                              : null,
                        ),
                      );
                    }),
                    const Gap(10),

                    // Last Name
                    GetBuilder<RecruiterEditMainProfileController>(
                        builder: (_) {
                      if (recruiterProfileInfoController
                          .recruiterProfileInfoList.isEmpty) {
                        return Obx(
                          () => ProfileInfoTile(
                            onPressed: null,
                            firstText: "Last Name",
                            secondText: recruiterProfileInfoController
                                    .selectedLName.value.isEmpty
                                ? "e.g. Hosen"
                                : recruiterProfileInfoController
                                    .selectedLName.value,
                            secondTextColor: recruiterProfileInfoController
                                    .selectedLName.value.isEmpty
                                ? AppColors.hintColor
                                : AppColors.blackColor,
                            iconPath: AppImagePaths.arrowForwardIcon,
                            iconColor: AppColors.blackColor.withOpacity(.4),
                          ),
                        );
                      }
                      return Obx(
                        () => ProfileInfoTile(
                          onPressed: () => Get.toNamed(
                              RouteHelper.getEditProfileInfoRoute(),
                              arguments: {
                                "title": "Last Name",
                                "controller": recruiterProfileInfoController
                                    .lNameController.value,
                                "hinText": "e.g. Sarker"
                              }),
                          firstText: "Last Name",
                          secondText: recruiterProfileInfoController
                                  .selectedLName.value.isEmpty
                              ? recruiterProfileInfoController
                                      .recruiterProfileInfoList[0].lastname ??
                                  "e.g. Hosen"
                              : recruiterProfileInfoController
                                  .selectedLName.value,
                          secondTextColor: recruiterProfileInfoController
                                          .recruiterProfileInfoList[0]
                                          .lastname ==
                                      null &&
                                  recruiterProfileInfoController
                                      .selectedLName.value.isEmpty
                              ? AppColors.hintColor
                              : AppColors.blackColor,
                          iconPath: recruiterProfileInfoController
                                  .selectedLName.value.isEmpty
                              ? recruiterProfileInfoController
                                          .recruiterProfileInfoList[0]
                                          .lastname ==
                                      null
                                  ? AppImagePaths.arrowForwardIcon
                                  : AppImagePaths.validated
                              : AppImagePaths.validated,
                          iconColor: recruiterProfileInfoController
                                  .selectedLName.value.isEmpty
                              ? recruiterProfileInfoController
                                          .recruiterProfileInfoList[0]
                                          .lastname ==
                                      null
                                  ? AppColors.blackColor.withOpacity(.4)
                                  : null
                              : null,
                        ),
                      );
                    }),
                    const Gap(10),

                    // company name
                    GetBuilder<RecruiterEditMainProfileController>(
                        builder: (_) {
                      if (recruiterProfileInfoController
                          .recruiterProfileInfoList.isEmpty) {
                        return Obx(
                          () => ProfileInfoTile(
                            onPressed: null,
                            firstText: "My Company Name",
                            secondText: recruiterProfileInfoController
                                    .selectedCompanyName.value.isEmpty
                                ? "e.g. Bringin Technologies Ltd."
                                : recruiterProfileInfoController
                                    .selectedCompanyName.value,
                            secondTextColor: recruiterProfileInfoController
                                    .selectedCompanyName.value.isEmpty
                                ? AppColors.hintColor
                                : AppColors.blackColor,
                            iconPath: AppImagePaths.arrowForwardIcon,
                            iconColor: AppColors.blackColor.withOpacity(.4),
                          ),
                        );
                      }
                      return recruiterProfileInfoController
                                  .recruiterProfileInfoList[0].companyname !=
                              null
                          ? SizedBox()
                          : Obx(
                              () => Column(
                                children: [
                                  ProfileInfoTile(
                                    onPressed: recruiterProfileInfoController
                                                .recruiterProfileInfoList[0]
                                                .companyname !=
                                            null
                                        ? null
                                        : () {
                                            if (recruiterProfileInfoController
                                                .recruiterCompanyList
                                                .value
                                                .isEmpty) {
                                              Get.toNamed(RouteHelper
                                                  .getcompanyNameRoute());
                                            } else {
                                              Get.toNamed(RouteHelper
                                                  .getcompanyNameRoute());
                                            }
                                          },
                                    firstText: "Company Name",
                                    secondText: recruiterProfileInfoController
                                            .companyNameSearchController
                                            .value
                                            .text
                                            .isEmpty
                                        ? recruiterProfileInfoController
                                                    .recruiterProfileInfoList[0]
                                                    .companyname ==
                                                null
                                            ? "e.g. Bringin Technologies Ltd."
                                            : recruiterProfileInfoController
                                                .recruiterProfileInfoList[0]
                                                .companyname!
                                                .legalName
                                        : recruiterProfileInfoController
                                            .companyNameSearchController
                                            .value
                                            .text,
                                    secondTextColor:
                                        recruiterProfileInfoController
                                                        .recruiterProfileInfoList[
                                                            0]
                                                        .companyname ==
                                                    null &&
                                                recruiterProfileInfoController
                                                    .companyNameSearchController
                                                    .value
                                                    .text
                                                    .isEmpty
                                            ? AppColors.hintColor
                                            : AppColors.blackColor,
                                    iconPath: AppImagePaths.arrowForwardIcon,
                                    iconColor:
                                        AppColors.blackColor.withOpacity(.4),
                                  ),
                                  const Gap(10),
                                ],
                              ),
                            );
                    }),

                    // Designation
                    GetBuilder<RecruiterEditMainProfileController>(
                        builder: (_) {
                      if (recruiterProfileInfoController
                          .recruiterProfileInfoList.isEmpty) {
                        return Obx(
                          () => ProfileInfoTile(
                            onPressed: () => null,
                            firstText: "Designation",
                            secondText: recruiterProfileInfoController
                                    .selectedDesignation.value.isEmpty
                                ? "e.g. CEO"
                                : recruiterProfileInfoController
                                    .selectedDesignation.value,
                            secondTextColor: recruiterProfileInfoController
                                    .selectedDesignation.value.isEmpty
                                ? AppColors.hintColor
                                : AppColors.blackColor,
                            iconPath: AppImagePaths.arrowForwardIcon,
                            iconColor: AppColors.blackColor.withOpacity(.4),
                          ),
                        );
                      }
                      return Obx(
                        () => ProfileInfoTile(
                          onPressed: () => Get.toNamed(
                              RouteHelper.getEditProfileInfoRoute(),
                              arguments: {
                                "title": "Designation",
                                "controller": recruiterProfileInfoController
                                    .designationController.value,
                                "hinText": "e.g. CEO"
                              }),
                          firstText: "Designation",
                          secondText: recruiterProfileInfoController
                                  .selectedDesignation.value.isEmpty
                              ? recruiterProfileInfoController
                                      .recruiterProfileInfoList[0]
                                      .designation ??
                                  "e.g. CEO"
                              : recruiterProfileInfoController
                                  .selectedDesignation.value,
                          secondTextColor: recruiterProfileInfoController
                                          .recruiterProfileInfoList[0]
                                          .designation ==
                                      null &&
                                  recruiterProfileInfoController
                                      .selectedDesignation.value.isEmpty
                              ? AppColors.hintColor
                              : AppColors.blackColor,
                          iconPath: recruiterProfileInfoController
                                  .selectedDesignation.value.isEmpty
                              ? recruiterProfileInfoController
                                          .recruiterProfileInfoList[0]
                                          .designation ==
                                      null
                                  ? AppImagePaths.arrowForwardIcon
                                  : AppImagePaths.validated
                              : AppImagePaths.validated,
                          iconColor: recruiterProfileInfoController
                                  .selectedDesignation.value.isEmpty
                              ? recruiterProfileInfoController
                                          .recruiterProfileInfoList[0]
                                          .designation ==
                                      null
                                  ? AppColors.blackColor.withOpacity(.4)
                                  : null
                              : null,
                        ),
                      );
                    }),
                    const Gap(10),

                    // My Email Address
                    GetBuilder<RecruiterEditMainProfileController>(
                        builder: (_) {
                      if (recruiterProfileInfoController
                          .recruiterProfileInfoList.isEmpty) {
                        return Obx(
                          () => ProfileInfoTile(
                            onPressed: () => null,
                            firstText: "Email Address",
                            secondText: recruiterProfileInfoController
                                    .selectedEmail.value.isEmpty
                                ? "e.g. example@bringin.io"
                                : recruiterProfileInfoController
                                    .selectedEmail.value,
                            secondTextColor: recruiterProfileInfoController
                                    .selectedEmail.value.isEmpty
                                ? AppColors.hintColor
                                : AppColors.blackColor,
                            iconPath: AppImagePaths.arrowForwardIcon,
                            iconColor: AppColors.blackColor.withOpacity(.4),
                          ),
                        );
                      }
                      return Obx(
                        () => ProfileInfoTile(
                          onPressed: () => Get.toNamed(
                              RouteHelper.getEditProfileInfoRoute(),
                              arguments: {
                                "title": "Email Address",
                                "controller": recruiterProfileInfoController
                                    .emailController.value,
                                "hinText": "e.g. example@bringin.io"
                              }),
                          firstText: "Email Address",
                          secondText: recruiterProfileInfoController
                                  .selectedEmail.value.isEmpty
                              ? recruiterProfileInfoController
                                      .recruiterProfileInfoList[0].email ??
                                  "e.g. rony@bringin.io"
                              : recruiterProfileInfoController
                                  .selectedEmail.value,
                          secondTextColor: recruiterProfileInfoController
                                          .recruiterProfileInfoList[0].email ==
                                      null &&
                                  recruiterProfileInfoController
                                      .selectedEmail.value.isEmpty
                              ? AppColors.hintColor
                              : AppColors.blackColor,
                          iconPath: recruiterProfileInfoController
                                  .selectedEmail.value.isEmpty
                              ? recruiterProfileInfoController
                                          .recruiterProfileInfoList[0].email ==
                                      null
                                  ? AppImagePaths.arrowForwardIcon
                                  : AppImagePaths.validated
                              : AppImagePaths.validated,
                          iconColor: recruiterProfileInfoController
                                  .selectedEmail.value.isEmpty
                              ? recruiterProfileInfoController
                                          .recruiterProfileInfoList[0].email ==
                                      null
                                  ? AppColors.blackColor.withOpacity(.4)
                                  : null
                              : null,
                        ),
                      );
                    }),

                    const Gap(60),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
        return Obx(
          () => BottomNavWidget(
            text: recruiterProfileInfoController.isInfoLoading.value
                ? "Saving..."
                : "Save & Next",
            onTap: recruiterProfileInfoController
                    .recruiterProfileInfoList.isEmpty
                ? null
                : recruiterProfileInfoController.isInfoLoading.value
                    ? null
                    : () {
                        print(HiveHelp.read(Keys.authToken));
                        if (recruiterProfileInfoController.recruiterProfileInfoList[0].image ==
                            null) {
                          Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "Profile photo is required",
                          );
                        } else if (recruiterProfileInfoController
                                .selectedFName.value.isEmpty &&
                            recruiterProfileInfoController
                                    .recruiterProfileInfoList[0].firstname ==
                                null) {
                          Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "First name is required",
                          );
                        } else if (recruiterProfileInfoController
                                .selectedLName.value.isEmpty &&
                            recruiterProfileInfoController
                                    .recruiterProfileInfoList[0].lastname ==
                                null) {
                          Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "Last name is required",
                          );
                        } else if (recruiterProfileInfoController
                                .companyNameSearchController
                                .value
                                .text
                                .isEmpty &&
                            recruiterProfileInfoController
                                    .recruiterProfileInfoList[0]
                                    .companyname ==
                                null) {
                          Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "Company name is required",
                          );
                        } else if (recruiterProfileInfoController
                                .selectedDesignation.value.isEmpty &&
                            recruiterProfileInfoController
                                    .recruiterProfileInfoList[0]
                                    .designation ==
                                null) {
                          Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "Designation is required",
                          );
                        } else if (recruiterProfileInfoController
                                .selectedEmail.value.isEmpty &&
                            recruiterProfileInfoController.recruiterProfileInfoList[0].email == null) {
                          Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "Email is required",
                          );
                        } else {
                          /// IF THE RECRUITER IS NEW
                          if (HiveHelp.read(Keys.isMainProfileEdit) ==
                              false) {
                            // if (CompanyRegistrationController
                            //         .to
                            //         .companyShortnameEditingCtrlr
                            //         .text
                            //         .isEmpty ||
                            //     IndustryControler
                            //         .to.selectedIndustryVal.value.isEmpty ||
                            //     CompanyRegistrationController
                            //         .to.companyEmployeesSize.value.isEmpty ||
                            //     CompanyRegistrationController.to
                            //         .selectedCompanyWebsiteVal.value.isEmpty ||
                            //     CompanyRegistrationController
                            //             .to.registrationStatusCode.value !=
                            //         200) {
                            //   Helpers().showToastMessage(
                            //       msg: "Please Resgister your company first");
                            //   Get.toNamed(
                            //       RouteHelper.getCompanyRegistrationRoute());
                            // }

                            if (recruiterProfileInfoController
                                    .recruiterProfileInfoList[0]
                                    .companyname ==
                                null) {
                              Helpers().showToastMessage(
                                  msg: "Please Resgister your company first");
                              Get.toNamed(
                                  RouteHelper.getCompanyRegistrationRoute());
                            } else {
                              final data = RecruiterEditMainProfilePostModel(
                                firstname: recruiterProfileInfoController
                                        .selectedFName.value.isEmpty
                                    ? recruiterProfileInfoController
                                        .recruiterProfileInfoList[0].firstname
                                    : recruiterProfileInfoController
                                        .selectedFName.value,
                                lastname: recruiterProfileInfoController
                                        .selectedLName.value.isEmpty
                                    ? recruiterProfileInfoController
                                        .recruiterProfileInfoList[0].lastname
                                    : recruiterProfileInfoController
                                        .selectedLName.value,
                                designation: recruiterProfileInfoController
                                        .selectedDesignation.value.isEmpty
                                    ? recruiterProfileInfoController
                                        .recruiterProfileInfoList[0]
                                        .designation
                                    : recruiterProfileInfoController
                                        .selectedDesignation.value,
                                email: recruiterProfileInfoController
                                        .selectedEmail.value.isEmpty
                                    ? recruiterProfileInfoController
                                        .recruiterProfileInfoList[0].email
                                    : recruiterProfileInfoController
                                        .selectedEmail.value,
                              );
                              // chatcontroll.usercreateandupdate(
                              //     details: recruiterProfileInfoController
                              //         .recruiterProfileInfoList[0]);
                              HiveHelp
                                  .write(
                                      Keys.recruiterCompanyName,
                                      recruiterProfileInfoController
                                              .companyNameSearchController
                                              .value
                                              .text
                                              .isEmpty
                                          ? recruiterProfileInfoController
                                                  .recruiterProfileInfoList[0]
                                                  .companyname ??
                                              "e.g. Bringin Technologies Ltd."
                                          : recruiterProfileInfoController
                                              .companyNameSearchController
                                              .value
                                              .text);

                              print(
                                  "hdsdjhbvsd ${HiveHelp.read(Keys.recruiterCompanyId)}");
                              recruiterProfileInfoController
                                  .postRecruiterProfileinfo(data: data);
                            }
                          }

                          /// IF THE RECRUITER IS FROM MAIN PROFILE PAGE
                          else {
                            final data = RecruiterEditMainProfilePostModel(
                              firstname: recruiterProfileInfoController
                                      .selectedFName.value.isEmpty
                                  ? recruiterProfileInfoController
                                      .recruiterProfileInfoList[0].firstname
                                  : recruiterProfileInfoController
                                      .selectedFName.value,
                              lastname: recruiterProfileInfoController
                                      .selectedLName.value.isEmpty
                                  ? recruiterProfileInfoController
                                      .recruiterProfileInfoList[0].lastname
                                  : recruiterProfileInfoController
                                      .selectedLName.value,
                              // companyId: box.read(Keys.companykey),
                              // companyName: recruiterProfileInfoController
                              //         .companyNameSearchController.value.text
                              //         .trim()
                              //         .isEmpty
                              //     ? recruiterProfileInfoController
                              //         .recruiterProfileInfoList[0].companyName
                              //     : recruiterProfileInfoController
                              //         .companyNameSearchController.value.text
                              //         .trim(),
                              designation: recruiterProfileInfoController
                                      .selectedDesignation.value.isEmpty
                                  ? recruiterProfileInfoController
                                      .recruiterProfileInfoList[0].designation
                                  : recruiterProfileInfoController
                                      .selectedDesignation.value,
                              email: recruiterProfileInfoController
                                      .selectedEmail.value.isEmpty
                                  ? recruiterProfileInfoController
                                      .recruiterProfileInfoList[0].email
                                  : recruiterProfileInfoController
                                      .selectedEmail.value,
                              // isVerified: recruiterProfileInfoController.recruiterProfileInfoList[0].isVerified,
                              // photo: recruiterProfileInfoController.recruiterProfileInfoList[0].photo,
                              // recruiterId: recruiterProfileInfoController.recruiterProfileInfoList[0].recruiterId,
                              // status: recruiterProfileInfoController.recruiterProfileInfoList[0].status
                            );
                            // chatcontroll.usercreateandupdate(
                            //     details: recruiterProfileInfoController
                            //         .recruiterProfileInfoList[0]);
                            HiveHelp.write(
                                Keys.recruiterCompanyName,
                                recruiterProfileInfoController
                                        .companyNameSearchController
                                        .value
                                        .text
                                        .isEmpty
                                    ? recruiterProfileInfoController
                                            .recruiterProfileInfoList[0]
                                            .companyname ??
                                        "e.g. Bringin Technologies Ltd."
                                    : recruiterProfileInfoController
                                        .companyNameSearchController
                                        .value
                                        .text);

                            recruiterProfileInfoController
                                .postRecruiterProfileinfo(data: data);
                          }
                        }
                      },
          ),
        );
      }),
    );
  }
}

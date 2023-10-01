import 'dart:math';

import 'package:bringin/Screens/recruiter_section/recruiter_total_chat_history_screen.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:bringin/utils/services/keys.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/dimensions.dart';
import '../../../../widgets/main_profile_tile.dart';
import '../../../Hive/hive.dart';
import '../../../controllers/ChatController/chatcontroll.dart';
import '../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../../widgets/build_contact_dialog.dart';
import '../../messages/recruiter_message/Onbording/onbording.dart';
import '../../messages/recruiter_message/components/recruiter_chats_tab.dart';
import 'components/manage_jobs_tile.dart';

class RecruiterMainProfileScreen extends StatelessWidget {
  RecruiterMainProfileScreen({super.key});
  final recuiterprofile = Get.find<RecruiterEditMainProfileController>();
  ChatControll chatControll = Get.put(ChatControll());
  @override
  Widget build(BuildContext context) {
    recuiterprofile.getRecruiterProfileInfoList();
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
                const Gap(8),

                /// Profile Completion
                _profileCompletion(onTap: () {
                  HiveHelp.write(Keys.isMainProfileEdit, true);

                  /// for recruiter_edit_mainProfile_screen
                  Get.toNamed(RouteHelper.getRecruiterEditMainProfileRoute());
                }),
                const Gap(8),

                /// Manage Jobs
                ManageJobsTile(
                    onTap: () => Get.toNamed(RouteHelper.getManageJobsRoute())),
                const Gap(10),

                /// footer section
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: height(8), horizontal: width(15)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius(6)),
                      border: Border.all(
                        color: AppColors.appBorder,
                        width: .5,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Outbound Chat
                      MainProfileTile(
                        onTap: () {
                          chatControll.channellistevent();
                          Get.to(Outboubd());
                        },
                        iconPath: "",
                        img: "assets/icon2/outboundchat.png",
                        text: "Outbound Chat",
                        additionalText: "",
                      ),
                      const Gap(5),

                      // Payment History
                      MainProfileTile(
                        onTap: () =>
                            Get.toNamed(RouteHelper.getPaymentHistoryRoute()),
                        iconPath: "assets/icon2/purchase_history.svg",
                        imgColor: AppColors.mainColor,
                        text: "Payment History",
                        additionalText: "",
                      ),
                      const Gap(5),

                      // Saved Candidates
                      MainProfileTile(
                        onTap: () {
                          Get.toNamed(RouteHelper.getSavedCandidatesRoute());
                          print(HiveHelp.read(Keys.authToken));
                        },
                        iconPath: "assets/icon2/save_candidate.svg",
                        text: "Saved Candidates",
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
                        additionalText: "Switch to Job Seeker",
                      ),
                      const Gap(5),

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
                        text: "Contact us",
                        additionalText: "",
                      ),

                      // MainProfileTile(
                      //   onTap: () => Get.to(PurchasePackageScreen()),
                      //   iconPath: "assets/icon2/contact.svg",
                      //   text: "Contact Us",
                      //   additionalText: "",
                      // ),
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
    return GetBuilder<RecruiterEditMainProfileController>(
      builder: (_) {
        return InkWell(
            onTap: onTap,
            splashFactory: InkSplash.splashFactory,
            splashColor: AppColors.mainColor.withOpacity(.1),
            highlightColor: AppColors.mainColor.withOpacity(.05),
            child: Container(
                height: 109.h,
                width: 330.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.appBorder,
                    width: .5,
                  ),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Row(children: [
                  Container(
                    height: _.recruiterProfileInfoList.isEmpty
                        ? 89.h
                        : _.recruiterProfileInfoList[0].other!.incomplete == 0
                            ? 100.h
                            : 89.h,
                    width: 211.w,
                    child: Row(children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Profile Setup:",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              _.recruiterProfileInfoList.isEmpty
                                  ? Text("")
                                  : Text(
                                      _.recruiterProfileInfoList[0].other!
                                                  .incomplete ==
                                              0
                                          ? "The profile has been fully updated and is now comprehensive."
                                          : "Profile has ${(_.recruiterProfileInfoList[0].other!.incomplete)} areas for improvement...",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                              SizedBox(height: 2.h),
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
                      ),
                      CircularPercentIndicator(
                        animationDuration: 1000,
                        animation: true,
                        lineWidth: 3,
                        radius: 30.r,
                        percent: _.recruiterProfileInfoList.isEmpty
                            ? 0.0
                            : _.recruiterProfileInfoList[0].other!.complete! > 7
                                ? 1 / 7
                                : (_.recruiterProfileInfoList[0].other
                                            ?.complete ??
                                        0) /
                                    (_.recruiterProfileInfoList[0].other
                                            ?.totalStep ??
                                        1),
                        progressColor: AppColors.mainColor,
                        center: Text(
                          _.recruiterProfileInfoList.isEmpty
                              ? ""
                              : "${((_.recruiterProfileInfoList[0].other!.complete! / _.recruiterProfileInfoList[0].other!.totalStep!) * 100).toStringAsFixed(0)}%",
                          style: Styles.bodySmall1
                              .copyWith(color: AppColors.mainColor),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(width: 10.w),
                  Image.asset(
                    "assets/icon2/Job Profile.png",
                    height: 93.h,
                    width: 93.w,
                  )
                ])));
      },
    );
  }

  Widget profileinfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            /// photo
            GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
              return GestureDetector(
                onTap: () {
                  HiveHelp.write(Keys.isMainProfileEdit, true);

                  /// for recruiter_edit_mainProfile_screen
                  Get.toNamed(RouteHelper.getRecruiterEditMainProfileRoute());
                },
                child: Container(
                    margin: EdgeInsets.only(right: width(10)),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      image: _.recruiterProfileInfoList.isEmpty
                          ? DecorationImage(
                              image: AssetImage(AppImagePaths.profile),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image: CachedNetworkImageProvider(
                                _.photoUrl == null
                                    ? "https://www.w3schools.com/howto/img_avatar.png"
                                    : AppConstants.imgurl + "${_.photoUrl}",
                              ),
                              fit: BoxFit.cover,
                              onError: (error, stackTrace) =>
                                  Icon(Icons.error, size: height(64)),
                            ),
                    ),
                    height: height(64),
                    width: height(64)),
              );
            }),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// name
                  GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
                    return Text(
                        _.recruiterProfileInfoList.isEmpty
                            ? ""
                            : "${_.recruiterProfileInfoList[0].firstname ?? ""} " +
                                "${_.recruiterProfileInfoList[0].lastname ?? ""}",
                        overflow: TextOverflow.ellipsis,
                        style: Styles.largeTitle.copyWith(fontSize: 20.sp));
                  }),
                  const Gap(5),
                  GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
                    return GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              child: Text(
                            _.recruiterProfileInfoList.isEmpty
                                ? ""
                                : "${_.recruiterProfileInfoList[0].designation == null ? "" : _.recruiterProfileInfoList[0].designation!}",
                            style: Styles.bodySmall1,
                            overflow: TextOverflow.ellipsis,
                          )),
                          SizedBox(width: 5.w),
                          Text("•", style: Styles.bodyMedium),
                          const Gap(5),
                          Text(
                            _.recruiterProfileInfoList.isEmpty
                                ? ""
                                : _.recruiterProfileInfoList[0].companyname ==
                                        null
                                    ? ""
                                    : _.recruiterProfileInfoList[0].companyname!
                                            .legalName ??
                                        "",
                            style: Styles.bodySmall1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
        const Gap(10),
        GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
          return Container(
            height: 48.h,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.appBorder, width: .5),
                borderRadius: BorderRadius.circular(6.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    print(HiveHelp.read(Keys.authToken));
                    var list = ["3", "jfd", "fdfj"];
                    log(list.length);
                  },
                  child: profilebox(
                      name: "Interviews",
                      value: recuiterprofile.recruiterProfileInfoList.isEmpty
                          ? ""
                          : "${recuiterprofile.recruiterProfileInfoList[0].other!.interview}"),
                ),
                InkWell(
                  onTap: () =>
                      Get.toNamed(RouteHelper.getSavedCandidatesRoute()),
                  child: profilebox(
                      name: "Saved Candidates",
                      value: recuiterprofile.recruiterProfileInfoList.isEmpty
                          ? ""
                          : "${recuiterprofile.recruiterProfileInfoList[0].other!.savecandidate}"),
                ),
                InkWell(
                  onTap: recuiterprofile.recruiterProfileInfoList.isEmpty
                      ? null
                      : () => Get.to(() => RecruiterTotalChatHistoryScreen(
                          id: recuiterprofile.recruiterProfileInfoList[0].sId)),
                  child: profilebox(
                      name: "Total Chats",
                      value: recuiterprofile.recruiterProfileInfoList.isEmpty
                          ? ""
                          : "${recuiterprofile.recruiterProfileInfoList[0].other!.totalChat}"),
                ),
              ],
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
        Text("$value", style: Styles.bodySmallSemiBold),
        Text("$name", style: Styles.smallText3.copyWith(fontSize: font(13)))
      ],
    );
  }
}

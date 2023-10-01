import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/app_button.dart';
import 'package:in_app_update/in_app_update.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/dimensions.dart';
import '../../../utils/services/keys.dart';
import '../../Hive/hive.dart';
import '../../controllers/ChatController/chatcontroll.dart';
import '../../controllers/candidate_section/candidate_main_profile_controller.dart';
import '../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../res/constants/image_path.dart';
import '../candidate_section/bottom_nav/bottom_nav_layout.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AppUpdateInfo? _updateInfo;

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      print(e);
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  ChatControll chatControll = Get.put(ChatControll());

  @override
  void initState() {
    checkForUpdate();
    super.initState();
  }

  var candidateProfileControll = Get.put(CandidateMainProfileController());
  var recruiterProfileControll = Get.put(RecruiterEditMainProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: "Settings", onBackPressed: () => Get.back(), actions: []),
      body: SafeArea(
        child: Column(
          children: [
            Dimensions.kDefaultgapTop,

            // settings menu section
            Padding(
                padding: Dimensions.kDefaultPadding / 2, child: _SettingBody()),
            Spacer(),

            // logout
            Container(
              padding: Dimensions.kDefaultPadding,
              margin: EdgeInsets.only(bottom: height(20)),
              child: AppButton(
                buttonWidth: double.maxFinite,
                borderColor: Colors.transparent,
                bgColor: AppColors.mainColor,
                text: "Log Out",
                textColor: AppColors.whiteColor,
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => AlertDialog(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      insetPadding: EdgeInsets.zero,
                      elevation: 0,
                      content: Container(
                        height: height(120),
                        width: Dimensions.screenWidth * .87,
                        padding: EdgeInsets.only(
                          top: height(20),
                          bottom: height(8),
                          left: height(20),
                          right: height(20),
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Log out of your Bringin account?",
                                style: Styles.bodyMedium1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /// CANCEL
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child:
                                      Text("CANCEL", style: Styles.bodyMedium1),
                                ),

                                /// LOGOUT
                                TextButton(
                                  onPressed: () {
                                    HiveHelp.remove(Keys.authToken);
                                    HiveHelp.remove(Keys.currentuserid);
                                    // chatControll.streamclose();
                                    chatControll.socket.disconnect();
                                    refreshBottomNavIndex();
                                    // HiveHelp.cleanall();
                                    if (HiveHelp.read(Keys.authToken) == null) {
                                      Get.offAllNamed(
                                          RouteHelper.getLoginSelectRoute());
                                    }
                                  },
                                  child: Text("LOG OUT",
                                      style: Styles.bodyMedium1.copyWith(
                                          color: AppColors.mainColor)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _SettingBody() {
    return Column(
      children: [
        /// Notifications
        _IconAndText(
          onTap: () {
            Get.toNamed(RouteHelper.getNotificationsRoute());
            if (HiveHelp.read(Keys.isRecruiter) == true) {
              recruiterProfileControll.getRecruiterProfileInfoList();
            } else {
              candidateProfileControll.getCandidateInfo();
            }
          },
          firstText: "Notifications",
          imagePath: AppImagePaths.notificationIcon,
        ),
        const Gap(10),

        /// Privacy Policy
        _IconAndText(
          onTap: () => Get.toNamed(RouteHelper.getPrivacyPolicyRoute()),
          firstText: "Privacy Policy",
          imagePath: AppImagePaths.privacy_policyIcon,
        ),
        const Gap(10),

        /// Terms & Conditions
        _IconAndText(
          onTap: () => Get.toNamed(RouteHelper.getTermsAndConditionsRoute()),
          firstText: "Terms & Conditions",
          imagePath: AppImagePaths.terms_and_conditionsIcon,
        ),
        const Gap(10),

        /// New Version Update
        _IconAndText(
          onTap: _updateInfo?.updateAvailability ==
                  UpdateAvailability.updateAvailable
              ? () {
                  InAppUpdate.performImmediateUpdate()
                      .catchError((e) => showSnack(e.toString()));
                }
              : () => Helpers.showAlartMessage(
                  msg: "No updates availabe", gravity: ToastGravity.BOTTOM),
          firstText: "New Version Update",
          isSecondText: true,
          imagePath: AppImagePaths.updateIcon,
        ),
        const Gap(10),

        /// About
        _IconAndText(
          onTap: () => Get.toNamed(RouteHelper.getAboutRoute()),
          firstText: "About",
          imagePath: AppImagePaths.aboutIcon,
        ),
        const Gap(10),

        /// Close Account
        _IconAndText(
          onTap: () => Get.toNamed(RouteHelper.getDeleteAccountRoute()),
          firstText: "Delete Account",
          imagePath: AppImagePaths.close_accountIcon,
        ),
        const Gap(10),

        if (HiveHelp.read(Keys.isRecruiter) == true)

          /// Cancel Subscriptions
          _IconAndText(
            onTap: () => Get.toNamed(RouteHelper.getCancelSubscriptionRoute()),
            firstText: "Cancel Subscriptions",
            imagePath: AppImagePaths.cancel_subscription,
          ),
      ],
    );
  }

  Widget _IconAndText({
    required void Function()? onTap,
    required String firstText,
    required String imagePath,
    bool? isSecondText = false,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius(9)),
      onTap: onTap,
      child: Ink(
        height: height(55),
        width: double.maxFinite,
        padding: Dimensions.kDefaultPadding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius(9)),
            border: Border.all(
              color: AppColors.appBorder,
              width: .4,
            )),
        child: Row(
          children: [
            SvgPicture.asset(imagePath, height: height(16), width: height(19)),
            const Gap(15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(firstText, style: Styles.bodyMedium),
                Gap(isSecondText == true ? 3 : 0),
                isSecondText == true
                    ? Text("Your app is up-to-date.",
                        style: Styles.smallText.copyWith(
                            color: AppColors.blackColor.withOpacity(.6)))
                    : SizedBox(),
              ],
            ),
            Spacer(),
            SvgPicture.asset(
              AppImagePaths.arrowForwardIcon,
              height: height(16),
            ),
          ],
        ),
      ),
    );
  }
}

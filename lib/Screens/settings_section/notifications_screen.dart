import 'package:bringin/widgets/app_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:notification_permissions/notification_permissions.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/strings.dart';
import '../../../res/dimensions.dart';
import '../../Hive/hive.dart';
import '../../controllers/both_category/settings_controller.dart';
import '../../controllers/candidate_section/candidate_main_profile_controller.dart';
import '../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../res/constants/image_path.dart';
import '../../utils/services/helpers.dart';
import '../../utils/services/keys.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool val1 = true;
  bool val2 = true;
  bool val3 = true;
  bool val4 = true;
  var candidateInfoController = Get.put(CandidateMainProfileController());
  var recruiterInfoController = Get.put(RecruiterEditMainProfileController());
  var isRecruiter = HiveHelp.read(Keys.isRecruiter);

  void notificationcheck() {
    NotificationPermissions.requestNotificationPermissions(
            iosSettings: const NotificationSettingsIos(
                sound: true, badge: true, alert: true))
        .then((_) {
      print("hdvbcjshdvjsd${_.name}");

      // when finished, check the permission status

      // permissionStatusFuture =
      //     getCheckNotificationPermStatus();
    });
  }

  @override
  void initState() {
    notificationcheck();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBarWidget(title: "Notifications", onBackPressed: () => Get.back(), actions: []),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: SingleChildScrollView(
          child: Obx(() {
            if (isRecruiter == true) {
              if (candidateInfoController.isLoading.value == true &&
                  SettingsController.to.isPressed.value == false) {
                return Helpers.appLoader();
              }
            } else {
              if (recruiterInfoController.isLoading.value == true &&
                  SettingsController.to.isPressed.value == false) {
                return Helpers.appLoader();
              }
            }
      
            return notificationBody();
          }),
        ),
      ),
    );
  }

  Widget notificationBody() {
    return Stack(
      children: [
        Column(
          children: [

            /// PUSH NOTIFICATIONS
            isRecruiter
                ? GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
                    return Obx(
                      () => _NotificationTile(
                        title: "Push Notifications",
                        description: AppStrings.pushNotificationDes,
                        onTap: () {
                          
                          val1 =
                              recruiterInfoController.notificationList[0].push!;
                          val1 = !val1;
                          SettingsController.to.notification(fields: {
                            "push": val1,
                            "isrecruiter": true,
                          });
                          setState(() {});
                        },
                        switchValue: recruiterInfoController
                                .notificationList.isEmpty
                            ? val1
                            : recruiterInfoController.notificationList[0].push,
                        onSwitchChanged: (v) {
                          val1 = v;
                          SettingsController.to.notification(fields: {
                            "push": v,
                            "isrecruiter": true,
                          });
                          notificationcheck();
                          setState(() {});
                        },
                      ),
                    );
                  })
                : GetBuilder<CandidateMainProfileController>(builder: (_) {
                    return Obx(
                      () => _NotificationTile(
                        title: "Push Notifications",
                        description: AppStrings.pushNotificationDes,
                        onTap: () {
                          val1 =
                              candidateInfoController.notificationList[0].push!;
                          val1 = !val1;
                          SettingsController.to.notification(fields: {
                            "push": val1,
                            "isrecruiter": false,
                          });
                          setState(() {});
                        },
                        switchValue: candidateInfoController
                                .notificationList.isEmpty
                            ? val1
                            : candidateInfoController.notificationList[0].push!,
                        onSwitchChanged: (v) {
                          val1 = v;
                          SettingsController.to.notification(fields: {
                            "push": v,
                            "isrecruiter": false,
                          });
                          notificationcheck();
                          setState(() {});
                        },
                      ),
                    );
                  }),
            const Gap(5),

            /// WhatsApp Notifications
            isRecruiter
                ? GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
                    return _NotificationTile(
                      title: "WhatsApp Notifications",
                      description: AppStrings.whatsappNotifications,
                      switchValue:
                          recruiterInfoController.notificationList.isEmpty
                              ? val1
                              : recruiterInfoController
                                  .notificationList[0].whatsapp,
                      isWhatsappIcon: true,
                      onTap: () {
                        val2 = recruiterInfoController
                            .notificationList[0].whatsapp!;
                        val2 = !val2;
                        SettingsController.to.notification(fields: {
                          "whatsapp": val2,
                          "isrecruiter": true,
                        });
                        setState(() {});
                      },
                      onSwitchChanged: (v) {
                        val2 = v;
                        SettingsController.to.notification(fields: {
                          "whatsapp": v,
                          "isrecruiter": true,
                        });
                        notificationcheck();
                        setState(() {});
                      },
                    );
                  })
                : GetBuilder<CandidateMainProfileController>(builder: (_) {
                    return _NotificationTile(
                      title: "WhatsApp Notifications",
                      description: AppStrings.whatsappNotifications,
                      switchValue:
                          candidateInfoController.notificationList.isEmpty
                              ? val2
                              : candidateInfoController
                                  .notificationList[0].whatsapp,
                      isWhatsappIcon: true,
                      onTap: () {
                        val2 = candidateInfoController
                            .notificationList[0].whatsapp!;
                        val2 = !val2;
                        SettingsController.to.notification(fields: {
                          "whatsapp": val2,
                          "isrecruiter": false,
                        });
                        setState(() {});
                      },
                      onSwitchChanged: (v) {
                        val2 = v;
                        SettingsController.to.notification(fields: {
                          "whatsapp": v,
                          "isrecruiter": false,
                        });
                        notificationcheck();
                        setState(() {});
                      },
                    );
                  }),
            const Gap(5),

            /// SMS Notifications
            isRecruiter
                ? GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
                    return _NotificationTile(
                      title: "SMS Notifications",
                      description: AppStrings.smsNotificationsDes,
                      switchValue:
                          recruiterInfoController.notificationList.isEmpty
                              ? val1
                              : recruiterInfoController.notificationList[0].sms,
                      onTap: () {
                        val3 = recruiterInfoController.notificationList[0].sms!;
                        val3 = !val3;
                        SettingsController.to.notification(fields: {
                          "sms": val3,
                          "isrecruiter": true,
                        });
                        setState(() {});
                      },
                      onSwitchChanged: (v) {
                        val3 = v;
                        SettingsController.to.notification(fields: {
                          "sms": v,
                          "isrecruiter": true,
                        });
                        notificationcheck();
                        setState(() {});
                      },
                    );
                  })
                : GetBuilder<CandidateMainProfileController>(builder: (_) {
                    return _NotificationTile(
                      title: "SMS Notifications",
                      description: AppStrings.smsNotificationsDes,
                      switchValue:
                          candidateInfoController.notificationList.isEmpty
                              ? val3
                              : candidateInfoController.notificationList[0].sms,
                      onTap: () {
                        val3 = candidateInfoController.notificationList[0].sms!;
                        val3 = !val3;
                        SettingsController.to.notification(fields: {
                          "sms": val3,
                          "isrecruiter": false,
                        });
                        setState(() {});
                      },
                      onSwitchChanged: (v) {
                        val3 = v;
                        SettingsController.to.notification(fields: {
                          "sms": v,
                          "isrecruiter": false,
                        });
                        setState(() {});
                      },
                    );
                  }),
            const Gap(5),

            /// Job Recommendations or candidate recommendation
            isRecruiter
                ? GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
                    return _NotificationTile(
                      title: "SMS Recommendations",
                      description: AppStrings.sMSRecommendationsDes,
                      switchValue:
                          recruiterInfoController.notificationList.isEmpty
                              ? val1
                              : recruiterInfoController.notificationList[0].job,
                      onTap: () {
                        val4 = recruiterInfoController.notificationList[0].job!;
                        val4 = !val4;
                        SettingsController.to.notification(fields: {
                          "job": val4,
                          "isrecruiter": true,
                        });
                        setState(() {});
                      },
                      onSwitchChanged: (v) {
                        val4 = v;
                        SettingsController.to.notification(fields: {
                          "job": v,
                          "isrecruiter": true,
                        });
                        setState(() {});
                      },
                    );
                  })
                : GetBuilder<CandidateMainProfileController>(builder: (_) {
                    return _NotificationTile(
                      title: "Job Recommendations",
                      description: AppStrings.sMSRecommendationsDes,
                      switchValue:
                          candidateInfoController.notificationList.isEmpty
                              ? val4
                              : candidateInfoController.notificationList[0].job,
                      onTap: () {
                        val4 = candidateInfoController.notificationList[0].job!;
                        val4 = !val4;
                        SettingsController.to.notification(fields: {
                          "job": val4,
                          "isrecruiter": false,
                        });
                        setState(() {});
                      },
                      onSwitchChanged: (v) {
                        val4 = v;
                        SettingsController.to.notification(fields: {
                          "job": v,
                          "isrecruiter": false,
                        });
                        notificationcheck();
                        setState(() {});
                      },
                    );
                  }),
          ],
        ),
        Obx(
          () => SettingsController.to.isLoading.value
              ? Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(child: Helpers.appLoader2()))
              : SizedBox(),
        ),
      ],
    );
  }

  Widget _NotificationTile({
    required String title,
    description,
    bool? isWhatsappIcon = false,
    switchValue = true,
    void Function(bool)? onSwitchChanged,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(height(15)),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(
            color: AppColors.appBorder,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(radius(9)),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    isWhatsappIcon == true
                        ? SvgPicture.asset(AppImagePaths.whatsappIcon,
                            height: height(16))
                        : SizedBox(),
                    Gap(isWhatsappIcon == true ? 10 : 0),
                    Text(title, style: Styles.bodyMedium),
                  ],
                ),
                const Gap(5),
                Container(
                    width: Dimensions.screenWidth * .6,
                    child: Text(description, style: Styles.bodySmall2)),
              ],
            ),
            Spacer(),
            AppSwitch(value: switchValue, onChanged: onSwitchChanged),
          ],
        ),
      ),
    );
  }
}

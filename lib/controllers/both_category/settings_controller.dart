import 'dart:convert';
import 'package:bringin/Http/get.dart';
import 'package:bringin/Screens/candidate_section/edit_main_profile/candidate_Edit_MainProfile_Screen.dart';
import 'package:bringin/Screens/recruiter_section/recruiter_edit_profile/recruiter_Edit_MainProfile_Screen.dart';
import 'package:bringin/controllers/ChatController/chatcontroll.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../Hive/hive.dart';
import '../../Hive/hive_collection_var.dart';
import '../../Screens/candidate_section/bottom_nav/bottom_nav_layout.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/app_constants.dart';
import '../../res/constants/image_path.dart';
import '../../res/dimensions.dart';
import '../../utils/services/keys.dart';
import '../../widgets/app_button.dart';
import '../candidate_section/candidate_main_profile_controller.dart';
import '../recruiter_section/recruiter_edit_main_profile_controller.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  CandidateMainProfileController candidateEditMainProfileController =
      Get.find<CandidateMainProfileController>();
  RecruiterEditMainProfileController recruiterProfileController =
      Get.find<RecruiterEditMainProfileController>();
  ChatControll chatControll = Get.put(ChatControll());
  RxBool isLoading = false.obs;
  Future<void> switchAccout({int? isRecruiter}) async {
    isLoading.value = true;
    await Httphelp.post(
        ENDPOINT_URL: AppConstants.switchAccountUrl,
        fields: {"isrecruiter": isRecruiter}).then((response) async {
      if (response.statusCode == 200) {
        isLoading.value = false;
        if (isRecruiter == 0) {
          print("seeker to recruiter");
          // HiveHelp.remove(Keys.isCandidateProfileBasicCompleted);
          // HiveHelp.remove(Keys.isCandidateJobPrefCompleted);
          // HiveHelp.remove(Keys.isRecruiterProfileBasicCompleted);
          // HiveHelp.remove(Keys.isRecruiterCompanyDocVerified);

          // Get.offAll(CandidateEditMainProfileScreen(loginhome: true));
          await chatControll.userinactive();
          print("seeker offline");
          HiveHelp.write(Keys.isRecruiter, true);

          HiveHelp.write(
              Keys.authToken, jsonDecode(response.body)['token'].toString());
          // chatControll.streamclose();
          chatControll.socket.disconnect();
          Future.delayed(Duration(milliseconds: 300), () {
            Get.offAll(
                () => RecruiterEditMainProfileScreen(isSwitchBack: true));
          });
        } else {
          print("recruiter to seeker");
          await chatControll.userinactive();
          print("recruiter offline");
          HiveHelp.write(Keys.isRecruiter, false);
          var data = jsonDecode(response.body);
          // chatControll.streamclose();
          chatControll.socket.disconnect();
          HiveHelp.write(
              Keys.authToken, jsonDecode(response.body)['token'].toString());

          if (data['seekerprofile'] == false) {
            HiveHelp.write(Keys.isCandidateProfileBasicCompleted, false);
            Get.offAll(() => CandidateEditMainProfileScreen(
                isSwitchBack: true, loginhome: true));
          } else if (data['carearpre'] == 0) {
            HiveHelp.write(Keys.isCandidateProfileBasicCompleted, true);
            HiveHelp.write(Keys.isCandidateJobPrefCompleted, false);
            Get.offAllNamed(RouteHelper.getCandidateCareerPrefRoute());
          } else {
            HiveHelp.write(Keys.isCandidateProfileBasicCompleted, true);
            HiveHelp.write(Keys.isCandidateJobPrefCompleted, true);
            Future.delayed(Duration(milliseconds: 300), () {
              Get.offAllNamed(RouteHelper.getBottomNavRoute());
            });
          }

          // Get.to(() => CandidateEditMainProfileScreen(loginhome: true));
        }

        Helpers().showToastMessage(msg: jsonDecode(response.body)['message']);
      } else {
        isLoading.value = false;
        Helpers().showToastMessage(msg: jsonDecode(response.body)['message']);
        print("failed: " + response.body);
        print("failed: " + response.statusCode.toString());
      }
    });
  }

  RxBool isPressed = false.obs;
  Future<void> notification({Map<String, dynamic>? fields}) async {
    isLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.notificationUrl, fields: fields)
        .then((response) {
      if (response.statusCode == 200) {
        if (HiveHelp.read(Keys.isRecruiter) == true) {
          recruiterProfileController.getRecruiterProfileInfoList();
        } else {
          candidateEditMainProfileController.getCandidateInfo();
        }
        isLoading.value = false;
        isPressed.value = true;
        print("succ" + response.body);
      } else {
        isLoading.value = false;
        print("failed: " + response.body);
        print("failed: " + response.statusCode.toString());
      }
    });
  }

  var deleteAccountEditingController = TextEditingController();
  var val = "".obs;

  AlertDialog alert = AlertDialog(
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius(10))),
    actions: [
      Padding(
          padding:
              EdgeInsets.symmetric(vertical: height(30), horizontal: width(33)),
          child: Column(
            children: [
              Image.asset(
                AppImagePaths.deleteIcon3,
                width: height(57),
                height: height(57),
              ),
              const Gap(15),
              Text(
                'Confirm Deletion',
                style: Styles.smallTitle,
              ),
              const Gap(15),
              Text(
               HiveHelp.read(Keys.isRecruiter)
               ? 'By proceeding, you will lose access to all of your entire data and active subscriptions. \nThis action cannot be undone!'
               : 'Delete your account will remove all of your entire personal data. This action cannot be undone!',
                textAlign: TextAlign.center,
                style: Styles.bodyMedium2,
              ),
              const Gap(15),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: "Delete",
                      textColor: AppColors.whiteColor,
                      bgColor: AppColors.newBtnColor,
                      onTap: () async {
                        if (HiveHelp.read(Keys.isRecruiter) == true) {
                          if (RecruiterEditMainProfileController
                              .to.recruiterProfileInfoList.isNotEmpty) {
                            await Httphelp.delete(
                                    ENDPOINT_URL: AppConstants
                                            .deleteRecruiterAccountUrl +
                                        "?id=${RecruiterEditMainProfileController.to.recruiterProfileInfoList[0].sId}")
                                .then((value) {
                              if (value.statusCode == 200) {
                                Get.back();
                                Get.offAllNamed(
                                    RouteHelper.getLoginSelectRoute());
                                HiveHelp.cleanall();
                                recentBox2.clear();
                                refreshBottomNavIndex();
                                return Get.defaultDialog(
                                  title: "",
                                  content: Container(
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(radius(10)),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            AppImagePaths.successfully_done,
                                          ),
                                          const Gap(25),
                                          Text(
                                            'Successfully Deleted',
                                            style: Styles.bodyLargeSemiBold,
                                          ),
                                        ],
                                      )),
                                );
                              } else {
                                Helpers().showToastMessage(
                                    msg: "Something went wrong");
                              }
                            });
                          }
                        } else if (HiveHelp.read(Keys.isRecruiter) == false) {
                          if (CandidateMainProfileController
                              .to.candidateProfileList.isNotEmpty) {
                            await Httphelp.delete(
                                    ENDPOINT_URL: AppConstants
                                            .deleteSeekerAccountUrl +
                                        "?id=${CandidateMainProfileController.to.candidateProfileList[0].id}")
                                .then((value) {
                              if (value.statusCode == 200) {
                                Get.back();
                                Get.offAllNamed(
                                    RouteHelper.getLoginSelectRoute());
                                HiveHelp.cleanall();
                                recentBox.clear();
                                refreshBottomNavIndex();
                                return Get.defaultDialog(
                                  title: "",
                                  content: Container(
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(radius(10)),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            AppImagePaths.successfully_done,
                                          ),
                                          const Gap(25),
                                          Text(
                                            'Successfully Deleted',
                                            style: Styles.bodyLargeSemiBold,
                                          ),
                                        ],
                                      )),
                                );
                              } else {
                                Helpers().showToastMessage(
                                    msg: "Something went wrong");
                              }
                            });
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Gap(15),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: "Cancel",
                      bgColor: AppColors.greyColor,
                      onTap: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ],
          )),
    ],
  );
  dialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

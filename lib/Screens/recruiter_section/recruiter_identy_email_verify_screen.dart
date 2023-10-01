import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../../controllers/recruiter_section/recruiter_identy_verify_controller.dart';
import '../../../../../../res/app_font.dart';
import '../../../../../../res/constants/strings.dart';
import '../../../../../../res/dimensions.dart';
import '../../../../../../widgets/app_bar.dart';
import '../../../../../../widgets/app_bottom_nav_widget.dart';
import '../../../../../../widgets/app_search_widget.dart';
import '../../Hive/hive.dart';
import '../../res/constants/image_path.dart';
import '../../utils/routes/route_helper.dart';
import '../../utils/services/keys.dart';

class RecruiterIdentyEmailVerifyScreen extends StatelessWidget {
  const RecruiterIdentyEmailVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RecruiterIdentyVerifyController controller = Get.find();
    return GestureDetector(
      onTap: () => Helpers.hideKeyboard(),
      child: Scaffold(
        appBar: appBarWidget(
            title: "", onBackPressed: () => Get.back(), actions: []),
        body: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDefaultgapTop,

               Text("Verify With Work Email", style: Styles.smallTitle),
                const Gap(3),
                Text(
                  AppStrings.recruiterIdentyEmailVerifyDes,
                  style: Styles.bodyMedium2,
                ),
              const Gap(15),

              /// verification text field
              GetBuilder<RecruiterIdentyVerifyController>(
                builder: (_){
                  var isValidated = (controller.emailTextEditingCtrlr.text.contains("@") && 
                    controller.emailTextEditingCtrlr.text.split(".").length - 1 >= 1) && !(
                      controller.emailTextEditingCtrlr.text
                              .contains("gmail") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("yahoo") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("icloud") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("outlook") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("zoho") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("trashmail") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("gmx") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("lycos") || 
                          controller.emailTextEditingCtrlr.text
                              .contains("tutanota") || 
                          controller.emailTextEditingCtrlr.text
                              .contains("protonmail") || 
                          controller.emailTextEditingCtrlr.text
                              .contains("mail") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("safe-mail") || 
                          controller.emailTextEditingCtrlr.text
                              .contains("hushmail") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("fastmail") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("1and1") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("aol") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("reckspace") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("yandex") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("mailfence") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("posteo") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("soverin") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("disroot") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("startmail"));
                        // Check for minimum 2 characters after "@" and before the last dot "."
                        if (isValidated) {
                          var emailParts = controller.emailTextEditingCtrlr.text.split("@");
                          if (emailParts.length == 2) {
                            var domainPart = emailParts[1];
                            var domainPartsBeforeDot = domainPart.split(".");
                            if (domainPartsBeforeDot.length >= 2) {
                              var firstPartBeforeDot = domainPartsBeforeDot[0];
                              if (firstPartBeforeDot.length >= 2) {
                                isValidated = true;
                              } else {
                                isValidated = false;
                              }
                            } else {
                              isValidated = false;
                            }
                          } else {
                            isValidated = false;
                          }
                        }

                        // Check for minimum 2 characters after the last dot "."
                        if (isValidated) {
                          var lastDotIndex = controller.emailTextEditingCtrlr.text.lastIndexOf(".");
                          if (
                            controller.emailTextEditingCtrlr.text.length - lastDotIndex - 1 < 2
                          ) {
                            isValidated = false;
                          }
                        }
                  return AppSearchWidget(
                    controller: controller.emailTextEditingCtrlr,
                    hinText: "Enter your work email",
                    child: controller.emailTextEditingCtrlr.text.isNotEmpty
                    ? isValidated 
                    ? SvgPicture.asset(AppImagePaths.validated,height: height(14),width: height(14),) 
                    : IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          controller.emailTextEditingCtrlr.clear();
                        },
                        icon: SvgPicture.asset(AppImagePaths.close_icon),
                      ) 
                    : SizedBox(),
                  );
                }
              ),
              const Gap(20),
            ],
          ),
        ),
        bottomNavigationBar: GetBuilder<RecruiterIdentyVerifyController>(builder: (_){
          var isValidated = (controller.emailTextEditingCtrlr.text.contains("@") && 
                    controller.emailTextEditingCtrlr.text.split(".").length - 1 >= 1) && !(
                      controller.emailTextEditingCtrlr.text
                              .contains("gmail") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("yahoo") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("icloud") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("outlook") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("zoho") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("trashmail") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("gmx") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("lycos") || 
                          controller.emailTextEditingCtrlr.text
                              .contains("tutanota") || 
                          controller.emailTextEditingCtrlr.text
                              .contains("protonmail") || 
                          controller.emailTextEditingCtrlr.text
                              .contains("mail") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("safe-mail") || 
                          controller.emailTextEditingCtrlr.text
                              .contains("hushmail") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("fastmail") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("1and1") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("aol") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("reckspace") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("yandex") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("mailfence") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("posteo") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("soverin") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("disroot") ||
                          controller.emailTextEditingCtrlr.text
                              .contains("startmail"));
          return Obx(
          () {
                 
            return BottomNavWidget(
              text: controller.isLoading.value ? "Processing..." : "Submit",
              onTap: controller.isLoading.value
                  ? null
                  : () async{
                      if (controller.emailTextEditingCtrlr.text.isEmpty) {
                        Helpers().showValidationErrorDialog();
                      } 
                      if(isValidated == false){
                        Helpers().showValidationErrorDialog(
                          title: "Authorization Request!",
                          errorText: "To proceed with the verification process, kindly use your company email. Please note that free email addresses are not accepted.",
                        );
                      }
                      
                        // Check for minimum 2 characters after "@" and before the last dot "."
                        if (isValidated) {
                          var emailParts = controller.emailTextEditingCtrlr.text.split("@");
                          if (emailParts.length == 2) {
                            var domainPart = emailParts[1];
                            var domainPartsBeforeDot = domainPart.split(".");
                            if (domainPartsBeforeDot.length >= 2) {
                              var firstPartBeforeDot = domainPartsBeforeDot[0];
                              if (firstPartBeforeDot.length >= 2) {
                                isValidated = true;
                              } else {
                                isValidated = false;
                                Helpers().showValidationErrorDialog(
                                title: "Authorization Request",
                                errorText: "To proceed with the verification process, kindly use your company email. Please note that free email addresses are not accepted.",
                              );
                              }
                            } else {
                              isValidated = false;
                              Helpers().showValidationErrorDialog(
                                title: "Authorization Request",
                                errorText: "To proceed with the verification process, kindly use your company email. Please note that free email addresses are not accepted.",
                              );
                            }
                          } else {
                            isValidated = false;
                            Helpers().showValidationErrorDialog(
                              title: "Authorization Request",
                              errorText: "To proceed with the verification process, kindly use your company email. Please note that free email addresses are not accepted.",
                            );
                          }
                        }

                        // Check for minimum 2 characters after the last dot "."
                        if (isValidated) {
                          var lastDotIndex = controller.emailTextEditingCtrlr.text.lastIndexOf(".");
                          if (
                            controller.emailTextEditingCtrlr.text.length - lastDotIndex - 1 < 2
                          ) {
                            isValidated = false;
                            Helpers().showValidationErrorDialog(
                              title: "Authorization Request",
                              errorText: "To proceed with the verification process, kindly use your company email. Please note that free email addresses are not accepted.",
                            );
                          }
                        }
                       if(isValidated == true) {
                        print(HiveHelp.read(Keys.authToken));
                        await controller.postEmailAndLinkEdin(data: {
                          "type": "1",
                          "email": controller.emailTextEditingCtrlr.text.trim(),
                        });
                        HiveHelp.write(Keys.recruiterEmail, controller.emailTextEditingCtrlr.text.trim());
                        controller.isBack.value ? Get.toNamed(
                          RouteHelper.getUnderVerificationRoute(),
                          arguments: ["email", true],
                        ):null; 
                      }
                    });
                });
        }),
      ),
    );
  }
}

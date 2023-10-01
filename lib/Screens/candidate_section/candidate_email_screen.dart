import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../controllers/candidate_section/candidate_email_edit_controller.dart';
import '../../../../../res/color.dart';
import '../../../../../res/dimensions.dart';
import '../../../../../utils/services/helpers.dart';
import '../../res/app_font.dart';


class CandidateEmailScreen extends GetView<CandidateEmailEditController> {
  const CandidateEmailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        onSavedPressed: () {
          if(controller.emailEditingCtrlr.text.isEmpty){
            Helpers().showValidationErrorDialog();
          }else if (!(controller.emailEditingCtrlr.text.contains("@") &&
           controller.emailEditingCtrlr.text.contains(".com") || 
           controller.emailEditingCtrlr.text.contains(".io"))) {
            print("please enter valid email format");
              Helpers().showValidationErrorDialog(
                errorText: "Please enter a valid email format",
                durationTime: 4,
              );
            }else{
            controller.postEmail(
              data:{
                "email" : controller.emailEditingCtrlr.text.trim(),
              }
            );
          }
        },
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kDefaultgapTop,
            Text("Email",style: Styles.smallTitle),
            const Gap(5),

            /// textfield
            Container(
             height: height(40),
              padding: EdgeInsets.symmetric(horizontal: width(14)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius(6)),
                border: Border.all(
                  color: AppColors.appBorder,
                  width: .5,
                ),
              ),
              child: AppTextField(
                maxLen: 40,
                inputTextWeight: FontWeight.w400,
                controller: controller.emailEditingCtrlr,
                hinText: "e.g. example@bringin.io",
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                 return controller.isLoading.value
                 ?Helpers.appLoader2():SizedBox();
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}

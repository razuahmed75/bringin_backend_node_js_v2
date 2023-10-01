import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../controllers/candidate_section/candidate_phone_edit_controller.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/dimensions.dart';
import '../../../../../utils/services/helpers.dart';
import '../../res/color.dart';
import '../../widgets/app_text_field.dart';

class CandidatePhoneNumberScreen extends GetView<CandidatePhoneEditController> {
  const CandidatePhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CandidatePhoneEditController candidatePostPhoneController = Get.find();
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        onSavedPressed: () async{
          if (controller.phoneEditingCtrlr.text.isEmpty) {
            Helpers().showValidationErrorDialog();
          } else if (controller.phoneEditingCtrlr.text.length < 10) {
            print("phone number should be at least in 10 chars");
            Helpers().showValidationErrorDialog(
              errorText: "Phone number should be at least within 10 characters",
              durationTime: 4,
            );
          } else {
            await candidatePostPhoneController.postPhone(data: {
              "number": "0" + "${controller.phoneEditingCtrlr.text.trim()}"
            });
            controller.phoneEditingCtrlr.clear();
            controller.phoneEditingCtrlr.text = "";
          }
        },
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kDefaultgapTop,
            Text("Phone Number", style: Styles.smallTitle),
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
                inputTextWeight: FontWeight.w400,
                controller: controller.phoneEditingCtrlr,
                hinText: "e.g. 01756748675",
                keyboardType: TextInputType.phone,
                inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),
                    FilteringTextInputFormatter.deny(
                      RegExp(r'^0+'),
                    ),
                    ////users can't type 0 at 1st position
                  ],
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return controller.isLoading.value
                      ? Helpers.appLoader2()
                      : SizedBox();
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}

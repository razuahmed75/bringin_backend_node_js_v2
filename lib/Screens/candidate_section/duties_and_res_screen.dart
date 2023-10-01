import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/custom_expand_text_field.dart';
import 'package:bringin/widgets/formfield_length_checker.dart';
import '../../controllers/candidate_section/duties_and_responsibility_controller.dart';
import '../../res/app_font.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';

class DutiesAndResponsibilitesScreen extends StatelessWidget {
  const DutiesAndResponsibilitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DutiesAndResponsibilitiesController controller = Get.find();
    return GestureDetector(
      onTap: ()=>Helpers.hideKeyboard(),
      child: Scaffold(
        appBar: appBarWidget(
          title: "",
          onBackPressed: () => Get.back(),
          onSavedPressed: () {
            if (controller.textFieldCtrlr.text.isEmpty) {
              Helpers().showValidationErrorDialog();
            } else if (controller.textFieldCtrlr.text.length < 74) {
              Helpers().showValidationErrorDialog(
                errorText:
                    "Your duties and responsibility should be at least 75 characters",
                durationTime: 4,
              );
            } else {
              controller.selectedResponsibilities.value =
                  controller.textFieldCtrlr.text.trim();
              Get.back();
            }
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: Dimensions.kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                 /// DUTIES AND RESPONSIBILITES TITLE
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: height(9)),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text("Duties & Responsibilities ",style: Styles.smallTitle),
                      const  Gap(4),
                      Text(
                        "Write down your duties & responsibilities in your previous job.",
                        textAlign: TextAlign.center,
                      style: Styles.bodyMedium2),
                    ],
                  ),
                ),
                const Gap(5),
            
                /// form section
                CustomExpandTextField(
                  controller: controller.textFieldCtrlr,
                  maxLength: 4000,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  hinText: """
e.g.
1.Analyse data & user feedback to plan\nproduct roadmap.
2.Reduced registration drop rate by 10%.
3.Overall team performance index\nincreased by 50% in a year.
                """,
                  onChanged: (value) {
                    controller.characterLength.value = value.length;
                  },
                ),
            
                /// field length checker
                Obx(
                  () => FormFieldLengthChecker(
                      characterLength: controller.characterLength.value,
                      maxLength: 4000),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

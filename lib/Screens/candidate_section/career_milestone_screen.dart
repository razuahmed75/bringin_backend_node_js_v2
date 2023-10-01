import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/custom_expand_text_field.dart';
import '../../controllers/candidate_section/career_milestone_controller.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/formfield_length_checker.dart';

class CareerMileStoneScreen extends StatelessWidget {
  const CareerMileStoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CareerMileStoneController careerMileStoneController = Get.find();
    return Scaffold(
      appBar: appBarWidget(
        title: "Career Milestone",
        onBackPressed: () => Get.back(),
        onSavedPressed: () {
          if (careerMileStoneController
              .textFieldCtrlr.text.isEmpty) {
            Helpers().showValidationErrorDialog();
          } else {
            careerMileStoneController.selectedAccomplishment.value = 
              careerMileStoneController.textFieldCtrlr.text.trim();
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
              // Dimensions.kDefaultgapTop,
      
              // /// Career Milestone TITLE
              // Container(
              //   width: double.maxFinite,
              //   height: height(52),
              //   alignment: Alignment.center,
              //   decoration: Dimensions.kDecoration,
              //   child: Text("Career Milestone",style: Styles.smallTitle),
              // ),
              // const Gap(5),
      
              /// form section
              CustomExpandTextField(
                onChanged: (value) {
                    careerMileStoneController.characterLength.value = value.length;
                  },
                maxLength: 4000,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: careerMileStoneController.textFieldCtrlr, 
                hinText: """
      My greatest achievement' examples could\n     include:
      • Giving a great presentation at work.
      • Beating sales targets.
      • Training for and completing a marathon.
      • Organizing a successful charity event.
      • Mentoring a coworker or fellow student.
                """),
      
                /// field length checker
                Obx(
                  () => FormFieldLengthChecker(
                      characterLength: careerMileStoneController.characterLength.value,
                      maxLength: 4000),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

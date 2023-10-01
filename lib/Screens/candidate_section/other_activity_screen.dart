import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controllers/candidate_section/other_activities_controller.dart';
import '../../res/app_font.dart';
import 'package:bringin/widgets/custom_expand_text_field.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/formfield_length_checker.dart';

class OtherActivityScreen extends StatelessWidget {
  const OtherActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OtherActivitiesController otherActivitiesController = Get.find();
    return Scaffold(
      appBar: appBarWidget(
          title: "",
          onBackPressed: () => Get.back(),
          onSavedPressed: () {
            if (otherActivitiesController.textFieldCtrlr.text.isEmpty) {
              Helpers().showValidationErrorDialog();
            } else {
              otherActivitiesController.selectedActivitiesValue.value =
                  otherActivitiesController.textFieldCtrlr.text.trim();
              Get.back();
            }
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Other Activities (Optional) TITLE
              Container(
                width: double.maxFinite,
                height: height(52),
                alignment: Alignment.center,
                child: Text("Other Activities (Optional)",style: Styles.smallTitle),
              ),
              const Gap(5),
      
              /// form section
              CustomExpandTextField(
                onChanged: (val){
                  otherActivitiesController.characterLength.value = val.length;
                },
                maxLength: 4000,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: otherActivitiesController.textFieldCtrlr, 
                hinText: """
e.g.
1.English debate class president
in Kazi azim uddin collage from January\n2012 to December 2013
2.Volunteering in rohingya camp during\nthe corona panadomic.
3.Member of LEO club.Which works for\nrural poor people.
              """),
               /// field length checker
                Obx(
                  () => FormFieldLengthChecker(
                      characterLength: otherActivitiesController.characterLength.value,
                      maxLength: 4000),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

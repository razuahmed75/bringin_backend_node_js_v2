import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/app_text_field.dart';
import 'package:bringin/widgets/formfield_length_checker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../controllers/candidate_section/candidate_lname_controller.dart';
import '../../../../../res/color.dart';
import '../../../../../res/dimensions.dart';
import '../../../../../utils/services/helpers.dart';
import '../../res/app_font.dart';


class CandidateLastNameScreen extends StatelessWidget {
  const CandidateLastNameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CandidateLNameController candidateLNameController = Get.find();
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        onSavedPressed: () {
          if(candidateLNameController.lNameEditingCtrlr.text.isEmpty){
            Helpers().showValidationErrorDialog();
          }else{
            candidateLNameController.postLastName(
              fields:{
                "lastname" : "${candidateLNameController.lNameEditingCtrlr.text.trim()}",
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
            Text("Last Name",style: Styles.smallTitle),
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
                controller: candidateLNameController.lNameEditingCtrlr,
                hinText: "e.g. Hosen",
              ),
            ),
            /// length counter
           
             GetBuilder<CandidateLNameController>(builder: (_){
              return  FormFieldLengthChecker(
                characterLength: candidateLNameController.lNameEditingCtrlr.text.length, maxLength: 20,
              );
             }),
            
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                 return candidateLNameController.isLoading.value
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

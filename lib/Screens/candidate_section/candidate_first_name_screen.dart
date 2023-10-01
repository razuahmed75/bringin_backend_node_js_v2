
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/app_text_field.dart';
import 'package:bringin/widgets/formfield_length_checker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../controllers/candidate_section/candidate_fname_controller.dart';
import '../../../../../res/color.dart';
import '../../../../../res/dimensions.dart';
import '../../res/app_font.dart';


class CandidateFirstNameScreen extends StatelessWidget {
  const CandidateFirstNameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CandidateFNameController candidateFNameController = Get.find();
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        onSavedPressed: () {
          if(candidateFNameController.fNameEditingCtrlr.text.isEmpty){
            Helpers().showValidationErrorDialog();
          }else{
            candidateFNameController.postPhone(
              fields:{
                "fastname" : "${candidateFNameController.fNameEditingCtrlr.text.trim()}",
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
            Text("First Name",style: Styles.smallTitle),
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
                controller: candidateFNameController.fNameEditingCtrlr,
                hinText: "e.g. Rony",
              ),
            ),
            /// length counter
              GetBuilder<CandidateFNameController>(builder: (_){
                return 
                FormFieldLengthChecker(
                 characterLength: candidateFNameController.fNameEditingCtrlr.text.length, maxLength: 20,
                );
              }),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                 return candidateFNameController.isLoading.value
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

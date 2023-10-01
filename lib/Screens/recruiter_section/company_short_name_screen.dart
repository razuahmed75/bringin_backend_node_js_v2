
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../res/color.dart';
import '../../../../../res/dimensions.dart';
import '../../controllers/recruiter_section/company_registration_controller.dart';
import '../../res/app_font.dart';


class CompanyShortNameScreen extends StatelessWidget {
  const CompanyShortNameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CompanyRegistrationController companyRegistrationController =
        Get.find<CompanyRegistrationController>();
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        onSavedPressed: () {
          if(companyRegistrationController.companyShortnameEditingCtrlr.text.isEmpty){
            Helpers().showValidationErrorDialog();
          }else{
            companyRegistrationController.selectedCShortName.value = companyRegistrationController.companyShortnameEditingCtrlr.text.trim();
            Get.back();
        }
        },
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kDefaultgapTop,
            Text("Short Name of Company",style: Styles.smallTitle),
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
                controller: companyRegistrationController.companyShortnameEditingCtrlr,
                hinText: "e.g. Bringin",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

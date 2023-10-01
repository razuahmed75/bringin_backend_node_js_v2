// ignore_for_file: must_be_immutable

import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_search_widget.dart';
import '../../../../res/dimensions.dart';
import '../../controllers/recruiter_section/company_registration_controller.dart';
import '../../res/app_font.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/formfield_length_checker.dart';

class RecruiterCompanyAddressScreen extends StatelessWidget {
  const RecruiterCompanyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyRegistrationController companyRegistrationController =
        Get.find<CompanyRegistrationController>();
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        onSavedPressed: () {
          if (companyRegistrationController
              .companyAddrEditinCtrlr.text.isEmpty) {
            Helpers().showValidationErrorDialog();
          } else {
            /// @ TO DO
            companyRegistrationController.selectedOptionLocation.value =
                companyRegistrationController.companyAddrEditinCtrlr.text
                    .trim();
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
            Text(
              "Company Address (Optional)",
              style: Styles.smallTitle,
            ),
            const Gap(10),
            AppSearchWidget(
              controller: companyRegistrationController.companyAddrEditinCtrlr,
              hinText: "House, Road Apt or Suit etc.",
              maxLen: 100,
              child: SizedBox(),
              onChanged: (value) {
                companyRegistrationController.characterLength.value =
                    value.length;
              },
            ),
            Obx(
              () => FormFieldLengthChecker(
                characterLength:
                    companyRegistrationController.characterLength.value,
                maxLength: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

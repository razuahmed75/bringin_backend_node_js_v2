// ignore_for_file: must_be_immutable

import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_search_widget.dart';
import '../../../../res/dimensions.dart';
import '../../controllers/recruiter_section/company_registration_controller.dart';
import '../../res/app_font.dart';
import '../../res/constants/image_path.dart';
import '../../utils/services/helpers.dart';

class RecruiterCompanyWebsiteScreen extends StatelessWidget {
  const RecruiterCompanyWebsiteScreen({super.key});

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
              .companyWebEditinCtrlr.text.isEmpty) {
            Helpers().showToastMessage(msg: "Company Website is Required",gravity: ToastGravity.CENTER);
          } else if (!((companyRegistrationController.companyInputText.value
                      .startsWith("www.") ||
                  companyRegistrationController.companyInputText
                      .contains("www.") ||
                  companyRegistrationController.companyInputText.value
                      .startsWith("http://") ||
                  companyRegistrationController.companyInputText.value
                      .startsWith("https://")) &&
              (companyRegistrationController.companyInputText
                          .split('.')
                          .length -
                      1) >=
                  2 &&
              companyRegistrationController.companyInputText.value.length -
                      companyRegistrationController.companyInputText.value
                          .lastIndexOf(".") -
                      1 >=
                  2)) {
            Helpers().showValidationErrorDialog(
              errorText: "Please enter a valid web address",
              durationTime: 4,
            );
          } else {
            /// @ TO DO
            companyRegistrationController.selectedCompanyWebsiteVal.value =
                companyRegistrationController.companyWebEditinCtrlr.text.trim();
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
              "Company Website",
              style: Styles.smallTitle,
            ),
            const Gap(10),
            Obx(() {
              var lastDotIndex = companyRegistrationController
                  .companyInputText.value
                  .lastIndexOf(".");
              bool validateInput = (companyRegistrationController
                          .companyInputText
                          .startsWith("www.") ||
                      companyRegistrationController.companyInputText
                          .contains("www.") ||
                      companyRegistrationController.companyInputText
                          .startsWith("http://") ||
                      companyRegistrationController.companyInputText
                          .startsWith("https://")) &&
                  (companyRegistrationController.companyInputText
                              .split('.')
                              .length -
                          1) >=
                      2 && // check for at least 2 dots or not
                  companyRegistrationController.companyInputText.value.length -
                          lastDotIndex -
                          1 >=
                      2; // check for at least 2 characters after dot
              return AppSearchWidget(
                controller: companyRegistrationController.companyWebEditinCtrlr,
                hinText: "https://bringin.io",
                child: companyRegistrationController
                            .companyInputText.value.length <
                        1
                    ? SizedBox.shrink()
                    : validateInput
                        ? SvgPicture.asset(
                            AppImagePaths.validated,
                            height: height(14),
                            width: height(14),
                          )
                        : InkResponse(
                            onTap: () {
                              companyRegistrationController
                                  .companyWebEditinCtrlr
                                  .clear();
                              companyRegistrationController
                                  .companyInputText.value = "";
                            },
                            child: SvgPicture.asset(
                              AppImagePaths.close_icon,
                              height: height(16),
                            ),
                          ),
                onChanged: (value) {
                  companyRegistrationController.companyInputText.value = value;
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

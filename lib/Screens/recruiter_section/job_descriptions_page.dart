import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../../controllers/recruiter_section/recruiter_job_post_controller.dart';
import '../../../../../../res/app_font.dart';
import '../../../../../../res/constants/strings.dart';
import '../../../../../../res/dimensions.dart';
import '../../../../../../widgets/app_bar.dart';
import '../../res/color.dart';


class JobDescriptionScreen extends StatelessWidget {
  JobDescriptionScreen({super.key});

  TextEditingController des = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RecruiterJobPostController recruiterJobPostController =
        Get.find<RecruiterJobPostController>();
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        onSavedPressed: () {
          if (recruiterJobPostController.textFieldController.text.isEmpty) {
            Helpers().showValidationErrorDialog();
          } else if (recruiterJobPostController
                  .textFieldController.text.length <
              50) {
            Helpers().showValidationErrorDialog(
              errorText: "Please enter at least 50 characters",
            );
          } else {
            // print(
            //     "sdvbsdv ${recruiterJobPostController.textFieldController.text.trim()}");
            // recruiterJobPostController.selectedJobDescriptionVal.value =
            //     recruiterJobPostController.textFieldController.text.trim();

            // String result = recruiterJobPostController
            //     .selectedJobDescriptionVal.value
            //     .replaceAll(new RegExp(r'[^0-9]'), "");

            // final newString = recruiterJobPostController
            //     .selectedJobDescriptionVal.value
            //     .replaceAllMapped(RegExp(r'[^0-9]'), (match) {
            //   return '"${match.group(0)}"';
            // });
            // print(newString);

            // var regex = RegExp(r'[0-9]');
            var regex = RegExp(r'(?:\+88||01)?(?:\d{10}|\d{13})$', multiLine: true);
            // final RegExp emailValidatorRegExp =
            //     RegExp(r"^[a-zA-Z0-9]+@", multiLine: true);
            final RegExp emailValidatorRegExp =
                RegExp(r"^[a-zA-Z0-9]+@", multiLine: true);
            // var replaced = recruiterJobPostController.textFieldController.text
            //     .replaceAll(emailValidatorRegExp, '*********');
            // var data2 = replaced.replaceAll(regex, '*');
            var filter1 = recruiterJobPostController.textFieldController.text
                .replaceAll(regex, "***");
            var filter2 = filter1.replaceAll(emailValidatorRegExp, "*");
            recruiterJobPostController.selectedJobDescriptionVal.value =
                filter2;
            print("sdhbjshdvbs ${filter2}");
            // recruiterJobPostController.textFieldController.clear();

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
      
              Text("Job Descriptions", style: Styles.smallTitle),
              const Gap(3),
              Text(AppStrings.jobDescriptionSubTitle, style: Styles.subTitle),
      
              SizedBox(height: 10.h),
      
              /// textfield
              Container(
                width: double.maxFinite,
                constraints: BoxConstraints(
                  minHeight: height(150),
                  maxHeight: height(500),
                ),
                padding: EdgeInsets.only(
                  left: width(4),
                  right: width(4),
                ),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: recruiterJobPostController.textFieldController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: AppColors.hintColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF828282).withOpacity(0.25))),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF828282).withOpacity(0.25))),
                    hintText: """
1. Company Introduction
2. Job Type, Location
3. Responsibilities
4. Candidate Requirements
              """,
                  ),
                ),
              )
      //             CustomExpandTextField(
      //                 controller: recruiterJobPostController.textFieldController,
      //                 hinText: """
      // 1. Company Introduction
      // 2. Job Type, Location
      // 3. Responsibilities
      // 4. Candidate Requirements
      // """),
            ],
          ),
        ),
      ),
    );
  }
}

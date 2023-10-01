import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/app_text_field.dart';
import 'package:bringin/widgets/formfield_length_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../res/color.dart';
import '../../res/dimensions.dart';
import '../../utils/routes/route_helper.dart';

class EditProfileInfoScreen extends StatefulWidget {
  const EditProfileInfoScreen({super.key});

  @override
  State<EditProfileInfoScreen> createState() => _EditProfileInfoScreenState();
}

class _EditProfileInfoScreenState extends State<EditProfileInfoScreen> {
  RecruiterEditMainProfileController recruiterProfileInfoController =
      Get.find<RecruiterEditMainProfileController>();
  // @override
  // void initState() {
  //   SchedulerBinding.instance.addPostFrameCallback((_) {
  //     if(recruiterProfileInfoController.recruiterProfileInfoList.isNotEmpty){
  //         recruiterProfileInfoController.fNameController.value.text = recruiterProfileInfoController.recruiterProfileInfoList[0].firstname!;
  //         recruiterProfileInfoController.lNameController.value.text = recruiterProfileInfoController.recruiterProfileInfoList[0].last_name!;
  //         recruiterProfileInfoController.designationController.value.text = recruiterProfileInfoController.recruiterProfileInfoList[0].designation!;
  //         recruiterProfileInfoController.emailController.value.text = recruiterProfileInfoController.recruiterProfileInfoList[0].email!;
  //       }
  //     });
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        onSavedPressed: () {
          if (data["controller"].text.isEmpty) {
            Helpers().showValidationErrorDialog();
          } else if (data["controller"] ==
              recruiterProfileInfoController.emailController.value) {
            if (!(recruiterProfileInfoController.emailController.value.text
                .contains("@"))) {
              Helpers().showValidationErrorDialog(
                  errorText:
                      "Email address should be included as (@) format");
            } else {
              Get.toNamed(RouteHelper.getRecruiterEditMainProfileRoute());
              recruiterProfileInfoController.selectedEmail.value =
                  recruiterProfileInfoController.emailController.value.text
                      .trim();
            }
          } else {
            recruiterProfileInfoController.selectedFName.value =
                recruiterProfileInfoController.fNameController.value.text
                    .trim();
            recruiterProfileInfoController.selectedLName.value =
                recruiterProfileInfoController.lNameController.value.text
                    .trim();
            recruiterProfileInfoController.selectedDesignation.value =
                recruiterProfileInfoController.designationController.value.text
                    .trim();
            print("first name :" +
                recruiterProfileInfoController.selectedFName.value);
            print("lst name :" +
                recruiterProfileInfoController.selectedLName.value);
            print("designation :" +
                recruiterProfileInfoController.selectedDesignation.value);
            print(
                "email :" + recruiterProfileInfoController.selectedEmail.value);
            Get.toNamed(RouteHelper.getRecruiterEditMainProfileRoute());
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
             data == null ? "" : data["title"] ?? "Empty",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            const Gap(10),

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
                maxLen: data["controller"] == recruiterProfileInfoController.emailController.value ? 40:20,
                inputTextWeight: FontWeight.w400,
                controller: data == null ? TextEditingController() : data["controller"],
                hinText: data == null ? "" : data["hinText"] ?? "empty",
              ),
            ),

            /// length counter

            GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
              if (data["controller"] ==
                  recruiterProfileInfoController.fNameController.value) {
                return FormFieldLengthChecker(
                  characterLength: recruiterProfileInfoController
                      .fNameController.value.text.length,
                  maxLength: 20,
                );
              } else if (data["controller"] ==
                  recruiterProfileInfoController.lNameController.value) {
                return FormFieldLengthChecker(
                  characterLength: recruiterProfileInfoController
                      .lNameController.value.text.length,
                  maxLength: 20,
                );
              } else if (data["controller"] ==
                  recruiterProfileInfoController.designationController.value) {
                return FormFieldLengthChecker(
                  characterLength: recruiterProfileInfoController
                      .designationController.value.text.length,
                  maxLength: 20,
                );
              } else {
                return FormFieldLengthChecker(
                  characterLength: recruiterProfileInfoController
                      .emailController.value.text.length,
                  maxLength: 40,
                );
              }
            })
          ],
        ),
      ),
    );
  }
}

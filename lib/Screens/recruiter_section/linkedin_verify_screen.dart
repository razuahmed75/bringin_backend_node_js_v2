import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../../controllers/recruiter_section/recruiter_identy_verify_controller.dart';
import '../../../../../../res/app_font.dart';
import '../../../../../../res/dimensions.dart';
import '../../../../../../widgets/app_bar.dart';
import '../../../../../../widgets/app_bottom_nav_widget.dart';
import '../../../../../../widgets/app_search_widget.dart';
import '../../res/constants/image_path.dart';
import '../../utils/routes/route_helper.dart';

class LinkedinVerifyScreen extends StatelessWidget {
  const LinkedinVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RecruiterIdentyVerifyController controller =
        Get.find<RecruiterIdentyVerifyController>();
    return GestureDetector(
      onTap: () => Helpers.hideKeyboard(),
      child: Scaffold(
        appBar: appBarWidget(
            title: "", onBackPressed: () => Get.back(), actions: []),
        body: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDefaultgapTop,

              Text("Verify With Your Linkedin Profile",
                      style: Styles.smallTitle),
              const Gap(3),
              Text("Click below to enter your LinkedIn profile username.",
                  style: Styles.subTitle),
              const Gap(15),

              /// verification text field
              GetBuilder<RecruiterIdentyVerifyController>(builder: (_){
                return AppSearchWidget(
                controller: controller.linkedinTextEditingCtrlr,
                hinText: "https://linkedin.com/in/username",
                child: controller.linkedinTextEditingCtrlr.text.isNotEmpty
                    ? controller.linkedinTextEditingCtrlr.text.contains("https://linkedin.com/in/") 
                    || controller.linkedinTextEditingCtrlr.text.contains("https://www.linkedin.com/in/")
                    || controller.linkedinTextEditingCtrlr.text.contains("www.linkedin.com/in/")
                    || controller.linkedinTextEditingCtrlr.text.contains("linkedin.com/in/")
                    ? SvgPicture.asset(AppImagePaths.validated,height: height(14),width: height(14),) 
                    : IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          controller.linkedinTextEditingCtrlr.clear();
                        },
                        icon: SvgPicture.asset(AppImagePaths.close_icon),
                      ) 
                    : SizedBox(),
                );
              }),
              const Gap(20),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavWidget(
              text: controller.isLoading.value ? "Processing..." : "Submit",
              onTap: controller.isLoading.value
                  ? null
                  : () async {
                      if (controller.linkedinTextEditingCtrlr.text.isEmpty) {
                        Helpers().showValidationErrorDialog();
                      } else if (!(controller.linkedinTextEditingCtrlr.text
                          .contains("https://linkedin.com/in/") ||
                          controller.linkedinTextEditingCtrlr.text.contains("https://www.linkedin.com/in/"))) {
                        Helpers().showValidationErrorDialog(
                          errorText: "Please enter a valid linkedin url",
                        );
                      } else {
                       await controller.postEmailAndLinkEdin(data: {
                          "type": "5",
                          "link":
                              controller.linkedinTextEditingCtrlr.text.trim(),
                        });
                        controller.isBack.value ? Get.toNamed(
                          RouteHelper.getUnderVerificationRoute(),
                          arguments: ["Linkedin Url", true],
                        ):null;
                      }
                    }),
        ),
      ),
    );
  }
}

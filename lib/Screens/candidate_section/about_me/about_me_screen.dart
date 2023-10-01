import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/custom_expand_text_field.dart';
import '../../../controllers/candidate_section/about_me_controller.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/image_path.dart';
import '../../../res/dimensions.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/formfield_length_checker.dart';
import 'components/about_me_examples.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AboutMeController _myBioController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget(
          title: "About Me",
          onBackPressed: () => Get.back(),
          onSavedPressed: () {
            if (_myBioController.characterLength.value == 0) {
              Helpers().showValidationErrorDialog();
            } else if (_myBioController.characterLength.value < 50) {
              Helpers().showValidationErrorDialog(
                errorText: "Please enter at least 50 characters",
                durationTime: 3,
              );
            } else {
              _myBioController.postAboutMe(data: {
                "about": _myBioController.textEditingController.text.trim(),
              });
            }
          }),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDefaultgapTop,


              /// form section
              CustomExpandTextField(
                controller: _myBioController.textEditingController,
                hinText: "Describe who you are",
                maxLength: 400,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                onChanged: (value) {
                  _myBioController.characterLength.value = value.length;
                },
              ),
              Obx(
                () => FormFieldLengthChecker(
                  characterLength: _myBioController.characterLength.value,
                  maxLength: 400,
                ),
              ),
              const Gap(5),
              Obx(() {
                return _myBioController.isLoading.value
                    ? SizedBox(
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Helpers.appLoader2(),
                            ]),
                      )
                    : SizedBox(height: 50);
              }),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(height(15)),
                decoration: Dimensions.kDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Need Help?", style: Styles.bodyLargeMedium),
                    InkWell(
                      onTap: () {
                        Helpers.hideKeyboard();
                        _myBioController.isShowing.value =
                            !_myBioController.isShowing.value;
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: height(10),
                            bottom: height(10),
                            right: width(5)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppImagePaths.eye,
                              color: AppColors.mainColor,
                              height: height(17),
                              width: width(17),
                            ),
                            const Gap(5),
                            Text("Click here to see the examples below.",
                                style: Styles.bodyMedium1
                                    .copyWith(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                    const Gap(30),
                    Obx(
                      () => _myBioController.isShowing.value
                          ? AboutMeExample()
                          : SizedBox.shrink(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

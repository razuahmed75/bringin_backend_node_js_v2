import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/widgets/app_button.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/strings.dart';
import '../../../res/dimensions.dart';
import '../../../widgets/phone_field.dart';
import '../../Hive/hive.dart';
import '../../controllers/both_category/signin_controller.dart';
import '../../res/constants/image_path.dart';
import '../../utils/services/helpers.dart';
import '../../utils/services/keys.dart';
import '../../widgets/app_bar.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final box = GetStorage();
    var isRecruiter = HiveHelp.read(Keys.isRecruiter);

    SignInController _controller = Get.find<SignInController>();

    return GestureDetector(
      onTap: () => Helpers.hideKeyboard(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBarWidget(
            title: "", onBackPressed: () => Get.back(), actions: []),
        body: GestureDetector(
          onTap: () => Helpers.hideKeyboard(),
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimensions.kDefaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimensions.kDefaultgapTop,
          
                  /// Sign In / Sign Up for job seeker / Recruiter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Login or Register", style: Styles.largeTitle),
                          const Gap(4),
                          HiveHelp.read(Keys.isRecruiter)
                              ? Text("As a Recruiter", style: Styles.largeTitle)
                              : Text("As a Job Seeker", style: Styles.largeTitle),
                        ],
                      ),
                    ],
                  ),
                  const Gap(30),
          
                  HiveHelp.read(Keys.isRecruiter)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SignInTile(text: "I am genuinely a Recruiter"),
                            const Gap(10),
                            SignInTile(text: "I am not a Hiring Consultant"),
                            const Gap(10),
                            SignInTile(text: "I am not a Fraud or Scammer"),
                            const Gap(50),
                          ],
                        )
                      : SizedBox.shrink(),
          
                  /// description text
                  Text(
                    AppStrings.signInDescription,
                    style: Styles.bodyMedium2.copyWith(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(22),
          
                  /// text field
                  PhoneField(
                    controller: _controller.phoneFieldController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]'),
                      ),
                      FilteringTextInputFormatter.deny(
                        RegExp(r'^0+'),
                      ),
                      ////users can't type 0 at 1st position
                    ],
                    onChanged: (val) {
                      if (val.length == 10) {
                        Helpers.hideKeyboard();
                      }
                    },
                  ),
                  const Gap(22),
          
                  /// send button
                  ValueListenableBuilder(
                      valueListenable: _controller.phoneFieldController,
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => AppButton(
                                borderRadius: BorderRadius.circular(21.r),
                                text: _controller.isLoading.value
                                    ? "Sending..."
                                    : "Send Code",
                                bgColor: AppColors.mainColor,
                                textColor: _controller.isLoading.value
                                    ? AppColors.blackColor
                                    : AppColors.whiteColor,
                                buttonWidth: width(140),
                                onTap: value.text.isNotEmpty &&
                                        value.text.length == 10 &&
                                        _controller.isLoading.value == false
                                    ? () async {
                                        if (value.text.startsWith("0")) {
                                          Helpers().showValidationErrorDialog(
                                              errorText:
                                                  'The phone number should be start without "0" (zero) and only within 10 digits.');
                                        } else {
                                            var appSignatureID =
                                                await SmsAutoFill()
                                                    .getAppSignature;
                                            print("signature id: " +
                                                appSignatureID);
                                            _controller.postSignIn(
                                              fields: {
                                                "number": "0" +
                                                    "${_controller
                                                        .phoneFieldController.text
                                                        .trim()}",
                                              },
                                            );
                                            HiveHelp.write(
                                                Keys.phoneNumber,
                                                "0" +
                                                    _controller
                                                        .phoneFieldController.text
                                                        .trim());
                                        }
                                      }
                                    : null,
                                borderColor: Colors.transparent,
                              ),
                            ),
                          ],
                        );
                      }),
        
                  
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: height(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isRecruiter
                        ? Container(
                            padding: EdgeInsets.only(bottom: height(20)),
                            margin: Dimensions.kDefaultPadding,
                            child: RichText(
                                text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.signInRecruiterDes1,
                                  style: Styles.bodyMedium2.copyWith(
                                    color: AppColors.blackColor.withOpacity(.5),
                                  ),
                                ),
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                        RouteHelper.getTermsAndConditionsRoute()),
                                    child: Text(
                                      AppStrings.signInRecruiterDesSpanText1,
                                      style: Styles.bodyMedium.copyWith(
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                        RouteHelper.getTermsAndConditionsRoute()),
                                    child: Text(
                                      AppStrings.signInRecruiterDesSpanText2,
                                      style: Styles.bodyMedium.copyWith(
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: AppStrings.signInRecruiterDes2,
                                  style: Styles.bodyMedium2.copyWith(
                                    color: AppColors.blackColor.withOpacity(.5),
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.toNamed(
                                        RouteHelper.getPrivacyPolicyRoute()),
                                  text: AppStrings.signInRecruiterDesSpanText3,
                                  style: Styles.bodyMedium.copyWith(
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            )),
                          )
                        : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget SignInTile({required String text}){
     return Row(
      children: [
        SvgPicture.asset(
          AppImagePaths.recruiter_done,
        ),
        const Gap(5),
        Text(
         text,
          style: Styles.bodyMedium1,
        )
      ],
    );
  }
}

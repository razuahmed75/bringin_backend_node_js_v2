import 'package:bringin/Hive/hive.dart';
import 'package:bringin/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../../controllers/recruiter_section/underverification.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/constants/strings.dart';
import '../../../../res/dimensions.dart';
import '../../../../widgets/app_bar.dart';
import '../../controllers/both_category/otp_controller.dart';
import '../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../controllers/recruiter_section/recruiter_identy_verify_controller.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/services/helpers.dart';
import '../../utils/services/keys.dart';

class UnderVerificationScreen extends StatefulWidget {
  const UnderVerificationScreen({super.key});

  @override
  State<UnderVerificationScreen> createState() =>
      _UnderVerificationScreenState();
}

class _UnderVerificationScreenState extends State<UnderVerificationScreen> {
  UnderVerification underVerification = Get.put(UnderVerification());
  OtpController _controller = Get.find<OtpController>();
  RecruiterIdentyVerifyController recruiterEmailController = Get.find();
  RecruiterEditMainProfileController recruiterProfileInfoController =
      Get.put(RecruiterEditMainProfileController());
  var codeValue;
  var isRefreshing = false;
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBarWidget(
          title: "Under Verification",
          onBackPressed: () => Get.back(),
          actions: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data[0] != "email") ...[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "You have submitted your ${data[0]} successfully.",
                    textAlign: TextAlign.center,
                    style: Styles.bodyMedium2,
                  ),
                ),
                const Gap(15),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AppImagePaths.alarm_clock,
                    height: height(60),
                    width: height(60),
                  ),
                ),

                const Gap(20),

                /// estimated timing box
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width(14),
                    vertical: height(10),
                  ),
                  width: double.maxFinite,
                  height: height(80),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: .25,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estimated audit completion time will be...",
                        style: Styles.bodySmall1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              DateFormat("hh:mm a").format(
                                  DateTime.now().add(Duration(hours: 2))),
                              style: Styles.bodyMedium),
                          InkWell(
                            onTap: () async {
                              await _handleButtonPress();
                              await recruiterProfileInfoController
                                  .getRecruiterProfileInfoList();
                              if (recruiterProfileInfoController
                                      .recruiterProfileInfoList[0]
                                      .other!
                                      .profileVerify ==
                                  true) {
                                HiveHelp.write(
                                    Keys.isRecruiterCompanyDocVerified, true);
                                Get.offAllNamed(RouteName.bottomNavLayout);
                              }
                              setState(() {});
                            },
                            child: Ink(
                              width: width(80),
                              height: height(30),
                              // alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Center(
                                child: Text(
                                  "Refresh",
                                  style: Styles.bodySmall.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Visibility(
                  visible: isRefreshing,
                  child: Center(
                      child: Helpers
                          .appLoader2()), // You can replace this with your custom loader widget
                ),
              ] else ...[
                Text(AppStrings.underVerificationDes,
                    textAlign: TextAlign.center, style: Styles.bodyMedium2),
                const Gap(10),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: height(38),
                    width: height(218),
                    child: PinFieldAutoFill(
                      controller: underVerification.verificationController,
                      currentCode: codeValue,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onCodeChanged: (String? code) {
                        codeValue = code!;
                        if (code.length == 4) {
                          Helpers.hideKeyboard();
                        }
                      },
                      codeLength: 4,
                      autoFocus: true,
                      cursor: Cursor(
                        width: 2,
                        height: height(20),
                        color: AppColors.mainColor,
                        radius: Radius.circular(1),
                        enabled: true,
                      ),
                      decoration: BoxLooseDecoration(
                        textStyle: Styles.bodySmall,
                        strokeWidth: .7,
                        radius: Radius.circular(radius(6)),
                        bgColorBuilder: FixedColorBuilder(AppColors.whiteColor),
                        strokeColorBuilder: FixedColorBuilder(
                            AppColors.blackColor.withOpacity(.2)),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Container(
                  child: Text(
                    "If you received a verification code, please submit here immediately!",
                    style: Styles.smallText2,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(10),
                Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => AppButton(
                      onTap: () async {
                        Helpers.hideKeyboard();
                        if (underVerification
                            .verificationController.text.isEmpty) {
                          Helpers().showValidationErrorDialog();
                        } else {
                          await underVerification.underverify(underVerification
                              .verificationController.text
                              .trim());
                        }
                      },
                      text:
                          underVerification.isLoading.value ? "Wait" : "Submit",
                      buttonHeight: height(34),
                      buttonWidth: width(106),
                      textColor: AppColors.whiteColor,
                    ),
                  ),
                ),
                const Gap(50),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive code?",
                          style: Styles.bodyLargeMedium.copyWith(
                            decoration: TextDecoration.underline,
                            fontSize: 14.sp,
                            color: _controller.isStartTimer.value
                                ? Colors.grey
                                : AppColors.blackColor,
                          ),
                        ),
                      ],
                    )),
                const Gap(12),

                /// Didn't receive code? send again
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _controller.isStartTimer.value
                            ? null
                            : () {
                                recruiterEmailController.postEmailAndLinkEdin(
                                    data: {
                                      "type": "1",
                                      "email":
                                          "${HiveHelp.read(Keys.recruiterEmail)}"
                                    });
                                _controller.startTimer();
                              },
                        child: Text(
                          "Resend Code",
                          style: Styles.bodyMedium1.copyWith(
                            color: _controller.isStartTimer.value
                                ? Colors.grey
                                : AppColors.mainColor,
                          ),
                        ),
                      ),
                      _controller.isStartTimer.value == false
                          ? SizedBox()
                          : Text(_controller.counter.value.toString() + "s",
                              style: Styles.bodySmall1),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: Dimensions.kDefaultPadding,
          height: height(100),
          child: Text(
            data[0] == "email"
                ? AppStrings.verificationConfirmationDes2
                : AppStrings.verificationConfirmationDes,
            style: Styles.subTitle,
          ),
        ),
      ),
    );
  }

  _handleButtonPress() async {
    setState(() {
      isRefreshing = true;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isRefreshing = false;
    });
  }
}

import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:sms_autofill/sms_autofill.dart';
import '../../Hive/hive.dart';
import '../../controllers/both_category/otp_controller.dart';
import '../../controllers/both_category/signin_controller.dart';
import '../../models/both_category/otp_post_model.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';
import '../../utils/services/keys.dart';
import '../../widgets/app_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
  OtpController _controller = Get.find<OtpController>();
  SignInController signInController = Get.find<SignInController>();
  @override
  void codeUpdated() {
    print("Update code $code");
    if(mounted){
      setState(() {
      print("codeUpdated");
    });
    }
  }

  @override
  void initState() {
    _controller.textFieldCtrlr.addListener(() {
      if(mounted){
        setState(() {});
      }
    });
    listenOtp();
    super.initState();
  }

  @override
  void dispose() {
    _controller.textFieldCtrlr.dispose();
    SmsAutoFill().unregisterListener();
    print("unregisterListener");
    super.dispose();
  }

  var codeValue;
  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    await SmsAutoFill().listenForCode;
    print("OTP listen Called");
  }

  @override
  Widget build(BuildContext context) {
    // final box = GetStorage();
    return GestureDetector(
      onTap: () => Helpers.hideKeyboard(),
      child: Scaffold(
        appBar: appBarWidget(title: "",onBackPressed: ()=> Get.back(),actions: []),
        body: SingleChildScrollView(
          child: Padding(
            padding: Dimensions.kDefaultPadding,
            child: Column(
              children: [
                const Gap(30),
        
                /// Verify Phone
                Text("Verify Your Phone Number", style: Styles.largeTitle),
                const Gap(10),
        
                /// Code is sent to 017**
                Text(
                  "Code is sent to ${HiveHelp.read(Keys.phoneNumber)}",
                  style: Styles.bodyMedium2,
                ),
                const Gap(20),
                Obx(()=> Text(
                    "Didn't receive code?",
                    style: Styles.bodyLargeMedium.copyWith(
                      decoration: TextDecoration.underline,
                      fontSize: 16.sp,
                      color: _controller.isStartTimer.value ? AppColors.blackColor : AppColors.mainColor,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height(64),
                      width: height(320),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            // BoxShadow(
                            //   color: AppColors.shadowColor.withOpacity(.4),
                            //   blurRadius: 10,
                            //   spreadRadius: 1,
                            // ),
                          ],
                        ),
                        child: PinFieldAutoFill(
                          controller: _controller.textFieldCtrlr,
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
                            strokeWidth: .7,
                            radius: Radius.circular(radius(6)),
                            bgColorBuilder: FixedColorBuilder(
                                AppColors.whiteColor),
                            strokeColorBuilder: FixedColorBuilder(AppColors.blackColor.withOpacity(.2)),
                           ),
                        ),
                      ),
                    ),
                  ],
                ),
        
                const Gap(15),
        
                /// Enter 4-digit code
                Text("Enter the 4-digit code", style: Styles.bodyMedium3),
        
                const Gap(10),
        
                /// Didn't receive code? send again
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _controller.isStartTimer.value
                            ? null
                            : () {
                                signInController.postSignIn(
                                  fields: {
                                    "number": "${HiveHelp.read(Keys.phoneNumber)}",
                                  },
                                );
                                _controller.startTimer();
                              },
                        child: Text(
                           "Resend Code",
                          style: Styles.bodyMedium1.copyWith(
                            color: _controller.isStartTimer.value ? Colors.grey : AppColors.mainColor,
                          ),
                        ),
                      ),
                     _controller.isStartTimer.value == false 
                     ? SizedBox() 
                     : Text(_controller.counter.value.toString()+"s",style: Styles.bodySmall1),
                    ],
                  ),
                ),
                const Gap(40),
        
                /// SUBMIT
                GetBuilder<OtpController>(builder: (_) {
                  return Obx(
                    () => AppButton(
                        text: _controller.isLoading.value
                            ? "Verifying..."
                            : "Submit",
                        bgColor: AppColors.mainColor,
                        textColor: _controller.isLoading.value
                            ? AppColors.blackColor
                            : AppColors.whiteColor,
                        borderColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(21.r),
                        buttonWidth: width(140),
                        onTap: _controller.textFieldCtrlr.text.length < 4 ||
                                _controller.isLoading.value == true
                            ? null
                            : () {
                                if (HiveHelp.read(Keys.isRecruiter) == true) {
                                  final body = OtpPostModel(
                                      number:
                                          "${HiveHelp.read(Keys.phoneNumber)}",
                                      otp:
                                          "${_controller.textFieldCtrlr.text.trim()}",
                                      isrecruiter: "1");
                                  _controller.postOtp(fields: body);
                                  HiveHelp.write(Keys.isMainProfileEdit, false);
        
                                  /// for edit recruiter_edit_mainProfile_screen
                                } else {
                                  final body = OtpPostModel(
                                      number:
                                          "${HiveHelp.read(Keys.phoneNumber)}",
                                      otp:
                                          "${_controller.textFieldCtrlr.text.trim()}",
                                      isrecruiter: "0");
                                  _controller.postOtp(fields: body);
                                }
                              }),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

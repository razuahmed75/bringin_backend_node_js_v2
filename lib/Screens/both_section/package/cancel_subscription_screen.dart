import 'package:bringin/controllers/Package_Controller/package_controller.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/dimensions.dart';
import '../../../utils/routes/route_helper.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_popup_dialog.dart';
import 'components/package_tile.dart';

class CancelSubscriptionScreen extends StatefulWidget {
  const CancelSubscriptionScreen({super.key});

  @override
  State<CancelSubscriptionScreen> createState() =>
      _CancelSubscriptionScreenState();
}

class _CancelSubscriptionScreenState extends State<CancelSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    RecruiterEditMainProfileController.to.getRecruiterProfileInfoList();
    return Scaffold(
      appBar: appBarWidget(
          title: "Cancel Subscriptions",
          onBackPressed: () => Get.back(),
          actions: []),
      body: Obx(() {
        if (RecruiterEditMainProfileController.to.isLoading.isTrue) {
          return Center(child: Helpers.appLoader2());
        } else if (RecruiterEditMainProfileController
            .to.recruiterProfileInfoList.isEmpty) {
          return Text("Not found");
        } else {
          var data = RecruiterEditMainProfileController
              .to.recruiterProfileInfoList[0].other!;
          return Padding(
            padding: EdgeInsets.all(10.r),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    data.premium == false ? "" : "Your Current Active Package",
                    style: Styles.bodyMedium,
                  ),
                  SizedBox(height: 8.h),
                  if (data.premium == true) ...[
                    PackageTile(
                      isPurchasePackage: false,
                      padding: EdgeInsets.all(15.h),
                      packageLevel: data.package == null
                          ? ""
                          : data.package!.packageid!.name!,
                      chatsAmount:
                          "${data.package == null ? "" : data.package!.packageid!.chat} Chats Per Day",
                      takaAmount:
                          "${data.package == null ? "" : data.package!.packageid!.amount} BDT",
                      durationMonth:
                          "${data.package == null ? "" : data.package!.packageid!.durationTime} Month",
                    ),
                    SizedBox(height: 56.h),
                    Center(
                        child: Image.asset(
                      "assets/icon2/cancle.png",
                      height: 68.h,
                      width: 102.w,
                    )),
                    SizedBox(height: 10.h),
                    Text(
                      "Are you sure you want to cancel your subscription?",
                      textAlign: TextAlign.center,
                      style: Styles.bodyLargeMedium,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "If you decide to cancel your subscription, please note that once it expires, you will no longer have access to the chat feature included in the package.",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BackButton(onTap: () => Get.back()),
                        SizedBox(width: 10.w),
                        UnsubscribeButton(onTap: () {
                          AppPopupDialog().showPopup(
                            context: context,
                            description: "Are you sure?",
                            buttonOkText: "Yes",
                            onOkPress: () async {
                              await PackageController.to
                                  .cancelSubscription(id: data.package!.id);
                              Get.back();
                            },
                            onCancelPress: () => Get.back(),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(height: 20.h),
                    Obx(
                      () => PackageController.to.isLoading.isFalse &&
                              PackageController.to.isCancelled.isTrue
                          ? Text(
                              "Your subscription has been successfully canceled. Please be aware that access to services and features will cease upon the expiration of your subscription.",
                              textAlign: TextAlign.center,
                              style: Styles.bodySmall1.copyWith(
                                color: Colors.green,
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                  if (data.premium == false) ...[
                    SizedBox(height: 25.h),
                    Center(
                        child: Image.asset(
                      "assets/icon2/cancle.png",
                      height: 68.h,
                      width: 102.w,
                    )),
                    SizedBox(height: 10.h),
                    Center(
                      child: Text(
                        "You didn't purchase any package yet!",
                        textAlign: TextAlign.center,
                        style: Styles.bodyLargeMedium,
                      ),
                    ),
                    const Gap(25),
                    AppButton(
                      onTap: () =>
                          Get.toNamed(RouteHelper.getPurchasePackageRoute()),
                      bgColor: Colors.transparent,
                      buttonHeight: height(36),
                      buttonWidth: double.maxFinite,
                      splashColor: AppColors.mainColor.withOpacity(.1),
                      highLightColor: AppColors.mainColor.withOpacity(.1),
                      borderColor: AppColors.mainColor,
                      text: "Upgrade Package",
                      textColor: AppColors.mainColor,
                      textSize: font(14),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget UnsubscribeButton({void Function()? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 38.h,
          width: 120.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: AppColors.mainColor,
              )),
          child: Text(
            "Unsubscribe",
            style: Styles.bodyMedium.copyWith(color: AppColors.mainColor),
          ),
        ),
      ),
    );
  }

  Widget BackButton({void Function()? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(3),
      splashColor: AppColors.mainColor.withOpacity(.2),
      highlightColor: AppColors.greyColor.withOpacity(.3),
      onTap: onTap,
      child: Ink(
        height: 38.h,
        width: 120.w,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Text(
            "Go Back",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

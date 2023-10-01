import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../controllers/ChatController/chatcontroll.dart';
import '../../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../../../models/Package/packagelist.dart';
import '../../../../models/recruiter_section/recruiter_profile_info_model.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/dimensions.dart';
import '../../../AmarPay/amarpay.dart';

class PackageTile extends StatelessWidget {
  final String? hint;
  final Color? hintColor, hintBgColor,borderColor,textColor;
  final String packageLevel;
  final String chatsAmount;
  final String takaAmount;
  final String durationMonth;
  final PackageList? package;
  final void Function()? onPurchasePressed;
  final bool? isPurchasePackage;
  final EdgeInsetsGeometry? padding;

  const PackageTile({
    super.key,
    this.hint,
    required this.packageLevel,
    required this.chatsAmount,
    required this.takaAmount,
    required this.durationMonth,
    this.onPurchasePressed,
    this.hintColor,
    this.hintBgColor, 
    this.borderColor, this.textColor, this.isPurchasePackage=true, 
    this.padding,
    this.package,
  });

  bool packageby(RecruiterProfileInfoModel profile) {
    ChatControll chatControll = Get.find<ChatControll>();
    chatControll.gettoday();
    DateTime enddate =profile.other!.package!.enddate!.toLocal()
        ;
    int different = enddate.difference(chatControll.todaydate).inDays;
    if (different <= 0) {
      return false;
    } else if (different > 0 &&
        package!.id == profile.other!.package!.packageid!.id) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final recuiterprofile = Get.find<RecruiterEditMainProfileController>();
    return GetBuilder<RecruiterEditMainProfileController>(
      builder: (controller) {
          return Container(
      padding: padding ?? EdgeInsets.only(
        left: width(10),
        top: height(5),
        bottom: height(5),
        right: width(5),
      ),
      margin: EdgeInsets.only(bottom: height(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius(9)),
        border: Border.all(
          color: AppColors.appBorder,
          width: .5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Best for Startups
        isPurchasePackage == true ?  Container(
            padding: EdgeInsets.symmetric(
              horizontal: width(10),
              vertical: height(5),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius(6)),
              color:
                  hintBgColor ?? AppColors.packageSilverColor.withOpacity(.1),
              border: Border.all(
                color: borderColor ?? AppColors.mainColor,
                width: .7,
              ),
            ),
            child: Text(
              hint ?? "",
              style: Styles.bodyMedium1.copyWith(
                color:textColor??  AppColors.packageSilverColor,
              ),
            ),
          ):SizedBox(),
           Gap(isPurchasePackage == true ? 15:0),

          /// Silver, 20 Chats Per Day
          Row(
            children: [
              Text(packageLevel, style: Styles.bodyMedium1),
              const Gap(10),
              Text("•", style: Styles.bodyMedium1),
              const Gap(10),
              Text(chatsAmount, style: Styles.bodyMedium1),
            ],
          ),
          const Gap(10),

          /// 1499 BDT, 1 Month
          Row(
            children: [
              /// 1499 BDT
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width(10),
                  vertical: height(5),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.packageSilverColor.withOpacity(.15),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImagePaths.takaIcon,
                      height: height(12),
                    ),
                    const Gap(10),
                    Text(takaAmount, style: Styles.bodyMedium1),
                  ],
                ),
              ),
              const Gap(15),

              /// 1 month
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width(10),
                  vertical: height(5),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.packageSilverColor.withOpacity(.15),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImagePaths.calander,
                      height: height(14),
                    ),
                    const Gap(10),
                    Text(durationMonth, style: Styles.bodyMedium1),
                  ],
                ),
              ),
            ],
          ),
           Gap(isPurchasePackage == true ? 15:0),

          /// purchase button
        isPurchasePackage == true ?   Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (controller.recruiterProfileInfoList[0].other!.package ==
                  null)
                MyPay(
                  package: package!,
                ),
              if (controller.recruiterProfileInfoList[0].other!.package !=
                      null &&
                  packageby(controller.recruiterProfileInfoList[0]) ==
                      false)
                MyPay(
                  package: package!,
                ),
              if (controller.recruiterProfileInfoList[0].other!.package !=
                      null &&
                  packageby(controller.recruiterProfileInfoList[0]) ==
                      true)
                Container(
                  padding:
                       EdgeInsets.symmetric(horizontal: width(10), vertical: height(5)),
                  decoration: ShapeDecoration(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Purchased',
                        style: Styles.bodyMedium.copyWith(color: AppColors.whiteColor),
                      ),
                    ],
                  ),
                )

              // InkWell(
              //   onTap: onPurchasePressed,
              //   borderRadius: BorderRadius.circular(radius(13)),
              //   splashColor: AppColors.greyColor,
              //   highlightColor: AppColors.greyColor,
              //   child: Ink(
              //     padding: EdgeInsets.symmetric(horizontal: width(8),vertical: height(3)),
              //     decoration: BoxDecoration(
              //       color: AppColors.mainColor,
              //       borderRadius: BorderRadius.circular(radius(13)),
              //     ),
              //     child: Text("Buy Now",style: Styles.bodyMedium.copyWith(
              //       color: AppColors.whiteColor,
              //     )),
              //   ),
              // ),
            ],
          ):SizedBox(),
        ],
      ),
    );
  
  
      },
    );
  }
}

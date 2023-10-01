import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/color.dart';
import '../../../../../res/constants/image_path.dart';
import '../../../../res/constants/strings.dart';
import '../../../both_section/package/purchase_package_screen.dart';

class ChatsDialog {
  static dialog(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius(23))),
          titlePadding: EdgeInsets.only(
              top: height(12), left: width(24), right: width(12)),
          insetPadding: Dimensions.kDefaultPadding,
          title: Container(
            alignment: Alignment.centerRight,
            child: InkResponse(
              onTap: () => Get.back(),
              child: Container(
                child: Icon(Icons.close),
              ),
            ),
          ),
          //EN: Logging out
          content: Container(
            width: double.maxFinite,
            padding: Dimensions.kDefaultPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImagePaths.sadIcon,
                  height: height(58),
                  width: height(58),
                ),
                const Gap(20),
                Text(AppStrings.buyPackageDes, style: Styles.bodyMedium2),
                const Gap(20),
                AppButton(
                    buttonWidth: double.maxFinite,
                    text: "Purchase Now",
                    textColor: AppColors.whiteColor,
                    onTap: () {
                      print('sdvsdvsdv');
                      Get.back();
                      Get.toNamed(
                        RouteHelper.getPurchasePackageRoute(),
                      );
                      // // Get.to(PurchasePackageScreen());
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => PurchasePackageScreen()));
                      // Get.back();
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:bringin/controllers/Package_Controller/package_controller.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../utils/routes/route_helper.dart';
import 'components/package_tile.dart';

class PurchasePackageScreen extends StatelessWidget {
  PurchasePackageScreen({super.key});

  PackageController packageController = Get.put(PackageController());

  @override
  Widget build(BuildContext context) {
    packageController.getpackagelist();
    return Scaffold(
      appBar: appBarWidget(
        title: "Choose Your Package",
        onBackPressed: () {
          Get.back();
        },
        actions: [],
      ),
      body: Obx(
        () => packageController.pckloading.value
            ? Center(child: Helpers.appLoader())
            : Padding(
                padding: Dimensions.kDefaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Expanded(
                        child: ListView.builder(
                            itemCount: packageController.packagelist.length,
                            itemBuilder: (_, index) {
                              var data = packageController.packagelist[index];
                              return PackageTile(
                                package: data,
                                hint: data.suggestname!,
                                packageLevel: data.name!,
                                chatsAmount: "${data.chat} Chats Per Day",
                                takaAmount: "${data.amount} BDT",
                                durationMonth: "${data.durationTime} Month",
                                onPurchasePressed: () {},
                                hintBgColor: data.name! == "Silver"
                                    ? AppColors.packageSilverColor
                                        .withOpacity(.1)
                                    : data.name! == "Gold"
                                        ? AppColors.packageGoldColor
                                            .withOpacity(.1)
                                        : AppColors.packagePlatinumColor
                                            .withOpacity(.1),
                                borderColor: data.name! == "Silver"
                                    ? AppColors.packageSilverColor
                                    : data.name! == "Gold"
                                        ? AppColors.packageGoldColor
                                        : AppColors.packagePlatinumColor,
                                textColor: data.name! == "Silver"
                                    ? AppColors.packageSilverColor
                                    : data.name! == "Gold"
                                        ? AppColors.packageGoldColor
                                        : AppColors.packagePlatinumColor,
                              );
                            }))
                  ],
                )),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: height(70),
          alignment: Alignment.center,
          margin: Dimensions.kDefaultPadding,
          child: RichText(
              text: TextSpan(
            children: [
              TextSpan(text: "Please read our", style: Styles.bodyMedium2),
              WidgetSpan(
                child: InkWell(
                  onTap: () => Get.toNamed(RouteHelper.getPrivacyPolicyRoute()),
                  child: Text(
                    " Privacy Policy ",
                    style:
                        Styles.bodyMedium.copyWith(color: AppColors.mainColor),
                  ),
                ),
              ),
              WidgetSpan(
                child: Text(
                  "and ",
                  style: Styles.bodyMedium2,
                ),
              ),
              WidgetSpan(
                child: InkWell(
                  onTap: () =>
                      Get.toNamed(RouteHelper.getTermsAndConditionsRoute()),
                  child: Text(
                    "Terms & Conditions ",
                    style:
                        Styles.bodyMedium.copyWith(color: AppColors.mainColor),
                  ),
                ),
              ),
              TextSpan(
                text: "before purchase a package.",
                style: Styles.bodyMedium2,
              ),
            ],
          )),
        ),
      ),
    );
  }
}

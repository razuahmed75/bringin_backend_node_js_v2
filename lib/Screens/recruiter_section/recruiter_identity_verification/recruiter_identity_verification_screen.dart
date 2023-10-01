import 'package:bringin/res/color.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../res/app_font.dart';
import '../../../res/dimensions.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/need_help_widget.dart';
import 'components/recruiter_identity_tile.dart';

class RecruiterIdentityVerifyScreen extends StatelessWidget {
  const RecruiterIdentityVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBarWidget(
            title: "", 
            onBackPressed: () => Get.back(), 
            actions: [
              NeedHelpWidget(),
              const Gap(20),
            ]
          ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDefaultgapTop,

              /// Recruiter Identity Verification
              Text("Recruiter Identity Verification",
                      style: Styles.smallTitle),
              const Gap(3),
              Text(
                "Choose one of the below listed method.",
                style: Styles.bodyMedium2,
              ),
              const Gap(30),

              /// recruiter identity fillup section
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius(6)),
                  border: Border.all(
                    color: AppColors.appBorder,
                    width: .5,
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Work Email
                    RecruiterIdentityTile(
                      onTap: () => Get.toNamed(
                        RouteHelper.getRecruiterIdentyEmailVerifyRoute(),
                      ),
                      firstText: "Work Email",
                      secondText: "Enter your work email",
                      iconPath: "assets/icon2/email2.png",
                    ),
              
                    /// Offer Letter
                    RecruiterIdentityTile(
                      onTap: () => Get.toNamed(
                        RouteHelper.getOfferLetterVerifyRoute(),
                      ),
                      firstText: "Offer Letter",
                      secondText: "Verify with your job offer letter",
                      iconPath: "assets/icon2/letter.png",
                    ),
              
                    /// Appointment Letter
                    RecruiterIdentityTile(
                      onTap: () => Get.toNamed(
                        RouteHelper.getAppointmentLetterVerifyRoute(),
                      ),
                      firstText: "Appointment Letter",
                      secondText: "Verify with your appointment letter",
                      iconPath: "assets/icon2/appontment.png",
                    ),
              
                    /// Company ID Card
                    RecruiterIdentityTile(
                      onTap: () => Get.toNamed(
                        RouteHelper.getCompanyIdCardVerifyRoute(),
                      ),
                      firstText: "Company ID Card",
                      secondText: "Verify with your company's ID card",
                      iconPath: "assets/icon2/iccard.png",
                    ),
              
                    /// LinkedIn Profile
                    RecruiterIdentityTile(
                      onTap: () => Get.toNamed(
                        RouteHelper.getLinkedinVerifyRoute(),
                      ),
                      firstText: "LinkedIn Profile",
                      secondText: "Enter Your LinkedIn Profile Link",
                      iconPath: "assets/icon2/linkdin.png",
                    ),
              
                    /// Any Other  Authorized Document
                    RecruiterIdentityTile(
                      onTap: () => Get.toNamed(
                        RouteHelper.getAuthorizedDocVerifyRoute(),
                      ),
                      firstText: "Any Other Authorized Document",
                      secondText: "Verify with any other valid documents",
                      iconPath: "assets/icon2/doc.png",
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../../controllers/recruiter_section/job_post_preview_controller.dart';
import '../../../../../../res/app_font.dart';
import '../../../../../../res/color.dart';
import '../../../../../../res/constants/image_path.dart';
import '../../../../../../res/constants/strings.dart';
import '../../../../../../res/dimensions.dart';
import '../../../../../../utils/routes/route_helper.dart';
import '../../../../../../utils/services/keys.dart';
import '../../../../../../widgets/app_bar.dart';
import '../../../../../../widgets/app_button.dart';
import '../../Hive/hive.dart';
import '../../controllers/both_category/bottom_nav_controller.dart';
import '../../utils/services/helpers.dart';
import '../candidate_section/bottom_nav/bottom_nav_layout.dart';

class SuccessfullyJobPostedPage extends StatelessWidget {
  const SuccessfullyJobPostedPage({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavController _bottomNavController = Get.find();
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.getJobPostPreviewRoute());
                  JobPostPreviewController.to
                      .getJobPreviewData(jobId: HiveHelp.read(Keys.jobPostId));
                },
                child: Container(
                    alignment: Alignment.center,
                    width: width(85),
                    height: height(30),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(radius(21)),
                    ),
                    child: Text("Preview",
                        style: Styles.bodyMedium
                            .copyWith(color: AppColors.whiteColor))),
              ),
            ],
          ),
          const Gap(20),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: Dimensions.kDefaultPadding,
          margin: EdgeInsets.only(bottom: height(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// post another
              Expanded(
                child: AppButton(
                  onTap: () =>
                      Get.toNamed(RouteHelper.getRecruiterJobPostRoute()),
                  text: "Post Another",
                  textSize: font(16),
                  textColor: AppColors.blackOpacity80,
                  bgColor: Colors.transparent,
                  borderColor: AppColors.appBorder,
                  borderRadius: BorderRadius.circular(radius(6)),
                ),
              ),
              const Gap(15),
              if (HiveHelp.read(Keys.isRecruiterNewJoined) == true) ...[
                /// Verify Your Company
                // if (box.read(Keys.isrecruiterverified) == false)
                Expanded(
                  child: AppButton(
                    onTap: () =>
                        Get.toNamed(RouteHelper.getCompanyVerificationRoute()),
                    // _bottomNavController.goToInitialPage(),
                    text: "Verify Your Company",
                    textSize: font(14),
                    textColor: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(radius(6)),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: AppButton(
                    onTap: () {
                      refreshBottomNavIndex();
                      Get.offAllNamed(RouteHelper.getBottomNavRoute());
                    },
                    text: "Go Home",
                    textSize: font(14),
                    textColor: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(radius(6)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDefaultgapTop,
              Text("Job Successfully Posted", style: Styles.smallTitle),
              const Gap(3),
              Text(AppStrings.successfullyJobPostedDes1,
                  style: Styles.bodyMedium2),
              const Gap(25),

              /// share job post
              Container(
                padding: EdgeInsets.all(height(9)),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.appBorder, width: .5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.successfullyJobPostedDes2,
                        style: Styles.bodyMedium.copyWith(
                            color: AppColors.blackColor.withOpacity(.5)),
                      ),
                    ),
                    const Gap(10),
                    Image.asset(
                      AppImagePaths.undraw_woman,
                      height: height(82),
                      fit: BoxFit.fitHeight,
                    )
                  ],
                ),
              ),

              const Gap(5),
              Container(
                padding: EdgeInsets.all(height(9)),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.appBorder, width: .5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImagePaths.twitterIcon,
                      height: height(30),
                      width: height(30),
                    ),
                    const Gap(15),
                    Image.asset(
                      AppImagePaths.facebookIcon,
                      height: height(30),
                      width: height(30),
                    ),
                    const Gap(15),
                    Image.asset(
                      AppImagePaths.instagramIcon,
                      height: height(30),
                      width: height(30),
                    ),
                    const Gap(15),
                    Image.asset(
                      AppImagePaths.linkedinIcon,
                      height: height(30),
                      width: height(30),
                    ),
                    Spacer(),

                    /// share
                    ShareButton(
                      onTap: () async {
                        if (HiveHelp.read(Keys.jobPostId) != null) {
                          print(HiveHelp.read(Keys.jobPostId));
                          var result = await Share.shareWithResult(
                              'https://bringin.io/job-details/${HiveHelp.read(Keys.jobPostId)}');
                          if (result.status == ShareResultStatus.success) {
                            print('Successfully shared');
                            Helpers()
                                .showToastMessage(msg: "Successfully shared");
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Gap(20),

              /// undraw image
              Image.asset(
                AppImagePaths.undraw,
                fit: BoxFit.fitHeight,
                height: height(242),
                width: width(300),
              ),
              const Gap(50),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Note: ",
                    style: Styles.bodySmall1,
                  ),
                  TextSpan(
                    text: AppStrings.successfullyJobPostedDes3,
                    style: Styles.bodyMedium1
                        .copyWith(color: AppColors.blackOpacity80),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell ShareButton({void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding:
            EdgeInsets.symmetric(horizontal: width(7), vertical: height(4)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius(18)),
          color: AppColors.mainColor.withOpacity(.1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(AppImagePaths.shareIcon2),
            const Gap(3),
            Text(
              "Share",
              style: Styles.bodyMedium.copyWith(
                color: AppColors.mainColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

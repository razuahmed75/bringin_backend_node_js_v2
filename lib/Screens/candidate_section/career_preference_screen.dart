// ignore_for_file: invalid_use_of_protected_member, must_be_immutable

import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/icon_and_text_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import '../../Hive/hive.dart';
import '../../controllers/both_category/expertise_area_controller.dart';
import '../../controllers/both_category/job_industry_controller.dart';
import '../../controllers/candidate_section/candidate_career_pref_controller.dart';
import '../../controllers/candidate_section/candidate_main_profile_controller.dart';
import '../../controllers/candidate_section/job_hunting_status_controller.dart';
import '../../controllers/candidate_section/my_resume_controller.dart';
import '../../controllers/candidate_section/select_location_controller.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/image_path.dart';
import '../../res/constants/strings.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';
import '../../utils/services/keys.dart';
import '../../widgets/length_counter.dart';
import 'career_pref/candidate_career_pref_screen.dart';
import 'Resume/my_resume/components/career_preferences.dart';

class CareerPreferenceScreen extends StatelessWidget {
  CareerPreferenceScreen({super.key});

  final myResumeController = Get.find<MyResumeController>();
  final candidateJobPrefController = Get.put(CandidateCareerPrefController());

  var jobIndustryController = Get.put(JobIndustryController());
  var functilnalAreaController = Get.put(ExpertiseAreaController());
  var selectLocationController = Get.put(SelectLocationController());
  var candidateInfoController = Get.put(CandidateMainProfileController());
  var jobSearchingStatusController = Get.put(JobHuntingStatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBarWidget(title: "", onBackPressed: () => Get.back(), actions: []),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: Dimensions.kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text("Career Preferences", style: Styles.smallTitle),
                        // const Gap(10),
                        Spacer(),

                        /// length counter
                        GetBuilder<MyResumeController>(
                          builder: (controller) {
                            return LengthCounter(
                                firstText: controller.myresume == null ||
                                        controller.myresume!.careerPreference ==
                                            null
                                    ? ""
                                    : "0${controller.myresume!.careerPreference!.length}",
                                secondText: "/05");
                          },
                        )
                      ],
                    ),

                    /// What type of job do you find most appealing?
                    Text("What type of job do you find most appealing?",
                        textAlign: TextAlign.center, style: Styles.bodyMedium2),
                  ],
                ),
                const Gap(33),

                /// image
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(height(15)),
                      width: width(208),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor.withOpacity(.25),
                        borderRadius: BorderRadius.circular(radius(12)),
                      ),
                      child: Text(AppStrings.profileCompletionDes,
                          style: Styles.bodyMedium1.copyWith(fontSize: font(17))),
                    ),
                    Container(
                      height: height(76),
                      width: height(74),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppImagePaths.profile_completion),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
                const Gap(35),

                /// adding experience section
                // experience(),
                GetBuilder<MyResumeController>(
                  builder: (controller) {
                    if (controller.myresume == null ||
                        controller.myresume!.careerPreference == null) {
                      return SizedBox();
                    }
                    return controller.myresume!.careerPreference!.isEmpty
                        ? SizedBox(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("Please add your job Preference"),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                controller.myresume!.careerPreference!.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, index) {
                              var data =
                                  controller.myresume!.careerPreference![index];
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: index ==
                                          controller.myresume!.careerPreference!
                                                  .length -
                                              1
                                      ? Colors.transparent
                                      : AppColors.borderColor,
                                  width: .25,
                                ))),
                                child: InkWell(
                                  onTap: () {
                                    CandidateCareerPrefController.to
                                        .getSingleCareerPref(index: index);
                                    Get.to(CandidateCareerPrefScreen(
                                      edit: true,
                                      jovpreid: data.id,
                                      jobprelength: myResumeController
                                          .myresume!.careerPreference!.length,
                                    ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: CareerPreferenceWidget(
                                      functionalArea: data.functionalarea ==
                                              null
                                          ? ""
                                          : data.functionalarea!.functionalname,
                                      location: data.division == null ||
                                              data.division!.cityid == null
                                          ? ""
                                          : "${data.division!.divisionname}, "
                                              '${data.division!.cityid!.name}',
                                      salary: data.salaray == null
                                          ? ""
                                          : data.salaray!.minSalary!.type ==
                                                      0 &&
                                                  data.salaray!.maxSalary!
                                                          .type ==
                                                      0
                                              ? "Negotiable"
                                              : "${data.salaray!.minSalary!.salary}K-" +
                                                  "${data.salaray!.maxSalary!.salary}" +
                                                  "K BDT",
                                      industryList: data.category!.isEmpty
                                          ? []
                                          : List.generate(
                                              data.category!.length,
                                              (index) => data.category![index]
                                                  .categoryname!),
                                    ),
                                  ),
                                ),
                              );
                            });
                  },
                ),
                const Gap(35),

                /// Add More Jobs
                GetBuilder<MyResumeController>(builder: (_) {
                  return myResumeController.myresume == null ||
                          myResumeController.myresume!.careerPreference ==
                              null ||
                          myResumeController
                                  .myresume!.careerPreference!.length ==
                              5
                      ? SizedBox()
                      : IconAndTextBtn(
                          btnwidth: double.maxFinite,
                          text: "Add More Preferences",
                          borderRadius: 3,
                          bgColor: AppColors.mainColor.withOpacity(.1),
                          borderColor: AppColors.mainColor.withOpacity(.25),
                          onTap: myResumeController.isresumeLoading.value
                              ? null
                              : () {
                                  HiveHelp.write(
                                      Keys.isSeekerFromMainProfilePage, true);
                                  Get.toNamed(
                                    RouteHelper.getCandidateCareerPrefRoute(),
                                  );
                                  CandidateCareerPrefController.to
                                      .resetSingleCareerPref();
                                },
                        );
                  //  TransparentButton(

                  //     iconPath: AppImagePaths.add_button,
                  //     widths: Dimensions.screenWidth * .9,
                  //     heights: height(50),
                  //     text: ,
                  //     fontSize: font(16),
                  //     bgColor: AppColors.shadowColor,
                  //     textColor: AppColors.blackColor,
                  //     borderColor: Colors.transparent,
                  //     isPaddingLeft: false,
                  //     isIcon: true,
                  //   );
                }),
                const Gap(42),

                /// What is your job hunting status?
                GestureDetector(
                  onTap: () => print(HiveHelp.read(Keys.authToken)),
                  child: Text("What is your job hunting status?",
                      style: Styles.bodyLargeSemiBold),
                ),
                const Gap(3),
                Container(
                  color: AppColors.appBorder,
                  height: .5,
                  width: width(250),
                ),
                const Gap(25),
                Obx(
                  () => candidateInfoController.isLoading.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Helpers.appLoader2()],
                        )
                      : candidateInfoController.candidateProfileList.isEmpty
                          ? SizedBox()
                          : GestureDetector(
                              onTap: () {
                                if (candidateInfoController
                                        .candidateProfileList[0]
                                        .other!
                                        .jobHunting ==
                                    "Informally Exploring") {
                                  jobSearchingStatusController
                                      .statusSelectedIndex.value = 1;
                                } else if (candidateInfoController
                                        .candidateProfileList[0]
                                        .other!
                                        .jobHunting ==
                                    "Proactively Seeking") {
                                  jobSearchingStatusController
                                      .statusSelectedIndex.value = 0;
                                }
                                if (candidateInfoController
                                        .candidateProfileList[0]
                                        .other!
                                        .moreStatus ==
                                    "Join Instantly") {
                                  jobSearchingStatusController
                                      .moreStatusSelectedIndex.value = 0;
                                } else if (candidateInfoController
                                        .candidateProfileList[0]
                                        .other!
                                        .moreStatus ==
                                    "1 week notice period") {
                                  jobSearchingStatusController
                                      .moreStatusSelectedIndex.value = 1;
                                } else if (candidateInfoController
                                        .candidateProfileList[0]
                                        .other!
                                        .moreStatus ==
                                    "2 week notice period") {
                                  jobSearchingStatusController
                                      .moreStatusSelectedIndex.value = 2;
                                } else if (candidateInfoController
                                        .candidateProfileList[0]
                                        .other!
                                        .moreStatus ==
                                    "2 week+ notice period") {
                                  jobSearchingStatusController
                                      .moreStatusSelectedIndex.value = 3;
                                }
                                jobSearchingStatusController.switchVal.value =
                                    candidateInfoController
                                        .candidateProfileList[0]
                                        .other!
                                        .jobRightNow!;

                                Get.toNamed(
                                    RouteHelper.getJobHuntingStatusRoute());
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        candidateInfoController
                                                    .candidateProfileList[0]
                                                    .other!
                                                    .jobRightNow ==
                                                true
                                            ? Text(
                                                "I’m not looking for any job right now",
                                                style: Styles.bodyMedium2,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis)
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: height(candidateInfoController
                                                                    .candidateProfileList[
                                                                        0]
                                                                    .other!
                                                                    .jobHunting ==
                                                                null
                                                            ? 13
                                                            : 0)),
                                                    child: Text(
                                                        candidateInfoController
                                                                .candidateProfileList[
                                                                    0]
                                                                .other!
                                                                .jobHunting ??
                                                            "Please add a job hunting status",
                                                        style:
                                                            Styles.bodyMedium2,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  const Gap(5),
                                                  Text(
                                                    candidateInfoController
                                                            .candidateProfileList[
                                                                0]
                                                            .other!
                                                            .moreStatus ??
                                                        "",
                                                    style: Styles.bodyMedium2,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                    SvgPicture.asset(
                                        AppImagePaths.arrowForwardIcon),
                                  ],
                                ),
                              ),
                            ),
                ),
                const Gap(60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

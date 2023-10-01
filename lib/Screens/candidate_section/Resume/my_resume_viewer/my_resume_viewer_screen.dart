// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:bringin/controllers/candidate_section/candidate_edit_main_profile_controller.dart';
import 'package:bringin/controllers/candidate_section/my_resume_controller.dart';
import 'package:bringin/controllers/candidate_section/my_skills_controller.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../widgets/app_bar.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../widgets/my_skills_tile.dart';
import '../../../../widgets/portfolio_tile.dart';
import '../my_resume/components/row_layout.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/dimensions.dart';
import '../my_resume/components/education_qualification.dart';
import '../my_resume/components/career_preferences.dart';
import '../my_resume/components/work_experience_tile.dart';
import 'components/icon_and_text.dart';
import 'package:share_plus/share_plus.dart';

class MyResumeViewerScreen extends StatelessWidget {
  MyResumeViewerScreen({super.key});
  MySkillsController mySkillsController = Get.put(MySkillsController());

  int differentedu(DateTime date1, DateTime date2) {
    LocalDate a = LocalDate.dateTime(date1);
    LocalDate b = LocalDate.dateTime(date2);
    Period diff = b.periodSince(a);
    return diff.years;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        actions: [
          IconButton(
              onPressed: () async {
                if (MyResumeController.to.myresume != null) {
                  var id = MyResumeController.to.myresume!.id;
                  print(id);
                  var result = await Share.shareWithResult(
                      'https://bringin.io/candidate-profile/$id');
                  if (result.status == ShareResultStatus.success) {
                    print('Successfully shared');
                    Helpers().showToastMessage(msg: "Successfully shared");
                  }
                }
              },
              icon: SvgPicture.asset(
                AppImagePaths.shareLink,
                width: width(32),
                height: height(32),
              )),
          const Gap(20),
        ],
        onBackPressed: () => Get.back(),
      ),
      body: GetBuilder<MyResumeController>(builder: (myResumeController) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// name, photo, designition
              GetBuilder<CandidateEditMainProfileController>(builder: (_) {
                return Container(
                  padding: Dimensions.kDefaultPadding,
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          height: height(65),
                          width: height(65),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: _.profileInfoList[0].image == null
                              ? Image.asset(
                                  AppImagePaths.profile,
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl: AppConstants.imgurl +
                                      _.profileInfoList[0].image!,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, error, stackTrace) =>
                                      Icon(Icons.error, size: height(65)),
                                ),
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _.profileInfoList[0].fastname == null ||
                                      _.profileInfoList[0].lastname == null
                                  ? ""
                                  : _.profileInfoList[0].fastname! +
                                      " " +
                                      _.profileInfoList[0].lastname!,
                              style: Styles.mediumTitle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const Gap(7),
                            myResumeController.myresume!.workexperience!.isEmpty
                                ? SizedBox()
                                : Text(
                                    "${myResumeController.myresume == null || myResumeController.myresume!.workexperience!.isEmpty ? "" : myResumeController.myresume!.workexperience![0].designation ?? ""} | ${myResumeController.myresume!.workexperience!.isEmpty ? "" : myResumeController.myresume!.workexperience![0].companyname ?? ""}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Styles.bodySmall1),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

              Container(
                width: double.maxFinite,
                height: height(106),
                padding: EdgeInsets.symmetric(
                    horizontal: width(20), vertical: height(14)),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: Dimensions.resumeVieweShadowList,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Job hunting status
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Job Hunting Status",
                              style: Styles.bodySmall1,
                            ),
                            const Gap(3),
                            Container(
                              height: .5,
                              width: width(120),
                              color: AppColors.appBorder,
                            ),
                          ],
                        ),
                        myResumeController.myresume == null ||
                                myResumeController.myresume!.userid == null ||
                                myResumeController.myresume!.userid!.other ==
                                    null
                            ? Text("")
                            : myResumeController
                                        .myresume!.userid!.other!.jobRightNow ==
                                    true
                                ? Container(
                                    constraints: BoxConstraints(
                                      maxWidth: width(150),
                                    ),
                                    child: Text(
                                      "Not looking for any job",
                                      style: Styles.bodySmall1,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : Container(
                                    constraints: BoxConstraints(
                                      maxWidth: width(150),
                                    ),
                                    child: Text(
                                      myResumeController.myresume!.userid!
                                              .other!.jobHunting ??
                                          "",
                                      style: Styles.bodySmall1,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                        myResumeController.myresume == null ||
                                myResumeController.myresume!.userid == null ||
                                myResumeController.myresume!.userid!.other ==
                                    null
                            ? SizedBox()
                            : myResumeController
                                        .myresume!.userid!.other!.jobRightNow ==
                                    true
                                ? SizedBox()
                                : Container(
                                    constraints: BoxConstraints(
                                      maxWidth: width(150),
                                    ),
                                    child: Text(
                                      myResumeController.myresume!.userid!
                                              .other!.moreStatus ??
                                          "",
                                      style: Styles.bodySmall1,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                      ],
                    ),
                    const Gap(10),

                    /// divider ande user exp
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height(100),
                            width: .7,
                            color: AppColors.borderColor,
                          ),
                          const Gap(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: IconAndText(
                                    iconPath: AppImagePaths.durationIcon,
                                    text: myResumeController
                                            .myresume!.education!.isEmpty
                                        ? ""
                                        : "${differentedu(myResumeController.myresume!.education![0].startdate!, myResumeController.myresume!.education![0].enddate!)}" +
                                            " Years",
                                    iconSize: height(17),
                                  ),
                                ),
                                IconAndText(
                                  iconPath: AppImagePaths.graduateIcon,
                                  text: myResumeController
                                          .myresume!.education!.isEmpty
                                      ? ""
                                      : myResumeController.myresume!
                                                  .education![0].digree ==
                                              null
                                          ? ""
                                          : myResumeController
                                                  .myresume!
                                                  .education![0]
                                                  .digree!
                                                  .education!
                                                  .name! +
                                              "-" +
                                              myResumeController.myresume!
                                                  .education![0].digree!.name!,
                                ),
                                IconAndText(
                                  iconPath: AppImagePaths.ageIcon,
                                  text: myResumeController.myresume!.userid ==
                                          null
                                      ? ""
                                      : "${different(myResumeController.myresume!.userid!.deatofbirth!)} Years",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),

              // About me
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowLayout(
                    text: "About Me",
                    isIcon: false,
                  ),
                  const Gap(10),
                  myResumeController.myresume!.about == null
                      ? SizedBox(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(""),
                            ),
                          ),
                        )
                      : Padding(
                          padding: Dimensions.kDefaultPadding,
                          child: Text(
                              myResumeController.myresume!.about!.about ?? "",
                              style: Styles.bodySmall2),
                        ),
                ],
              ),
              const Gap(10),

              // Career Preferences\
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowLayout(
                    text: "Career Preferences",
                    isIcon: false,
                  ),
                  const Gap(10),
                  myResumeController.myresume!.careerPreference!.isEmpty
                      ? SizedBox(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(""),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: myResumeController
                              .myresume!.careerPreference!.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            var data = myResumeController
                                .myresume!.careerPreference![index];
                            return Padding(
                              padding: Dimensions.kDefaultPadding,
                              child: CareerPreferenceWidget(
                                isArrowIcon: false,
                                functionalArea:
                                    data.functionalarea!.functionalname,
                                location: data.division == null ||
                                        data.division!.cityid == null
                                    ? ""
                                    : "${data.division!.divisionname},"
                                        "${data.division!.cityid!.name}",
                                salary: data.salaray == null
                                    ? ""
                                    : data.salaray!.minSalary!.type == 0 &&
                                            data.salaray!.maxSalary!.type == 0
                                        ? "Negotiable"
                                        : "${data.salaray!.minSalary!.salary}K-" +
                                            "${data.salaray!.maxSalary!.salary}" +
                                            "K BDT",
                                industryList: data.category!.isEmpty
                                    ? []
                                    : List.generate(
                                        data.category!.length,
                                        (index) => data
                                            .category![index].categoryname!),
                              ),
                            );
                          }),
                ],
              ),
              const Gap(10),

              // work experience
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowLayout(
                    text: "Work Experiences",
                    isIcon: false,
                  ),
                  const Gap(10),
                  myResumeController.myresume!.workexperience!.isEmpty
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          child: Center(child: Text("")),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: myResumeController
                              .myresume!.workexperience!.length,
                          itemBuilder: (BuildContext context, index) {
                            var data = myResumeController
                                .myresume!.workexperience![index];

                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: height(10),
                                  right: width(15),
                                  left: width(15)),
                              child: WorkExperienceTile(
                                isIcon: false,
                                companyName: data.companyname,
                                workDuration:
                                    "${DateFormat("MMM yyyy").format(data.startdate!)} - ${data.enddate!.year > DateTime.now().year ? "Present" : DateFormat("MMM yyyy").format(data.enddate!)}",
                                designation: data.designation,
                                expertise_area: data.expertisearea == null
                                    ? ""
                                    : data.expertisearea!.functionalname,
                                jobDescriptionScreen:
                                    data.dutiesandresponsibilities,
                                jobDescriptionMaxLines: null,
                                jobDescriptionOverflow: TextOverflow.visible,
                              ),
                            );
                          }),
                ],
              ),
              const Gap(10),

              // education qualification
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowLayout(
                    text: "Educational Qualifications",
                    isIcon: false,
                  ),
                  const Gap(10),
                  myResumeController.myresume!.education!.isEmpty
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          child: Center(child: Text("")),
                        )
                      : ListView.builder(
                          itemCount:
                              myResumeController.myresume!.education!.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            var data =
                                myResumeController.myresume!.education![index];

                            return Padding(
                              padding: Dimensions.kDefaultPadding,
                              child: Container(
                                margin: EdgeInsets.only(bottom: height(3)),
                                child: EducationQualify(
                                  isArrowIcon: false,
                                  instituteName: data.institutename,
                                  educationLevel: data.digree == null
                                      ? ""
                                      : data.digree!.education!.name! +
                                          " - " +
                                          data.digree!.name!,
                                  gradePoint:
                                      "${data.subject == null ? "" : data.subject!.name!} - " +
                                          "${data.type == 2 ? data.grade! + " " + data.gradetype! : data.gradetype! + " " + data.grade!}",
                                  educationDuration:
                                      "${DateFormat("MMM yyyy").format(data.startdate!)} - ${DateFormat("MMM yyyy").format(data.enddate!)}",
                                  otherActivities: data.otheractivity,
                                  otherActivitiesMaxLines: null,
                                  otherActivitiesOverflow: TextOverflow.visible,
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
              const Gap(10),

              // my skills section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowLayout(
                    text: "My Skills",
                    isIcon: false,
                  ),
                  const Gap(10),
                  myResumeController.myresume!.skill!.isEmpty
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          child: Center(child: Text("")),
                        )
                      : Padding(
                          padding: Dimensions.kDefaultPadding,
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 8,
                            children: [
                              ...List.generate(
                                  myResumeController.myresume!.skill!.length,
                                  (index) {
                                return MySkillsTile(
                                  indicatorColor: myResumeController
                                                              .myresume!
                                                              .skill!
                                                              .length -
                                                          1 ==
                                                      index
                                                  ? Colors.transparent
                                                  : AppColors.borderColor,
                                                  text: myResumeController.myresume!.skill![index],
                                );
                              }),
                            ],
                          ),
                        ),
                ],
              ),
              const Gap(10),

              // My Portfolio
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowLayout(
                    text: "My Portfolio",
                    isIcon: false,
                  ),
                  myResumeController.myresume!.protfoliolink!.isEmpty
                      ? Center(
                          child: Text(""),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: myResumeController
                              .myresume!.protfoliolink!.length,
                          itemBuilder: (_, index) {
                            var data = myResumeController
                                .myresume!.protfoliolink![index];
                            return InkWell(
                              onTap: () async {
                                try {
                                  if (data.protfoliolink!.contains("http://") ||
                                      data.protfoliolink!
                                          .contains("https://")) {
                                    await launchUrl(
                                        Uri.parse(data.protfoliolink!));
                                  } else {
                                    await launchUrl(Uri.parse(
                                        "https://" + data.protfoliolink!));
                                  }
                                } catch (e) {
                                  Helpers.showAlartMessage(msg: e.toString());
                                }
                              },
                              child: PortfolioTile(
                                text: data.protfoliolink ?? "",
                              ),
                            );
                          }),
                ],
              ),
              const Gap(35),
            ],
          ),
        );
      }),
    );
  }

  int different(DateTime date2) {
    DateTime date1 = DateTime.now();
    int year = date1.difference(date2).inDays;
    return year ~/ 365;
  }
}

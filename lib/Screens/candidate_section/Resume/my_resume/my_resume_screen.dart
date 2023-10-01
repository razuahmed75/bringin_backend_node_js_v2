// ignore_for_file: invalid_use_of_protected_member, must_be_immutable

import 'package:bringin/utils/routes/screen_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:intl/intl.dart';
import '../../../../Hive/hive.dart';
import '../../../../controllers/candidate_section/about_me_controller.dart';
import '../../../../controllers/candidate_section/candidate_career_pref_controller.dart';
import '../../../../controllers/candidate_section/candidate_main_profile_controller.dart';
import '../../../../controllers/candidate_section/education_controller.dart';
import '../../../../controllers/candidate_section/my_portfolio_controller.dart';
import '../../../../controllers/candidate_section/my_resume_controller.dart';
import '../../../../controllers/candidate_section/my_skills_controller.dart';
import '../../../../controllers/candidate_section/resume_management_controller.dart';
import '../../../../controllers/candidate_section/work_experience_controller.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/constants/strings.dart';
import '../../../../res/dimensions.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../utils/services/keys.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/my_skills_tile.dart';
import '../../../../widgets/portfolio_tile.dart';
import 'components/education_qualification.dart';
import 'components/career_preferences.dart';
import 'components/row_layout.dart';
import 'components/upload_resume.dart';
import 'components/user_info.dart';
import 'components/work_experience_tile.dart';

class MyResumeScreen extends StatefulWidget {
  MyResumeScreen({super.key});

  @override
  State<MyResumeScreen> createState() => _MyResumeScreenState();
}

class _MyResumeScreenState extends State<MyResumeScreen> {
  CandidateMainProfileController candidateEditMainProfileController =
      Get.find<CandidateMainProfileController>();

  CandidateMainProfileController profileControll =
      Get.put(CandidateMainProfileController());
  MyResumeController myResumeController = Get.put(MyResumeController());
  var resumeManagementControll = Get.put(ResumeManagementController());
  WorkExperienceController workExperienceController =
      Get.put(WorkExperienceController());
  loadResumeData() async{
    if(myResumeController.myresume == null){
      await myResumeController.getMyResume();
    }
    if(candidateEditMainProfileController.candidateProfileList.isEmpty){
      await candidateEditMainProfileController.getCandidateInfo();
    }
  }
  @override
  void initState() {
    loadResumeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyResumeController>(builder: (resumecontroll) {
      // candidateEditMainProfileController.getCandidateInfo();
      return Scaffold(
          appBar: appBarWidget(
            title: "My Resume",
            actions: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(RouteHelper.getMyResumeViewerRoute());
                  },
                  icon: SvgPicture.asset(
                    AppImagePaths.resume_icon,
                    width: height(32),
                    height: height(32),
                    fit: BoxFit.fitWidth,
                  )),
              const Gap(20),
            ],
            onBackPressed: () => Get.back(),
          ),
          body: SingleChildScrollView(
            child: myResumeController.isresumeLoading.value
                ? SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    child: Center(
                      child: Helpers.appLoader2(),
                    ),
                  )
                : myResumeController.myresume == null
                    ? SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height,
                      child: Center(
                          child: Text("No Data Found", style: Styles.bodyMedium),
                        ),
                    )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
      

                            /// user basic info section
                            Container(
                              width: double.maxFinite,
                              padding: Dimensions.kDefaultPadding,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(20),
                                  UserInfo(),
                                  const Gap(12),

                                  /// a complete profile attracts more recruiters attention.
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        AppImagePaths.circleIcon,
                                        height: height(8),
                                        width: height(8),
                                      ),
                                      Text(AppStrings.myResumeHeader,
                                          style: Styles.smallText2.copyWith(
                                            color: AppColors.blackOpacity80,
                                            fontSize: font(13),
                                          )),
                                      SvgPicture.asset(
                                        AppImagePaths.circleIcon,
                                        height: height(8),
                                        width: height(8),
                                      ),
                                    ],
                                  ),
                                  const Gap(20),
                                ],
                              ),
                            ),
                            const Gap(5),
                            Container(
                              padding: EdgeInsets.all(height(15)),
                              decoration:BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: Dimensions.kRadius,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GetBuilder<
                                              CandidateMainProfileController>(
                                          builder: (_) {
                                        if (profileControll
                                            .candidateProfileList.isEmpty) {
                                          return SizedBox();
                                        }
                                        if(_.candidateProfileList[0].other == null || _.candidateProfileList[0].other!.incomplete == null){
                                          return SizedBox();
                                        }
                                        if(_.candidateProfileList[0].other!.incomplete! < 1){
                                          return SizedBox(
                                            width: resumeManagementControll.uploadresumelist.isNotEmpty && HiveHelp.read(Keys.isUploadeRealAvatar) == true ? Dimensions.screenWidth * .8 : width(250),
                                            child: Text(
                                                "The profile has been fully updated and is now comprehensive.",
                                                style: Styles.bodyMedium),
                                          );
                                        }
                                        return SizedBox(
                                          width: resumeManagementControll.uploadresumelist.isNotEmpty && HiveHelp.read(Keys.isUploadeRealAvatar) == true ? Dimensions.screenWidth * .8 : width(250),
                                          child: Text(
                                              "Your profile has ${profileControll.candidateProfileList[0].other!.incomplete} ${profileControll.candidateProfileList[0].other!.incomplete! > 1 ? "Items":"Item"} to be improved.",
                                              style: Styles.bodyMedium),
                                        );
                                      }),
                                    InkWell(
                                        onTap: resumeManagementControll.uploadresumelist.isNotEmpty && HiveHelp.read(Keys.isUploadeRealAvatar) == true
                                        ? null : () {
                                          setState(() {
                                            MyResumeController.to.isVisible =
                                                !MyResumeController
                                                    .to.isVisible;
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width(8),
                                              vertical: height(8)),
                                          child: Transform.rotate(
                                            angle:
                                                MyResumeController.to.isVisible
                                                    ? -1.5
                                                    : 1.5,
                                            child: SvgPicture.asset(
                                              AppImagePaths.arrowForward2Icon,
                                              height: height(15),
                                              width: width(15),
                                              color: resumeManagementControll.uploadresumelist.isNotEmpty && HiveHelp.read(Keys.isUploadeRealAvatar) == true?
                                              Colors.transparent:AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(15),

                                  /// improvement slider
                                  ImprovementSlider(),
                                  const Gap(10),

                                  //upload resume section
                                  MyResumeController.to.isVisible
                                      ? UploadResume()
                                      : SizedBox.shrink(),
                                  const Gap(12),
                                  GetBuilder<ResumeManagementController>(builder: (_){
                                    return _.uploadresumelist.isEmpty ? 
                                    SizedBox() 
                                    : Container(
                                      padding: EdgeInsets.symmetric(horizontal: width(12),vertical: height(7)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(radius(16)),
                                        border: Border.all(
                                          color: AppColors.mainColor.withOpacity(.3),
                                        ),
                                      ),
                                      child: Text(
                                        "${_.uploadresumelist.length} Resume Uploaded",
                                        style: Styles.smallText1,
                                      ),
                                    );
                                  }),

                                ],
                              ),
                            ),

                            /// resume editing section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // About me
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowLayout(
                                      text: "About Me",
                                      firstImagePath: AppImagePaths.about_me,
                                      secondImagePath: AppImagePaths.edit1,
                                      onTap: () {
                                        Get.toNamed(
                                          RouteHelper.getAboutMeRoute());
                                        AboutMeController.to.textEditingController.text = resumecontroll.myresume!.about == null ? "" : resumecontroll.myresume!.about!.about ?? "";
                                        AboutMeController.to.characterLength.value = AboutMeController.to.textEditingController.text.length;
                                      },
                                    ),
                                    resumecontroll.myresume!.about == null
                                        ? SizedBox(
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(""),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: Dimensions.kDefaultPadding,
                                            child: Text(
                                                resumecontroll
                                                    .myresume!.about!.about ?? "",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Styles.bodySmall2),
                                          ),
                                  ],
                                ),

                                // Career Preferences
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowLayout(
                                      text: "Career Preferences",
                                      firstImagePath: AppImagePaths.career_pref,
                                      onTap: () => Get.toNamed(RouteHelper
                                          .getCareerPreferenceRoute()),
                                    ),
                                    resumecontroll
                                            .myresume!.careerPreference!.isEmpty
                                        ? SizedBox(
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                    ""),
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: resumecontroll.myresume!
                                                .careerPreference!.length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder:
                                                (BuildContext context, index) {   
                                              var data = resumecontroll
                                                  .myresume!
                                                  .careerPreference![index];
                                              return InkWell(
                                                onTap: () {
                                                  print(data.division);
                                                  CandidateCareerPrefController
                                                      .to
                                                      .getSingleCareerPref(
                                                          index: index);
                                                  Get.to(
                                                      CandidateCareerPrefScreen(
                                                    edit: true,
                                                    jovpreid: data.id!,
                                                  ));
                                                },
                                                child: Padding(
                                                  padding: Dimensions
                                                      .kDefaultPadding,
                                                  child: CareerPreferenceWidget(
                                                    functionalArea:
                                                        data.functionalarea ==
                                                                null
                                                            ? ""
                                                            : data
                                                                .functionalarea!
                                                                .functionalname,
                                                    location: data.division ==
                                                                null ||
                                                            data.division!
                                                                    .cityid ==
                                                                null
                                                        ? ""
                                                        : "${data.division!.divisionname},""${data.division!.cityid!.name}"
                                                            ,
                                                    salary: data.salaray == null || data.salaray!.minSalary == null || data.salaray!.maxSalary == null
                                                        ? ""
                                                        : data.salaray!.minSalary!.type == 0 && data.salaray!.maxSalary!.type == 0 
                                                        ? "Negotiable" :
                                                         "${data.salaray!.minSalary!.salary}K-" +
                                                            "${data.salaray!.maxSalary!.salary}K BDT",
                                                    industryList: data.category!.isEmpty ? [] : List.generate(
                                                        data.category!.length,
                                                        (index) => data
                                                            .category![index]
                                                            .categoryname!),
                                                  ),
                                                ),
                                              );
                                            }),
                                  ],
                                ),

                                // work experience
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowLayout(
                                        text: "Work Experiences",
                                        firstImagePath: AppImagePaths.work_exp,
                                        onTap: () {
                                          workExperienceController
                                              .resetSingleWorkExps();
                                          HiveHelp.write(Keys.isWorkExpDeleteOption,
                                              false);
                                          Get.toNamed(RouteHelper
                                              .getWorkExperienceRoute());
                                        }),
                                    resumecontroll
                                            .myresume!.workexperience!.isEmpty
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 80,
                                            child: Center(
                                                child: Text(
                                                    "")),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: resumecontroll.myresume!
                                                .workexperience!.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              var data = resumecontroll
                                                  .myresume!
                                                  .workexperience![index];
                                              ;
                                              return InkWell(
                                                onTap: () {
                                                  
                                                  print(data.id);
                                                  HiveHelp.write(
                                                      Keys.isWorkExpDeleteOption,
                                                      true);
                                                  workExperienceController
                                                      .getSingleWorkExps(
                                                          index: index);
                                                  Get.to(() =>
                                                      WorkExperienceScreen(
                                                          experienceId:
                                                              data.id));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: height(10),
                                                      right: width(15),
                                                      left: width(15)),
                                                  child: WorkExperienceTile(
                                                    companyName:
                                                        data.companyname,
                                                    workDuration: "${DateFormat("MMM yyyy").format(data.startdate!)} - ${data.enddate!.year > DateTime.now().year ? "Present" : DateFormat("MMM yyyy").format(data.enddate!)}",
                                                    designation: data.designation,
                                                    expertise_area: data.expertisearea == null ? "" : data.expertisearea!.functionalname,
                                                    jobDescriptionScreen: data
                                                        .dutiesandresponsibilities,
                                                  ),
                                                ),
                                              );
                                            }),
                                  ],
                                ),

                                // education qualification
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowLayout(
                                        text: "Educational Qualifications",
                                        firstImagePath:
                                            AppImagePaths.graduateIcon,
                                        firstIconSize: height(20),
                                        onTap: () {
                                          HiveHelp.write(
                                              Keys.isEducationDeleteOption,
                                              false);
                                          EducationController.to
                                              .resetSingleEducationData();
                                          Get.toNamed(
                                              RouteHelper.getEducationRoute());
                                        }),
                                    resumecontroll.myresume!.education!.isEmpty
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 80,
                                            child: Center(
                                                child: Text(
                                                    "")),
                                          )
                                        : ListView.builder(
                                          padding: EdgeInsets.zero,
                                            itemCount: resumecontroll
                                                .myresume!.education!.length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              var data = resumecontroll
                                                  .myresume!.education![index];
                                              return InkWell(
                                                onTap: () {
                                                  HiveHelp.write(
                                                      Keys.isEducationDeleteOption,
                                                      true);
                                                  print(data.id);
                                                  EducationController.to
                                                      .getSingleEducationData(
                                                          index: index);
                                                  Get.to(() => EducationScreen(
                                                      educationId: data.id));
                                                },
                                                child: Padding(
                                                  padding: Dimensions
                                                      .kDefaultPadding,
                                                  child: EducationQualify(
                                                    instituteName:
                                                        data.institutename ==
                                                                null
                                                            ? ""
                                                            : data
                                                                .institutename,
                                                    educationLevel:
                                                        data.digree == null
                                                            ? ""
                                                            : data
                                                                    .digree!
                                                                    .education!
                                                                    .name! +
                                                                " - " +
                                                                data.digree!
                                                                    .name!,
                                                    gradePoint: 
                                                        "${data.subject == null ? "" : data.subject!.name!} - " + "${data.type == 2 
                                                             ? data.grade! + " "+ data.gradetype! : data.gradetype! +
                                                                " " +
                                                                data.grade!}",
                                                    educationDuration: "${DateFormat("MMM yyyy").format(data.startdate!)} - ${DateFormat("MMM yyyy").format(data.enddate!)}",
                                                    otherActivities: data.otheractivity,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  ],
                                ),

                                // my skills section
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowLayout(
                                      text: "My Skills",
                                      firstImagePath: AppImagePaths.skills,
                                      onTap: () {
                                        if(resumecontroll.myresume!.skill!.isNotEmpty){
                                          MySkillsController.to.selectedSkill.clear();
                                          for(var i in resumecontroll.myresume!.skill!){
                                            MySkillsController.to.selectedSkill.add(i);
                                          }
                                          Get.to(()=> MySkillScreen(categoryId: myResumeController.myresume!.careerPreference![0].functionalarea!.categoryid));
                                        }else{
                                          Get.to(()=> MySkillScreen(categoryId: myResumeController.myresume!.careerPreference![0].functionalarea!.categoryid));
                                        }  
                                      },
                                    ),
                                    resumecontroll.myresume!.skill!.isEmpty
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 80,
                                            child: Center(
                                                child: Text(
                                                    "")),
                                          )
                                        : Padding(
                                            padding: Dimensions.kDefaultPadding,
                                            child: Wrap(
                                              spacing: 5,
                                              runSpacing: 8,
                                              children: [
                                                ...List.generate(
                                                    resumecontroll
                                                        .myresume!
                                                        .skill!
                                                        .length, (index) {
                                                  return MySkillsTile(
                                                    indicatorColor: myResumeController.myresume!.skill!.length - 1 == index
                      ? Colors.transparent
                      : AppColors.borderColor,
                      text: resumecontroll.myresume!.skill![index],
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                                const Gap(5),
                                
                                // My Portfolio
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowLayout(
                                        text: "My Portfolio",
                                        firstImagePath: AppImagePaths.worldIcon,
                                        onTap: () {
                                          HiveHelp.write(
                                              Keys.isPortfolioDeleteOption,
                                              false);
                                          Get.toNamed(
                                              RouteHelper.getMyPortfolioRoute());
                                        }),
                                    resumecontroll
                                            .myresume!.protfoliolink!.isEmpty
                                        ? Center(
                                            child:
                                                Text(""),
                                          )
                                        : ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: resumecontroll.myresume!
                                                .protfoliolink!.length,
                                            itemBuilder: (_, index) {
                                              return InkWell(
                                                onTap: () {
                                                  HiveHelp.write(
                                                      Keys.isPortfolioDeleteOption,
                                                      true);
                                                  Get.to(() => MyPortfolioScreen(
                                                      portfolioId:
                                                          resumecontroll
                                                              .myresume!
                                                              .protfoliolink![
                                                                  index]
                                                              .id!));
                                                  MyPortfolioController
                                                          .to
                                                          .textFieldController
                                                          .text =
                                                      resumecontroll
                                                          .myresume!
                                                          .protfoliolink![index]
                                                          .protfoliolink!;
                                                  MyPortfolioController.to.characterLen.value = 
                                                  MyPortfolioController.to.textFieldController.text.length;
                                                  MyPortfolioController.to.inputText.value = resumecontroll
                                                          .myresume!
                                                          .protfoliolink![index]
                                                          .protfoliolink!;
                                                },
                                                child: PortfolioTile(
                                                  text: resumecontroll.myresume!.protfoliolink![index].protfoliolink!,
                                                ),
                                              );
                                            }),
                                  ],
                                ),
                              ],
                            ),
                            const Gap(35),
                          ]),
          ));
    });
  }

  Widget ImprovementSlider() {
    return GetBuilder<CandidateMainProfileController>(builder: (_) {
      return _.candidateProfileList.isEmpty
          ? SizedBox()
          : Container(
              width: Dimensions.screenWidth,
              height: 20.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _.candidateProfileList[0].other!.totalStep,
                itemBuilder: (context, index) {
                  print(profileControll.candidateProfileList[0].other!.totalStep! -
                      profileControll.candidateProfileList[0].other!.complete!);
                  if (index < _.candidateProfileList[0].other!.complete!) {
                    return Row(
                      children: [
                        Container(
                          height: height(18),
                          width: height(18),
                          padding: EdgeInsets.all(height(5)),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(AppImagePaths.check7),
                        ),
                       index + 1 == _.candidateProfileList[0].other!.totalStep ? SizedBox() : Container(
                          height: 2.5,
                          width: Dimensions.screenWidth*.09,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Incomplete step with white circle design
                    return Row(
                      children: [
                        index + 1 == _.candidateProfileList[0].other!.totalStep
                            ? Container(
                                height: height(18),
                                width: height(18),
                                padding: EdgeInsets.all(height(5)),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          AppColors.borderColor.withOpacity(.5),
                                      width: 2.2),
                                  shape: BoxShape.circle,
                                ),
                              )
                            : Container(
                                height: height(18),
                                width: height(18),
                                padding: EdgeInsets.all(height(5)),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 2),
                                      color: AppColors.shadowColor,
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                        index + 1 == _.candidateProfileList[0].other!.totalStep
                            ? SizedBox()
                            : Container(
                                height: 2.5,
                                width: Dimensions.screenWidth*.09,
                                color: AppColors.borderColor.withOpacity(.5),
                              ),
                      ],
                    );
                  }
                },
              ));
    });
  }
}

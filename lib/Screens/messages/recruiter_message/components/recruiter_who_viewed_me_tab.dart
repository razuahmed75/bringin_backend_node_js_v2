import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../../../../Hive/hive.dart';
import '../../../../controllers/both_category/bottom_nav_controller.dart';
import '../../../../controllers/candidate_section/candidate_controll.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/constants/strings.dart';
import '../../../../res/dimensions.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../utils/services/keys.dart';
import '../../../../widgets/candidates_tile.dart';
import '../../../../widgets/empty_who_saved_me_widget.dart';
import '../../../recruiter_section/candidate_details_screen.dart';

class RecruiterWhoViewedMeTab extends StatefulWidget {
  const RecruiterWhoViewedMeTab({super.key});

  @override
  State<RecruiterWhoViewedMeTab> createState() =>
      _RecruiterWhoViewedMeTabState();
}

class _RecruiterWhoViewedMeTabState extends State<RecruiterWhoViewedMeTab> {
  BottomNavController _bottomNavController = Get.find();
  CandidateControll candidateControll = Get.put(CandidateControll());
  Box? hiddenIndices;
  var isLoading = false;
  load()async{
    setState(() {
      isLoading = true;
    });
    await CandidateControll.to.getWhoViewedMe();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    hiddenIndices = Hive.box(Keys.hiveinit);
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Obx(()=> CandidateControll.to.isLoading.value ? 
   return isLoading ? Center(
      child: Helpers.appLoader2(),
    ) : CandidateControll.to.whoViewedMeList.isEmpty 
    ? EmptyWhoSavedMe(
      onTap: () => _bottomNavController.goToInitialPage(),
      icon: AppImagePaths.emptyViewedMe,
      description: AppStrings.whoViewedMeDes,
    ) 
    : ListView.builder(
      itemCount: CandidateControll.to.whoViewedMeList.length,
      itemBuilder: (_,index){
      var candidateData = CandidateControll.to.whoViewedMeList[index];
      bool isNewVisible = !hiddenIndices!.containsKey(candidateData.id);
            return InkWell(
              onTap: () {
                print(candidateData.id.toString());
                print(HiveHelp.read(Keys.authToken));
                Get.to(CandidateDetailsScreen(
                  index: candidateData,
                  isArrowIcon: true,
                ));
               CandidateControll.to.candidateViewCount(
                fields: {
                  "candidate_profileid" : candidateData.id,
                  "candidate_id" : candidateData.userid
                }
              );
              setState(() {
                hiddenIndices!.put(candidateData.id, candidateData.id);
              });
              },
              child: CandidatesTile(
                name: candidateData.userid == null
                    ? ""
                    : "${candidateData.userid!.fastname ?? ""}" +
                        " " +
                        "${candidateData.userid!.lastname ?? ""}",
                designation: candidateData.workexperience!.isEmpty
                    ? ""
                    : candidateData
                            .workexperience![0].designation ??
                        "",
                avatar: candidateData.userid == null ||
                        candidateData.userid!.image == null
                    ? "https://www.w3schools.com/howto/img_avatar.png"
                    : AppConstants.imgurl +
                        candidateData.userid!.image!,
                educational_level: candidateData
                        .education!.isEmpty
                    ? ""
                    : candidateData.education![0].digree!.name ??
                        "",
                experienceLevel: candidateData.userid == null ||
                        candidateData.userid!.experiencedlevel ==
                            null
                    ? ""
                    : candidateData
                            .userid!.experiencedlevel!.name ??
                        "",
                salaryRange:
                    candidateData.careerPreference!.isEmpty ||
                            candidateData.careerPreference![0]
                                    .salaray ==
                                null || candidateData
                                        .careerPreference![0]
                                        .salaray!
                                        .minSalary == null || candidateData
                                        .careerPreference![0]
                                        .salaray!
                                        .maxSalary == null
                        ? ""
                        : candidateData
                                        .careerPreference![0]
                                        .salaray!
                                        .minSalary!
                                        .type ==
                                    0 &&
                                candidateData
                                        .careerPreference![0]
                                        .salaray!
                                        .maxSalary!
                                        .type ==
                                    0
                            ? "Negotiable"
                            : candidateData.careerPreference![0]
                                    .salaray!.minSalary!.salary
                                    .toString() +
                                "K-" +
                                candidateData.careerPreference![0]
                                    .salaray!.maxSalary!.salary
                                    .toString() +
                                "K " +
                                candidateData
                                    .careerPreference![0]
                                    .salaray!
                                    .minSalary!
                                    .currency!,
                instituteName: candidateData.education!.isEmpty
                    ? ""
                    : candidateData.education![0].institutename!,
                subject_name: candidateData.education!.isEmpty ||
                        candidateData.education![0].subject ==
                            null
                    ? ""
                    : candidateData.education![0].subject!.name!,

                skills: candidateData.skill!.isEmpty
                    ? []
                    : List.generate(
                        candidateData.skill!.length,
                        (i) =>
                            candidateData.skill![i]),
                location: candidateData.careerPreference!.isEmpty
                    ? ""
                    : candidateData.careerPreference![0]
                                    .division ==
                                null ||
                            candidateData.careerPreference![0]
                                    .division!.cityid ==
                                null
                        ? ""
                        : candidateData.careerPreference![0]
                                .division!.divisionname! + ", " + candidateData.careerPreference![0]
                                .division!.cityid!.name! ,
                       companyName: candidateData.workexperience!.isEmpty 
                              ? "": candidateData.workexperience![0].companyname!,
                              workDuration: candidateData.workexperience!.isEmpty 
                              ? "": "${DateFormat("MMM yyyy").format(candidateData.workexperience![0].startdate!)} - ${candidateData.workexperience![0].enddate!.year > DateTime.now().year ? "Present" :  DateFormat("MMM yyyy").format(candidateData.workexperience![0].enddate!)}",     
                            
                child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Viewed your profile",
                            style: Styles.smallText2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (isNewVisible)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width(4), vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.newBtnColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "New",
                                style: Styles.smallText.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            );
    });
    // );
  }
}

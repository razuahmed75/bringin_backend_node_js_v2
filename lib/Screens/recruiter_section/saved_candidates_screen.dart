import 'package:bringin/Screens/recruiter_section/saved_candidate_details_screen.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Hive/hive.dart';
import '../../controllers/candidate_section/candidate_controll.dart';
import '../../res/app_font.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/services/helpers.dart';
import '../../utils/services/keys.dart';
import '../../widgets/candidates_tile.dart';

class SavedCandidatesScreen extends StatefulWidget {
  const SavedCandidatesScreen({super.key});

  @override
  State<SavedCandidatesScreen> createState() => _SavedCandidatesScreenState();
}

class _SavedCandidatesScreenState extends State<SavedCandidatesScreen> {
  final candidatecontroll = Get.put(CandidateControll());

  bool loading = false;

  Future getloaddata() async {
    setState(() {
      loading = true;
    });
    await candidatecontroll.viewsavecandidate();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getloaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(
          title: "Saved Candidates",
          onBackPressed: () => Get.back(),
          actions: [],
        ),
        body: loading
            ? Center(
                child: Helpers.appLoader2(),
              )
            : GetBuilder<CandidateControll>(builder: (_) {
                if (candidatecontroll.savecandidateList.isEmpty) {
                  return Container(
                    height: Dimensions.screenHeight,
                    width: Dimensions.screenWidth,
                    child: Center(
                      child:
                          Text("No candidates found", style: Styles.bodyMedium),
                    ),
                  );
                }
                return Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: candidatecontroll.savecandidateList.length,
                    itemBuilder: (context, index) {
                      var candidateData = candidatecontroll
                          .savecandidateList[index].candidatefullprofile;
                      return InkWell(
                        onTap: () {
                          print(HiveHelp.read(Keys.authToken));
                          Get.to(ViewCandidateDetailsScreen(
                            index: candidateData,
                            isArrowIcon: true,
                          ));
                        },
                        child: CandidatesTile(
                          name: candidateData == null ||
                                  candidateData.userid == null
                              ? ""
                              : "${candidateData.userid!.fastname ?? ""}" +
                                  " " +
                                  "${candidateData.userid!.lastname ?? ""}",
                          designation: candidateData == null ||
                                  candidateData.workexperience!.isEmpty
                              ? ""
                              : candidateData.workexperience![0].designation ??
                                  "",
                          avatar: candidateData == null ||
                                  candidateData.userid == null ||
                                  candidateData.userid!.image == null
                              ? "https://www.w3schools.com/howto/img_avatar.png"
                              : AppConstants.imgurl +
                                  candidateData.userid!.image!,
                          educational_level: candidateData == null ||
                                  candidateData.education!.isEmpty ||
                                  candidateData.education![0].digree == null
                              ? ""
                              : candidateData.education![0].digree!.name ?? "",
                          experienceLevel: candidateData == null ||
                                  candidateData.userid == null ||
                                  candidateData.userid!.experiencedlevel == null
                              ? ""
                              : candidateData.userid!.experiencedlevel!.name ??
                                  "",
                          salaryRange: candidateData == null ||
                                  candidateData.careerPreference!.isEmpty ||
                                  candidateData.careerPreference![0].salaray ==
                                      null
                              ? ""
                              : candidateData.careerPreference![0].salaray!.minSalary!.type == 0 && candidateData.careerPreference![0].salaray!.maxSalary!.type == 0 
                              ? "Negotiable" : candidateData
                                      .careerPreference![0].salaray!.minSalary!.salary.toString() +
                                  "K-" +
                                  candidateData
                                      .careerPreference![0].salaray!.maxSalary!.salary.toString() +
                                  "K " +
                                  candidateData
                                      .careerPreference![0].salaray!.minSalary!.currency!,
                          instituteName: candidateData == null ||
                                  candidateData.education!.isEmpty
                              ? ""
                              : candidateData.education![0].institutename ?? "",
                          subject_name: candidateData == null ||
                                  candidateData.education!.isEmpty ||
                                  candidateData.education![0].subject == null
                              ? ""
                              : candidateData.education![0].subject!.name ?? "",
                          skills: candidateData == null ||
                                  candidateData.skill!.isEmpty
                              ? []
                              : List.generate(candidateData.skill!.length,
                                  (i) => candidateData.skill![i]),
                          location: candidateData == null ||
                                  candidateData.careerPreference!.isEmpty
                              ? ""
                              : candidateData.careerPreference![0].division ==
                                          null ||
                                      candidateData.careerPreference![0].division!
                                              .cityid ==
                                          null
                                  ? ""
                                  : candidateData.careerPreference![0].division!
                                          .cityid!.name! +
                                      "," +
                                      candidateData.careerPreference![0].division!
                                          .divisionname!,
                          description:
                              candidateData == null || candidateData.about == null
                                  ? ""
                                  : candidateData.about!.about ?? "",
                          companyName: candidateData!.workexperience!.isEmpty 
                              ? "": candidateData.workexperience![0].companyname!,
                              workDuration: candidateData.workexperience!.isEmpty 
                              ? "": "${DateFormat("MMM yyyy").format(candidateData.workexperience![0].startdate!)} - ${candidateData.workexperience![0].enddate!.year > DateTime.now().year ? "Present" :  DateFormat("MMM yyyy").format(candidateData.workexperience![0].enddate!)}",
                        ),
                      );
                    },
                  ),
                );
              }));
  }
}

import 'package:bringin/Screens/recruiter_section/manage_jobs/components/rejectcandidateview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../Hive/hive.dart';
import '../../../../controllers/recruiter_section/managejob_controll.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../utils/services/keys.dart';
import '../../../../widgets/candidates_tile.dart';
import '../../../../widgets/empty_job_post_tile.dart';

class RejectedTab extends StatefulWidget {
  const RejectedTab({super.key});

  @override
  State<RejectedTab> createState() => _RejectedTabState();
}

class _RejectedTabState extends State<RejectedTab> {
  final managejobcontrol = Get.put(ManagejobControll());

  bool loading = true;

  Future loaddata() async {
    await managejobcontrol.getrejectjob();
    if(mounted){
      setState(() {
      loading = false;
    });
    }
  }

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagejobControll>(
      builder: (controller) {
        return loading
            ? Helpers.appLoader()
            : controller.rejectedCandidateList.isEmpty
                ? EmptyJobPostTile(text: "There are no rejected candidates",imagePath: AppImagePaths.rejected_candidate)
                : Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: controller.rejectedCandidateList.length,
                        itemBuilder: (_, index) {
                          var candidateData = controller
                              .rejectedCandidateList[index]
                              .candidatefullprofileid;
                          return InkWell(
                            onTap: () {
                              print(HiveHelp.read(Keys.authToken));
                              Get.to(RejectCandidateDetailsScreen(
                                index: candidateData,
                                isArrowIcon: true,
                              ))!
                                  .then((value) => controller.getrejectjob());
                            },
                            child: CandidatesTile(
                              name: candidateData!.userid == null
                                  ? ""
                                  : candidateData.userid!.fastname! +
                                      " " +
                                      candidateData.userid!.lastname!,
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
                                              null
                                      ? ""
                                      : candidateData.careerPreference![0].salaray!.minSalary!.type == 0 && candidateData.careerPreference![0].salaray!.maxSalary!.type == 0 
                                      ? "Negotiable" : candidateData.careerPreference![0]
                                              .salaray!.minSalary!.salary.toString() +
                                          "K-" +
                                          candidateData.careerPreference![0]
                                              .salaray!.maxSalary!.salary.toString() +
                                          "K " +
                                          candidateData.careerPreference![0]
                                              .salaray!.minSalary!.currency!,
                              instituteName: candidateData.education!.isEmpty
                                  ? ""
                                  : candidateData.education![0].institutename ??
                                      "",
                              subject_name: candidateData.education!.isEmpty ||
                                      candidateData.education![0].subject ==
                                          null
                                  ? ""
                                  : candidateData.education![0].subject!.name ??
                                      "",
                              skills: candidateData.skill!.isEmpty
                                  ? []
                                  : List.generate(
                                      candidateData.skill!.length,
                                      (i) =>
                                          candidateData.skill![i]),
                              location:
                                  candidateData.careerPreference!.isEmpty ||
                                          candidateData.careerPreference![0]
                                                  .division ==
                                              null ||
                                          candidateData.careerPreference![0]
                                                  .division!.cityid ==
                                              null
                                      ? ""
                                      : candidateData.careerPreference![0]
                                              .division!.divisionname! +
                                          ", " + candidateData.careerPreference![0]
                                              .division!.cityid!.name!
                                          ,
                              description: candidateData.about == null
                                  ? ""
                                  : candidateData.about!.about ?? "",
                              companyName: candidateData.workexperience!.isEmpty 
                              ? "": candidateData.workexperience![0].companyname!,
                              workDuration: candidateData.workexperience!.isEmpty 
                              ? "": "${DateFormat("MMM yyyy").format(candidateData.workexperience![0].startdate!)} - ${candidateData.workexperience![0].enddate!.year > DateTime.now().year ? "Present" :  DateFormat("MMM yyyy").format(candidateData.workexperience![0].enddate!)}",
                            ),
                          );
                        }));
      },
    );
  }
}

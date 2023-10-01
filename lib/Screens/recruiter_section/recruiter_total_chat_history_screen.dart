import 'package:bringin/controllers/candidate_section/candidate_controll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../res/dimensions.dart';
import '../../../../widgets/app_bar.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/candidates_tile.dart';
import 'candidate_details_screen.dart';

class RecruiterTotalChatHistoryScreen extends StatelessWidget {
  final String? id;
  const RecruiterTotalChatHistoryScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    CandidateControll.to.getTotalChatHistory(id: id);
    CandidateControll candidateControll = Get.find();
    return Scaffold(
      appBar: appBarWidget(
          title: "Total Chats", onBackPressed: () => Get.back(), actions: []),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kDefaultgapTop,

            /// JOB TITLE
            Obx(() {
              return candidateControll.isLoading.value
                  ? Helpers.appLoader()
                  : candidateControll.totalChatHistoryList.isEmpty
                      ? Container(
                          height: Dimensions.screenHeight * .5,
                          width: double.maxFinite,
                          child: Center(
                            child: Text("Not found"),
                          ),
                        )
                      : Flexible(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  candidateControll.totalChatHistoryList.length,
                              itemBuilder: (BuildContext context, index) {
                                var candidateData = candidateControll
                                    .totalChatHistoryList[index];
                                return InkWell(
                                  onTap: () {
                                    Get.to(CandidateDetailsScreen(
                                      index: candidateData,
                                      isArrowIcon: true,
                                    ));
                                    candidateControll
                                        .candidateViewCount(fields: {
                                      "candidate_profileid": candidateData.id,
                                      "candidate_id": candidateData.userid
                                    });
                                  },
                                  child: CandidatesTile(
                                    name: candidateData.userid == null
                                        ? ""
                                        : "${candidateData.userid!.fastname ?? ""}" +
                                            " " +
                                            "${candidateData.userid!.lastname ?? ""}",
                                    designation:
                                        candidateData.workexperience!.isEmpty
                                            ? ""
                                            : candidateData.workexperience![0]
                                                    .designation ??
                                                "",
                                    avatar: candidateData.userid == null ||
                                            candidateData.userid!.image == null
                                        ? "https://www.w3schools.com/howto/img_avatar.png"
                                        : AppConstants.imgurl +
                                            candidateData.userid!.image!,
                                    educational_level:
                                        candidateData.education!.isEmpty
                                            ? ""
                                            : candidateData.education![0]
                                                    .digree!.name ??
                                                "",
                                    experienceLevel:
                                        candidateData.userid == null ||
                                                candidateData.userid!
                                                        .experiencedlevel ==
                                                    null
                                            ? ""
                                            : candidateData.userid!
                                                    .experiencedlevel!.name ??
                                                "",
                                    salaryRange: candidateData
                                                .careerPreference!.isEmpty ||
                                            candidateData.careerPreference![0].salaray ==
                                                null ||
                                            candidateData.careerPreference![0]
                                                    .salaray!.minSalary ==
                                                null ||
                                            candidateData.careerPreference![0]
                                                    .salaray!.maxSalary ==
                                                null
                                        ? ""
                                        : candidateData.careerPreference![0].salaray!.minSalary!.type == 0 &&
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
                                                candidateData
                                                    .careerPreference![0]
                                                    .salaray!
                                                    .maxSalary!
                                                    .salary
                                                    .toString() +
                                                "K " +
                                                candidateData
                                                    .careerPreference![0]
                                                    .salaray!
                                                    .minSalary!
                                                    .currency!,
                                    instituteName:
                                        candidateData.education!.isEmpty
                                            ? ""
                                            : candidateData
                                                .education![0].institutename!,
                                    subject_name:
                                        candidateData.education!.isEmpty ||
                                                candidateData.education![0]
                                                        .subject ==
                                                    null
                                            ? ""
                                            : candidateData
                                                .education![0].subject!.name!,
                                    skills: candidateData.skill!.isEmpty
                                        ? []
                                        : List.generate(
                                            candidateData.skill!.length,
                                            (i) => candidateData.skill![i]),
                                    location: candidateData
                                            .careerPreference!.isEmpty
                                        ? ""
                                        : candidateData.careerPreference![0]
                                                        .division ==
                                                    null ||
                                                candidateData
                                                        .careerPreference![0]
                                                        .division!
                                                        .cityid ==
                                                    null
                                            ? ""
                                            : candidateData.careerPreference![0]
                                                    .division!.divisionname! +
                                                ", " +
                                                candidateData
                                                    .careerPreference![0]
                                                    .division!
                                                    .cityid!
                                                    .name!,
                                    description: candidateData.about == null
                                        ? ""
                                        : candidateData.about!.about ?? "",
                                    companyName:
                                        candidateData.workexperience!.isEmpty
                                            ? ""
                                            : candidateData.workexperience![0]
                                                .companyname!,
                                    workDuration: candidateData
                                            .workexperience!.isEmpty
                                        ? ""
                                        : "${DateFormat("MMM yyyy").format(candidateData.workexperience![0].startdate!)} - ${candidateData.workexperience![0].enddate!.year > DateTime.now().year ? "Present" : DateFormat("MMM yyyy").format(candidateData.workexperience![0].enddate!)}",
                                  ),
                                );
                              }),
                        );
            }),
          ],
        ),
      ),
    );
  }
}

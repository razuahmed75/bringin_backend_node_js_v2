import 'dart:developer';
import 'package:bringin/widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../Hive/hive.dart';
import '../../../../../controllers/candidate_section/candidate_controll.dart';
import '../../../../../models/candidate_section/CandidateList/candidatelist_model.dart';
import '../../../../../res/color.dart';
import '../../../../../res/constants/app_constants.dart';
import '../../../../../utils/services/keys.dart';
import '../../../../../widgets/candidates_tile.dart';
import '../../../../recruiter_section/candidate_details_screen.dart';

class CandidateItemPage extends StatefulWidget {
  final int index;

  const CandidateItemPage({super.key, required this.index});

  @override
  State<CandidateItemPage> createState() => _CandidateItemPageState();
}

class _CandidateItemPageState extends State<CandidateItemPage> {
  final candidatecontroll = Get.find<CandidateControll>();

  bool loading = false;

  List<Candidatelist>? candidatelist = [];
  Future loaddata() async {
    setState(() {
      loading = true;
    });
    candidatecontroll.tabIndex.value = widget.index;
    candidatelist = await candidatecontroll.loadcandidate(index: widget.index);
    // candidatecontroll.candidatetabindex.value = widget.index;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CandidateControll>(builder: (_) {
      return loading
          ? ShimmerEffect()
          : candidatelist!.isEmpty
              ? Center(
                  child: Text("No candidates found"),
                )
              : Obx(() => ListView.builder(
                  shrinkWrap: true,
                  itemCount: candidatecontroll.candidatefilter.value
                      ? candidatecontroll.candidatefilterdata.length
                      : candidatecontroll.isCandidateFilter.value 
                      ? candidatecontroll.candidateFilterList.length
                      : candidatelist!.length,
                  itemBuilder: (BuildContext context, index) {
                    var candidateData = candidatecontroll.candidatefilter.value
                        ? candidatecontroll.candidatefilterdata[index]
                        : candidatecontroll.isCandidateFilter.value 
                        ? candidatecontroll.candidateFilterList[index]
                        : candidatelist![index];
                    return InkWell(
                      onTap: () {
                        print(candidateData.userid!.id);
                        log(HiveHelp.read(Keys.authToken));
                        Get.to(CandidateDetailsScreen(
                          index: candidateData,
                          isArrowIcon: true,
                        ));
                        candidatecontroll.candidateViewCount(fields: {
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
                        designation: candidateData.workexperience!.isEmpty
                            ? ""
                            : candidateData.workexperience![0].designation ??
                                "",
                        avatar: candidateData.userid == null ||
                                candidateData.userid!.image == null
                            ? "https://www.w3schools.com/howto/img_avatar.png"
                            : AppConstants.imgurl +
                                candidateData.userid!.image!,
                        educational_level: candidateData.education!.isEmpty
                            ? ""
                            : candidateData.education![0].digree!.name ?? "",
                        experienceLevel: candidateData.userid == null ||
                                candidateData.userid!.experiencedlevel == null
                            ? ""
                            : candidateData.userid!.experiencedlevel!.name ??
                                "",
                        salaryRange: candidateData.careerPreference!.isEmpty ||
                                candidateData.careerPreference![0].salaray ==
                                    null ||
                                candidateData.careerPreference![0].salaray!
                                        .minSalary ==
                                    null ||
                                candidateData.careerPreference![0].salaray!
                                        .maxSalary ==
                                    null
                            ? ""
                            : candidateData.careerPreference![0].salaray!
                                            .minSalary!.type ==
                                        0 &&
                                    candidateData.careerPreference![0].salaray!
                                            .maxSalary!.type ==
                                        0
                                ? "Negotiable"
                                : candidateData.careerPreference![0].salaray!
                                        .minSalary!.salary
                                        .toString() +
                                    "K-" +
                                    candidateData.careerPreference![0].salaray!
                                        .maxSalary!.salary
                                        .toString() +
                                    "K " +
                                    candidateData.careerPreference![0].salaray!
                                        .minSalary!.currency!,
                        instituteName: candidateData.education!.isEmpty
                            ? ""
                            : candidateData.education![0].institutename!,
                        subject_name: candidateData.education!.isEmpty ||
                                candidateData.education![0].subject == null
                            ? ""
                            : candidateData.education![0].subject!.name!,
                        skills: candidateData.skill!.isEmpty
                            ? []
                            : List.generate(candidateData.skill!.length,
                                (i) => candidateData.skill![i]),
                        location: candidateData.careerPreference!.isEmpty
                            ? ""
                            : candidateData.careerPreference![0].division ==
                                        null ||
                                    candidateData.careerPreference![0].division!
                                            .cityid ==
                                        null
                                ? ""
                                : candidateData.careerPreference![0].division!
                                        .divisionname! +
                                    ", " +
                                    candidateData.careerPreference![0].division!
                                        .cityid!.name!,
                        description: candidateData.about == null
                            ? ""
                            : candidateData.about!.about ?? "",
                        companyName: candidateData.workexperience!.isEmpty
                            ? ""
                            : candidateData.workexperience![0].companyname!,
                        workDuration: candidateData.workexperience!.isEmpty
                            ? ""
                            : "${DateFormat("MMM yyyy").format(candidateData.workexperience![0].startdate!)} - ${candidateData.workexperience![0].enddate!.year > DateTime.now().year ? "Present" : DateFormat("MMM yyyy").format(candidateData.workexperience![0].enddate!)}",
                      ),
                    );
                  }));

      // return NestedScrollView(
      //   physics: NeverScrollableScrollPhysics(),
      //     headerSliverBuilder: (context, innerBoxIsScrolled) {
      //       return [
      //       // if (widget.index != 0)  SliverPersistentHeader(delegate: Candidatefilter(widget: filter()),pinned: true),
      //         // if (widget.index != 0) SliverToBoxAdapter(child: Container(height: 50.h,width: double.infinity, child: filter())),
      //         if (widget.index == 0)
      //           SliverToBoxAdapter(
      //               child: SizedBox(
      //             height: 2.h,
      //           )),
      //       ];
      //     },
      //     body: Scaffold(
      //       body: _.candidateloading
      //           ? ShimmerEffect()
      //           : _.candidatelist.isEmpty
      //               ? Center(
      //                   child: Text("No candidates found"),
      //                 )
      //               : ListView.builder(
      //                   shrinkWrap: true,
      //                   itemCount: _.candidatelist.length,
      //                   itemBuilder: (BuildContext context, index) {
      //                     var candidateData = _.candidatelist[index];
      //                     return InkWell(
      //                       onTap: () {
      //                         print(candidateData.userid!.id);
      //                         log(HiveHelp.read(Keys.authToken));
      //                         Get.to(CandidateDetailsScreen(
      //                           index: candidateData,
      //                           isArrowIcon: true,
      //                         ));
      //                         candidatecontroll.candidateViewCount(fields: {
      //                           "candidate_profileid": candidateData.id,
      //                           "candidate_id": candidateData.userid
      //                         });
      //                       },
      //                       child: CandidatesTile(
      //                         name: candidateData.userid == null
      //                             ? ""
      //                             : "${candidateData.userid!.fastname ?? ""}" +
      //                                 " " +
      //                                 "${candidateData.userid!.lastname ?? ""}",
      //                         designation: candidateData.workexperience!.isEmpty
      //                             ? ""
      //                             : candidateData
      //                                     .workexperience![0].designation ??
      //                                 "",
      //                         avatar: candidateData.userid == null ||
      //                                 candidateData.userid!.image == null
      //                             ? "https://www.w3schools.com/howto/img_avatar.png"
      //                             : AppConstants.imgurl +
      //                                 candidateData.userid!.image!,
      //                         educational_level: candidateData
      //                                 .education!.isEmpty
      //                             ? ""
      //                             : candidateData.education![0].digree!.name ??
      //                                 "",
      //                         experienceLevel: candidateData.userid == null ||
      //                                 candidateData.userid!.experiencedlevel ==
      //                                     null
      //                             ? ""
      //                             : candidateData
      //                                     .userid!.experiencedlevel!.name ??
      //                                 "",
      //                         salaryRange: candidateData.careerPreference!.isEmpty ||
      //                                 candidateData.careerPreference![0].salaray ==
      //                                     null ||
      //                                 candidateData.careerPreference![0].salaray!.minSalary ==
      //                                     null ||
      //                                 candidateData.careerPreference![0]
      //                                         .salaray!.maxSalary ==
      //                                     null
      //                             ? ""
      //                             : candidateData.careerPreference![0].salaray!
      //                                             .minSalary!.type ==
      //                                         0 &&
      //                                     candidateData.careerPreference![0]
      //                                             .salaray!.maxSalary!.type ==
      //                                         0
      //                                 ? "Negotiable"
      //                                 : candidateData.careerPreference![0]
      //                                         .salaray!.minSalary!.salary
      //                                         .toString() +
      //                                     "K-" +
      //                                     candidateData.careerPreference![0]
      //                                         .salaray!.maxSalary!.salary
      //                                         .toString() +
      //                                     "K " +
      //                                     candidateData.careerPreference![0]
      //                                         .salaray!.minSalary!.currency!,
      //                         instituteName: candidateData.education!.isEmpty
      //                             ? ""
      //                             : candidateData.education![0].institutename!,
      //                         subject_name: candidateData.education!.isEmpty ||
      //                                 candidateData.education![0].subject ==
      //                                     null
      //                             ? ""
      //                             : candidateData.education![0].subject!.name!,
      //                         studyDuration: candidateData.education!.isEmpty ||
      //                                 candidateData.education![0].startdate ==
      //                                     null ||
      //                                 candidateData.education![0].enddate ==
      //                                     null
      //                             ? ""
      //                             : "${DateFormat("MMM yyyy").format(candidateData.education![0].startdate!)} - ${DateFormat("MMM yyyy").format(candidateData.education![0].enddate!)}",
      //                         skills: candidateData.skill!.isEmpty
      //                             ? []
      //                             : List.generate(
      //                                 candidateData.skill!.length,
      //                                 (i) =>
      //                                     candidateData.skill![i]),
      //                         location: candidateData.careerPreference!.isEmpty
      //                             ? ""
      //                             : candidateData.careerPreference![0]
      //                                             .division ==
      //                                         null ||
      //                                     candidateData.careerPreference![0]
      //                                             .division!.cityid ==
      //                                         null
      //                                 ? ""
      //                                 : candidateData.careerPreference![0]
      //                                         .division!.divisionname! +
      //                                     ", " +
      //                                     candidateData.careerPreference![0]
      //                                         .division!.cityid!.name!,
      //                         description: candidateData.about == null
      //                             ? ""
      //                             : candidateData.about!.about ?? "",
      //                         companyName: candidateData.workexperience!.isEmpty
      //                         ? "": candidateData.workexperience![0].companyname!,
      //                         workDuration: candidateData.workexperience!.isEmpty
      //                         ? "": "${DateFormat("MMM yyyy").format(candidateData.workexperience![0].startdate!)} - ${candidateData.workexperience![0].enddate!.year > DateTime.now().year ? "Present" :  DateFormat("MMM yyyy").format(candidateData.workexperience![0].enddate!)}",
      //                       ),
      //                     );
      //                   }),
      //     ));
    });
  }
}

class Candidatefilter extends SliverPersistentHeaderDelegate {
  final Widget? widget;
  Candidatefilter({this.widget});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      height: 30.h,
      color: AppColors.whiteColor,
      width: double.infinity,
      child: widget,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 30.h;

  @override
  // TODO: implement minExtent
  double get minExtent => 30.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

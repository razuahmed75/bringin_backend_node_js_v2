import 'package:bringin/Hive/hive_collection_var.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../Hive/hive.dart';
import '../../../../../controllers/candidate_section/candidate_controll.dart';
import '../../../../../controllers/candidate_section/select_location_controller.dart';
import '../../../../../models/recent_candidate_search_model.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/color.dart';
import '../../../../../res/constants/app_constants.dart';
import '../../../../../res/constants/image_path.dart';
import '../../../../../res/dimensions.dart';
import '../../../../../utils/services/keys.dart';
import '../../../../../widgets/app_search_form_field.dart';
import '../../../../../widgets/candidates_tile.dart';
import '../../../../recruiter_section/candidate_details_screen.dart';
import '../../../select_location/select_location_screen.dart';

class CandidatesearchScreen extends StatelessWidget {
  const CandidatesearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CandidateControll candidateControll = Get.find();
    return WillPopScope(
      onWillPop: () async {
        candidateControll.candidateNameField.clear();
        candidateControll.searchcandidatelist.clear();
        candidateControll.isSearchTapped.value = false;
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextButton(
              onPressed: () {
                Get.back();
                candidateControll.candidateNameField.clear();
                candidateControll.searchcandidatelist.clear();
                candidateControll.isSearchTapped.value = false;
              },
              child: Text("Cancel", style: Styles.bodyLargeSemiBold)),
          actions: [
            TextButton(
                onPressed: () {
                  if (candidateControll.candidateNameField.text.isEmpty &&
                      candidateControll.candidateLocationField.text.isEmpty) {
                    Helpers().showValidationErrorDialog(
                        errorText:
                            "Candidate name and Location field is required");
                  } else {
                    Helpers.hideKeyboard();
                    candidateControll.candidateSearch(
                        candidateControll.candidateNameField.text.trim(),
                        candidateControll.candidatelocationid);
                    var recentData = RecentCandidateSearchModel(
                      candidateName:
                          candidateControll.candidateNameField.text.trim(),
                      city:
                          candidateControll.candidateLocationField.text.trim(),
                    );
                    recentBox2.put(
                        'key_${candidateControll.candidateNameField.text.trim()}',
                        recentData);
                  }
                },
                child: Text("Search", style: Styles.bodyLargeSemiBold)),
            const Gap(20),
          ],
        ),
        body: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            children: [
              CustomSearchField(
                  controller: candidateControll.candidateNameField,
                  hinText: 'Search by candidate name',
                  radius: radius(24),
                  height: height(38),
                  prefixIcon: Padding(
                    padding: Dimensions.kDefaultPadding,
                    child: SvgPicture.asset(
                      AppImagePaths.searchIcon,
                      alignment: Alignment.center,
                      height: height(14),
                    ),
                  ),
                  suffixIcon: SizedBox()),
              const Gap(10),
              InkWell(
                onTap: () {
                  if (SelectLocationController.to.allLocationList.isEmpty) {
                    SelectLocationController.to.getAllLocation();
                    Get.to(() => SelectLocationScreen(isCandidateSearch: true));
                  } else {
                    Get.to(() => SelectLocationScreen(isCandidateSearch: true));
                  }
                },
                child: IgnorePointer(
                  ignoring: true,
                  child: CustomSearchField(
                      controller: candidateControll.candidateLocationField,
                      hinText: 'Search by location',
                      radius: radius(24),
                      height: height(38),
                      prefixIcon: Padding(
                        padding: Dimensions.kDefaultPadding,
                        child: SvgPicture.asset(
                          AppImagePaths.locationIcon,
                          alignment: Alignment.center,
                          height: height(14),
                        ),
                      ),
                      suffixIcon: SizedBox()),
                ),
              ),
              const Gap(20),
              GetBuilder<CandidateControll>(builder: (_) {
                return Obx(() {
                  if (candidateControll.isSearching.value == true) {
                    return Center(
                      child: Helpers.appLoader2(),
                    );
                  } else if (candidateControll.searchcandidatelist.isEmpty &&
                      candidateControll.isSearchTapped.value == true) {
                    return Container(
                      height: Dimensions.screenHeight * .5,
                      child: Center(
                        child: Text("No candidates found",
                            style: Styles.bodyMedium),
                      ),
                    );
                  }
                  return candidateControll.searchcandidatelist.isEmpty
                      ? recentBox2 != null && recentBox2.isNotEmpty
                          ? RecentSearch(
                              onClear: () => candidateControll.clearAll(),
                              controll: candidateControll)
                          : SizedBox()
                      : SearchedCandidateList(candidateControll);
                });
              })
            ],
          ),
        ),
      ),
    );
  }

  Flexible SearchedCandidateList(CandidateControll candidateControll) {
    return Flexible(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: candidateControll.searchcandidatelist.length,
          itemBuilder: (BuildContext context, index) {
            var candidateData = candidateControll.searchcandidatelist[index];
            return InkWell(
              onTap: () {
                print(candidateData.id.toString());
                print(HiveHelp.read(Keys.authToken));
                Get.to(CandidateDetailsScreen(
                  index: candidateData,
                  isArrowIcon: true,
                ));
                candidateControll.candidateViewCount(fields: {
                  "candidate_profileid": candidateData.id,
                  "candidate_id": candidateData.userid
                });
              },
              child: CandidatesTile(
                name: candidateData.userid == null
                    ? ""
                    : candidateData.userid!.fastname! +
                        " " +
                        candidateData.userid!.lastname!,
                designation: candidateData.workexperience!.isEmpty
                    ? ""
                    : candidateData.workexperience![0].designation ?? "",
                avatar: candidateData.userid == null ||
                        candidateData.userid!.image == null
                    ? "https://www.w3schools.com/howto/img_avatar.png"
                    : AppConstants.imgurl + candidateData.userid!.image!,
                educational_level: candidateData.education!.isEmpty
                    ? ""
                    : candidateData.education![0].digree!.name ?? "",
                experienceLevel: candidateData.userid == null ||
                        candidateData.userid!.experiencedlevel == null
                    ? ""
                    : candidateData.userid!.experiencedlevel!.name ?? "",
                salaryRange: candidateData.careerPreference!.isEmpty
                    ? ""
                    : candidateData.careerPreference![0].salaray!.minSalary!
                                    .type ==
                                0 &&
                            candidateData.careerPreference![0].salaray!
                                    .maxSalary!.type ==
                                0
                        ? "Negotiable"
                        : candidateData
                                .careerPreference![0].salaray!.minSalary!.salary
                                .toString() +
                            "K-" +
                            candidateData
                                .careerPreference![0].salaray!.maxSalary!.salary
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
                    : candidateData.education![0].subject!.name ?? "",
                skills: candidateData.skill!.isEmpty
                    ? []
                    : List.generate(candidateData.skill!.length,
                        (index) => candidateData.skill![index]),
                location: candidateData.careerPreference!.isEmpty ||
                        candidateData.careerPreference![0].division == null ||
                        candidateData.careerPreference![0].division!.cityid ==
                            null
                    ? ""
                    : candidateData
                            .careerPreference![0].division!.cityid!.name! +
                        "," +
                        candidateData
                            .careerPreference![0].division!.divisionname!,
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
          }),
    );
  }

  Widget RecentSearch(
      {void Function()? onClear, required CandidateControll controll}) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          // constraints: BoxConstraints(
          //   minHeight: height(300),
          //   maxWidth: double.infinity,
          //   maxHeight: Dimensions.screenHeight*.6
          // ),

          decoration: BoxDecoration(
            border: Border.all(color: AppColors.appBorder, width: .5),
            borderRadius: BorderRadius.circular(radius(9)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: width(15),
                  right: width(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recent Searches", style: Styles.bodyLarge),
                    IconButton(
                      onPressed: onClear,
                      icon:
                          Icon(Icons.delete_outlined, color: Colors.grey[600]),
                    )
                  ],
                ),
              ),
              const Gap(10),
              Container(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recentBox2.length,
                    itemBuilder: (_, index) {
                      RecentCandidateSearchModel recent =
                          recentBox2.getAt(index);
                      return ListTile(
                        onTap: () {
                          controll.candidateSearch(
                              recent.candidateName, recent.city);
                          controll.candidateNameField.text =
                              recent.candidateName;
                          controll.candidateLocationField.text = recent.city;
                        },
                        title: Text(recent.candidateName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.bodyLarge),
                        subtitle: Text(
                          recent.city,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.bodyMedium3,
                        ),
                        trailing:
                            SvgPicture.asset(AppImagePaths.arrowForwardIcon),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

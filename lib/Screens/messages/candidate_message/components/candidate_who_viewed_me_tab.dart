import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/both_category/bottom_nav_controller.dart';
import '../../../../controllers/candidate_section/job_controll.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/constants/strings.dart';
import '../../../../res/dimensions.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../widgets/empty_who_saved_me_widget.dart';
import '../../../../widgets/jobs_tile.dart';
import '../../../recruiter_section/job_details_screen.dart';
import 'package:hive/hive.dart';
import '../../../../utils/services/keys.dart';

class CandidateWhoViewedMeTab extends StatefulWidget {
  const CandidateWhoViewedMeTab({super.key});

  @override
  State<CandidateWhoViewedMeTab> createState() =>
      _CandidateWhoViewedMeTabState();
}

class _CandidateWhoViewedMeTabState extends State<CandidateWhoViewedMeTab> {
  BottomNavController _bottomNavController = Get.find();
  JobControll jobControll = JobControll();
  Box? hiddenIndices;
  bool isLoading = false;
  load() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    await JobControll.to.getWhoViewedMe();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    hiddenIndices = Hive.box(Keys.hiveinit);
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobControll>(
      builder: (controller) {
        print("dvjhsdbvs ${controller.whoViewedMeList}");
        return isLoading
            ? Center(
                child: Helpers.appLoader2(),
              )
            : controller.whoViewedMeList.isEmpty
                ? EmptyWhoSavedMe(
                    onTap: () => _bottomNavController.goToInitialPage(),
                    icon: AppImagePaths.emptyViewedMe,
                    description: AppStrings.whoViewedMeDes,
                  )
                : ListView.builder(
                    itemCount: controller.whoViewedMeList.length,
                    itemBuilder: (_, index) {
                      var data = controller.whoViewedMeList[index];
                      bool isNewVisible = !hiddenIndices!.containsKey(data!.id);
                      return InkWell(
                        onTap: () async {
                          await controller.jobViewCount(fields: {
                            "jobid": data.id,
                            "jobpost_userid": data.userid!.id,
                          });
                          Get.to(() => JobDetailsScreen(
                                jobid: data.id,
                              ));
                          setState(() {
                            hiddenIndices!.put(data.id, data.id);
                          });
                        },
                        child: Padding(
                          padding: Dimensions.kDefaultPadding,
                          child: JobsTile(
                            jobTitle: data.jobTitle ?? "",
                            salary: data.salary == null
                                ? ""
                                : data.salary!.minSalary!.type == 0 &&
                                        data.salary!.maxSalary!.type == 0
                                    ? "Negotiable"
                                    : data.salary!.minSalary!.salary
                                            .toString() +
                                        "K-" +
                                        data.salary!.maxSalary!.salary
                                            .toString() +
                                        "K " +
                                        data.salary!.minSalary!.currency!,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Viewed your profile",
                                  style: Styles.bodySmall1,
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
                            experienceLevel: data.experience == null
                                ? ""
                                : "${data.experience!.name}",
                            educationLevel: data.education == null
                                ? ""
                                : "${data.education!.name}",
                            companyName: data.company == null
                                ? "null"
                                : "${data.company!.legalName}",
                            employeeSize: data.company == null
                                ? ""
                                : "${data.company!.cSize!.size} Employees",
                            userPhoto: data.userid == null
                                ? "https://www.w3schools.com/howto/img_avatar.png"
                                : "${AppConstants.imgurl}" +
                                    "${data.userid!.image}",
                            userName: data.userid == null
                                ? ""
                                : "${data.userid!.firstname}" +
                                    " ${data.userid!.lastname}",
                            designation: data.userid == null
                                ? ""
                                : "${data.userid!.designation}",
                            location: data.jobLocation == null ?
                            data.company!.cLocation!.divisiondata!.divisionname! + ", "+ data.company!.cLocation!.divisiondata!.cityid!.name!
                            : data.jobLocation!.divisiondata!.divisionname! + ", "+ data.jobLocation!.divisiondata!.cityid!.name!,
                            // location: data.company == null
                            //     ? ""
                            //     : data.company!.cLocation!.city == null
                            //         ? data.company!.cLocation!.formetAddress ==
                            //                 null
                            //             ? ""
                            //             : data
                            //                 .company!.cLocation!.formetAddress!
                            //         : data.company!.cLocation!.city!,
                            isPremium: data.userid == null ||
                                    data.userid!.other == null
                                ? false
                                : data.userid!.other!.premium,
                            isRemote: data.remote,
                          ),
                        ),
                      );
                    });
      },
    );
  }
}

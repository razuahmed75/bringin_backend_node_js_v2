import 'package:bringin/res/app_font.dart';
import 'package:bringin/res/color.dart';
import 'package:bringin/res/constants/image_path.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/candidate_section/job_controll.dart';
import '../../models/recruiter_section/job_post_preview_model.dart';
import '../../widgets/jobs_opening_count.dart';
import '../../widgets/jobs_opening_tile.dart';
import '../both_section/Map/map.dart';
import 'job_details_screen.dart';

class RecruitersCompanyDetailsScreen extends StatelessWidget {
  final Company? companyData;
  final String? recruiterid;
  RecruitersCompanyDetailsScreen(
      {super.key, this.companyData, this.recruiterid});

  JobControll jobcontroll = Get.find<JobControll>();

  @override
  Widget build(BuildContext context) {
    jobcontroll.recruiterprofileview(recruiterid!);
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        actions: [],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: Dimensions.kDefaultPadding,
                    child: Column(
                      children: [
                        Dimensions.kDefaultgapTop,
                        Padding(
                          padding: Dimensions.kDefaultPadding,
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  height: height(60),
                                  width: height(60),
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                        companyData!.legalName == null
                                            ? "A"
                                            : companyData!.legalName!
                                                .substring(0, 1)
                                                .toUpperCase(),
                                        style: Styles.smallTitle.copyWith(
                                          color: AppColors.whiteColor,
                                        )),
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  companyData!.legalName ?? "",
                                  style: Styles.bodyLargeMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Gap(5),
                                Text(
                                  companyData!.cSize == null ||
                                          companyData!.cSize!.size == null
                                      ? ""
                                      : companyData!.cSize!.size! +
                                          " Employees",
                                  style: Styles.bodyMedium1,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Gap(5),
                                Text(
                                  companyData!.industry == null
                                      ? ""
                                      : companyData!.industry!.categoryname ??
                                          "",
                                  style: Styles.bodyMedium1,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(10),
                        Padding(
                          padding: Dimensions.kDefaultPadding,
                          child: Divider(
                            color: AppColors.borderColor,
                          ),
                        ),

                        Gap(15),

                        /// company address
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Company Address",
                              style: Styles.bodyLargeMedium,
                            ),
                            const Gap(5),
                            //
                            //
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  companyData!.cLocation!.divisiondata!
                                          .divisionname! +
                                      ", " +
                                      companyData!.cLocation!.divisiondata!
                                          .cityid!.name!,
                                  style: Styles.bodyMedium1,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                InkWell(
                                  onTap: () {
                                    Get.to(Scaffold(
                                      appBar: AppBar(title: Text("Location")),
                                      body: BothMapScreen(
                                          latLng: LatLng(
                                              companyData!.cLocation!.lat!
                                                  .toDouble(),
                                              companyData!.cLocation!.lon!
                                                  .toDouble())),
                                    ));
                                  },
                                  child: Container(
                                    height: height(35),
                                    width: width(130),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.mainColor.withOpacity(.1),
                                      border: Border.all(
                                          width: 1,
                                          color: AppColors.borderColor),
                                      borderRadius:
                                          BorderRadius.circular(radius(12)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            AppImagePaths.navigationIcon),
                                        Gap(10),
                                        Text("Navigation",
                                            style: Styles.bodySmall1.copyWith(
                                                color: AppColors.mainColor)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gap(24),

                        /// company profile
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       "Company Profile",
                        //       style: Styles.bodyLargeMedium
                        //     ),
                        //     const Gap(5),
                        //     Row(
                        //       children: [
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 "Please read T&C before applying You accept that company can store your data for 6 months +More",
                        //                 style: Styles.bodyMedium1,
                        //                 maxLines: 3,
                        //                 overflow: TextOverflow.ellipsis,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        // Gap(24),

                        /// business information
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Business Information",
                              style: Styles.bodyLargeMedium,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Company Legal Name  ",
                                    style: Styles.bodySmall1,
                                  ),
                                ),
                                // const Gap(20),
                                Expanded(
                                  child: Text(companyData!.legalName ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.bodySmall1),
                                ),
                              ],
                            ),
                            // const Gap(6),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Text(
                            //         "Company Founded ",
                            //         style: Styles.bodySmall1

                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Text("July 2022",
                            //           style: Styles.bodySmall1),
                            //     ),
                            //   ],
                            // ),
                            const Gap(6),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Official Website ",
                                    style: Styles.bodySmall1,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppImagePaths.worldIcon,
                                        color: companyData!.cWebsite == null
                                            ? Colors.transparent
                                            : AppColors.mainColor,
                                        height: height(15),
                                      ),
                                      const Gap(3),
                                      GestureDetector(
                                        onTap: () async {
                                          if (!(companyData!.cWebsite!
                                                  .contains("http://") ||
                                              companyData!.cWebsite!
                                                  .contains("https://"))) {
                                            await launchUrl(Uri.parse(
                                                "https://${companyData!.cWebsite}"));
                                          } else {
                                            await launchUrl(Uri.parse(
                                                "${companyData!.cWebsite}"));
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height(4)),
                                          constraints: BoxConstraints(
                                              maxWidth: width(120)),
                                          child: Text(
                                            companyData!.cWebsite ?? "",
                                            style: Styles.subTitle.copyWith(
                                              color: AppColors.mainColor,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Gap(8),
                  Divider(
                    color: AppColors.appBorder,
                  ),
                  // const Gap(8),
                  // /// jobs opening
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              maxChildSize: 0.9,
              minChildSize: 0.2,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  height: Dimensions.screenHeight,
                  width: Dimensions.screenWidth,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: width(50),
                            height: height(7),
                            decoration: BoxDecoration(
                                color: AppColors.borderColor,
                                borderRadius: BorderRadius.circular(3)),
                          ),
                        ),
                        GetBuilder<JobControll>(
                          builder: (_) {
                            return _.recruiterprofileload
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Column(
                                    children: [
                                      const Gap(10),
                                      JobsOpeningCount(
                                          text:
                                              "${_.recruiterprofiledetails!.joblist!.length}"),
                                      const Gap(10),
                                      // /// ovpening jobs list
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: _.recruiterprofiledetails!
                                              .joblist!.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            var data = _
                                                .recruiterprofiledetails!
                                                .joblist![index];
                                            return JobsOpeningTile(
                                              jobTitle: data.jobTitle!,
                                              salary: data.salary == null
                                                  ? ""
                                                  : data.salary!.minSalary!
                                                                  .type ==
                                                              0 &&
                                                          data.salary!
                                                                  .maxSalary!.type ==
                                                              0
                                                      ? "Negotiable"
                                                      : data.salary!.minSalary!
                                                              .salary
                                                              .toString() +
                                                          "K-" +
                                                          data.salary!
                                                              .maxSalary!.salary
                                                              .toString() +
                                                          "K " +
                                                          data
                                                              .salary!
                                                              .minSalary!
                                                              .currency!,
                                              jobDescription:
                                                  "${data.jobDescription}",
                                              experienceLevel: data
                                                          .experience ==
                                                      null
                                                  ? ""
                                                  : "${data.experience!.name}",
                                              educationLevel: data.education ==
                                                      null
                                                  ? ""
                                                  : "${data.education!.name}",
                                              location: data.jobLocation == null
                                                  ? data
                                                          .company!
                                                          .cLocation!
                                                          .divisiondata!
                                                          .divisionname! +
                                                      ", " +
                                                      data
                                                          .company!
                                                          .cLocation!
                                                          .divisiondata!
                                                          .cityid!
                                                          .name!
                                                  : data
                                                          .jobLocation!
                                                          .divisiondata!
                                                          .divisionname! +
                                                      ", " +
                                                      data
                                                          .jobLocation!
                                                          .divisiondata!
                                                          .cityid!
                                                          .name!,
                                              isRemote: data.remote,
                                              onTap: () async {
                                                await jobcontroll
                                                    .jobViewCount(fields: {
                                                  "jobid": data.id,
                                                  "jobpost_userid":
                                                      data.userid!.id,
                                                });
                                                Get.to(() => JobDetailsScreen(
                                                      jobid: data.id,
                                                    ));

                                                print("job id is: " +
                                                    data.id.toString());
                                              },
                                            );
                                          }),
                                    ],
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

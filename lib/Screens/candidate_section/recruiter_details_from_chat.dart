import 'package:bringin/res/color.dart';
import 'package:bringin/res/constants/image_path.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controllers/candidate_section/job_controll.dart';
import '../../res/app_font.dart';
import '../../res/constants/app_constants.dart';
import '../../widgets/jobs_opening_count.dart';
import '../../widgets/jobs_opening_tile.dart';
import '../../widgets/premium.dart';
import '../Photo_View/photoview.dart';
import '../recruiter_section/job_details_screen.dart';

class RecruitersDetailsFromChat extends StatelessWidget {
   RecruitersDetailsFromChat({
    super.key,
  });
  JobControll jobcontroll = Get.find<JobControll>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (JobControll.to.isLoading.value) {
          return Center(child: Helpers.appLoader2());
        } else if (JobControll.to.singleRecruiterDetailsList.isEmpty) {
          return Center(
            child: Text("Not found"),
          );
        } else {
          var recruiterDetail =
              JobControll.to.singleRecruiterDetailsList[0].recruiter;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: height(160),
                    width: Dimensions.screenWidth,
                    decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      image: DecorationImage(
                        image: AssetImage(AppImagePaths.recruiterCoverImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height(25),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(AppImagePaths.arrowBackIcon),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(0, -width(28)),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: ()=> Get.to(()=>PhotoViewPage(photourl: AppConstants.imgurl + recruiterDetail.image!),),
                          child: ClipOval(
                          child: Container(
                           decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                          height: height(80),
                          width: height(80),
                            child: CachedNetworkImage(
                                imageUrl: AppConstants.imgurl + recruiterDetail!.image!,fit: BoxFit.cover))),
                        ),
                        // recruiterDetail!.other!.premium == true
                        //     ? CircleAvatar(
                        //         radius: 10,
                        //         backgroundImage: AssetImage(AppImagePaths.crown),
                        //       )
                        //     : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: Dimensions.kDefaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: width(200)),
                          child: Text(
                            recruiterDetail.firstname! +
                                " " +
                                recruiterDetail.lastname!,
                            style: Styles.bodyLargeMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: recruiterDetail.other!.premium == true ? 8 : 0,
                        ),
                        recruiterDetail.other!.premium == true
                            ? Premium()
                            : SizedBox(),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Center(
                          child: Text(
                            recruiterDetail.designation! +
                                " • " +
                                "${recruiterDetail.companyname == null ? "" : recruiterDetail.companyname!.legalName}",
                            style: Styles.bodyMedium1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                        // const Gap(3),
                        // Text("•", style: Styles.bodyMedium1),
                        // const Gap(3),
                        // Container(
                        //   constraints: BoxConstraints(maxWidth: width(150)),
                        //   child: Text(
                        //     companyDetail == null ? " " : companyDetail!.legalName!+"bringin technology limited",
                        //     style: Styles.bodyMedium1,
                        //     maxLines: 1,
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(8),
              Padding(
                padding: Dimensions.kDefaultPadding,
                child: Divider(
                  color: AppColors.appBorder,
                ),
              ),
              const Gap(8),
              GetBuilder<JobControll>(
                builder: (_) {
                  return _.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              JobsOpeningCount(
                                  text:
                                      "${_.singleRecruiterDetailsList[0].joblist!.length}"),
                              // /// ovpening jobs list
                              Expanded(
                                child: ListView.builder(
                                    itemCount: _.singleRecruiterDetailsList[0]
                                        .joblist!.length,
                                    itemBuilder: (BuildContext context, index) {
                                      var data = _.singleRecruiterDetailsList[0]
                                          .joblist![index];
                                      return JobsOpeningTile(
                                        jobTitle: data.jobTitle!,
                                        salary: data.salary == null
                                            ? ""
                                            : data.salary!.minSalary!.type ==
                                                        0 &&
                                                    data.salary!.maxSalary!
                                                            .type ==
                                                        0
                                                ? "Negotiable"
                                                : data
                                                        .salary!.minSalary!.salary
                                                        .toString() +
                                                    "K-" +
                                                    data.salary!.maxSalary!
                                                        .salary
                                                        .toString() +
                                                    "K " +
                                                    data.salary!.minSalary!
                                                        .currency!,
                                        jobDescription:
                                            "${data.jobDescription}",
                                        experienceLevel: data.experience == null
                                            ? ""
                                            : "${data.experience!.name}",
                                        educationLevel: data.education == null
                                            ? ""
                                            : "${data.education!.name}",
                                        location: data.jobLocation == null ?
                            data.company!.cLocation!.divisiondata!.divisionname! + ", "+ data.company!.cLocation!.divisiondata!.cityid!.name!
                            : data.jobLocation!.divisiondata!.divisionname! + ", "+ data.jobLocation!.divisiondata!.cityid!.name!,
                                        isRemote: data.remote,
                                        onTap: () async {
                                          await jobcontroll
                                              .jobViewCount(fields: {
                                            "jobid": data.sId,
                                            "jobpost_userid": data.userid!.sId,
                                          });
                                          Get.to(() => JobDetailsScreen(
                                                jobid: data.sId,
                                              ));

                                          print("job id is: " +
                                              data.sId.toString());
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                },
              ),

              // /// jobs opening
              // JobsOpeningCount(text: "10"),
              // /// opening jobs list
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: 10,
              //     itemBuilder: (BuildContext context, index) {
              //       return JobsOpeningTile(
              //         jobTitle: "Flutter Developer",
              //         salary: "20K-25K BDT",
              //         jobDescription: "software into easy-to-use products for our client exinto easy-to-use products for our clien",
              //         experienceLevel: "Experienced",
              //         educationLevel: "Graduation Diploma",
              //         location: "Uttora, Dhaka",
              //         isRemote: true,
              //       );
              //     }),
              // ),
            ],
          );
        }
      }),
    );
  }
}

import 'package:bringin/Screens/Photo_View/photoview.dart';
import 'package:bringin/res/color.dart';
import 'package:bringin/res/constants/image_path.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controllers/candidate_section/job_controll.dart';
import '../../models/recruiter_section/job_post_preview_model.dart';
import '../../res/app_font.dart';
import '../../res/constants/app_constants.dart';
import '../../widgets/jobs_opening_count.dart';
import '../../widgets/jobs_opening_tile.dart';
import '../../widgets/premium.dart';
import 'job_details_screen.dart';

class RecruitersDetailsScreen extends StatelessWidget {
  final Userid? recruiterDetail;
  final Company? companyDetail;
  RecruitersDetailsScreen(
      {super.key, this.recruiterDetail, this.companyDetail});

  JobControll jobControll = Get.find<JobControll>();

  @override
  Widget build(BuildContext context) {
    print(recruiterDetail!.id);
    jobControll.recruiterprofileview(recruiterDetail!.id!);
    return Scaffold(
      body: Column(
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
                      onTap: ()=> Get.to(()=>PhotoViewPage(photourl: AppConstants.imgurl + recruiterDetail!.image!),),
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
                    // CircleAvatar(
                    //   backgroundColor: Colors.grey[300],
                    //   radius: 35,
                    //   backgroundImage: NetworkImage(
                    //       ),
                    // ),
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
                        recruiterDetail!.firstname! +
                            " " +
                            recruiterDetail!.lastname!,
                        style: Styles.bodyLargeMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: recruiterDetail!.other!.premium == true ? 8 : 0,
                    ),
                    recruiterDetail!.other!.premium == true
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
                        recruiterDetail!.designation! +
                            " • " +
                            "${companyDetail == null ? "" : companyDetail!.legalName!}",
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
          // const Gap(8),
          // /// jobs opening
          GetBuilder<JobControll>(
            builder: (_) {
              return _.recruiterprofileload
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: Column(
                        children: [
                          JobsOpeningCount(
                              text:
                                  "${_.recruiterprofiledetails!.joblist!.length}"),
                          // /// ovpening jobs list
                          Expanded(
                            child: ListView.builder(
                                itemCount:
                                    _.recruiterprofiledetails!.joblist!.length,
                                itemBuilder: (BuildContext context, index) {
                                  var data = _
                                      .recruiterprofiledetails!.joblist![index];
                                  return JobsOpeningTile(
                                    jobTitle: data.jobTitle!,
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
                                  await jobControll
                                              .jobViewCount(fields: {
                                            "jobid": data.id,
                                            "jobpost_userid": data.userid!.id,
                                          });
                                          Get.to(() => JobDetailsScreen(
                                                jobid: data.id,
                                              ));

                                          print("job id is: " +
                                              data.id.toString());
                                },
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
            },
          ),
        
        
        ],
      ),
    );
  }
}

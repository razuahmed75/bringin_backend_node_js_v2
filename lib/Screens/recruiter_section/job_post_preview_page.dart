import 'package:bringin/Screens/recruiter_section/job_post/recruiter_job_post_screen.dart';
import 'package:bringin/controllers/recruiter_section/recruiter_job_post_controller.dart';
import 'package:bringin/res/app_font.dart';
import 'package:bringin/res/color.dart';
import 'package:bringin/res/constants/image_path.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';
import '../../../res/dimensions.dart';
import '../../controllers/recruiter_section/job_post_preview_controller.dart';
import '../../controllers/recruiter_section/managejob_controll.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/app_bottom_nav_widget.dart';
import '../both_section/Map/map.dart';

class JobPostPreviewPage extends StatefulWidget {
  final String? jobid;
  final bool managejob;
  final int? tabindex;
  const JobPostPreviewPage(
      {super.key, this.jobid, this.tabindex, this.managejob = false});

  @override
  State<JobPostPreviewPage> createState() => _JobPostPreviewPageState();
}

class _JobPostPreviewPageState extends State<JobPostPreviewPage> {
  final managejobcontrol = Get.put(ManagejobControll());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        actions: [],
      ),
      bottomNavigationBar: widget.tabindex == 1
          ? Obx(
              () => BottomNavWidget(
                text: "Edit",
                onTap: JobPostPreviewController.to.isLoading.value == true
                    ? null
                    : () {
                        print(widget.jobid);
                        Get.to(() => RecruiterJobPostScreen(
                            isEditJobPost: true, jobId: widget.jobid));
                        RecruiterJobPostController.to.getSingleJobPostValue();
                      },
              ),
            )
          : SizedBox(),
      body: SingleChildScrollView(
        child: Obx(() {
          if (JobPostPreviewController.to.isLoading.value == true) {
            return Helpers.appLoader();
          }
          var jobData = JobPostPreviewController.to.jobList[0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: Dimensions.kDefaultPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExpandableText(
                      text: jobData.jobTitle ?? "",
                      style: Styles.bodyLargeMedium,
                      textWidth: 21,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(height(3)),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.mainColor.withOpacity(.2),width: .7),
                        borderRadius: BorderRadius.circular(radius(10)),
                      ),
                      child: Text(
                        jobData.salary == null
                            ? ""
                            : jobData.salary!.minSalary!.type == 0 && jobData.salary!.maxSalary!.type == 0 
                            ? "Negotiable" : "${jobData.salary!.minSalary!.salary}" +
                                "K-" +
                                "${jobData.salary!.maxSalary!.salary}K" +
                                "" +
                                " ${jobData.salary!.minSalary!.currency}",
                        style: Styles.bodySmall.copyWith(color: AppColors.mainColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: Dimensions.kDefaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/icon2/location2.png",height: 20.h,),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            jobData.jobLocation == null ?
                            jobData.company!.cLocation!.divisiondata!.divisionname! + ", "+ jobData.company!.cLocation!.divisiondata!.cityid!.name!
                            : jobData.jobLocation!.divisiondata!.divisionname! + ", "+ jobData.jobLocation!.divisiondata!.cityid!.name!,
                            style: Styles.bodySmall1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                          height: height(10),
                        ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                          children: [
                            Image.asset("assets/icon2/education.png",height: 20.h,),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                jobData.education == null
                                    ? ""
                                    : jobData.education!.name ?? "",
                                style: Styles.bodySmall1,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                                                  ),
                        ),
                       const Gap(20),
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset("assets/icon2/lavel.png",height: 20.h,),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  jobData.experience == null
                                      ? ""
                                      : jobData.experience!.name ?? "",
                                  style: Styles.bodySmall1,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                    
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              /// post status (active or deactive)
              Padding(
                padding: Dimensions.kDefaultPadding,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9.r),
                    border:
                        Border.all(color: AppColors.appBorder,width: .5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 5.w,
                          ),
                          Image.asset("assets/icon2/active.png",height: 15.h,),
                          const Gap(10),
                          Text(
                            jobData.jobStatus == "Open" ? "Active" : "Deactive",
                            style: Styles.bodyMedium
                                .copyWith(color: AppColors.mainColor),
                          )
                        ],
                      ),
                      const Gap(6),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: Text(
                            "Posted on ${JobPostPreviewController.to.formattedJobPostDate}",
                            style: Styles.bodySmall2),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: Dimensions.kDefaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Job Descriptions",
                      style: Styles.bodyMedium,
                    ),
                    const Gap(15),
                    Wrap(
                      children: jobData.skill!.map((String chip) {
                        return Container(
                          padding: EdgeInsets.only(right: 5.w),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: jobData.skill!.length -1  == jobData.skill!.indexOf(chip) 
                                ? Colors.transparent : AppColors.appBorder,
                              )
                            )
                          ),
                          margin: EdgeInsets.only(right: 5.w,bottom: 10.h),
                          child: Text(
                            chip,
                            style: Styles.bodySmall1.copyWith(color: AppColors.mainColor)
                          ),
                          
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      jobData.jobDescription ?? "",
                      style: Styles.bodySmall1,
                    ),
                    Gap(15),
                  ],
                ),
              ),
              /// company details
              Padding(
                padding: Dimensions.kDefaultPadding,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border:
                        Border.all(color: AppColors.appBorder,width: .5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          /// image
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: height(40),
                                width: height(40),
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    jobData.company == null
                                        ? ""
                                        : jobData.company!.legalName!
                                            .substring(0, 1)
                                            .toUpperCase(),
                                    style: Styles.bodyMedium1.copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: height(-2),
                                right: height(4),
                                child: SvgPicture.asset(
                                    AppImagePaths.cVerifiedIcon),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width(10),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Dimensions.screenWidth*.6,
                                child: Text(
                                  jobData.company == null
                                      ? ""
                                      : jobData.company!.legalName ?? "",
                                  style: Styles.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Gap(5),
                              Text(
                                jobData.company == null ||
                                        jobData.company!.cSize == null
                                    ? ""
                                    : jobData.company!.cSize!.size! +
                                        " Employees",
                                style: Styles.bodySmall1,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImagePaths.arrowForwardIcon,
                                height: 14.h,
                                width: 14.h,
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ),
              const Gap(15),
              Container(
                height: 200,
                width: Dimensions.screenWidth,
                padding: Dimensions.kDefaultPadding,
                child: BothMapScreen(
                    latLng: LatLng(
                        jobData.jobLocation == null || jobData.jobLocation!.lat == 0 ?
                        jobData.company!.cLocation!.lat! : jobData.jobLocation!.lat!,

                        jobData.jobLocation == null || jobData.jobLocation!.lon == 0 ?
                        jobData.company!.cLocation!.lon! : jobData.jobLocation!.lon!,)),
              ),
              const Gap(20),
            ],
          );
        }),
      ),
    );
  }
}

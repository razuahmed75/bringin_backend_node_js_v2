import 'dart:ui';

import 'package:bringin/res/app_font.dart';
import 'package:bringin/res/color.dart';
import 'package:bringin/res/constants/image_path.dart';
import 'package:bringin/utils/routes/screen_lists.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/premium.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../../Hive/hive.dart';
import '../../controllers/ChatController/chatcontroll.dart';
import '../../controllers/candidate_section/candidate_edit_main_profile_controller.dart';
import '../../controllers/candidate_section/job_controll.dart';
import '../../models/candidate_section/Chat/GroupChannel/groupchannel.dart';
import '../../res/constants/app_constants.dart';
import '../../res/dimensions.dart';
import '../../utils/routes/route_helper.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/app_bottom_nav_widget.dart';
import '../both_section/Map/map.dart';
import '../messages/candidate_message/Chat/Inbox/chatscreen.dart';

class JobDetailsScreen extends StatefulWidget {
  final String? jobid;
  const JobDetailsScreen({super.key, this.jobid});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final jobs = Get.find<JobControll>();
  bool loading = false;

  Future loaddata() async {
    setState(() {
      loading = true;
    });
    await jobs.getobdetails(jobid: widget.jobid!);
    setState(() {
      loading = false;
    });
  }

  bool chatload = false;

  // final chatcontroll = Get.put(SeekerChatController());
  CandidateEditMainProfileController controller =
      Get.find<CandidateEditMainProfileController>();

  Groupchannel? groupchannel;
  final currentprofileinfo = Get.find<CandidateEditMainProfileController>();

  ChatControll chatControll = Get.put(ChatControll());
  Future interchatinbox() async {
    setState(() {
      loading = true;
    });
    var channeldata = await chatControll.channelcreate(
        chatControll.currentuserid,
        jobs.jobdetails[0].userid!.id!,
        jobs.jobdetails[0].id!,
        null,
        true);

    print("sjdhbjsndbvjshbd  ${chatControll.currentuserid}");
    chatControll.channelconnect(channelid: channeldata.id);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SeekerChatScreen(data: channeldata)));

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
    return Scaffold(
        appBar: _buildAppBar(),
        bottomNavigationBar: BottomNavWidget(
          text: "Start Chatting",
          onTap: loading
              ? null
              : () {
                  interchatinbox();
                },
        ),
        body: loading
            ? Center(child: Helpers.appLoader2())
            : SingleChildScrollView(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimensions.kDefaultgapTop,

                  /// expertise, salary
                  Padding(
                    padding: Dimensions.kDefaultPadding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            constraints: BoxConstraints(
                                // maxWidth: width(170),
                                ),
                            child: Text(
                              jobs.jobdetails[0].jobTitle ?? "",
                              style: Styles.bodyLargeMedium.copyWith(fontSize: font(20)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        jobs.jobdetails[0].salary == null
                            ? SizedBox()
                            : jobs.jobdetails[0].salary!.minSalary!.type == 0 &&
                                    jobs.jobdetails[0].salary!.maxSalary!
                                            .type ==
                                        0
                                ? Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(height(3)),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.mainColor
                                              .withOpacity(.2),
                                          width: .7),
                                      borderRadius:
                                          BorderRadius.circular(radius(10)),
                                    ),
                                    child: Text(
                                      "Negotiable",
                                      style: Styles.bodyMedium
                                          .copyWith(color: AppColors.mainColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(height(3)),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.mainColor
                                              .withOpacity(.2),
                                          width: .7),
                                      borderRadius:
                                          BorderRadius.circular(radius(10)),
                                    ),
                                    child: Text(
                                      jobs.jobdetails[0].salary!.minSalary!
                                              .salary
                                              .toString() +
                                          "K-" +
                                          jobs.jobdetails[0].salary!.maxSalary!
                                              .salary
                                              .toString() +
                                          "K ${jobs.jobdetails[0].salary!.minSalary!.currency}",
                                      style: Styles.bodyMedium
                                          .copyWith(color: AppColors.mainColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                      ],
                    ),
                  ),
                  const Gap(10),

                  /// location, experience level, graduation/diploma
                  Flexible(
                    child: Padding(
                      padding: Dimensions.kDefaultPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icon2/education.png",
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                jobs.jobdetails[0].education == null
                                    ? ""
                                    : "${jobs.jobdetails[0].education!.name!}",
                                style: Styles.bodySmall1.copyWith(
                                  fontSize: font(15)
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icon2/location2.png",
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: width(150),
                                    ),
                                    child: Text(
                                      jobs.jobdetails[0].jobLocation == null
                                          ? jobs
                                                  .jobdetails[0]
                                                  .company!
                                                  .cLocation!
                                                  .divisiondata!
                                                  .divisionname! +
                                              ", " +
                                              jobs
                                                  .jobdetails[0]
                                                  .company!
                                                  .cLocation!
                                                  .divisiondata!
                                                  .cityid!
                                                  .name!
                                          : jobs.jobdetails[0].jobLocation!
                                                  .divisiondata!.divisionname! +
                                              ", " +
                                              jobs.jobdetails[0].jobLocation!
                                                  .divisiondata!.cityid!.name!,
                                      style: Styles.bodySmall1.copyWith(
                                  fontSize: font(15)
                                ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(10),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icon2/lavel.png",
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    jobs.jobdetails[0].experience == null
                                        ? ""
                                        : jobs.jobdetails[0].experience!.name
                                            .toString(),
                                    style: Styles.bodySmall1.copyWith(
                                  fontSize: font(15)
                                ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(17),

                  /// recruiter profile status
                  Padding(
                    padding: Dimensions.kDefaultPadding,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => RecruitersDetailsScreen(
                              recruiterDetail: jobs.jobdetails[0].userid,
                              companyDetail: jobs.jobdetails[0].company,
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: width(15), bottom: height(10), top: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.borderColor, width: .5),
                          borderRadius: BorderRadius.circular(radius(6)),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Align(
                                //     alignment: Alignment.centerRight,
                                //     child: Padding(
                                //       padding:
                                //           EdgeInsets.only(top: 8.h, right: 8.w),
                                //       child: jobs.jobdetails[0].userid!.other!
                                //                   .premium ==
                                //               true
                                //           ? Premium()
                                //           : SizedBox(),
                                //     )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            if (jobs.jobdetails[0].userid!
                                                    .image ==
                                                null)
                                              CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    AppImagePaths.avatar1),
                                              ),
                                            if (jobs.jobdetails[0].userid!
                                                    .image !=
                                                null)
                                              ClipOval(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    shape: BoxShape.circle,
                                                  ),
                                                  height: height(40),
                                                  width: height(40),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        AppConstants.imgurl +
                                                            jobs.jobdetails[0]
                                                                .userid!.image!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            SvgPicture.asset(
                                                AppImagePaths.verifiedIcon),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                /// first name, last name
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: width(165),
                                                  ),
                                                  child: Text(
                                                    "${jobs.jobdetails[0].userid == null ? "" : jobs.jobdetails[0].userid!.firstname ?? ""} ${jobs.jobdetails[0].userid == null ? "" : jobs.jobdetails[0].userid!.lastname ?? ""}",
                                                    style: Styles.bodyMedium,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),

                                                /// inOnline
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text("•",
                                                    style: Styles.isOnline),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  chatControll.timestempsformet(
                                                              jobs
                                                                  .jobdetails[0]
                                                                  .userid!
                                                                  .other!
                                                                  .offlinedate!) ==
                                                          0
                                                      ? "Online"
                                                      : "Offline",
                                                  style: Styles.isOnline,
                                                ),
                                              ],
                                            ),

                                            /// designation, company name
                                            Row(
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth:
                                                        Dimensions.screenWidth *
                                                            .25,
                                                  ),
                                                  child: Text(
                                                    jobs.jobdetails[0].userid!
                                                                .designation ==
                                                            null
                                                        ? ""
                                                        : jobs
                                                            .jobdetails[0]
                                                            .userid!
                                                            .designation!,
                                                    style: Styles.bodySmall1,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const Gap(5),
                                                Text(
                                                  "•",
                                                  style: Styles.bodySmall1
                                                      .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Gap(5),
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth:
                                                        Dimensions.screenWidth *
                                                            .36,
                                                  ),
                                                  child: Text(
                                                    jobs.jobdetails[0]
                                                                .company ==
                                                            null
                                                        ? ""
                                                        : jobs
                                                                .jobdetails[0]
                                                                .company!
                                                                .legalName ??
                                                            "",
                                                    style: Styles.bodySmall1,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: height(jobs.jobdetails[0].userid!
                                                      .other!.premium ==
                                                  false
                                              ? 25
                                              : 30),
                                          right: width(15)),
                                      child: SvgPicture.asset(
                                          AppImagePaths.back_arrow),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: height(5),
                                ),
                                Row(
                                  children: [
                                    if (jobs.jobdetails[0].userid!.other!
                                            .profileVerify ==
                                        true)
                                      Image.asset(
                                        AppImagePaths.tick_mark,
                                        width: height(14),
                                        height: height(14),
                                      ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    if (jobs.jobdetails[0].userid!.other!
                                            .profileVerify ==
                                        true)
                                      Expanded(
                                          child:
                                              jobs.jobdetails[0].userid == null
                                                  ? Text("")
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                          right: width(15)),
                                                      child: Text(
                                                        "Verified by Jakaria Hasan  on ${jobs.formatDate(jobs.jobdetails[0].userid!.other!.profileVerifyDate!.toString())}",
                                                        style: Styles.subTitle,
                                                      ),
                                                    )),
                                    if (jobs.jobdetails[0].userid!.other!
                                            .profileVerify ==
                                        false)
                                      Expanded(
                                          child: Text(
                                        "Unverified",
                                        style: Styles.subTitle
                                            .copyWith(color: Colors.red),
                                      )),
                                  ],
                                ),
                              ],
                            ),
                            jobs.jobdetails[0].userid!.other!.premium == true
                                ? Positioned(right: 5, child: Premium())
                                : Positioned(
                                    top: 0, right: 0, child: SizedBox())
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// job description
                  Padding(
                    padding: Dimensions.kDefaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height(15),
                        ),
                        Text(
                          "Job Descriptions",
                          style: Styles.bodyMedium,
                        ),
                        const Gap(10),
                        Wrap(
                          children: jobs.jobdetails[0].skill!.map((chip) {
                            return Container(
                              padding: EdgeInsets.only(right: 5.w),
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                color: jobs.jobdetails[0].skill!.length - 1 ==
                                        jobs.jobdetails[0].skill!.indexOf(chip)
                                    ? Colors.transparent
                                    : AppColors.appBorder,
                              ))),
                              margin: EdgeInsets.only(right: 5.w, bottom: 10.h),
                              child: Text(chip,
                                  style: Styles.bodySmall1
                                      .copyWith(color: AppColors.mainColor)),
                            );
                          }).toList(),
                        ),
                        const Gap(5),
                        SelectableText(
                          jobs.jobdetails[0].jobDescription ?? "",
                          style: Styles.bodySmall1,
                        ),
                        SizedBox(
                          height: height(15),
                        ),

                        /// company details
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width(15), vertical: height(6)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius(6)),
                              border: Border.all(
                                color: AppColors.borderColor,
                                width: .3,
                              )),
                          child: InkWell(
                            onTap: jobs.jobdetails[0].company == null
                                ? null
                                : () {
                                    Get.to(() => RecruitersCompanyDetailsScreen(
                                        recruiterid:
                                            jobs.jobdetails[0].userid!.id!,
                                        companyData:
                                            jobs.jobdetails[0].company));
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
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
                                              jobs.jobdetails[0].company == null
                                                  ? ""
                                                  : jobs.jobdetails[0].company!
                                                      .legalName!
                                                      .substring(0, 1)
                                                      .toUpperCase(),
                                              style:
                                                  Styles.bodyMedium1.copyWith(
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: height(-3),
                                          right: height(4),
                                          child: SvgPicture.asset(
                                              AppImagePaths.cVerifiedIcon),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: height(15),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          jobs.jobdetails[0].company == null
                                              ? ""
                                              : jobs.jobdetails[0].company!
                                                  .legalName!,
                                          style: Styles.bodyMedium,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Gap(1),
                                        Text(
                                          jobs.jobdetails[0].company == null
                                              ? ""
                                              : jobs.jobdetails[0].company!
                                                      .cSize!.size
                                                      .toString() +
                                                  " Employees",
                                          style: Styles.bodySmall1,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(AppImagePaths.back_arrow),
                              ],
                            ),
                          ),
                        ),

                        /// map, and see next button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height(10),
                            ),

                            Container(
                              height: height(200),
                              width: MediaQuery.sizeOf(context).width,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  BothMapScreen(
                                      latLng: LatLng(
                                    jobs.jobdetails[0].jobLocation == null ||
                                            jobs.jobdetails[0].jobLocation!
                                                    .lat ==
                                                0
                                        ? jobs.jobdetails[0].company!.cLocation!
                                            .lat!
                                            .toDouble()
                                        : jobs.jobdetails[0].jobLocation!.lat!
                                            .toDouble(),
                                    jobs.jobdetails[0].jobLocation == null ||
                                            jobs.jobdetails[0].jobLocation!
                                                    .lon ==
                                                0
                                        ? jobs.jobdetails[0].company!.cLocation!
                                            .lon!
                                            .toDouble()
                                        : jobs.jobdetails[0].jobLocation!.lon!
                                            .toDouble(),
                                  )),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(Scaffold(
                                          appBar: AppBar(
                                              title: Text(
                                            "Location",
                                            style: TextStyle(
                                                color: AppColors.blackColor),
                                          )),
                                          body: BothMapScreen(
                                              latLng: LatLng(
                                            jobs.jobdetails[0].jobLocation ==
                                                        null ||
                                                    jobs.jobdetails[0]
                                                            .jobLocation!.lat ==
                                                        0
                                                ? jobs.jobdetails[0].company!
                                                    .cLocation!.lat!
                                                    .toDouble()
                                                : jobs.jobdetails[0]
                                                    .jobLocation!.lat!
                                                    .toDouble(),
                                            jobs.jobdetails[0].jobLocation ==
                                                        null ||
                                                    jobs.jobdetails[0]
                                                            .jobLocation!.lon ==
                                                        0
                                                ? jobs.jobdetails[0].company!
                                                    .cLocation!.lon!
                                                    .toDouble()
                                                : jobs.jobdetails[0]
                                                    .jobLocation!.lon!
                                                    .toDouble(),
                                          )),
                                        ));
                                      },
                                      // child: Container(
                                      //   padding: EdgeInsets.all(5),
                                      //   margin: EdgeInsets.all(10),
                                      //   decoration: BoxDecoration(
                                      //       border: Border.all(
                                      //           color: AppColors.blackColor
                                      //               .withOpacity(0.3)),
                                      //       borderRadius:
                                      //           BorderRadius.circular(5.r),
                                      //       color:
                                      //           Colors.grey.withOpacity(0.5)),
                                      //   child: Text("Check the location",
                                      //       style: Styles.bodySmall1.copyWith(
                                      //           color: Color(0xFF0077B5))),
                                      // ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: new ClipRect(
                                            child: new BackdropFilter(
                                              filter: new ImageFilter.blur(
                                                  sigmaX: 10.0, sigmaY: 10.0),
                                              child: new Container(
                                                decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey.shade200
                                                        .withOpacity(0.5)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: new Text(
                                                    'Check the location',
                                                    style: Styles.bodySmall1
                                                        .copyWith(
                                                            color: Color(
                                                                0xFF0077B5)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // SizedBox(
                            //   height: height(12),
                            // ),
                            // seeNextButton(context),
                            SizedBox(
                              height: height(30),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )));
  }

  Widget seeNextButton(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(height(12)),
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(.25),
        borderRadius: BorderRadius.circular(radius(6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                backgroundImage: AssetImage(AppImagePaths.avatar1),
              ),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width(130),
                    child: Text(
                      "Gravity Technologies",
                      style: Styles.bodySmall1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: width(130),
                    child: Text(
                      "Full Stack Developer",
                      style: Styles.bodySmall1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            height: height(30),
            width: width(80),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text("See Next", style: Styles.bodySmall1),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return appBarWidget(title: "", onBackPressed: () => Get.back(), actions: [
      Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: width(15), top: height(10)),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.mainColor.withOpacity(.2),
              ),
              borderRadius: BorderRadius.circular(radius(19)),
            ),
            child: Row(
              children: [
                const Gap(3),
                GetBuilder<JobControll>(builder: (controll) {
                  return InkResponse(
                      onTap: () {
                        controll.saveJob(jobId: widget.jobid!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          HiveHelp.read(widget.jobid!) == widget.jobid!
                              ? AppImagePaths.fav_filled
                              : AppImagePaths.fav_outlined,
                          height: height(17),
                          width: height(17),
                        ),
                      ));
                }),
                InkResponse(
                    onTap: () async {
                      if (widget.jobid != null) {
                        print(widget.jobid);
                        var result = await Share.shareWithResult(
                            'https://bringin.io/job-details/${widget.jobid}');
                        if (result.status == ShareResultStatus.success) {
                          print('Successfully shared');
                          Helpers()
                              .showToastMessage(msg: "Successfully shared");
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppImagePaths.shareIcon),
                    )),
                InkResponse(
                    onTap: () {
                      Get.toNamed(RouteHelper.getReportRoute(), arguments: {
                        "jobId": widget.jobid,
                        "jobpostuserid": jobs.jobdetails[0].userid!.id!
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppImagePaths.reportIcon),
                    )),
                const Gap(3),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}

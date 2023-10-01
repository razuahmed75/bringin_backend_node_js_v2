// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:bringin/Http/get.dart';
import 'package:bringin/controllers/ChatController/chatcontroll.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:time_machine/time_machine.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../widgets/app_bar.dart';
import '../../../../Hive/hive.dart';
import '../../../../controllers/candidate_section/candidate_controll.dart';
import '../../../../controllers/recruiter_section/managejob_controll.dart';
import '../../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../../../models/Reject_Candidate/reject_candidate.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/dimensions.dart';
import '../../../../utils/routes/route_helper.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../widgets/app_bottom_nav_widget.dart';
import '../../../../widgets/my_skills_tile.dart';
import '../../../../widgets/portfolio_tile.dart';
import '../../../candidate_section/Resume/my_resume/components/career_preferences.dart';
import '../../../candidate_section/Resume/my_resume/components/education_qualification.dart';
import '../../../candidate_section/Resume/my_resume/components/row_layout.dart';
import '../../../candidate_section/Resume/my_resume/components/work_experience_tile.dart';
import '../../../candidate_section/Resume/my_resume_viewer/components/icon_and_text.dart';

class RejectCandidateDetailsScreen extends StatefulWidget {
  final bool? isArrowIcon;
  final Candidatefullprofileid? index;
  RejectCandidateDetailsScreen(
      {super.key, this.isArrowIcon = false, this.index});

  @override
  State<RejectCandidateDetailsScreen> createState() =>
      _RejectCandidateDetailsScreenState();
}

class _RejectCandidateDetailsScreenState
    extends State<RejectCandidateDetailsScreen> {
  final candidatejobcontroll = Get.put(CandidateControll());
  var recuiterprofile = Get.find<RecruiterEditMainProfileController>();
  ChatControll chatControll = Get.put(ChatControll());

  // final controll = Get.put(RecruiterChatControll());

  int differentedu(DateTime date1, DateTime date2) {
    LocalDate a = LocalDate.dateTime(date1);
    LocalDate b = LocalDate.dateTime(date2);
    Period diff = b.periodSince(a);
    return diff.years;
  }

  bool chatload = false;

  bool loading = false;
  final managejobcontrol = Get.put(ManagejobControll());
  Future interchatinbox() async {
    setState(() {
      loading = true;
    });
    await Httphelp.post(
        ENDPOINT_URL: "/candidate_unreject",
        fields: {"candidateid": widget.index!.userid!.id!});

    chatControll.loadrecruiterchannel();
    setState(() {
      loading = false;
    });
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavWidget(
        text: loading ? "Unrejecting" : "Unreject Candidate",
        onTap: loading ? null : () {
          interchatinbox();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // name, photo, job position
            UserInfoSection(),

            // user basic info
            UserBasicInfo(),
            const Gap(10),

            // about me
            RowLayout(
              text: "About Me",
              isIcon: false,
            ),
            const Gap(10),
            Padding(
              padding: Dimensions.kDefaultPadding,
              child: widget.index!.about == null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(""),
                      ),
                    )
                  : Text("${widget.index!.about!.about}",
                      style: Styles.bodySmall2),
            ),
            const Gap(10),

            // job preferences
            JobPrefSection(),
            const Gap(10),

            // work experience
            WorkExpSection(),
            const Gap(10),

            // education qualification
            EducationQualiSection(),

            // my skills section
            MySkillsSection(),

            // my online portfolio
            OnlinePortfolioSection(),
            const Gap(35),
          ],
        ),
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
              border: Border.all(color: AppColors.mainColor.withOpacity(.2)),
              borderRadius: BorderRadius.circular(radius(19)),
            ),
            child: Row(
              children: [
                const Gap(3),
                GetBuilder<CandidateControll>(builder: (controll) {
                  return InkResponse(
                      onTap: () {
                        controll.savecandidateprofile(
                            seekerid: widget.index!.userid!.id!,
                            fields: {
                              "candidatefullprofile": widget.index!.id,
                              "candidateid": widget.index!.userid!.id!
                            });
                        recuiterprofile.getRecruiterProfileInfoList();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          HiveHelp.read(widget.index!.userid!.id!) ==
                                  widget.index!.userid!.id!
                              ? AppImagePaths.fav_filled
                              : AppImagePaths.fav_outlined,
                          height: height(17),
                          width: height(17),
                        ),
                      ));
                }),
                InkResponse(
                    onTap: () async{
                      var result = await Share.shareWithResult('https://bringin.io/candidatedetails/${widget.index!.id}');
                      if (result.status == ShareResultStatus.success) {
                            print('Successfully shared');
                            Helpers().showToastMessage(msg: "Successfully shared");
                        }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppImagePaths.shareIcon),
                    )),
                InkResponse(
                    onTap: () {
                      Get.toNamed(RouteHelper.getReportRoute(), arguments: {
                        "seekerId": widget.index!.userid!.id!,
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppImagePaths.reportIcon),
                    )),
              ],
            ),
          ),
        ],
      ),
      const Gap(3),
    ]);
  }

  Container OnlinePortfolioSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowLayout(
            text: "My Portfolio",
            isIcon: false,
          ),
          const Gap(10),
          widget.index!.protfoliolink!.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(""),
                  ),
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    var data = widget.index!.protfoliolink![0];
                    return GestureDetector(
                      onTap: () async {
                        try {
                          if (data.protfoliolink!.contains("http://") ||
                              data.protfoliolink!.contains("https://")) {
                            await launchUrl(Uri.parse(data.protfoliolink!));
                          } else {
                            await launchUrl(
                                Uri.parse("https://" + data.protfoliolink!));
                          }
                        } catch (e) {
                          Helpers.showAlartMessage(msg: e.toString());
                        }
                      },
                      child: PortfolioTile(text: data.protfoliolink ?? ""),
                    );
                  }),
        ],
      ),
    );
  }

  Container UserInfoSection() {
    return Container(
      padding: Dimensions.kDefaultPadding,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => Scaffold(
                      body: Center(
                    child: PhotoView(
                        maxScale: 1.0,
                        minScale: 0.1,
                        imageProvider: NetworkImage(widget
                                    .index!.userid!.image ==
                                null
                            ? "https://www.w3schools.com/howto/img_avatar.png"
                            : AppConstants.imgurl +
                                widget.index!.userid!.image!)),
                  )));
            },
            child: ClipOval(
              child: Container(
                height: height(65),
                width: height(65),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: CachedNetworkImage(
                          imageUrl: widget.index!.userid!.image == null
                          ? "https://www.w3schools.com/howto/img_avatar.png"
                          : AppConstants.imgurl + widget.index!.userid!.image!,
                          fit: BoxFit.cover,
                          errorWidget: (context, error, stackTrace) => Icon(Icons.error,size: height(65)),
                        ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.index!.userid!.fastname ?? ""} ${widget.index!.userid!.lastname ?? ""}",
                  style: Styles.largeTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(10),
                widget.index!.workexperience!.isEmpty
                    ? SizedBox()
                    : Text(
                        "${widget.index!.workexperience!.isNotEmpty ? widget.index!.workexperience![0].designation : ""} | ${widget.index!.workexperience!.isNotEmpty ? widget.index!.workexperience![0].companyname : ""}",
                        style: Styles.bodySmall2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container UserBasicInfo() {
    return Container(
      width: double.maxFinite,
      height: height(widget.index!.userid!.other!.jobHunting == null ||
              widget.index!.userid!.other!.moreStatus == null
          ? 126
          : 106),
      padding:
          EdgeInsets.symmetric(horizontal: width(20), vertical: height(14)),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: Dimensions.resumeVieweShadowList,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Job hunting status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Job Hunting Status",
                      style: Styles.bodySmall1,
                    ),
                    const Gap(3),
                    Container(
                      height: .5,
                      width: width(120),
                      color: AppColors.appBorder,
                    ),
                  ],
                ),
                Gap(widget.index!.userid!.other!.jobHunting == null ||
                        widget.index!.userid!.other!.moreStatus == null
                    ? 8.h
                    : 0),
                widget.index!.userid!.other == null
                    ? Text("")
                    : widget.index!.userid!.other!.jobHunting == null ||
                            widget.index!.userid!.other!.moreStatus == null
                        ? Expanded(
                            child: Text(
                              "Nothing selected yet, send him a message to know the notice period!",
                              style: Styles.bodySmall1,
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : widget.index!.userid!.other!.jobRightNow == true
                            ? Container(
                                constraints: BoxConstraints(
                                  maxWidth: width(150),
                                ),
                                child: Text(
                                  "Not looking for any job",
                                  style: Styles.bodySmall1,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : Container(
                                constraints: BoxConstraints(
                                  maxWidth: width(150),
                                ),
                                child: Text(
                                  widget.index!.userid!.other!.jobHunting ?? "",
                                  style: Styles.bodySmall1,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                widget.index!.userid!.other == null
                    ? SizedBox()
                    : widget.index!.userid!.other!.jobRightNow == true
                        ? SizedBox()
                        : Container(
                            constraints: BoxConstraints(
                              maxWidth: width(150),
                            ),
                            child: Text(
                              widget.index!.userid!.other!.moreStatus ?? "",
                              style: Styles.bodySmall1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
              ],
            ),
          ),
          const Gap(20),

          /// divider ande user exp
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height(100),
                  width: .7,
                  color: AppColors.borderColor,
                ),
                const Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        widget.index!.userid!.other!.jobHunting == null ||
                                widget.index!.userid!.other!.moreStatus == null
                            ? MainAxisAlignment.spaceAround
                            : MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: IconAndText(
                          iconPath: AppImagePaths.durationIcon,
                          text: widget.index!.education!.isEmpty
                              ? ""
                              : differentedu(
                                          widget
                                              .index!.education![0].startdate!,
                                          widget.index!.education![0].enddate!)
                                      .toString() +
                                  " Years",
                          iconSize: height(17),
                        ),
                      ),
                      IconAndText(
                          iconPath: AppImagePaths.graduateIcon,
                          text:
                              "${widget.index!.education!.isNotEmpty ? widget.index!.education![0].digree == null ? "" : widget.index!.education![0].digree!.name : ""}"),
                      IconAndText(
                        iconPath: AppImagePaths.ageIcon,
                        text: widget.index!.userid!.deatofbirth == null
                            ? ""
                            : "${different(widget.index!.userid!.deatofbirth!)} Years",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int different(DateTime date2) {
    DateTime date1 = DateTime.now();
    int year = date1.difference(date2).inDays;
    return year ~/ 365;
  }

  Container MySkillsSection() {
    return Container(
      margin: EdgeInsets.only(bottom: height(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowLayout(
            text: "My Skills",
            isIcon: false,
          ),
          const Gap(10),
          widget.index!.skill!.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(""),
                  ),
                )
              : Padding(
                  padding: Dimensions.kDefaultPadding,
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 8,
                    children: [
                      ...List.generate(
                        widget.index!.skill!.length,
                        (index) {
                          return MySkillsTile(
                                  indicatorColor: widget.index!.skill!.length -1 == index ? Colors.transparent : AppColors.borderColor,
                                                  text: widget.index!.skill![index],
                                );
                        },
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Container EducationQualiSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowLayout(
            text: "Educational Qualifications",
            isIcon: false,
          ),
          const Gap(10),
          Container(
            padding: Dimensions.kDefaultPadding,
            child: widget.index!.education!.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(""),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.index!.education!.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      var data = widget.index!.education![index];
                      return EducationQualify(
                        isArrowIcon: false,
                        instituteName: data.institutename == null
                            ? ""
                            : "${data.institutename}",
                        gradePoint:   "${data.subject == null ? "" : data.subject!.name!} - " + "${data.type == 2 
                                ? data.grade! + " "+ data.gradetype! : data.gradetype! +
                                  " " +
                                  data.grade!}",
                        educationLevel:
                            "${data.digree == null ? "" : data.digree!.name ?? ""}",
                        educationDuration: data.startdate == null ||
                                data.enddate == null
                            ? ""
                            : "${DateFormat("MMM yyyy").format(data.startdate!)} - ${DateFormat("MMM yyyy").format(data.enddate!)}",
                        otherActivities: data.otheractivity,
                        otherActivitiesMaxLines: null,
                        otherActivitiesOverflow: TextOverflow.visible,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Container WorkExpSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowLayout(
            text: "Work Experiences",
            isIcon: false,
          ),
          const Gap(10),
          widget.index!.workexperience!.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(""),
                  ),
                )
              : Container(
                  padding: Dimensions.kDefaultPadding,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.index!.workexperience!.length,
                      itemBuilder: (BuildContext context, index) {
                        var data = widget.index!.workexperience![index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: height(10)),
                          child: WorkExperienceTile(
                            isIcon: false,
                            companyName: data.companyname == null
                                ? ""
                                : "${data.companyname}",
                            workDuration: data.startdate == null ||
                                    data.enddate == null
                                ? ""
                                : "${DateFormat("MMM yyyy").format(data.startdate!)} - ${data.enddate!.year > DateTime.now().year ? "Present" : DateFormat("MMM yyyy").format(data.enddate!)}",
                            jobDescriptionScreen:
                                data.dutiesandresponsibilities == null
                                    ? ""
                                    : data.dutiesandresponsibilities,
                            designation: data.designation,
                            expertise_area: data.expertisearea == null
                                ? ""
                                : data.expertisearea!.functionalname,
                            jobDescriptionMaxLines: null,
                            jobDescriptionOverflow: TextOverflow.visible,
                          ),
                        );
                      }),
                ),
        ],
      ),
    );
  }

  Container JobPrefSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowLayout(
            text: "Career Preferences",
            isIcon: false,
          ),
          const Gap(10),
          widget.index!.careerPreference!.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(""),
                  ),
                )
              : Container(
                  padding: Dimensions.kDefaultPadding,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.index!.careerPreference!.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        var data = widget.index!.careerPreference![index];
                        return CareerPreferenceWidget(
                            functionalArea: data.functionalarea == null
                                ? ""
                                : data.functionalarea!.functionalname,
                            salary: data.salaray == null ||
                                    data.salaray!.minSalary == null ||
                                    data.salaray!.maxSalary == null
                                ? ""
                                : data.salaray!.minSalary!.type == 0 &&
                                        data.salaray!.maxSalary!.type == 0
                                    ? "Negotiable"
                                    : data.salaray!.minSalary!.salary
                                            .toString() +
                                        "K-" +
                                        data.salaray!.maxSalary!.salary
                                            .toString() +
                                        "K " +
                                        data.salaray!.minSalary!.currency! +
                                        "/Month",
                            location: data.division == null ||
                                    data.division!.cityid == null
                                ? ""
                                : data.division!.divisionname! +
                                    ", " +
                                    data.division!.cityid!.name!,
                            isArrowIcon: false,
                            industryList: data.category!.isEmpty ||
                                    data.category == null
                                ? []
                                : List.generate(
                                    data.category!.length,
                                    (index) =>
                                        data.category![index].categoryname!));
                      }),
                ),
        ],
      ),
    );
  }
}

import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/Screens/candidate_section/Resume/resume_view.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/candidate_section/resume_management_controller.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/app_constants.dart';
import '../../../utils/routes/route_helper.dart';
import '../../../widgets/app_bottom_nav_widget.dart';
import '../../../widgets/length_counter.dart';

class Resume_management extends StatefulWidget {
  const Resume_management({super.key});

  @override
  State<Resume_management> createState() => _Resume_managementState();
}

class _Resume_managementState extends State<Resume_management> {
  final resumecontroll = Get.put(ResumeManagementController());

  bool loading = false;

  Future loaddata() async {
    setState(() {
      loading = true;
    });
    if(resumecontroll.uploadresumelist.isEmpty){
      await resumecontroll.getallresume();
    }
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
      appBar: appBarWidget(
        title: "Manage your CV",
        onBackPressed: () => Get.back(),
        actions: [
           GetBuilder<ResumeManagementController>(builder: (_) {
              return  LengthCounter(firstText: "${resumecontroll.uploadresumelist.length}", secondText: "/3");
            }),
          const Gap(20),
        ],
      ),
      bottomNavigationBar: BottomNavWidget(
        text: "Upload a new CV",
        onTap: () {
          if (resumecontroll.uploadresumelist.length < 3) {
            Get.toNamed(RouteHelper.getAddCvRoute());
          } else {
            Helpers().showToastMessage(
                msg: "Maximum number of resumes already added.");
          }
        },
      ),
      body: loading
          ? Center(child: Helpers.appLoader2())
          : Padding(
              padding: EdgeInsets.all(10.r),
              child: Column(
                children: [
                  GetBuilder<ResumeManagementController>(
                    builder: (_) {
                      if (resumecontroll.uploadresumelist.isEmpty) {
                        return Container(
                          height: Dimensions.screenHeight * .5,
                          width: double.maxFinite,
                          child: Center(
                            child: Text("No resume found"),
                          ),
                        );
                      }
                      return Expanded(
                        child: Stack(
                          children: [
                            resumelist(),
                            (resumecontroll.isDeletingResume ||
                                    resumecontroll.isLoading)
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget resumelist() {
    return ListView.builder(
      itemCount: resumecontroll.uploadresumelist.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var data = resumecontroll.uploadresumelist[index];
        print(data.resume!.path);
        return InkWell(
          onTap: () {
            Get.to(UploadRecumeView(
              url: "${AppConstants.imgurl}" + data.resume!.path!,
            ));
          },
          child: Container(
            padding: EdgeInsets.only(
              left: width(10),
              top: height(10),
              bottom: height(10)
            ),
            margin: EdgeInsets.only(bottom: height(5)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius(6)),
              border: Border.all(
                color: AppColors.appBorder,
                width: .4,
              )
            ),
            child: Row(
              children: [
                Image.asset("assets/images/pdf.png", height: 30.h),
                SizedBox(width: 10.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            resumecontroll
                                .uploadresumelist[index].resume!.filename!,
                            style: Styles.bodyMedium1,
                          ),
                          SizedBox(
                            height: 20.h,
                            child: PopupMenuButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onSelected: (value) {
                                if (value == 1) {
                                  resumecontroll.resumedelete(data.sId!);
                                } else if (value == 2) {
                                  //...
                                }
                              },
                              icon: Icon(
                                Icons.more_vert,
                                color: AppColors.mainColor.withOpacity(.7),
                              ),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                      child: Text("Delete"), value: 1),
                                  PopupMenuItem(child: Text("Cancel"), value: 2)
                                ];
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetBuilder<ResumeManagementController>(builder: (_){
                            if(_.uploadresumelist[index].resume!.size! >= 1048576){
                              return Text(
                              (_.uploadresumelist[index].resume!
                                              .size! /
                                          1024/1024)
                                      .toStringAsFixed(2) +
                                  " MB",
                              style: Styles.smallText2);
                            }
                            return Text(
                              (_.uploadresumelist[index].resume!
                                              .size! /
                                          1024)
                                      .toStringAsFixed(2) +
                                  " KB",
                              style: Styles.smallText2);
                          }),
                          SizedBox(width: 10.w),
                          Text(
                              DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                  resumecontroll
                                      .uploadresumelist[index].uploadtime!)),
                              style: Styles.smallText2)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

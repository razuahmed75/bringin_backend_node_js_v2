import 'dart:io';
import 'package:bringin/controllers/candidate_section/job_controll.dart';
import 'package:bringin/res/app_font.dart';
import 'package:bringin/res/color.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../../Hive/hive.dart';
import '../../controllers/candidate_section/candidate_controll.dart';
import '../../controllers/upload_file/report_ss_upload_controller.dart';
import '../../utils/services/keys.dart';
import '../../widgets/app_bottom_nav_widget.dart';
import '../../widgets/custom_expand_text_field.dart';
import '../../widgets/formfield_length_checker.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JobControll jobControll = Get.find();
    CandidateControll candidateControll = Get.find();
    var isRecruiter = HiveHelp.read(Keys.isRecruiter);
    ReportController reportCtrlr = Get.find();
    var data = Get.arguments;

    return GestureDetector(
      onTap: () => Helpers.hideKeyboard(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: appBarWidget(
            title: isRecruiter ? "Report this Candidate" : "Report this Job",
            actions: [],
            onBackPressed: () {
              Get.back();
            }),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: isRecruiter
                          ? reportCtrlr.recruiterItems.length
                          : reportCtrlr.candidateItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(
                          () => Theme(
                            data: ThemeData(
                                unselectedWidgetColor: AppColors.appBorder,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                )),
                            child: CheckboxListTile(
                              side: BorderSide(
                                width: .5,
                              ),
                              title: Text(
                                isRecruiter
                                    ? reportCtrlr.recruiterItems[index]
                                    : reportCtrlr.candidateItems[index],
                                style: Styles.bodyMedium,
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              value: isRecruiter
                                  ? reportCtrlr.recruiterChecked[index]
                                  : reportCtrlr.candidateChecked[index],
                              visualDensity: VisualDensity(
                                  horizontal: -1.0, vertical: -4.0),
                              onChanged: (bool? value) {
                                /// IF THE USER ROLE IS RECRUITER
                                if (isRecruiter == true) {
                                  reportCtrlr.recruiterChecked[index] = value!;
                                  if (!reportCtrlr.recruiterSelectedItems
                                      .contains(
                                          reportCtrlr.recruiterItems[index])) {
                                    reportCtrlr.recruiterSelectedItems
                                        .add(reportCtrlr.recruiterItems[index]);
                                  } else {
                                    reportCtrlr.recruiterSelectedItems.remove(
                                        reportCtrlr.recruiterItems[index]);
                                  }
                                  print(reportCtrlr.recruiterSelectedItems);
                                  reportCtrlr.recruiterSelectedItems.refresh();
                                  reportCtrlr.recruiterChecked.refresh();
                                }

                                /// IF THE USER ROLE IS CANDIDATE
                                else {
                                  reportCtrlr.candidateChecked[index] = value!;
                                  if (!reportCtrlr.candidateSelectedItems
                                      .contains(
                                          reportCtrlr.candidateItems[index])) {
                                    reportCtrlr.candidateSelectedItems
                                        .add(reportCtrlr.candidateItems[index]);
                                  } else {
                                    reportCtrlr.candidateSelectedItems.remove(
                                        reportCtrlr.candidateItems[index]);
                                  }
                                  print(reportCtrlr.candidateSelectedItems);
                                  reportCtrlr.candidateSelectedItems.refresh();
                                  reportCtrlr.candidateChecked.refresh();
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    Gap(15),
                    Padding(
                      padding: Dimensions.kDefaultPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Write a report to help us remove frauds.",
                            style: Styles.bodyLargeMedium,
                          ),
                          Gap(15),
                          CustomExpandTextField(
                            maxHeight: 150,
                            minHeight: 150,
                            onChanged: (v) {
                              reportCtrlr.characterLength.value = v.length;
                            },
                            autofocus: false,
                            controller: reportCtrlr.textFeildController.value,
                            hinText: "Write a short description here",
                            maxLength: 700,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          ),

                          /// field length checker
                          Obx(
                            () => FormFieldLengthChecker(
                                characterLength:
                                    reportCtrlr.characterLength.value,
                                maxLength: 700),
                          ),
                          Gap(15),
                          GetBuilder<ReportController>(builder: (_) {
                            return _.renamedFile == null
                                ? InkWell(
                                    onTap: () {
                                      reportCtrlr.getScreenShot();
                                      Helpers.hideKeyboard();
                                    },
                                    child: Container(
                                      height: height(38),
                                      width: height(145),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.5,
                                            color: AppColors.shadowColor),
                                        borderRadius:
                                            BorderRadius.circular(radius(6)),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(height(8)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                size: height(12),
                                                color: AppColors.blackOpacity80,
                                              ),
                                              SizedBox(
                                                height: height(5),
                                              ),
                                              Text(
                                                "Add Screenshot",
                                                style: Styles.bodySmall2,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: height(100),
                                    width: height(100),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        InkWell(
                                          onTap: () => Get.to(() => PhotoView(
                                              imageProvider:
                                                  FileImage(_.renamedFile!))),
                                          child: Image.file(
                                            File(_.renamedFile!.path),
                                            fit: BoxFit.cover,
                                            height: height(100),
                                            width: height(100),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(),
                                              onPressed: () => _.resetPath(),
                                              icon: Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                  color: AppColors.mainColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  size: height(14),
                                                  color: AppColors.whiteColor,
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  );
                          }),
                        ],
                      ),
                    ),
                    Gap(30),
                  ],
                ),
              )),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavWidget(
            text: isRecruiter == true
                ? candidateControll.isReporting.value
                    ? "Submitting..."
                    : "Submit"
                : jobControll.isReporting.value
                    ? "Submitting..."
                    : "Submit",
            onTap: () async {
              print(HiveHelp.read(Keys.authToken));

              /// IF THE USER ROLE IS RECRUITER
              if (isRecruiter == true) {
                if (reportCtrlr.recruiterSelectedItems.isEmpty) {
                  Helpers().showToastMessage(
                      msg: "Please select the reasons for the report first");
                } else if (reportCtrlr.textFeildController.value.text.isEmpty) {
                  Helpers().showToastMessage(
                      msg: "Please write a short description");
                } else {
                  final body = {
                    "candidateid": "${data['seekerId']}",
                    "candidatefulldetailsid": "${data['full_detail_id']}",
                    "report": "${reportCtrlr.recruiterSelectedItems}",
                    "description":
                        reportCtrlr.textFeildController.value.text.trim()
                  };
                  candidateControll.reportCandidate(
                      data: body,
                      path: reportCtrlr.compressedFile == null
                          ? null
                          : reportCtrlr.compressedFile!.path);
                  reportCtrlr.recruiterSelectedItems.clear();
                }
              }

              /// IF THE USER ROLE IS CANDIDATE
              else {
                if (reportCtrlr.candidateSelectedItems.isEmpty) {
                  Helpers().showToastMessage(
                      msg: "Please select the reasons for the report first");
                } else if (reportCtrlr.textFeildController.value.text.isEmpty) {
                  Helpers().showToastMessage(
                      msg: "Please write a short description");
                } else {
                  final body = {
                    "jobid": "${data['jobId']}",
                    "jobpostuserid": "${data['jobpostuserid']}",
                    "report": "${reportCtrlr.candidateSelectedItems}",
                    "description":
                        reportCtrlr.textFeildController.value.text.trim()
                  };
                  jobControll.reportJob(
                      data: body,
                      path: reportCtrlr.compressedFile == null
                          ? null
                          : reportCtrlr.compressedFile!.path);
                  reportCtrlr.candidateSelectedItems.clear();
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

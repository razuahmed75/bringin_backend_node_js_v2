import 'dart:convert';
import 'dart:io';

import 'package:bringin/Http/get.dart';
import 'package:bringin/res/app_font.dart';
import 'package:bringin/res/color.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Hive/hive.dart';
import '../../../../../controllers/upload_file/report_ss_upload_controller.dart';
import '../../../../../models/Chat/channelinfo.dart';
import '../../../../../utils/services/keys.dart';
import '../../../../../widgets/app_bottom_nav_widget.dart';
import '../../../../../widgets/custom_expand_text_field.dart';
import '../../../../../widgets/formfield_length_checker.dart';

class ChatReportScreen extends StatefulWidget {
  final ChannelInfo channel;
  const ChatReportScreen({super.key, required this.channel});

  @override
  State<ChatReportScreen> createState() => _ChatReportScreenState();
}

class _ChatReportScreenState extends State<ChatReportScreen> {
  Future report(
      {required String dis, List<String>? report, String? img}) async {
    var data = await Httphelp.report2(
        ENDPOINT_URL: "/chat_report",
        fields: {
          'channel': widget.channel.id!,
          'seekerid': widget.channel.seekerid!.id!,
          'recruiterid': widget.channel.recruiterid!.id!,
          'discription': dis,
        },
        key: "report",
        report: report,
        path: img);

    Helpers.showAlartMessage(msg: jsonDecode(data.body)['message']);
    Navigator.pop(context);
  }

  String? imgpath;
  List<String> reportlist = [];

  Future imageupload() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        print(image.path);
        imgpath = File(image.path).path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var isRecruiter = HiveHelp.read(Keys.isRecruiter);
    ReportController reportCtrlr = Get.find();

    return GestureDetector(
      onTap: () => Helpers.hideKeyboard(),
      child: Scaffold(
        appBar: appBarWidget(
            title: isRecruiter
                      ? "Report this Candidate"
                      : "Report this Recruiter",
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
                                unselectedWidgetColor: AppColors.borderColor,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                )),
                            child: CheckboxListTile(
                              side: BorderSide(
                                width: .7,
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
                                // / IF THE USER ROLE IS RECRUITER
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
                      padding: const EdgeInsets.only(left: 15, right: 15),
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
                          imgpath == null
                              ? InkWell(
                                  onTap: () {
                                    // reportCtrlr.getScreenShot();
                                    imageupload();
                                    Helpers.hideKeyboard();
                                  },
                                  child: Container(
                                    height: height(38),
                                    width: height(133),
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
                                              style: Styles.smallText1,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 100.h,
                                  width: 100.w,
                                  child: Stack(
                                    children: [
                                      Image.file(File(imgpath!)),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
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
        bottomNavigationBar: BottomNavWidget(
          // text: isRecruiter == true ? candidateListController.isReporting.value ? "Submitting..." : "Submit" : jobControll.isReporting.value ? "Submitting..." : "Submit",
          text: 'Submit',
          onTap: () async {
            print(HiveHelp.read(Keys.authToken));
            report(
                dis: reportCtrlr.textFeildController.value.text,
                img: imgpath,
                report: isRecruiter == true
                    ? reportCtrlr.recruiterSelectedItems.value
                    : reportCtrlr.candidateSelectedItems.value);
          },
        ),
      ),
    );
  }
}

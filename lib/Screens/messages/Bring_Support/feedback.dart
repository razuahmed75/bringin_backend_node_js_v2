import 'dart:convert';
import 'dart:io';
import 'package:bringin/Hive/hive.dart';
import 'package:bringin/Http/get.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/utils/services/keys.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../res/app_font.dart';
import '../../../controllers/candidate_section/candidate_edit_main_profile_controller.dart';
import '../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../../models/Chat/channelinfo.dart';
import '../../../widgets/app_bottom_nav_widget.dart';

class HelpAndFeedback extends StatefulWidget {
  final ChannelInfo data;
  const HelpAndFeedback({super.key, required this.data});

  @override
  State<HelpAndFeedback> createState() => _HelpAndFeedbackState();
}

class _HelpAndFeedbackState extends State<HelpAndFeedback> {
  TextEditingController fieldtext = TextEditingController();

  String? imgpath;

  Future imageupload() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      imgpath = result.files[0].path;
    }

    setState(() {});
  }

  CandidateEditMainProfileController candidateEditMainProfileController =
      Get.put(CandidateEditMainProfileController());
  RecruiterEditMainProfileController recruiterEditMainProfileController =
      Get.put(RecruiterEditMainProfileController());

  Future submit() async {
    Map<String, String>? fields = {
      'userid': HiveHelp.read(Keys.isRecruiter) == true
          ? "null"
          : candidateEditMainProfileController.profileInfoList[0].id!,
      'recruiterid': HiveHelp.read(Keys.isRecruiter) == false
          ? "null"
          : recruiterEditMainProfileController.recruiterProfileInfoList[0].sId!,
      'text': fieldtext.text,
      'channel': widget.data.id!
    };

    var data = await Httphelp.report2(
        ENDPOINT_URL: "/chatfeedback",
        fields: fields,
        path: imgpath,
        report: []);

    Helpers.showAlartMessage(msg: jsonDecode(data.body)['message']);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavWidget(
        text: "Submit",
        onTap: ()=> submit(),
      ),
      appBar: AppBar(
        title: Text(
          'Help & Feedback',
          style: TextStyle(
            color: Color(0xFF454545),
            fontSize: 22,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [textbox(), screenshot()],
        ),
      ),
    );
  }

  Widget textbox() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.only(
        top: 5.h,
        left: 15.w,
        right: 15.w,
        bottom: 8.h,
      ),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.25, color: Color(0x33212427)),
            borderRadius: BorderRadius.circular(9),
          )),
      child: Column(
        children: [
          TextFormField(
            controller: fieldtext,
            inputFormatters: [
              LengthLimitingTextInputFormatter(4000),
            ],
            maxLines: 8,
            minLines: 8,
            maxLength: 4000,
            decoration: InputDecoration(
                counterStyle: TextStyle(
                  color: Color(0xFF00A0DC),
                ),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.4000000059604645),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                hintText:
                    "Please provide a detailed description of the issue you have encountered or share your suggestions (if any)."),
          ),
        ],
      ),
    );
  }

  Widget screenshot() {
    return Container(
      margin: EdgeInsets.only(left: 15.w, top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Submit screenshots (optional)',
            style: Styles.bodyMedium1,
          ),
          SizedBox(height: 10.h),
          if (imgpath == null)
            InkWell(
              onTap: () {
                imageupload();
              },
              child: Container(
                width: 91,
                height: 76,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 91,
                        height: 76,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.25, color: Color(0x33212427)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 26,
                      top: 18,
                      child: Opacity(
                        opacity: 0.70,
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Stack(children: [
                            SvgPicture.asset("assets/icon2/Add_round_light.svg")
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (imgpath != null)
            Container(
                margin: EdgeInsets.only(right: 15.w),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Image.file(File(imgpath!)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                imgpath = null;
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                            ))
                      ],
                    )))
        ],
      ),
    );
  }

}

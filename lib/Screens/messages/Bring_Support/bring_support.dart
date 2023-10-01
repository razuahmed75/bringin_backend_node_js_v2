import 'package:bringin/Hive/hive.dart';
import 'package:bringin/Http/get.dart';
import 'package:bringin/widgets/app_bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/candidate_section/candidate_edit_main_profile_controller.dart';
import '../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../../models/Chat/bring_assist.dart';
import '../../../models/Chat/channelinfo.dart';
import '../../../utils/services/keys.dart';
import 'feedback.dart';

class BringSupportPage extends StatefulWidget {
  final ChannelInfo data;
  const BringSupportPage({super.key, required this.data});

  @override
  State<BringSupportPage> createState() => _BringSupportPageState();
}

class _BringSupportPageState extends State<BringSupportPage> {
  List<BringAssestesmsg> msg = [];

  bool loading = false;

  Future loaddata() async {
    setState(() {
      loading = true;
    });
    var data = await Httphelp.get(
        ENDPOINT_URL: "/bringin_sup_msg?channelid=${widget.data.id}");

    msg = bringAssestesmsgFromJson(data.body);
    loadcurrentuser();
    setState(() {
      loading = false;
    });
  }

  CandidateEditMainProfileController candidateEditMainProfileController =
      Get.put(CandidateEditMainProfileController());
  RecruiterEditMainProfileController recruiterEditMainProfileController =
      Get.put(RecruiterEditMainProfileController());
  Future loadcurrentuser() async {
    if (HiveHelp.read(Keys.isRecruiter) == false) {
      await Get.find<CandidateEditMainProfileController>().getProfileInfo();
    } else {
      await Get.find<RecruiterEditMainProfileController>()
          .getRecruiterProfileInfoList();
    }
  }


  String name() {
    if(HiveHelp.read(Keys.isRecruiter)){
      return "${recruiterEditMainProfileController.recruiterProfileInfoList[0].firstname} ${recruiterEditMainProfileController.recruiterProfileInfoList[0].lastname}";
    }else
    return "${candidateEditMainProfileController.profileInfoList[0].fastname} ${candidateEditMainProfileController.profileInfoList[0].lastname}";
  }

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavWidget(
        text: "Help Feedback",
        onTap: ()=> Get.to(HelpAndFeedback(data: widget.data)),
      ),
      appBar: AppBar(
          title: Text(
            "Bringin Assistant",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: msg.length,
              itemBuilder: (context, index) {
                var data = msg[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Color(0xFF00517B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${DateFormat("EEEE").format(DateTime.fromMillisecondsSinceEpoch(data.message!.createdAt!))}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      padding: EdgeInsets.only(
                        top: 7.h,
                        left: 9.w,
                        right: 3.w,
                        bottom: 6.42.h,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF2F2F2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // width: 229,
                            // height: 108.58,
                            constraints: BoxConstraints(maxWidth: 229.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 229.w,
                                  child: Text(
                                    'Hello ${name()}, Welcome to Bringin! you are now approved to reach more! if there anything we can help you with, feel free to reach us at +88 01756175141 via WhatsApp.',
                                    style: TextStyle(
                                      color: Color(0xE5212427),
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 1.36,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  height: 11.58,
                                  child: Text(
                                    '${DateFormat("HH:mm").format(DateTime.fromMillisecondsSinceEpoch(data.message!.createdAt!))}',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0x3F212427),
                                      fontSize: 11,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }
}

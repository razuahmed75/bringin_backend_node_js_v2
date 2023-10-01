import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/ChatController/chatcontroll.dart';
import '../../../../../controllers/both_category/seeker_chat_controller.dart';
import '../../../../../models/Chat/channelinfo.dart';
import '../../../../../models/candidate_section/Chat/GroupChannel/groupchannel.dart';
import '../../../../Hive/hive.dart';
import '../../../../controllers/candidate_section/candidate_controll.dart';
import '../../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../candidate_message/Chat/Report/recruiterreport.dart';

class RecruiterChatSettingPage extends StatefulWidget {
  final ChannelInfo data;
  const RecruiterChatSettingPage({super.key, required this.data});

  @override
  State<RecruiterChatSettingPage> createState() =>
      _RecruiterChatSettingPageState();
}

class _RecruiterChatSettingPageState extends State<RecruiterChatSettingPage> {
  final ChatControll chatControll = Get.put(ChatControll());
  CandidateControll controll = Get.put(CandidateControll());
  var recuiterprofile = Get.find<RecruiterEditMainProfileController>();

  @override
  void initState() {
    super.initState();
  }

  bool block = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Chat Setting",
            style: TextStyle(color: Colors.black),
          )),
      body: GetBuilder<ChatControll>(builder: (_) {
        return Column(
          children: [
          if(widget.data.candidateFullprofile != null)  ListTile(
              title: Text(
                "Save Candidate",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              trailing: Switch(
                // value: blockdata['${widget.user.recruiterId ?? widget.user.id}'],
                value:  HiveHelp.read(widget.data.candidateFullprofile!.userid!.id!) ==
                        widget.data.candidateFullprofile!.userid!.id! ? true : false,
                onChanged: (value) {
                  controll.savecandidateprofile(
                      seekerid: widget.data.candidateFullprofile!.userid!.id,
                      fields: {
                        "candidatefullprofile": widget.data.candidateFullprofile!.id,
                        "candidateid":widget.data.candidateFullprofile!.userid!.id!
                      });
                  recuiterprofile.getRecruiterProfileInfoList();
                },
              ),
            ),
            ListTile(
              title: Text(
                "Block",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              trailing: Switch(
                // value: blockdata['${widget.user.recruiterId ?? widget.user.id}'],
                value: _.seekerblock,
                onChanged: (value) {
                  // _.blockget(false, value);
                  var mapdata = {
                    "channelid": widget.data.id,
                    "seekerblock": value,
                    "recruiterblock": _.recruiterblock
                  };
                  _.socket.emit("block_user", mapdata);
                },
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(ChatReportScreen(channel: widget.data));
              },
              title:
                  Text("Report", style: TextStyle(fontWeight: FontWeight.w400)),
            )
          ],
        );
      }),
    );
  }
}

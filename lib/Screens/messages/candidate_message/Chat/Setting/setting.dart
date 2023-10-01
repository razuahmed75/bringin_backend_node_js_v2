import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Hive/hive.dart';
import '../../../../../controllers/ChatController/chatcontroll.dart';
import '../../../../../controllers/both_category/seeker_chat_controller.dart';
import '../../../../../controllers/candidate_section/job_controll.dart';
import '../../../../../models/Chat/channelinfo.dart';
import '../../../../../models/candidate_section/Chat/GroupChannel/groupchannel.dart';
import '../Report/recruiterreport.dart';

class ChatSettingPage extends StatefulWidget {
  final ChannelInfo data;
  const ChatSettingPage({super.key, required this.data});

  @override
  State<ChatSettingPage> createState() => _ChatSettingPageState();
}

class _ChatSettingPageState extends State<ChatSettingPage> {
  final ChatControll chatControll = Get.put(ChatControll());
  JobControll controll = Get.put(JobControll());

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
            if (widget.data.jobid != null)
              ListTile(
                title: Text(
                  "Save Job",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                trailing: Switch(
                  value: HiveHelp.read(widget.data.jobid!.id!) == widget.data.jobid!.id! ? true : false,
                  onChanged: (value) {
                    controll.saveJob(jobId: widget.data.jobid!.id!);
                    
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
                value: _.recruiterblock,
                onChanged: (value) {
                  // _.blockget(false, value);
                  var mapdata = {
                    "channelid": widget.data.id,
                    "seekerblock": _.seekerblock,
                    "recruiterblock": value
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

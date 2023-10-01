import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../Http/get.dart';
import '../../../controllers/ChatController/chatcontroll.dart';
import '../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../../models/Chat/channelinfo.dart';
import '../../../res/constants/app_constants.dart';
import '../candidate_message/components/chats_dialog.dart';
import '../recruiter_message/Inbox/inbox.dart';
import '../recruiter_message/components/recruiter_chats_tab.dart';

class RecruiterReject extends StatefulWidget {
  const RecruiterReject({super.key});

  @override
  State<RecruiterReject> createState() => _RecruiterRejectState();
}

class _RecruiterRejectState extends State<RecruiterReject> {
  ChatControll chatControll = Get.put(ChatControll());
  bool loading = false;
  Future interchatinbox({seekerId}) async {
    setState(() {
      loading = true;
    });
    await Httphelp.post(
        ENDPOINT_URL: "/candidate_unreject",
        fields: {"candidateid": "$seekerId"});
    chatControll.loadrecruiterchannel();
    // rejectlist = chatControll.chanellist
    //     .where(
    //         (element) => element.type == 1 && element.recruiterReject == true)
    //     .toList();
    // print(rejectlist.length);
    setState(() {
      loading = false;
    });
    // Get.back();
  }

  @override
  void initState() {
    // rejectlist = chatControll.chanellist
    //     .where(
    //         (element) => element.type == 1 && element.recruiterReject == true)
    //     .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Not Interested ", style: TextStyle(color: Colors.black)),
          centerTitle: true),
      body: GetBuilder<ChatControll>(
        builder: (controller) {
          return Column(
            children: [
              Center(
                child: Container(
                  height: 23.h,
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0077B5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.25,
                        color: Colors.black.withOpacity(0.15000000596046448),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${controller.rejectlist.length} Person',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Flexible(
                child: SlidableAutoCloseBehavior(
                  closeWhenOpened: true,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 290.w,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.25,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0x33212427),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    shrinkWrap: true,
                    itemCount: controller.rejectlist.length,
                    itemBuilder: (context, index) {
                      var data = controller.rejectlist[index];
                      return conversation(data, controller, context, index);
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget conversation(
      ChannelInfo data, ChatControll _, BuildContext context, int index) {
    final recuiterprofile = Get.find<RecruiterEditMainProfileController>();
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              // interchatinbox(seekerId: data.seekerid!.id);
              await Httphelp.post(
                  ENDPOINT_URL: "/candidate_unreject",
                  fields: {"candidateid": "${data.seekerid!.id}"});
              chatControll.loadrecruiterchannel();
              // rejectlist = chatControll.chanellist
              //     .where((element) =>
              //         element.type == 1 && element.recruiterReject == true)
              //     .toList();
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            label: 'Remove',
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          // chatControll.channelconnect(channelid: data.id);
          // if (premiunmessage(data, chatControll,
          //     recuiterprofile.recruiterProfileInfoList[0])) {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => RecruiterChatScreen(data: data)));
          // } else {
          //   ChatsDialog.dialog(context);
          // }
        },
        leading: CircleAvatar(
          radius: 25.r,
          backgroundImage: NetworkImage(data.seekerid == null
              ? "https://www.w3schools.com/howto/img_avatar.png"
              : "${AppConstants.imgurl}${data.seekerid!.image}"),
        ),
        dense: true,
        title: Transform.translate(
          offset: Offset(-5, 0),
          child: Row(
            children: [
              Expanded(
                flex: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.seekerid!.fastname!} ${data.seekerid!.lastname}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                    Text(
                      "${data.seekerid!.other!.lastfunctionalarea!.functionalname}",
                      maxLines: 1,
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    )
                  ],
                ),
              ),
              Spacer(),
              if (data.lastmessage != null)
                Column(
                  children: [
                    Text(
                      _.dateformet(data.lastmessage!.updatedAt!),
                      style:
                          TextStyle(color: Color(0xFF0077B5), fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    if (data.recruiterUnseen != 0)
                      Container(
                        width: 18,
                        height: 18,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Color(0xFF0077B5),
                          shape: OvalBorder(),
                        ),
                        child: Text(
                          "${data.recruiterUnseen}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                  ],
                )
            ],
          ),
        ),
        // subtitle: Text(
        //     data.lastmessage == null
        //         ? ""
        //         : data.lastmessage!.message!.customProperties!
        //                     .type ==
        //                 5
        //             ? "Send image"
        //             : data.lastmessage!.message!.user!.id ==
        //                         data.seekerid!.id &&
        //                     data.lastmessage!.message!
        //                             .customProperties!.type ==
        //                         2
        //                 ? "Sent CV."
        //                 : data.lastmessage!.message!.text!,
        //     maxLines: 2),
        subtitle: Transform.translate(
          offset: Offset(-5, 0),
          child: Text(
            lastmessage(data.lastmessage, data),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Color(0x72212427),
                fontSize: 14.sp,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  String lastmessage(Lastmessage? lastmessage, ChannelInfo data) {
    if (lastmessage == null) {
      return "last message empty";
    } else if (lastmessage.message!.user!.id == data.seekerid!.id &&
        data.lastmessage!.message!.customProperties!.type == 2) {
      return "${lastmessage.message!.user!.firstName} ${lastmessage.message!.user!.lastName} sent you a CV";
    } else if (lastmessage.message!.user!.id == data.seekerid!.id &&
        data.lastmessage!.message!.customProperties!.type == 5) {
      return "${lastmessage.message!.user!.firstName} ${lastmessage.message!.user!.lastName} sent you a image";
    } else if (lastmessage.message!.user!.id == data.recruiterid!.id &&
        data.lastmessage!.message!.customProperties!.type == 5) {
      return "You have sent a picture";
    } else {
      return lastmessage.message!.text!;
    }
  }
}

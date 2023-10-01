import 'package:bringin/res/constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/ChatController/chatcontroll.dart';
import '../../../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../../../models/Chat/channelinfo.dart';
import '../../../../models/recruiter_section/recruiter_profile_info_model.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../Bring_Support/bring_support.dart';
import '../../Recruiter_reject/recruiter_reject.dart';
import '../../candidate_message/components/chats_dialog.dart';
import '../Inbox/inbox.dart';
import '../Singlerec_whoviewme/single_recr_whoviewme.dart';

bool premiunmessage(ChannelInfo data, ChatControll chatControll,
    RecruiterProfileInfoModel recuiterprofile) {
  if (recuiterprofile.other!.package != null &&
      recuiterprofile.other!.package!.active == true) {
    ChatControll chatControll = Get.find<ChatControll>();
    chatControll.gettoday();
    DateTime enddate = recuiterprofile.other!.package!.enddate!.toLocal();
    int different = enddate.difference(chatControll.todaydate).inDays;
    if (different <= 0) {
      return false;
    } else if (different > 0 &&
        chatControll.recruiter_today_conv.isNotEmpty &&
        chatControll.recruiter_today_conv.length >= (recuiterprofile.other!.package!.packageid!.chat! + 5)) {
      if (chatControll.recruiter_today_conv
          .any((element) => element.id == data.id)) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  } else {
    if (chatControll.recruiter_today_conv.isNotEmpty &&
        chatControll.recruiter_today_conv.length >= 6) {
      if (chatControll.recruiter_today_conv
          .any((element) => element.id == data.id)) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  // if (chatControll.recruiter_today_conv.isNotEmpty &&
  //     chatControll.recruiter_today_conv.length >= (recuiterprofile.other!.package == null ? 6 : recuiterprofile.other!.package!.packageid!.chat!)) {
  //   if (chatControll.recruiter_today_conv
  //       .any((element) => element.id == data.id)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // } else {
  //   return true;
  // }
}

class RecruiterChatsTab extends StatefulWidget {
  final bool onbording;
  RecruiterChatsTab({super.key, this.onbording = false});

  @override
  State<RecruiterChatsTab> createState() => _RecruiterChatsTabState();
}

class _RecruiterChatsTabState extends State<RecruiterChatsTab>
    with WidgetsBindingObserver {
  ChatControll chatControll = Get.put(ChatControll());
  TextEditingController searchtext = TextEditingController();
  final recuiterprofile = Get.find<RecruiterEditMainProfileController>();
  List<ChannelInfo> searchchanellist = [];
  FocusNode focusNode = FocusNode();

  void searchchannel(String value) {
    var data = chatControll.chanellist.where((element) {
      String fastname = element.seekerid != null
          ? element.seekerid!.fastname!.toLowerCase()
          : "";
      String lastname = element.seekerid != null
          ? element.seekerid!.lastname!.toLowerCase()
          : "";
      return "${fastname} ${lastname}".contains(value.toLowerCase());
    }).toList();
    searchchanellist = data;
  }

  String lastmessage(Lastmessage? lastmessage, ChannelInfo data) {
    if (lastmessage == null) {
      return "last message empty";
    } else if (lastmessage.message!.user!.id == data.seekerid!.id &&
        data.lastmessage!.message!.customProperties!.type == 1) {
      return "${lastmessage.message!.user!.firstName} ${lastmessage.message!.user!.lastName} sent his phone number";
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

  @override
  void initState() {
    chatControll.loadrecruiterchannel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          searchbox(),
          SizedBox(height: 8.h),
          GetBuilder<ChatControll>(
            builder: (_) {
              return _.channellistloading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  : widget.onbording
                      ? ListView.separated(
                          separatorBuilder: (context, index) {
                            var data = searchtext.text.isEmpty
                                ? _.chanellist[index]
                                : searchchanellist[index];
                            if (data.type == 1 &&
                                data.type == 4 &&
                                (data.recruiterReject == null ||
                                    data.recruiterReject == false) &&
                                data.lastmessage != null &&
                                data.type != 3 &&
                                data.type != 2 &&
                                data.outbound == true) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 290.w,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 0.25,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0x33212427),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: searchtext.text.isEmpty
                              ? _.chanellist.length
                              : searchchanellist.length,
                          itemBuilder: (context, index) {
                            var data = searchtext.text.isEmpty
                                ? _.chanellist[index]
                                : searchchanellist[index];
                            if (data.type == 4 &&
                                data.recruiterid!.id ==
                                    chatControll.currentuserid &&
                                widget.onbording == true) {
                              return rejectbox(data, _);
                            } else if (data.type == 1 &&
                                (data.recruiterReject == null ||
                                    data.recruiterReject == false) &&
                                data.lastmessage != null &&
                                data.outbound == widget.onbording) {
                              return conversation(data, _);
                            } else {
                              return SizedBox();
                            }
                          },
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            var data = searchtext.text.isEmpty
                                ? _.chanellist[index]
                                : searchchanellist[index];
                            if (data.type == 2 ||
                                data.type == 3 ||
                                (data.type == 4 &&
                                        data.recruiterid!.id ==
                                            chatControll.currentuserid ||
                                    (data.type == 1 &&
                                        (data.recruiterReject == null ||
                                            data.recruiterReject == false) &&
                                        data.lastmessage != null))) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 290.w,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 0.25,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0x33212427),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: searchtext.text.isEmpty
                              ? _.chanellist.length
                              : searchchanellist.length,
                          itemBuilder: (context, index) {
                            var data = searchtext.text.isEmpty
                                ? _.chanellist[index]
                                : searchchanellist[index];
                            if (data.type == 2 && widget.onbording == false) {
                              return bringassistent(data);
                            } else if (data.type == 3 &&
                                widget.onbording == false) {
                              return whoviewme(data);
                            } else if (data.type == 4 &&
                                data.recruiterid!.id ==
                                    chatControll.currentuserid &&
                                widget.onbording == false) {
                              return rejectbox(data, _);
                            } else if (data.type == 1 &&
                                (data.recruiterReject == null ||
                                    data.recruiterReject == false) &&
                                data.lastmessage != null &&
                                data.outbound == widget.onbording) {
                              return conversation(data, _);
                            } else {
                              return SizedBox();
                            }
                          },
                        );
            },
          ),
        ],
      ),
    );
  }

  Widget bringassistent(ChannelInfo data) {
    return ListTile(
      onTap: () {
        searchtext.clear();
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BringSupportPage(data: data)))
            .then((value) {});
      },
      contentPadding: EdgeInsets.only(left: 7.w, right: 10.w),
      horizontalTitleGap: 10.w,
      leading: Container(
          width: 57.h,
          height: 57.h,
          child: SvgPicture.asset("assets/icon2/bring.svg")),
      dense: true,
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.bringAssis!.title}",
                  style: Styles.bodyMedium,
                ),
                Text(
                  "Hi, ${recuiterprofile.recruiterProfileInfoList[0].firstname} ${recuiterprofile.recruiterProfileInfoList[0].lastname}! welcome to brinign!",
                  maxLines: 1,
                  style: Styles.bodySmall3
                      .copyWith(color: AppColors.blackColor.withOpacity(.45)),
                )
              ],
            ),
          ),
          Column(
            children: [
              Text(
                chatControll.dateformet(DateTime.fromMillisecondsSinceEpoch(
                    data.bringAssis!.bringlastmessage!.message!.createdAt!)),
                style: Styles.smallText1.copyWith(color: AppColors.mainColor),
              ),
              SizedBox(
                height: 6,
              ),
              if (data.seekerUnseen != 0)
                Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0077B5),
                    shape: OvalBorder(),
                  ),
                  child: Text("${data.seekerUnseen}",
                      textAlign: TextAlign.right,
                      style: Styles.smallText1
                          .copyWith(color: AppColors.whiteColor)),
                )
            ],
          ),
        ],
      ),
      subtitle: Text(data.bringAssis!.message2!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.bodySmall1),
    );
  }

  Widget whoviewme(ChannelInfo data) {
    return ListTile(
      onTap: () {
        Get.to(SingleRecWhoViewme(data: data));
      },
      contentPadding: EdgeInsets.only(left: 7.w, right: 10),
      horizontalTitleGap: 10.w,
      leading: Container(
          width: 57.h,
          height: 57.h,
          child: SvgPicture.asset("assets/icon2/whoviewme.svg")),
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.whoViewMe!.title}",
                  style: Styles.bodyMedium,
                ),
                SizedBox(height: 7.h),
                Text(
                  data.whoViewMe!.recruiterview != null
                      ? data.whoViewMe!.totalview == 1
                          ? "${data.whoViewMe!.recruiterview!.fastname} ${data.whoViewMe!.recruiterview!.lastname} viewed you"
                          : "${data.whoViewMe!.recruiterview!.fastname} ${data.whoViewMe!.recruiterview!.lastname} and ${data.whoViewMe!.totalview! - 1} others viewed you"
                      : "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.bodySmall3,
                )
              ],
            ),
          ),
          Column(
            children: [
              Text(
                chatControll.dateformet(DateTime.now()),
                style: TextStyle(color: Color(0xFF0077B5), fontSize: 12.sp),
              ),
              SizedBox(
                height: 6,
              ),
              if (data.whoViewMe!.newview != 0)
                Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0077B5),
                    shape: OvalBorder(),
                  ),
                  child: Text(
                    "${data.whoViewMe!.newview}",
                    textAlign: TextAlign.right,
                    style:
                        Styles.smallText1.copyWith(color: AppColors.whiteColor),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }

  Widget conversation(ChannelInfo data, ChatControll _) {
    return ListTile(
      onTap: () {
        searchtext.clear();
        focusNode.unfocus();
        chatControll.channelconnect(channelid: data.id);
        if (premiunmessage(
            data, chatControll, recuiterprofile.recruiterProfileInfoList[0])) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecruiterChatScreen(data: data)));
        } else {
          ChatsDialog.dialog(context);
        }
        // if (_.recruiter_today_conv.isNotEmpty &&
        //     _.recruiter_today_conv.length >= 3) {
        //   if (_.recruiter_today_conv.any((element) => element.id == data.id)) {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => RecruiterChatScreen(data: data)));
        //   } else {
        //     ChatsDialog.dialog();
        //   }
        // } else {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => RecruiterChatScreen(data: data)));
        // }
      },
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(
      //       "${AppConstants.imgurl}${data.seekerid!.image}"),
      // ),
      // contentPadding: EdgeInsets.only(left: 7.w, right: 10),
      // leading: Container(
      //   width: 57.w,
      //   height: 57.h,
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     image: DecorationImage(
      //       image: NetworkImage(data.recruiterid == null
      //           ? "https://www.w3schools.com/howto/img_avatar.png"
      //           : "${AppConstants.imgurl}${data.recruiterid!.image}"),
      //       fit: BoxFit.fill,
      //     ),
      //   ),
      // ),
      contentPadding: EdgeInsets.only(left: 7.w, right: 10.w),
      horizontalTitleGap: 10.w,
      leading: Container(
        width: 57.h,
        height: 57.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              data.seekerid == null
                  ? "https://www.w3schools.com/howto/img_avatar.png"
                  : "${AppConstants.imgurl}${data.seekerid!.image}",
            ),
            fit: BoxFit.cover,
            onError: (error, stackTrace) => Icon(Icons.error, size: 57.h),
          ),
        ),
      ),

      dense: true,
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${data.seekerid!.fastname!} ${data.seekerid!.lastname}",
                style: Styles.bodyMedium,
              ),
              Text(
                "${data.seekerid!.other!.lastfunctionalarea!.functionalname}",
                maxLines: 1,
                style: Styles.bodySmall1
                    .copyWith(color: AppColors.blackColor.withOpacity(.45)),
              )
            ],
          ),
          Spacer(),
          if (data.lastmessage != null)
            Column(
              children: [
                Text(
                  chatControll
                      .dateformet(data.lastmessage!.message!.createdAt!),
                  style: Styles.smallText1.copyWith(color: AppColors.mainColor),
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
                    child: Text("${data.recruiterUnseen}",
                        textAlign: TextAlign.right,
                        style: Styles.smallText1
                            .copyWith(color: AppColors.whiteColor)),
                  )
              ],
            )
        ],
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
      subtitle: Text(
        lastmessage(data.lastmessage, data),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Styles.bodySmall1,
      ),
    );
  }

  Widget rejectbox(ChannelInfo data, ChatControll _) {
    return ListTile(
      onTap: () {
        Get.to(RecruiterReject());
      },
      dense: true,
      contentPadding: EdgeInsets.only(left: 7.w, right: 10),
      horizontalTitleGap: 10.w,
      title: Text(
        data.notInterest!.title!,
        style: Styles.bodyMedium,
      ),
      subtitle: Text("${data.notInterest!.person} Person"),
      leading: Container(
          width: 57.h,
          height: 57.h,
          child: SvgPicture.asset("assets/icon2/reject.svg")),
    );
  }

  Widget searchbox() {
    return Container(
      height: 40.h,
      width: 330.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFEEEEEE), borderRadius: BorderRadius.circular(6.r)),
      child: TextFormField(
        focusNode: focusNode,
        controller: searchtext,
        onChanged: (value) {
          if (value.isEmpty) {
            searchchanellist.clear();
          } else {
            searchchannel(value);
          }
          setState(() {});
        },
        decoration: InputDecoration(
            hintText: "Search",
            isDense: true,
            prefixIconConstraints:
                BoxConstraints(minHeight: 15.h, minWidth: 15.w),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 5.w),
              child: SvgPicture.asset(
                "assets/icon2/search.svg",
                width: 15.w,
                height: 15.h,
              ),
            ),
            border: InputBorder.none),
      ),
    );
  }
}

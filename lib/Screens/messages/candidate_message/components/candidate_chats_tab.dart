import 'package:bringin/res/constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/ChatController/chatcontroll.dart';
import '../../../../models/Chat/channelinfo.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../Bring_Support/bring_support.dart';
import '../Chat/Inbox/chatscreen.dart';
import '../SingleWhoViewme/singlewwhoview.dart';

class CandidateChatsTab extends StatefulWidget {
  CandidateChatsTab({super.key});

  @override
  State<CandidateChatsTab> createState() => _CandidateChatsTabState();
}

class _CandidateChatsTabState extends State<CandidateChatsTab>
    with WidgetsBindingObserver {
  ChatControll chatControll = Get.put(ChatControll());
  FocusNode focusNode = FocusNode();

  List<ChannelInfo> searchchanellist = [];
  TextEditingController searchtext = TextEditingController();

  String lastmessage(Lastmessage? lastmessage, ChannelInfo data) {
    if (lastmessage == null) {
      return "last message empty";
    } else if (lastmessage.message!.user!.id == data.seekerid!.id &&
        data.lastmessage!.message!.customProperties!.type == 2) {
      return "Your Cv has been sent.";
    } else if (lastmessage.message!.user!.id == data.seekerid!.id &&
        data.lastmessage!.message!.customProperties!.type == 5) {
      return "You have sent a picture";
    } else if (lastmessage.message!.user!.id == data.recruiterid!.id &&
        data.lastmessage!.message!.customProperties!.type == 5) {
      return "${lastmessage.message!.user!.firstName} ${lastmessage.message!.user!.lastName} sent you a image";
    } else {
      return lastmessage.message!.text!;
    }
  }

  void searchchannel(String value) {
    print(value);
    var data = chatControll.chanellist.where((element) {
      String fastname = element.recruiterid != null
          ? element.recruiterid!.firstname!.toLowerCase()
          : "";
      String lastname = element.recruiterid != null
          ? element.recruiterid!.lastname!.toLowerCase()
          : "";
      return element.recruiterid != null &&
          "${fastname} ${lastname}".contains(value.toLowerCase());
    }).toList();
    searchchanellist = data;
  }

  @override
  void initState() {
    chatControll.channellistloading = true;
    chatControll.channellistevent();
    // chatControll.socket.emit("channellistroom", chatControll.currentuserid);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                      child: CircularProgressIndicator(
                        color: AppColors.blackColor,
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        var data = searchtext.text.isEmpty
                            ? _.chanellist[index]
                            : searchchanellist[index];
                        if (data.type == 2 ||
                            data.type == 3 ||
                            data.type == 1) {
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

                        if (data.type == 2) {
                          return bringaassiet(data);
                        } else if (data.type == 3) {
                          return whoviewme(data);
                        } else if (data.type == 1) {
                          return conversation(data);
                        } else {
                          return SizedBox();
                        }
                      },
                    );
            },
          )
        ],
      ),
    );
  }

  Widget bringaassiet(ChannelInfo data) {
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
        // leading: Container(
        //   width: 57.h,
        //   height: 57.h,
        //   child: SvgPicture.asset("assets/icon2/bring.svg"),
        // ),
        leading: CircleAvatar(
          radius: 20.r,
          child: SvgPicture.asset("assets/icon2/bring.svg"),
        ),
        dense: true,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.bringAssis!.title}",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                  ),
                  Text(
                    "Hi, ${data.seekerid!.fastname} ${data.seekerid!.lastname}! welcome to brinign!",
                    maxLines: 1,
                    style: Styles.bodySmall1,
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
        subtitle: Text(
          data.bringAssis!.message2!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.bodySmall1,
        ));
  }

  Widget whoviewme(ChannelInfo data) {
    return ListTile(
      onTap: () {
        Get.to(SingleWhoViewMe(data: data));
      },
      contentPadding: EdgeInsets.only(left: 7.w, right: 10),
      horizontalTitleGap: 10.w,
      dense: true,
      // leading: Container(
      //     width: 57.h,
      //     height: 57.h,
      //     child: SvgPicture.asset("assets/icon2/whoviewme.svg")),
      leading: CircleAvatar(
        radius: 20.r,
        backgroundImage: AssetImage("assets/icon2/whoviewme.png"),
      ),
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
                  data.whoViewMe!.seekerviewid != null
                      ? "${data.whoViewMe!.seekerviewid!.firstname} ${data.whoViewMe!.seekerviewid!.lastname} and ${data.whoViewMe!.totalview} others viewed you"
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
                style: Styles.smallText1.copyWith(color: AppColors.mainColor),
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
                  child: Text("${data.whoViewMe!.newview}",
                      textAlign: TextAlign.right,
                      style: Styles.smallText1
                          .copyWith(color: AppColors.whiteColor)),
                )
            ],
          ),
        ],
      ),
    );
  }

  Widget conversation(ChannelInfo data) {
    return ListTile(
      onTap: () {
        searchtext.clear();
        chatControll.channelconnect(channelid: data.id);
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SeekerChatScreen(data: data)))
            .then((value) {});
      },
      contentPadding: EdgeInsets.only(left: 7.w, right: 10),
      horizontalTitleGap: 10.w,
      // leading: Container(
      //   width: 57.h,
      //   height: 57.h,
      //   decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       color: Colors.grey[300],
      //       image: DecorationImage(
      //         image: CachedNetworkImageProvider(
      //           data.recruiterid == null
      //               ? "https://www.w3schools.com/howto/img_avatar.png"
      //               : "${AppConstants.imgurl}${data.recruiterid!.image}",
      //         ),
      //         fit: BoxFit.cover,
      //         onError: (error, stackTrace) => Icon(Icons.error, size: 57.h),
      //       )),
      // ),
      leading: CircleAvatar(
        radius: 20.r,
        backgroundImage: NetworkImage(data.recruiterid == null
            ? "https://www.w3schools.com/howto/img_avatar.png"
            : "${AppConstants.imgurl}${data.recruiterid!.image}"),
      ),
      dense: true,
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.recruiterid == null ||
                          data.recruiterid!.firstname == null ||
                          data.recruiterid!.lastname == null
                      ? ""
                      : "${data.recruiterid!.firstname!} ${data.recruiterid!.lastname}",
                  style: Styles.bodyMedium,
                ),
                Text(
                  data.recruiterid == null ||
                          data.recruiterid!.companyname == null
                      ? ""
                      : "${data.recruiterid!.companyname!.legalName}-${data.recruiterid!.companyname!.industry!.categoryname}",
                  maxLines: 1,
                  style: Styles.bodySmall3
                      .copyWith(color: AppColors.blackColor.withOpacity(.45)),
                )
              ],
            ),
          ),
          Column(
            children: [
              if (data.lastmessage != null)
                Text(
                  chatControll.dateformet(data.lastmessage!.updatedAt!),
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
      subtitle: Text(
        lastmessage(data.lastmessage, data),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Styles.bodySmall1,
      ),
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
          print(value);
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

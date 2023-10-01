import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:bringin/Screens/candidate_section/recruiter_details_from_chat.dart';
import 'package:bringin/controllers/candidate_section/job_controll.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:bringin/res/constants/app_constants.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../Hive/hive.dart';
import '../../../../../Http/notification.dart';
import '../../../../../controllers/ChatController/chatcontroll.dart';
import '../../../../../controllers/candidate_section/resume_management_controller.dart';
import '../../../../../models/Chat/channelinfo.dart';
import '../../../../../models/candidate_section/upload_resume_list.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/color.dart';
import '../../../../../res/dimensions.dart';
import '../../../../../utils/services/keys.dart';
import '../../../../../widgets/app_bottom_nav_widget.dart';
import '../../../../../widgets/radio_tile.dart';
import '../../../../Photo_View/photoview.dart';
import '../../../../candidate_section/Resume/resume_view.dart';
import '../Setting/setting.dart';

/// type 1 seeker send number
/// type 2 seeker send cv
/// type 3 recruiter ask number
/// type 4 recruiter ask cv
/// type 6

class SeekerChatScreen extends StatefulWidget {
  final ChannelInfo data;
  final bool notifi;

  const SeekerChatScreen({
    super.key,
    required this.data,
    this.notifi = false,
  });

  @override
  State<SeekerChatScreen> createState() => _SeekerChatScreenState();
}

class _SeekerChatScreenState extends State<SeekerChatScreen> {
  final ChatControll chatControll = Get.put(ChatControll());
  final FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  bool emojiShowing = false;

  _onBackspacePressed() {
    textEditingController
      ..text = textEditingController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length));
  }

  late ChatUser currentuser = ChatUser(
      id: widget.data.seekerid!.id!,
      firstName: widget.data.seekerid!.fastname,
      lastName: widget.data.seekerid!.lastname,
      profileImage: "${AppConstants.imgurl}${widget.data.seekerid!.image}",
      customProperties: {
        "recruiter": HiveHelp.read(Keys.isRecruiter),
        "phone": widget.data.seekerid!.secoundnumber,
        "email": widget.data.seekerid!.email,
        "recruiterid": widget.data.recruiterid!.id,
        "seekerid": widget.data.seekerid!.id,
      });

  Future messagesend(ChatMessage message, int type) async {
    ChatMessage message2 = ChatMessage(
        user: message.user,
        createdAt: message.createdAt,
        customProperties: {
          "type": type,
          "seen": recruiterjoin,
          "reaply": false,
          "reaplymsg": null,
          "messageid": ""
        },
        medias: message.medias,
        mentions: message.mentions,
        quickReplies: message.quickReplies,
        replyTo: message.replyTo,
        status: message.status,
        text: message.text);
    chatControll.messageadd(message2);
    var mapdata = {"channelid": widget.data.id, "message": message2};
    chatControll.socket.emit("message", mapdata);
  }

  Future greatingsend() async {
    var msg = ChatMessage(
        customProperties: {
          "type": 0,
          "seen": false,
          "reaply": false,
          "reaplymsg": null,
          "messageid": ""
        },
        user: currentuser,
        createdAt: DateTime.now(),
        text: seekergreetingList[HiveHelp.read(Keys.seekergreating) ?? 0]);

    chatControll.messages.add(msg);

    var mapdata = {"channelid": widget.data.id, "message": msg};
    chatControll.socket.emit("greating", mapdata);
  }

  Future imageupload() async {
    var rng = Random();
    int imgid = rng.nextInt(999999999);
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File filedata = File(image.path);
      List<int> fileBytes = filedata.readAsBytesSync();
      String base64Image = base64Encode(fileBytes);
      ChatMessage message2 = ChatMessage(
        user: currentuser,
        createdAt: DateTime.now(),
        customProperties: {
          "type": 5,
          "seen": recruiterjoin,
          "reaply": false,
          "reaplymsg": null,
          "messageid": "",
          "imageid": imgid
        },
        medias: [
          ChatMedia(
              url: "${AppConstants.imgurl}uploads/${image.name}",
              fileName: image.name,
              type: MediaType.image,
              customProperties: {"data": "sdv"},
              isUploading: false,
              uploadedDate: DateTime.now())
        ],
      );
      chatControll.messages.add(message2);

      var map = {
        "base64": base64Image,
        "name": image.name,
        "channelid": widget.data.id,
        "message": message2
      };
      chatControll.socket.emit("file_upload", map);
    }
  }

  Future numbersend() async {
    var msg = ChatMessage(
        customProperties: {
          "type": 1,
          "seen": recruiterjoin,
          "reaply": false,
          "reaplymsg": "",
          "messageid": ""
        },
        user: currentuser,
        createdAt: DateTime.now(),
        text: "Your phone number has been sent.");
    chatControll.messages.add(msg);
    var mapdata = {"channelid": widget.data.id, "message": msg};
    chatControll.socket.emit("message", mapdata);
  }

  Future cvsend(Uploadresumelist resume) async {
    var msg = ChatMessage(
        customProperties: {
          "type": 2,
          "seen": recruiterjoin,
          "reaply": false,
          "reaplymsg": "",
          "messageid": ""
        },
        user: currentuser,
        createdAt: DateTime.now(),
        text: 'Your CV has been sent.',
        medias: [
          ChatMedia(
              url: "${AppConstants.baseUrl}/${resume.resume!.path!}",
              fileName: resume.resume!.filename!,
              type: MediaType.file,
              customProperties: {"sdv": "sdvsd"})
        ]);
    chatControll.messages.add(msg);
    var mapdata = {"channelid": widget.data.id, "message": msg};
    chatControll.socket.emit("message", mapdata);
    chatControll.cvsendstore(recruiterid: widget.data.recruiterid!.id);
  }

  void getblock() {
    chatControll.seekerblock = widget.data.seekerblock!;
    chatControll.recruiterblock = widget.data.recruiterblock!;
  }

  List<String> optonname = ["Send Number", "Send CV", "Welcome Message"];
  List<String> optonimg = [
    "assets/icon2/r_call.svg",
    "assets/icon2/r_sendcv.svg",
    "assets/icon2/welcome_message.svg"
  ];

  bool recruiterjoin = false;

  void recruiterjoinon() {
    chatControll.socket.on("recruiter_join", (data) {
      recruiterjoin = data;
      setState(() {});
    });
  }

  late var seekerjoin = {
    "currentchannelid": chatControll.currentchannelid,
    "recruiterid": widget.data.recruiterid!.id,
    "seekerid": widget.data.seekerid!.id,
    "isrecruiter": false,
  };

  @override
  void initState() {
    chatControll.messagelistloading = true;
    chatControll.setcurrentchannelid(widget.data.id!);
    if (widget.data.greating == 0) {
      greatingsend();
    }
    getblock();
    chatControll.socket.emit("channel", widget.data.id);
    chatControll.socket.emit("messagelist", widget.data.id);
    if (widget.data.seekerUnseen! > 0)
      chatControll.socket.emit("seeker_join", seekerjoin);
    recruiterjoinon();

    super.initState();
  }

  @override
  void dispose() {
    chatControll.setcurrentchannelid(null);
    chatControll.socket.emit("seeker_leave", widget.data.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (focusNode.hasPrimaryFocus) {
      emojiShowing = false;
    }
    return GetBuilder<ChatControll>(builder: (_) {
      _.messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return Scaffold(
        appBar: appbar(_),
        body: _.messagelistloading
            ? Center(child: CircularProgressIndicator())
            : DashChat(
                emojionTap: () {
                  setState(() {
                    focusNode.unfocus();
                    emojiShowing = !emojiShowing;
                  });
                },
                emojishow: emojiShowing,
                emojiwidget: eojipicker(),
                jobiteam: widget.data.jobid != null
                    ? candidateChat_Part(context)
                    : SizedBox(),
                candidateiteam: null,
                readOnly: _.seekerblock || _.recruiterblock,
                currentUser: currentuser,
                messages: _.messages,
                inputOptions: inputoption(),
                messageListOptions: messageListOptions(_),
                onSend: (message) {
                  messagesend(message, 0);
                },
                messageOptions: messageoptions(),
              ),
      );
    });
  }

  MessageListOptions messageListOptions(ChatControll _) {
    return MessageListOptions(
      chatFooterBuilder: _.seekerblock || _.recruiterblock
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  width: 300.w,
                  child: Text(
                    // "You can not send this message. because ${_.seekerblock ? "${widget.data.recruiterid!.firstname} ${widget.data.recruiterid!.lastname}" : "${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}"} block this user",
                    "This user has been blocked you so can't send messages.",
                    textAlign: TextAlign.center,
                    style: Styles.bodySmall1
                        .copyWith(color: Colors.red.withOpacity(.5)),
                  ),
                ),
              ],
            )
          : SizedBox(),
    );
  }

  var appBarHeight = AppBar().preferredSize.height;

  InputOptions inputoption() {
    return InputOptions(
        textController: textEditingController,
        focusNode: focusNode,
        leading: [
          PopupMenuButton(
            child: Padding(
              padding: EdgeInsets.only(left: 7.w, right: 20.w),
              child: SvgPicture.asset("assets/icon2/more.svg"),
            ),
            constraints: BoxConstraints(maxWidth: 100.w),
            offset: focusNode.hasFocus ? Offset(10, 60) : Offset(10, -220),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            // icon: SvgPicture.asset("assets/icon2/more.svg"),
            itemBuilder: (context) {
              return List.generate(optonname.length, (index) {
                return PopupMenuItem(
                    value: index,
                    padding: EdgeInsets.zero,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: index == 0 ? 12.h : 14.h,
                          bottom: index == 2 ? 17.h : 0),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(optonimg[index],
                              height: 32.h, width: 32.w),
                          SizedBox(height: 4.h),
                          Text(
                            optonname[index],
                            style: Styles.smallText,
                          )
                        ],
                      ),
                    ));
              });
            },
            onSelected: (value) {
              if (value == 0) {
                numbersend();
              } else if (value == 1) {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => InboxresumesendPage(
                          onSend: (Uploadresumelist resume, String baseurl) {
                            cvsend(resume);
                            HttpNtf().notificationsend(
                                data: {
                                  "channelid": widget.data.id,
                                  "recruiter": false,
                                  "type": 1
                                },
                                push:
                                    "${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}",
                                message: "Yes, already shared CV. Thanks",
                                playerid: widget.data.recruiterid!.other!
                                    .pushnotification!);
                            Navigator.pop(context);
                          },
                        ));
              } else {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                        data: widget.data,
                        voidcallback: (String text) {
                          print(text);
                          messagesend(
                              ChatMessage(
                                  customProperties: {'sd': "dvsd"},
                                  user: currentuser,
                                  createdAt: DateTime.now(),
                                  text: text),
                              0);
                        },
                      );
                    });
              }
            },
            onOpened: () {
              print(focusNode.hasFocus);
              focusNode.unfocus();
              print("open");
            },
            onCanceled: () {
              print("close");
            },
          ),
          GestureDetector(
              onTap: () {
                imageupload();
              },
              child: SvgPicture.asset("assets/icon2/gallary.svg")),
          SizedBox(width: 14.w),
        ]);
  }

  AppBar appbar(ChatControll _) {
    return AppBar(
      title: Row(
        children: [
          InkResponse(
            onTap: () => Get.to(() => PhotoViewPage(
                photourl: widget.data.recruiterid == null
                    ? "https://www.w3schools.com/howto/img_avatar.png"
                    : "${AppConstants.imgurl}${widget.data.recruiterid!.image}")),
            child: Stack(
              fit: StackFit.loose,
              children: [
                // ClipOval(
                //   child: Container(
                //     height: height(45.h),
                //     width: height(45.w),
                //     decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //       shape: BoxShape.circle,
                //     ),
                //     child: CachedNetworkImage(
                //       imageUrl: widget.data.recruiterid == null
                //           ? "https://www.w3schools.com/howto/img_avatar.png"
                //           : "${AppConstants.imgurl}${widget.data.recruiterid!.image}",
                //       fit: BoxFit.cover,
                //       errorWidget: (context, error, stackTrace) =>
                //           Icon(Icons.error, size: height(45)),
                //     ),
                //   ),
                // ),
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: NetworkImage(widget.data.recruiterid == null
                      ? "https://www.w3schools.com/howto/img_avatar.png"
                      : "${AppConstants.imgurl}${widget.data.recruiterid!.image}"),
                  // child: CachedNetworkImage(
                  //   imageUrl: widget.data.recruiterid == null
                  //       ? "https://www.w3schools.com/howto/img_avatar.png"
                  //       : "${AppConstants.imgurl}${widget.data.recruiterid!.image}",
                  //   fit: BoxFit.cover,
                  //   errorWidget: (context, error, stackTrace) =>
                  //       Icon(Icons.error, size: height(45)),
                  // ),
                ),
                Positioned(
                  right: 2,
                  bottom: 0,
                  child: CircleAvatar(
                    backgroundColor: chatControll.timestempsformet(
                                widget.data.recruiterid!.other!.offlinedate!) ==
                            0
                        ? Color(0xFF5AD439)
                        : Colors.grey,
                    radius: 5.r,
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: InkWell(
                onTap: () {
                  if (widget.data.recruiterid != null) {
                    print(widget.data.recruiterid!.id);
                    JobControll.to.getSingleRecruiterDetails(
                        id: widget.data.recruiterid!.id);
                    Get.to(() => RecruitersDetailsFromChat());
                  }
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.data.recruiterid == null
                                  ? ""
                                  : "${widget.data.recruiterid!.firstname!} ${widget.data.recruiterid!.lastname!}",
                              style: Styles.bodyMediumSemiBold.copyWith(
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          if (widget.data.recruiterid!.other!.premium == true)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFD2AF26)),
                                  color: Color(0xFFD2AF26).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(2.r)),
                              child: Text(
                                "Premium",
                                style: Styles.smallText
                                    .copyWith(color: AppColors.yellowColor),
                              ),
                            )
                        ],
                      ),
                      Text(
                        widget.data.recruiterid == null
                            ? ""
                            : "${widget.data.recruiterid!.designation}",
                        style: Styles.bodySmall1.copyWith(
                            color: AppColors.blackOpacity80, fontSize: 14.sp),
                      ),
                      // ),
                      Text(
                        chatControll.timestempsformet(widget
                                    .data.recruiterid!.other!.offlinedate!) ==
                                0
                            ? "Active Now"
                            : "Active ${chatControll.timestempsformet(widget.data.recruiterid!.other!.offlinedate!)} day ago",
                        // widget.data.recruiterid!.other!.online!
                        //     ? "Active Now"
                        //     : "${chatControll.timestempsformet(widget.data.recruiterid!.other!.offlinedate!)}",
                        style: Styles.smallText.copyWith(
                            color: AppColors.blackColor.withOpacity(.5),
                            fontSize: 10.sp),
                        // ],
                      ),
                    ])),
          ),
          if (_.seekerblock == false)
            IconButton(
                onPressed: () {
                  Get.to(ChatSettingPage(data: widget.data));
                },
                icon: Icon(Icons.more_vert, color: AppColors.mainColor)),
        ],
      ),
      // actions: [
      //   if (_.seekerblock == false)
      //     IconButton(
      //         onPressed: () {
      //           Get.to(ChatSettingPage(data: widget.data));
      //         },
      //         icon: Icon(Icons.more_vert)),
      // ],
    );
  }

  MessageOptions messageoptions() {
    return MessageOptions(
      messageRowBuilder: (message, previousMessage, nextMessage,
          isAfterDateSeparator, isBeforeDateSeparator, i) {
        return MessageRow(
            numbersend: () {
              numbersend();
            },
            cvsend: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => InboxresumesendPage(
                        onSend: (Uploadresumelist resume, String baseurl) {
                          cvsend(resume);
                          HttpNtf().notificationsend(
                              data: {
                                "channelid": widget.data.id,
                                "recruiter": false,
                                "type": 1
                              },
                              push:
                                  "${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}",
                              message: "Yes, already shared CV. Thanks",
                              playerid: widget
                                  .data.recruiterid!.other!.pushnotification!);
                          Navigator.pop(context);
                        },
                      ));
            },
            message: message,
            messageOptions: MessageOptions(
              // messagePadding: EdgeInsets.zero,
              timePadding: EdgeInsets.only(top: 0),
              onTapMedia: (media) {
                if (media.type == MediaType.image) {
                  Get.to(PhotoViewPage(photourl: media.url));
                }
              },
            ),
            isAfterDateSeparator: isAfterDateSeparator,
            isBeforeDateSeparator: isBeforeDateSeparator,
            nextMessage: nextMessage,
            previousMessage: previousMessage,
            currentUser: currentuser,
            messageindex: i);
      },
    );
  }

  Widget eojipicker() {
    return Offstage(
      offstage: !emojiShowing,
      child: SizedBox(
          height: 250,
          child: EmojiPicker(
            textEditingController: textEditingController,
            onBackspacePressed: _onBackspacePressed,
            config: Config(
              columns: 7,
              // Issue: https://github.com/flutter/flutter/issues/28894
              emojiSizeMax: 32 *
                  (foundation.defaultTargetPlatform == TargetPlatform.iOS
                      ? 1.30
                      : 1.0),
              verticalSpacing: 0,
              horizontalSpacing: 0,
              gridPadding: EdgeInsets.zero,
              initCategory: Category.RECENT,
              bgColor: const Color(0xFFF2F2F2),
              indicatorColor: AppColors.mainColor,
              iconColor: Colors.grey,
              iconColorSelected: AppColors.mainColor,
              backspaceColor: AppColors.mainColor,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              recentTabBehavior: RecentTabBehavior.RECENT,
              recentsLimit: 28,
              replaceEmojiOnLimitExceed: false,
              noRecents: Text(
                'No Recents',
                style: Styles.smallTitle.copyWith(
                  color: Colors.black26,
                  fontSize: 20.sp,
                ),
                textAlign: TextAlign.center,
              ),
              loadingIndicator: const SizedBox.shrink(),
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
              checkPlatformCompatibility: true,
            ),
          )),
    );
  }

  String welcomeMsg1 =
      "I would like to learn more about this job position, can we discuss it further?";
  String welcomeMsg2 =
      "Greetings Sir, I am interested in discussing how my skills and experience meet the requirements for the job. Can we talk for a while?";
  String welcomeMsg3 =
      "Respectful Greetings Sir, My profile is suitable based on your job post. May I have a moment of your time?";
  String welcomeMsg4 =
      "Hi, I am confident that my skills and experience make me a good fit for the job. Can we have a quick conversation about it?";
  late String welcomeMsg5 =
      "Hi there, I am ${currentuser.firstName} ${currentuser.lastName}, and I would like to learn more about the job post. Could we schedule a meeting to discuss it further?";
  String welcomeMsg6 =
      "Hello Sir, I am interested in the job opening and I think I have the skills and experience you are looking for. Let’s have a details discussion.";
  late String welcomeMsg7 =
      "Hi ${widget.data.recruiterid!.firstname} ${widget.data.recruiterid!.lastname}, Good day! I am interested in discussing the job opening with you. Could we schedule a meeting at your convenience?";
  late String welcomeMsg8 =
      "Hello ${widget.data.recruiterid!.firstname} ${widget.data.recruiterid!.lastname}, I would like to have a meeting with you to talk about the job post. Could we schedule a time that works for both of us?";

  late List<String> seekergreetingList = [
    welcomeMsg1,
    welcomeMsg2,
    welcomeMsg3,
    welcomeMsg4,
    welcomeMsg5,
    welcomeMsg6,
    welcomeMsg7,
    welcomeMsg8,
  ];

  Widget candidateChat_Part(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TileWidget(
                  text: widget.data.jobid == null
                      ? ""
                      : "${widget.data.jobid!.education!.name}"),
              SizedBox(width: 5),
              TileWidget(
                  text: widget.data.jobid == null
                      ? ""
                      : "${widget.data.jobid!.experience!.name}"),
              SizedBox(width: 5),
              TileWidget(
                  text: widget.data.jobid == null
                      ? ""
                      : widget.data.jobid!.salary!.minSalary!.type == 0
                          ? "Negotiable"
                          : "${widget.data.jobid!.salary!.minSalary!.salary}K-${widget.data.jobid!.salary!.maxSalary!.salary}K BDT"),
            ],
          ),
          SizedBox(height: height(5)),
          Text(
            "${widget.data.jobid!.jobDescription!.trimRight()}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Styles.smallText2,
          ),
          SizedBox(height: height(5)),
          Row(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * .5,
                ),
                child: Text(
                  "${widget.data.jobid!.company!.legalName}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.bodySmall3,
                ),
              ),
              SizedBox(width: 3),
              Text(
                "•",
                style: Styles.bodySmall3,
              ),
              SizedBox(width: 3),
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * .7,
                  ),
                  child: Text(
                    widget.data.jobid!.jobLocation == null
                        ? widget.data.jobid!.company!.cLocation!.divisiondata!
                                .divisionname! +
                            ", " +
                            widget.data.jobid!.company!.cLocation!.divisiondata!
                                .cityid!.name!
                        : widget.data.jobid!.jobLocation!.divisiondata!
                                .divisionname! +
                            ", " +
                            widget.data.jobid!.jobLocation!.divisiondata!
                                .cityid!.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.smallText3.copyWith(
                      color: AppColors.blackColor.withOpacity(.5),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: 330.w,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.30,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0x26212427),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget TileWidget({required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height(1), horizontal: width(3)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appBorder, width: .5),
        borderRadius: BorderRadius.circular(radius(9)),
      ),
      child: Text(text, style: Styles.smallText2),
    );
  }
}

class InboxresumesendPage extends StatefulWidget {
  final Function onSend;
  const InboxresumesendPage({super.key, required this.onSend});

  @override
  State<InboxresumesendPage> createState() => _InboxresumesendPageState();
}

class _InboxresumesendPageState extends State<InboxresumesendPage> {
  final resumecontroll = Get.put(ResumeManagementController());

  bool loading = false;

  Future loaddata() async {
    setState(() {
      loading = true;
    });
    await resumecontroll.getallresume();
    setState(() {
      loading = false;
    });
  }

  Uploadresumelist? resume;

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              fit: StackFit.expand,
              children: [
                ListView.builder(
                  itemCount: resumecontroll.uploadresumelist.length,
                  itemBuilder: (context, index) {
                    var data = resumecontroll.uploadresumelist[index];
                    return ListTile(
                      onTap: () {
                        setState(() {
                          resume = data;
                        });
                      },
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 15.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                                color: resume != null && resume == data
                                    ? Colors.indigo
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.indigo)),
                          ),
                          SizedBox(width: 5.w),
                          Image.asset("assets/images/pdf.png", height: 30.h),
                        ],
                      ),
                      title: Text("Resume (${index + 1})"),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: resume == null ? SizedBox() : bottom(),
                )
              ],
            ),
    );
  }

  Widget bottom() {
    return Row(
      children: [
        Expanded(
          child: BottomNavWidget(
            text: "Send",
            onTap: () {
              widget.onSend(resume, AppConstants.baseUrl);
            },
          ),
        ),
        Expanded(
          child: BottomNavWidget(
            text: "View",
            onTap: () {
              Get.to(UploadRecumeView(
                url: "${AppConstants.baseUrl}/" + resume!.resume!.path!,
              ));
            },
          ),
        )
      ],
    );
  }
}

class BottomSheet extends StatefulWidget {
  final Function voidcallback;
  final ChannelInfo data;
  const BottomSheet({
    super.key,
    required this.voidcallback,
    required this.data,
  });

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  String greeting1 =
      "I would like to learn more about this job position, can we discuss it further?";
  late String greeting2 =
      "Greetings Sir, I am interested in discussing how my skills and experience meet the requirements for the job. Can we talk for a while?";
  late String greeting3 =
      "Respectful Greetings Sir, My profile is suitable based on your job post. May I have a moment of your time?";
  late String greeting4 =
      "Hi, I am confident that my skills and experience make me a good fit for the job. Can we have a quick conversation about it?";
  late String greeting5 =
      "Hi there, I am ${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}, and I would like to learn more about the job post. Could we schedule a meeting to discuss it further?";
  late String greeting6 =
      "Hello Sir, I am interested in the job opening and I think I have the skills and experience you are looking for. Let’s have a details discussion.";
  late String greeting7 =
      "Hi ${widget.data.recruiterid!.firstname} ${widget.data.recruiterid!.lastname}, Good day! I am interested in discussing the job opening with you. Could we schedule a meeting at your convenience?";
  late String greeting8 =
      "Hello ${widget.data.recruiterid!.firstname} ${widget.data.recruiterid!.lastname}, I would like to have a meeting with you to talk about the job post. Could we schedule a time that works for both of us?";

  late List<String> greetingList = [
    greeting1,
    greeting2,
    greeting3,
    greeting4,
    greeting5,
    greeting6,
    greeting7,
    greeting8,
  ];

  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
            padding: EdgeInsets.all(10.r),
            itemCount: greetingList.length,
            itemBuilder: (context, index) {
              return RadioTileWidget(
                value: index,
                groupValue: HiveHelp.read(Keys.seekergreating) ?? 0,
                title: greetingList[index],
                onChanged: (value) {
                  HiveHelp.write(Keys.seekergreating, value);
                  setState(() {
                    text = greetingList[index];
                  });
                },
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavWidget(
              text: "Send",
              onTap: () {
                widget.voidcallback(text);

                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

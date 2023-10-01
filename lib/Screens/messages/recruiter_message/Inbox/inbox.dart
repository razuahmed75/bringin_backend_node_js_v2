import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:time_machine/time_machine.dart' as time;
import 'package:url_launcher/url_launcher.dart';
import '../../../../Hive/hive.dart';
import '../../../../Http/notification.dart';
import '../../../../controllers/ChatController/chatcontroll.dart';
import '../../../../controllers/candidate_section/candidate_controll.dart';
import '../../../../models/Chat/channelinfo.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/dimensions.dart';
import '../../../../utils/services/keys.dart';
import '../../../../widgets/app_bottom_nav_widget.dart';
import '../../../../widgets/radio_tile.dart';
import '../../../Photo_View/photoview.dart';
import '../../../recruiter_section/candidate_details_from_chat.dart';
import '../Setting/setting.dart';

class RecruiterChatScreen extends StatefulWidget {
  final ChannelInfo data;

  const RecruiterChatScreen({
    super.key,
    required this.data,
  });

  @override
  State<RecruiterChatScreen> createState() => _RecruiterChatScreenState();
}

class _RecruiterChatScreenState extends State<RecruiterChatScreen> {
  final ChatControll chatControll = Get.put(ChatControll());
  final FocusNode focusNode = FocusNode();
  final CandidateControll candidateControll = Get.find();

  TextEditingController textEditingController = TextEditingController();
  bool emojiShowing = false;

  _onBackspacePressed() {
    textEditingController
      ..text = textEditingController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length));
  }

  late ChatUser currentuser = ChatUser(
      id: widget.data.recruiterid!.id!,
      firstName: widget.data.recruiterid!.firstname,
      lastName: widget.data.recruiterid!.lastname,
      profileImage: "${AppConstants.imgurl}${widget.data.recruiterid!.image}",
      customProperties: {
        "recruiter": HiveHelp.read(Keys.isRecruiter),
        "recruiterid": widget.data.recruiterid!.id,
        "seekerid": widget.data.seekerid!.id,
      });

  Future messagesend(ChatMessage message, int type) async {
    ChatMessage message2 = ChatMessage(
        user: message.user,
        createdAt: message.createdAt,
        customProperties: {
          "type": type,
          "seen": seekerjoin,
          "reaply": false,
          "reaplymsg": null,
          "messageid": "",
          "request": type,
        },
        medias: message.medias,
        mentions: message.mentions,
        quickReplies: message.quickReplies,
        replyTo: message.replyTo,
        status: message.status,
        text: message.text);
    chatControll.messageadd(message2);
    // chatControll.messagesend(widget.channelid, message2);
    var mapdata = {"channelid": widget.data.id, "message": message2};
    if (!chatControll.recruiterblock && !chatControll.seekerblock)
      chatControll.socket.emit("message", mapdata);
    chatControll.recruiterdateupdate(widget.data.id!);
  }

  Future exchangerequest({required int type, required String mgs}) async {
    var msg = ChatMessage(customProperties: {
      "type": type,
      "seen": seekerjoin,
      "reaply": false,
      "reaplymsg": null,
      "messageid": "",
      "request": 1,
    }, user: currentuser, createdAt: DateTime.now(), text: mgs);
    // messagesend(msg, type);
    chatControll.messageadd(msg);
    var mapdata = {"channelid": widget.data.id, "message": msg};
    if (!chatControll.recruiterblock && !chatControll.seekerblock)
      chatControll.socket.emit("message", mapdata);

    chatControll.recruiterdateupdate(widget.data.id!);
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
          "seen": seekerjoin,
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
      chatControll.recruiterdateupdate(widget.data.id!);
    }
  }

  void getblock() {
    chatControll.seekerblock = widget.data.seekerblock!;
    chatControll.recruiterblock = widget.data.recruiterblock!;
  }

  List<String> optonname = [
    "Ask Number",
    "Ask CV",
    "Welcome Message",
    "Not Interested"
  ];
  List<String> optonimg = [
    "assets/icon2/r_call.svg",
    "assets/icon2/r_sendcv.svg",
    "assets/icon2/welcome_message.svg",
    "assets/icon2/not_interest.svg"
  ];

  bool seekerjoin = false;

  void seekerjoinon() {
    chatControll.socket.on("seeker_join", (data) {
      seekerjoin = data;
    });
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
        text: recruitergreetingList[HiveHelp.read(Keys.seekergreating) ?? 0]);

    chatControll.messages.add(msg);

    var mapdata = {"channelid": widget.data.id, "message": msg};

    chatControll.socket.emit("greating", mapdata);
    chatControll.recruiterdateupdate(widget.data.id!);
  }

  late var recruiterjoin = {
    "currentchannelid": chatControll.currentchannelid,
    "recruiterid": widget.data.recruiterid!.id,
    "seekerid": widget.data.seekerid!.id,
    "isrecruiter": true,
  };

  @override
  void initState() {
    chatControll.messagelistloading = true;
    chatControll.setcurrentchannelid(widget.data.id!);
    if (widget.data.greating == 0) {
      greatingsend();
    }
    getblock();
    // chatControll.socket.emit("channel", widget.data.id);
    chatControll.socket.emit("messagelist", widget.data.id);
    if (widget.data.recruiterUnseen! > 0)
      chatControll.socket.emit("recruiter_join", recruiterjoin);
    seekerjoinon();

    super.initState();
  }

  bool scrollbottm = false;

  @override
  void dispose() {
    chatControll.setcurrentchannelid(null);
    chatControll.socket.emit("recruiter_leave", chatControll.currentchannelid);
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
                    emojiShowing = !emojiShowing;
                    focusNode.unfocus();
                  });
                },
                emojishow: emojiShowing,
                emojiwidget: eojipicker(),
                jobiteam: null,
                candidateiteam: widget.data.candidateFullprofile == null
                    ? SizedBox()
                    : RecruiterChat_Part(context),
                readOnly: _.seekerblock || _.recruiterblock,
                messageListOptions: MessageListOptions(
                    chatFooterBuilder: _.seekerblock || _.recruiterblock
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.r),
                                width: 300.w,
                                child: Text(
                                  // "You can not send this message. because ${_.recruiterblock ? "${widget.data.recruiterid!.firstname} ${widget.data.recruiterid!.lastname}" : "${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}"} block this user",
                                  "This user has been blocked you so can't send messages.",
                                  textAlign: TextAlign.center,
                                  style: Styles.smallText1.copyWith(
                                    color: Colors.red.withOpacity(.5),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox()),
                currentUser: currentuser,
                messages: _.messages,
                inputOptions: inputoption(),
                messageOptions: messageOption(),
                onSend: (message) {
                  messagesend(message, 0);
                },
              ),
      );
    });
  }

  AppBar appbar(ChatControll _) {
    return AppBar(
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => Scaffold(
                      body: Center(
                    child: PhotoView(
                        imageProvider: NetworkImage(widget
                                    .data.seekerid!.image ==
                                null
                            ? "https://www.w3schools.com/howto/img_avatar.png"
                            : AppConstants.imgurl +
                                widget.data.seekerid!.image!)),
                  )));
            },
            child: Stack(
              fit: StackFit.loose,
              children: [
                // ClipOval(
                //   child: Container(
                //     height: height(45),
                //       width: height(45),
                //     decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //       shape: BoxShape.circle,
                //     ),
                //     child: CachedNetworkImage(
                //       imageUrl: widget.data.seekerid == null || widget.data.seekerid!.image == null
                //         ? "https://www.w3schools.com/howto/img_avatar.png"
                //         : "${AppConstants.imgurl}${widget.data.seekerid!.image}",
                //       fit: BoxFit.cover,
                //       errorWidget: (context, error, stackTrace) => Icon(Icons.error,size: height(45)),
                //     ),
                //   ),
                // ),
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: NetworkImage(widget.data.seekerid == null ||
                          widget.data.seekerid!.image == null
                      ? "https://www.w3schools.com/howto/img_avatar.png"
                      : "${AppConstants.imgurl}${widget.data.seekerid!.image}"),
                ),
                Positioned(
                  right: 2,
                  bottom: 0,
                  child: CircleAvatar(
                    backgroundColor: chatControll.timestempsformet(
                                widget.data.seekerid!.other!.offlinedate!) ==
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
          Expanded(
            flex: 200,
            child: InkWell(
              onTap: () {
                print("id is: " + widget.data.seekerid!.id!);
                candidateControll.getCandidateDetails(
                    candidateId: widget.data.seekerid!.id);
                Get.to(() => CandidateDetailsFromChat());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.data.seekerid!.fastname!} ${widget.data.seekerid!.lastname!}",
                    style: Styles.bodyMediumSemiBold.copyWith(
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "${widget.data.seekerid!.other!.lastfunctionalarea!.functionalname}",
                    overflow: TextOverflow.ellipsis,
                    style: Styles.bodySmall1.copyWith(
                        color: AppColors.blackOpacity80,
                        letterSpacing: 1,
                        fontSize: 12.sp),
                  ),
                  Text(
                    widget.data.seekerid == null
                        ? ""
                        : chatControll.timestempsformet(widget
                                    .data.seekerid!.other!.offlinedate!) ==
                                0
                            ? "Active Now"
                            : "Active ${chatControll.timestempsformet(widget.data.seekerid!.other!.offlinedate!)} day ago",
                    style: Styles.smallText
                        .copyWith(color: AppColors.blackColor.withOpacity(.5)),
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          if (_.recruiterblock == false)
            IconButton(
                onPressed: () {
                  Get.to(RecruiterChatSettingPage(data: widget.data));
                },
                icon: Icon(
                  Icons.more_vert,
                  color: AppColors.mainColor,
                )),
        ],
      ),
      // actions: [
      //   if (_.recruiterblock == false)
      //     IconButton(
      //         onPressed: () {
      //           Get.to(RecruiterChatSettingPage(data: widget.data));
      //         },
      //         icon: Icon(Icons.more_vert)),
      // ],
    );
  }

  Widget exchange() {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                HttpNtf().notificationsend(
                    data: {
                      "channelid": widget.data.id,
                      "recruiter": false,
                      "type": 1
                    },
                    push:
                        "${widget.data.recruiterid!.firstname} ${widget.data.recruiterid!.lastname}",
                    message:
                        "Hello ${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}, Can you send me your contact number.",
                    playerid: widget.data.seekerid!.other!.pushnotification!);
                exchangerequest(
                    type: 1, mgs: "request to ask phone numbers has been sent");
              },
              child: Column(
                children: [
                  Image.asset("assets/images/phonenum.png"),
                  SizedBox(height: 10),
                  Text(
                    "Ask Number",
                    style: Styles.smallText.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            )),
            Expanded(
                child: InkWell(
              onTap: () {
                HttpNtf().notificationsend(
                    data: {
                      "channelid": widget.data.id,
                      "recruiter": true,
                      "type": 1
                    },
                    push:
                        "${widget.data.recruiterid!.firstname} ${widget.data.recruiterid!.lastname}",
                    message:
                        "Hello ${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}, Can you send me your CV.",
                    playerid: widget.data.seekerid!.other!.pushnotification!);
                exchangerequest(
                    type: 2, mgs: "request to exchange CV has been sent.");
              },
              child: Column(
                children: [
                  Image.asset("assets/images/fileexchange.png"),
                  SizedBox(height: 10),
                  Text(
                    "Ask Resume",
                    style: Styles.smallText.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            )),
            // Expanded(
            //     child: InkWell(
            //   onTap: () async {
            //     Helpers.showAlartMessage(msg: "This Feature not active");
            //     // exchangerequest(type: 3, mgs: "request for video call");
            //     // controll.recruiterinterviewcount();
            //     // Get.to(SeekerVideoCall(groupchannel: widget.groupchannel));
            //   },
            //   child: Column(
            //     children: [
            //       Image.asset("assets/images/video.png"),
            //       SizedBox(height: 10),
            //       Text(
            //         "Video Interview",
            //         style: TextStyle(
            //             fontSize: 12,
            //             fontWeight: FontWeight.w300,
            //             color: Colors.black),
            //       )
            //     ],
            //   ),
            // )),

            Expanded(
                child: InkWell(
              onTap: () {
                exchangerequest(type: 4, mgs: "not interest");
                chatControll.candidate_reject(widget.data.seekerid!.id!);
              },
              child: Column(
                children: [
                  Image.asset("assets/images/Broken_heart_light.png"),
                  SizedBox(height: 10),
                  Text(
                    "Not Interested",
                    style: Styles.smallText.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ],
    );
  }

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
            offset:
                focusNode.hasFocus ? Offset(10.w, 0.h) : Offset(10.w, -290.h),
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
                          bottom: index == 3 ? 17.h : 0),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(optonimg[index],
                              height: 32.h, width: 32.w),
                          SizedBox(height: 4.h),
                          Text(
                            optonname[index],
                            style: Styles.smallText.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                    ));
              });
            },
            onSelected: (value) {
              if (value == 0) {
                HttpNtf().notificationsend(
                    data: {
                      "channelid": widget.data.id,
                      "recruiter": true,
                      "type": 1
                    },
                    push:
                        "${widget.data.recruiterid!.firstname} ${widget.data.recruiterid!.lastname}",
                    message:
                        "Hello ${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}, Can you send me your contact number.",
                    playerid: widget.data.seekerid!.other!.pushnotification!);
                exchangerequest(
                    type: 3,
                    mgs: "Your request to ask phone number has been sent.");
              } else if (value == 1) {
                HttpNtf().notificationsend(
                    data: {
                      "channelid": widget.data.id,
                      "recruiter": true,
                      "type": 1
                    },
                    push:
                        "${widget.data.recruiterid!.firstname} ${widget.data.recruiterid!.lastname}",
                    message:
                        "Hello ${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}, Can you send me your CV.",
                    playerid: widget.data.seekerid!.other!.pushnotification!);
                exchangerequest(
                    type: 4, mgs: "Your request to exchange CV has been sent.");
              } else if (value == 2) {
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
              } else {
                // exchangerequest(type: 4, mgs: "not interest");
                chatControll.candidate_reject(widget.data.seekerid!.id!);
              }
            },
            onOpened: () {
              // print(focusNode.hasFocus);
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
          // IconButton(
          //   onPressed: () {
          //     showModalBottomSheet(
          //       context: context,
          //       builder: (context) {
          //         return BottomSheet(
          //           data: widget.data,
          //           voidcallback: (String text) {
          //             print(text);
          //             messagesend(
          //                 ChatMessage(
          //                     customProperties: {'sd': "dvsd"},
          //                     user: currentuser,
          //                     createdAt: DateTime.now(),
          //                     text: text),
          //                 0);
          //           },
          //         );
          //       },
          //     );
          //   },
          //   icon: SvgPicture.asset("assets/icon2/greateing.svg"),
          // ),
          // IconButton(
          //     onPressed: () {
          //       imageupload();
          //     },
          //     icon: SvgPicture.asset("assets/icon2/gallary.svg"))
        ]);
  }

  MessageOptions messageOption() {
    return MessageOptions(
      messageRowBuilder: (message, previousMessage, nextMessage,
          isAfterDateSeparator, isBeforeDateSeparator, i) {
        return MessageRow(
            numbercall: () async {
              await launchUrl(
                  Uri.parse("tel:${message.user.customProperties!['phone']}"));
            },
            numbercopy: () async {
              await Clipboard.setData(
                  ClipboardData(text: message.user.customProperties!['phone']));
            },
            message: message,
            isAfterDateSeparator: isAfterDateSeparator,
            isBeforeDateSeparator: isBeforeDateSeparator,
            messageOptions: MessageOptions(
                onTapMedia: (media) {
                  if (media.type == MediaType.image) {
                    Get.to(PhotoViewPage(photourl: media.url));
                  }
                },
                callhight: 25.h,
                calltextsize: 14.sp,
                callpading: EdgeInsets.only(
                    top: 3.h, bottom: 4.h, left: 9.w, right: 9.w)),
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
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              backspaceColor: Colors.blue,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              recentTabBehavior: RecentTabBehavior.RECENT,
              recentsLimit: 28,
              replaceEmojiOnLimitExceed: false,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
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

  late String welcomeMsg1 =
      "Hello ${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}! I am interested in your profile, Let’s talk in details about the job post.";

  late String welcomeMsg2 =
      "Hey ${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}, You have a good profile. Can I know your skills, qualifications & experiences in depth?";

  late String welcomeMsg3 =
      "Hello ${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}, Are you available to response? I'd love to chat with you about our current job openings.";

  late String welcomeMsg4 =
      "Greetings ${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}, I am interested in your profile, can we have a talk? Please feel free to knock me back asap!";

  late String welcomeMsg5 =
      "Hi ${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}, I have read your bio. Would you please share me your details CV to learn more about your education & experiences?";

  late String welcomeMsg6 =
      "Hi, Upon reviewing your profile, Found you matched according to our requirements. Are you available for a quick chat now?";

  late String welcomeMsg7 =
      "Hello, I am interested in your profile. Would you please send me your resume or more details about yourself? ";

  late String welcomeMsg8 =
      "Hello ${widget.data.seekerid!.fastname} ${widget.data.seekerid!.lastname}, I would like to have a meeting with you to talk about the job post. Could we schedule a time that works for both of us?";

  late List<String> recruitergreetingList = [
    welcomeMsg1,
    welcomeMsg2,
    welcomeMsg3,
    welcomeMsg4,
    welcomeMsg5,
    welcomeMsg6,
    welcomeMsg7,
    welcomeMsg8,
  ];

  int differentedu(DateTime date1, DateTime date2) {
    time.LocalDate a = time.LocalDate.dateTime(date1);
    time.LocalDate b = time.LocalDate.dateTime(date2);
    time.Period diff = b.periodSince(a);
    return diff.years;
  }

  int different(DateTime date2) {
    DateTime date1 = DateTime.now();
    int year = date1.difference(date2).inDays;
    return year ~/ 365;
  }

  Widget RecruiterChat_Part(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Wrap(
              // alignment: WrapAlignment.spaceBetween,
              runSpacing: 5,
              children: [
                if (widget.data.candidateFullprofile!.education!.isNotEmpty)
                  TileWidget(
                      text: widget.data.candidateFullprofile!.education!.isEmpty
                          ? ""
                          : "${differentedu(widget.data.candidateFullprofile!.education![0].startdate!, widget.data.candidateFullprofile!.education![0].enddate!).toString() + " Years"}"),
                if (widget.data.candidateFullprofile!.education!.isNotEmpty)
                  SizedBox(width: 5.w),
                if (widget.data.candidateFullprofile!.education!.isNotEmpty)
                  TileWidget(
                      text:
                          "${widget.data.candidateFullprofile!.education!.isNotEmpty ? widget.data.candidateFullprofile!.education![0].digree == null ? "" : widget.data.candidateFullprofile!.education![0].digree!.name : ""}"),
                if (widget.data.candidateFullprofile!.education!.isNotEmpty)
                  SizedBox(width: 5.w),
                TileWidget(
                    text:
                        "${different(widget.data.candidateFullprofile!.userid!.deatofbirth!)} Years"),
                SizedBox(width: 5.w),
                if (widget
                    .data.candidateFullprofile!.careerPreference!.isNotEmpty)
                  TileWidget(
                      text: widget.data.candidateFullprofile!.careerPreference!
                              .isEmpty
                          ? ""
                          : widget
                                      .data
                                      .candidateFullprofile!
                                      .careerPreference![0]
                                      .salaray!
                                      .minSalary!
                                      .type ==
                                  0
                              ? "Negotiable"
                              : "${widget.data.candidateFullprofile!.careerPreference![0].salaray!.minSalary!.salary}K-${widget.data.candidateFullprofile!.careerPreference![0].salaray!.maxSalary!.salary}K BDT"),
                SizedBox(width: 5.w),
              ],
            ),
          ),
          SizedBox(height: height(5)),
          Text(
            widget.data.candidateFullprofile!.about == null
                ? ""
                : "${widget.data.candidateFullprofile!.about!.about}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Styles.smallText2,
          ),
          SizedBox(height: height(5)),
          Row(
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImagePaths.suitcase,
                    height: height(12),
                    width: height(12),
                  ),
                  SizedBox(width: width(6)),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * .45,
                    ),
                    child: Text(
                      widget.data.candidateFullprofile!.workexperience!.isEmpty
                          ? ""
                          : "${widget.data.candidateFullprofile!.workexperience![0].companyname}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.bodySmall3,
                    ),
                  )
                ],
              ),
              SizedBox(width: 3),
              Text(
                "•",
                style: Styles.bodySmall3,
              ),
              SizedBox(width: 3),
              Text(
                widget.data.candidateFullprofile!.workexperience!.isEmpty
                    ? ""
                    : "${DateFormat("MMM yyyy").format(widget.data.candidateFullprofile!.workexperience![0].startdate!)} - ${widget.data.candidateFullprofile!.workexperience![0].enddate!.year > DateTime.now().year ? "Present" : DateFormat("MMM yyyy").format(widget.data.candidateFullprofile!.workexperience![0].enddate!)}",
                style: Styles.smallText3.copyWith(
                  color: AppColors.blackColor.withOpacity(.5),
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
  late String welcomeMsg1 = HiveHelp.read(Keys.isRecruiter)
      ? "Hello ${widget.data.seekerid!.fastname}! I am interested in your profile, Let’s talk in details about the job post."
      : "I would like to learn more about this job position, can we discuss it further?";
  late String welcomeMsg2 = HiveHelp.read(Keys.isRecruiter)
      ? "Hey ${widget.data.seekerid!.fastname}, You have a good profile. Can I know your skills, qualifications & experiences in depth?"
      : "Greetings Sir, I am interested in discussing how my skills and experience meet the requirements for the job. Can we talk for a while?";
  late String welcomeMsg3 = HiveHelp.read(Keys.isRecruiter)
      ? "Hi ${widget.data.seekerid!.fastname}, Your resume looks amazing. We have an open position based on your profile, Considering your profile hope you’ll be a great fit for the position. Would you like to have a chat?"
      : "Respectful Greetings Sir, My profile is suitable based on your job post. May I have a moment of your time?";
  late String welcomeMsg4 = HiveHelp.read(Keys.isRecruiter)
      ? "Hey ${widget.data.seekerid!.fastname}, Are you available to response? I'd love to chat with you about our current job opening."
      : "Hi, I am confident that my skills and experience make me a good fit for the job. Can we have a quick conversation about it?";
  late String welcomeMsg5 = HiveHelp.read(Keys.isRecruiter)
      ? "Hello ${widget.data.seekerid!.fastname}, I am interested in your profile, can we have a talk? Please feel free to knock me back asap!"
      : "Hi there, I am <name of the seeker>, and I would like to learn more about the job post. Could we schedule a meeting to discuss it further?";
  late String welcomeMsg6 = HiveHelp.read(Keys.isRecruiter)
      ? "Hi ${widget.data.seekerid!.fastname}, I have read your bio. Would you please share me your details CV to learn more about your education & experiences?"
      : "Hello Sir, I am interested in the job opening and I think I have the skills and experience you are looking for. Let’s have a details discussion.";
  late String welcomeMsg7 = HiveHelp.read(Keys.isRecruiter)
      ? "Hi ${widget.data.seekerid!.fastname}! Upon reviewing your profile, Found you matched according to our requirements. Are you available for a quick chat now?"
      : "Hi <name of the recruiter>, Good day! I am interested in discussing the job opening with you. Could we schedule a meeting at your convenience?";
  late String welcomeMsg8 = HiveHelp.read(Keys.isRecruiter)
      ? "Hello ${widget.data.seekerid!.fastname}, I am interested in your profile. Would you please send me your resume or more details about yourself? "
      : "Hello <name of the recruiter>, I would like to have a meeting with you to talk about the job post. Could we schedule a time that works for both of us?";

  late List<String> greetingList = [
    welcomeMsg1,
    welcomeMsg2,
    welcomeMsg3,
    welcomeMsg4,
    welcomeMsg5,
    welcomeMsg6,
    welcomeMsg7,
    welcomeMsg8,
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

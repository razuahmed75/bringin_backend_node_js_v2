// import 'dart:io';

// import 'package:bringin/utils/services/keys.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../../Http/get.dart';
// import '../../../../../Http/notification.dart';
// import '../../../../../controllers/both_category/seeker_chat_controller.dart';
// import '../../../../../controllers/candidate_section/greetingbody_controller.dart';
// import '../../../../../controllers/candidate_section/resume_management_controller.dart';
// import '../../../../../models/candidate_section/Chat/GroupChannel/groupchannel.dart';
// import '../../../../../models/candidate_section/upload_resume_list.dart';
// import '../../../../../res/constants/app_constants.dart';
// import '../../../../../widgets/app_bottom_nav_widget.dart';
// import '../../../../../widgets/file_imageview.dart';
// import '../../../../../views/both_category/greeting/components/greeting_body.dart';
// import '../../../../candidate_section/Resume/resume_view.dart';
// import '../Setting/setting.dart';
// import '../VideoCall/seekervideocall.dart';

// // 1 = phone exchange
// // 2 = cv request
// // 3 = video call
// // 4 = not interest
// // 5 = image send
// // 6 = number send
// // 7 = message reaply

// // 8 = resume send

// class ChatInboxPage extends StatefulWidget {
//   final Groupchannel groupchannel;

//   const ChatInboxPage({super.key, required this.groupchannel});

//   @override
//   State<ChatInboxPage> createState() => _ChatInboxPageState();
// }

// class _ChatInboxPageState extends State<ChatInboxPage> {
//   GetStorage box = GetStorage();
//   late int currenidindex = widget.groupchannel.userinfo!
//       .indexWhere((element) => element.id == box.read(Keys.isseekerprofileid));
//   late Userinfo chatuser = widget.groupchannel.userinfo![currenidindex];
//   late Userinfo user =
//       widget.groupchannel.userinfo![currenidindex == 0 ? 1 : 0];
//   late List<ChatMessage> messagelist = [];
//   final controll = Get.put(SeekerChatController());
//   bool active = false;

//   ChatUser asDashChatUser() {
//     return ChatUser(
//         firstName: chatuser.firstname,
//         id: chatuser.id.toString(),
//         customProperties: {"phone": chatuser.phone, "email": chatuser.email},
//         profileImage: AppConstants.imgurl + chatuser.photo!,
//         lastName: chatuser.lastname);
//   }

//   Future exchangerequest({required int type, required String mgs}) async {
//     var messageid = FirebaseFirestore.instance
//         .collection("channel")
//         .doc(widget.groupchannel.channelid)
//         .collection("message")
//         .doc()
//         .id;
//     var msg = ChatMessage(
//         customProperties: {
//           "type": type,
//           "seen": false,
//           "reaply": reaplymessag == null ? false : true,
//           "reaplymsg": reaplymessag == null ? null : reaplymessag!.text,
//           "messageid": messageid
//         },
//         user: asDashChatUser(),
//         createdAt: DateTime.now(),
//         medias: [],
//         mentions: [],
//         quickReplies: [],
//         text: mgs);
//     messagelist.add(msg);
//     setState(() {});
//     controll.messagesend(
//         messageid: messageid,
//         channelid: widget.groupchannel.channelid!,
//         chatuserid: chatuser,
//         userid: user,
//         msg: msg);
//   }

//   bool loading = false;

//   int different(DateTime _date2) {
//     DateTime date1 = DateTime.now();
//     DateTime date2 = _date2;
//     return date1.difference(date2).inSeconds;
//   }

//   late Stream<DocumentSnapshot> useractive =
//       controll.activecitydetect(user.recruiterId.toString());

//   void activicityget() {
//     useractive.listen((event) {
//       setState(() {
//         active = event['active'];
//       });
//     });
//   }

//   void videocallstream(ChatMessage recmsg, String lastmsgid) async {
//     if (recmsg.user.id == user.recruiterId.toString()) {
//       controll.messageseenupdate(
//           channelid: widget.groupchannel.channelid!,
//           msg: ChatMessage(
//               createdAt: recmsg.createdAt,
//               user: recmsg.user,
//               medias: recmsg.medias,
//               mentions: recmsg.mentions,
//               replyTo: recmsg.replyTo,
//               status: recmsg.status,
//               quickReplies: recmsg.quickReplies,
//               text: recmsg.text,
//               customProperties: {
//                 "type": recmsg.customProperties!['type'],
//                 "seen": true,
//               }),
//           lastmsgid: lastmsgid);
//       if (recmsg.customProperties!['type'] == 3 &&
//           different(recmsg.createdAt) <= 2) {
//         showDialog(
//           context: context,
//           builder: (context) => SendDialog(
//               reaplymessag: reaplymessag!,
//               message: recmsg,
//               channel: widget.groupchannel,
//               sendmessage: () {}),
//         );
//       }
//     }
//   }

//   bool showgreating = false;

//   List<XFile> imgpaths = [];

//   Future imageupload() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       imgpaths.add(image);
//       setState(() {});
//     }
//   }

//   Future onsend(ChatMessage message) async {
//     var messageid = FirebaseFirestore.instance
//         .collection("channel")
//         .doc(widget.groupchannel.channelid)
//         .collection("message")
//         .doc()
//         .id;
//     var url;
//     if (imgpaths.isNotEmpty) {
//       url = await Httphelp().imageupload(
//           ENDPOINT_URL: AppConstants.imgupload, imgpath: imgpaths[0].path);
//     }

//     var msg = ChatMessage(
//         customProperties: {
//           "type": reaplymessag == null ? 0 : 7,
//           "seen": false,
//           "reaply": reaplymessag == null ? false : true,
//           "reaplymsg": reaplymessag == null ? null : reaplymessag!.text,
//           "messageid": messageid
//         },
//         user: asDashChatUser(),
//         createdAt: DateTime.now(),
//         medias: List.generate(
//             imgpaths.length,
//             (index) => ChatMedia(
//                 fileName: imgpaths[index].name,
//                 type: MediaType.image,
//                 url: url,
//                 customProperties: {"type": "img"},
//                 isUploading: false,
//                 uploadedDate: DateTime.now())),
//         mentions: [],
//         quickReplies: [],
//         text: message.text);
//     // messagelist.add(msg);
//     await controll.messagesend(
//         messageid: messageid,
//         channelid: widget.groupchannel.channelid!,
//         chatuserid: chatuser,
//         userid: user,
//         msg: msg);
//     // if (imgpaths.isNotEmpty) {
//     //   controll.imageupload(
//     //       imgpaths[0].path, messageid, widget.groupchannel.channelid!, msg);
//     // }
//     imgpaths.clear();
//     reaplymessag = null;
//     if (active == false) {
//       sendnotification(message: message.text);
//     }
//     // setState(() {});
//   }

//   ChatMessage? reaplymessag;

//   String greeting1 =
//       "I am interested in this job post, may we have a discussion?";
//   late String greeting2 =
//       "Hello ${user.firstname} ${user.lastName}, I am interested in this role. Please let me know when we can discuss in details.";
//   late String greeting3 =
//       "Hi ${user.firstname} ${user.lastName}, My skills and experience matched with your requirements. Can we talk for a while?";
//   late String greeting4 =
//       "Hello ${user.firstname} ${user.lastName}, My profile is suitable for your job opening. Can we have a discussion?";
//   late String greeting5 =
//       "Hi ${user.firstname} ${user.lastName}, I hope you are doing well. I have carefully read your job description. I believe that my expertise can contribute to your team. Please, let me know when we can talk?";
//   late String greeting6 =
//       "Hello ${user.firstname} ${user.lastName}, I have read your job description. Let’s discuss in more details for the possibilities of the job opening?";
//   late String greeting7 =
//       "Hello, ${user.firstname} ${user.lastName} your requirements matches with my skills. Let’s schedule a interview call?";
//   late String greeting8 =
//       "Hello, I am ${chatuser.firstname} ${chatuser.lastName} and interested in your job post. Let’s have a meeting in your convenient time.";

//   late List<String> greetingList = [
//     greeting1,
//     greeting2,
//     greeting3,
//     greeting4,
//     greeting5,
//     greeting6,
//     greeting7,
//     greeting8,
//   ];

//   String ntftoken = "";

//   Future settoken() async {
//     ntftoken = await controll.ntftokenget(user.id.toString());
//     print(ntftoken);
//     setState(() {});
//   }

//   @override
//   void initState() {
//     activicityget();
//     settoken();
//     super.initState();
//   }

//   MessageOptions messageOptions = MessageOptions();

//   GreetingBodyController greetingBodyController =
//       Get.put(GreetingBodyController());

//   Future sendnotification({required String message}) async {
//     await HttpNtf().notificationsend(
//         push: "${chatuser.firstname} message you",
//         message: message,
//         playerid: ntftoken);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       bottomNavigationBar: showgreating
//           ? Container(
//               height: 300.h,
//               width: double.infinity,
//               child: GreetingBody(),
//             )
//           : SizedBox(),
//       appBar: customappbar(),
//       body: Column(
//         children: [
//           exchange(),
//           StreamBuilder(
//               stream: controll.receivemessage(widget.groupchannel.channelid!),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   messagelist = snapshot.data!.docs
//                       .map((e) => ChatMessage.fromJson(e.data()))
//                       .toList();
//                   Future.delayed(Duration(milliseconds: 200), () {
//                     if (snapshot.data!.docs.isEmpty) {
//                       var messageid = FirebaseFirestore.instance
//                           .collection("channel")
//                           .doc(widget.groupchannel.channelid)
//                           .collection("message")
//                           .doc()
//                           .id;
//                       var msg = ChatMessage(
//                           customProperties: {
//                             "type": 0,
//                             "seen": false,
//                             "reaply": reaplymessag == null ? false : true,
//                             "reaplymsg": reaplymessag == null
//                                 ? null
//                                 : reaplymessag!.text,
//                             "messageid": messageid
//                           },
//                           user: asDashChatUser(),
//                           createdAt: DateTime.now(),
//                           medias: [],
//                           mentions: [],
//                           quickReplies: [],
//                           text:
//                               greetingList[box.read(Keys.seekergreating) ?? 0]);
//                       controll.messagesend(
//                           messageid: messageid,
//                           channelid: widget.groupchannel.channelid!,
//                           chatuserid: chatuser,
//                           userid: user,
//                           msg: msg);
//                     }
//                     videocallstream(
//                         ChatMessage.fromJson(snapshot.data!.docs.first.data()),
//                         snapshot.data!.docs.first.id);
//                   });
//                   return Expanded(
//                       child: DashChat(
//                           reaplychild:
//                               reaplymessag == null ? SizedBox() : reaplyui(),
//                           readOnly: widget
//                               .groupchannel.block!['${user.recruiterId}']!,
//                           messageListOptions: messagelistoption(),
//                           currentUser: asDashChatUser(),
//                           inputOptions: inputoption(),
//                           messages: messagelist,
//                           onSend: (message) {
//                             onsend(message);
//                           },
//                           messageOptions: messageoptions()));
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//               })
//         ],
//       ),
//     );
//   }

//   AppBar customappbar() {
//     return AppBar(
//       actions: [
//         IconButton(
//             onPressed: () {}, icon: Image.asset("assets/images/vector.png")),
//         IconButton(
//             onPressed: () {
//               Get.to(ChatSettingPage(
//                   groupchannel: widget.groupchannel, user: user));
//             },
//             icon: Icon(Icons.more_vert)),
//       ],
//       title: ListTile(
//         contentPadding: EdgeInsets.zero,
//         leading: CircleAvatar(
//           radius: 25.r,
//           backgroundImage: NetworkImage(AppConstants.imgurl + user.photo!),
//         ),
//         title: Text(user.firstname!),
//         subtitle: Text(active == true ? "online" : "ofline"),
//       ),
//     );
//   }

//   Widget exchange() {
//     return Column(
//       children: [
//         SizedBox(height: 10.h),
//         Row(
//           children: [
//             Expanded(
//                 child: InkWell(
//               onTap: () {
//                 exchangerequest(
//                     type: 1,
//                     mgs: "request to exchange phone numbers has been sent");
//               },
//               child: Column(
//                 children: [
//                   Image.asset("assets/images/phonenum.png"),
//                   SizedBox(height: 10.h),
//                   Text(
//                     "Exch Number",
//                     style: TextStyle(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w300,
//                         color: Colors.black),
//                   )
//                 ],
//               ),
//             )),
//             Expanded(
//                 child: InkWell(
//               onTap: () {
//                 exchangerequest(
//                     type: 2, mgs: "request to send cv has been sent");
//               },
//               child: Column(
//                 children: [
//                   Image.asset("assets/images/fileexchange.png"),
//                   SizedBox(height: 10.h),
//                   Text(
//                     "Send My Resume",
//                     style: TextStyle(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w300,
//                         color: Colors.black),
//                   )
//                 ],
//               ),
//             )),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget currentuserreq(ChatMessage message) {
//     return Container(
//       constraints: BoxConstraints(
//         maxWidth: 218.w,
//       ),
//       child: Card(
//         child: Padding(
//           padding: EdgeInsets.all(5.r),
//           child: Text(
//             "you ${message.text}",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey, fontSize: 12.sp),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget recuiterreq(ChatMessage message) {
//     return Row(
//       children: [
//         Container(
//           margin: EdgeInsets.all(10.r),
//           constraints: BoxConstraints(
//             maxWidth: 218.w,
//           ),
//           child: Card(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(5.r),
//                   child: Text(
//                       "The recruiter has requested the ${message.customProperties!['type'] == 1 ? "Phone Number" : message.customProperties!['type'] == 2 ? "resume" : "video call"} please accept to share your ${message.customProperties!['type'] == 1 ? "Phone Number" : "resume"} with recruiter."),
//                 ),
//                 InkWell(
//                   onTap: message.customProperties!['request'] == 1
//                       ? null
//                       : () {
//                           showDialog(
//                               context: context,
//                               builder: (context) => SendDialog(
//                                     reaplymessag: reaplymessag ?? null,
//                                     sendmessage: () {
//                                       setState(() {
//                                         print(message
//                                             .customProperties!['messageid']);

//                                         controll.requestmessageupdate(
//                                             messageid: message
//                                                 .customProperties!['messageid'],
//                                             channelid:
//                                                 widget.groupchannel.channelid!);
//                                       });
//                                     },
//                                     message: message,
//                                     channel: widget.groupchannel,
//                                   ));
//                         },
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 40.h,
//                     width: 192.w,
//                     decoration: BoxDecoration(
//                         color: Color(0xFF0C8CE9),
//                         borderRadius: BorderRadius.circular(5.r)),
//                     child: Text(
//                       message.customProperties!['request'] == 0
//                           ? "ACCEPT"
//                           : "DONE",
//                       style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10.h),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget sendphonenumberbox(ChatMessage message) {
//     return Card(
//       child: Container(
//         padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
//         width: 250.h,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "${message.user.firstName!} mobile num:",
//               style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: 5.h),
//             Text(
//               "${message.user.customProperties!['phone']}",
//               style: TextStyle(fontSize: 14.sp),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: MaterialButton(
//                   padding: EdgeInsets.zero,
//                   onPressed: () async {
//                     await launchUrl(Uri.parse(
//                         "tel:${message.user.customProperties!['phone']}"));
//                   },
//                   child: Text("Call"),
//                 )),
//                 Container(
//                   height: 20.h,
//                   width: 1.w,
//                   color: Colors.grey,
//                 ),
//                 Expanded(
//                     child: MaterialButton(
//                   padding: EdgeInsets.zero,
//                   onPressed: () async {
//                     await Clipboard.setData(ClipboardData(
//                         text: message.user.customProperties!['phone']));
//                   },
//                   child: Text("Copy"),
//                 ))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget imagepathshow() {
//     return Container(
//       height: 70.h,
//       width: double.infinity,
//       child: ListView.builder(
//         itemCount: imgpaths.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           var data = imgpaths[index];
//           return Card(
//             child: Container(
//               height: 70.h,
//               width: 70.w,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(5.r),
//                     child: InkWell(
//                       onTap: () {
//                         Get.to(FileImageView(path: data.path));
//                       },
//                       child: Image.file(
//                         File(data.path),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: InkWell(
//                       onTap: () {
//                         imgpaths.remove(data);
//                         setState(() {});
//                       },
//                       child: Card(
//                         color: Colors.red,
//                         child: Icon(
//                           Icons.close,
//                           size: 15.r,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   MessageListOptions messagelistoption() {
//     return MessageListOptions(
//         chatFooterBuilder: imgpaths.isNotEmpty
//             ? imagepathshow()
//             : widget.groupchannel.block!['${user.recruiterId}'] == false
//                 ? SizedBox()
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(10.r),
//                         width: 300.w,
//                         child: Text(
//                           "You can not send this message. because you block this user",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.red.withOpacity(0.5)),
//                         ),
//                       ),
//                     ],
//                   ));
//   }

//   InputOptions inputoption() {
//     return InputOptions(leading: [
//       IconButton(
//           onPressed: () {
//             imageupload();
//           },
//           icon: Icon(
//             Icons.image,
//             color: Colors.grey,
//           ))
//     ]);
//   }

//   double messagemove = 0.0;

//   MessageOptions messageoptions() {
//     return MessageOptions(
//       messageRowBuilder: (message, previousMessage, nextMessage,
//           isAfterDateSeparator, isBeforeDateSeparator) {
//         if (message.customProperties!['type'] == 0 ||
//             message.customProperties!['type'] == 5) {
//           return MessageRow(
//               messageOptions: MessageOptions(
//                 onPanEnd: (p0, p1) {
//                   reaplymessag = p1;
//                   setState(() {});
//                 },
//                 showTime: true,
//                 onTapMedia: (media) {
//                   if (media.type == MediaType.file) {
//                     Get.to(UploadRecumeView(
//                       url: media.url,
//                     ));
//                   } else if (media.type == MediaType.image) {}
//                 },
//                 showOtherUsersAvatar: false,
//                 messageTimeBuilder: (message, isOwnMessage) {
//                   return Padding(
//                     padding: messageOptions.timePadding,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           DateFormat("HH:mm").format(message.createdAt),
//                           style: TextStyle(
//                               fontSize: messageOptions.timeFontSize,
//                               color: isOwnMessage
//                                   ? messageOptions
//                                       .currentUserTimeTextColor(context)
//                                   : messageOptions.timeTextColor()),
//                         ),
//                         isOwnMessage ? SizedBox(width: 5.w) : SizedBox(),
//                         isOwnMessage
//                             ? message.customProperties!['seen'] == true
//                                 ? Image.asset("assets/images/Seen Icon.png")
//                                 : Image.asset("assets/images/unseen.png")
//                             : SizedBox()
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               currentUser: asDashChatUser(),
//               message: message,
//               isAfterDateSeparator: isAfterDateSeparator,
//               isBeforeDateSeparator: isBeforeDateSeparator,
//               nextMessage: nextMessage,
//               previousMessage: previousMessage);
//         } else if (message.user.id == chatuser.id.toString() &&
//             (message.customProperties!['type'] == 1 ||
//                 message.customProperties!['type'] == 2)) {
//           return currentuserreq(message);
//         } else if (message.customProperties!['type'] == 6) {
//           return sendphonenumberbox(
//             message,
//           );
//         } else if (message.customProperties!['type'] == 4) {
//           return Container(
//             constraints: BoxConstraints(
//               maxWidth: 218.w,
//             ),
//             child: Card(
//               child: Padding(
//                 padding: EdgeInsets.all(5.r),
//                 child: Text(
//                   "${message.user.firstName} ${message.text}",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey, fontSize: 12.sp),
//                 ),
//               ),
//             ),
//           );
//         } else if (message.customProperties!['type'] == 7) {
//           return reaplymessageui(message);
//         } else {
//           if (message.user.id == user.recruiterId.toString() &&
//               message.customProperties!['type'] != 3) {
//             return recuiterreq(message);
//           } else {
//             return Container(
//               width: 250.w,
//               child: Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(5.r),
//                   child: Text(
//                     "${user.firstname} ${message.text}",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.grey, fontSize: 12.sp),
//                   ),
//                 ),
//               ),
//             );

//             // return sendphonenumberbox(
//             //     message, controll.sendbird.currentUser!);
//           }
//         }
//       },
//     );
//   }

//   Widget reaplyui() {
//     return Container(
//       child: Row(
//         children: [
//           Container(
//             height: 50.h,
//             width: 2.w,
//             decoration: BoxDecoration(color: Color(0xFFFF6868)),
//           ),
//           SizedBox(width: 10.w),
//           Flexible(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       reaplymessag!.user.firstName!,
//                       style: TextStyle(
//                           color: Color(0xFFFF6868),
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.w400),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         reaplymessag = null;
//                         setState(() {});
//                       },
//                       child: Icon(
//                         Icons.close,
//                         color: Colors.black,
//                         size: 15.r,
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 5.h),
//                 Text(reaplymessag!.text),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget reaplymessageui(ChatMessage message) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 3.h),
//           padding: EdgeInsets.all(10.w),
//           constraints: BoxConstraints(maxWidth: 190.w),
//           decoration: BoxDecoration(
//               color: Color(0xFF0099FA),
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15.r),
//                   bottomLeft: Radius.circular(15.r))),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     height: 50.h,
//                     width: 2.w,
//                     decoration: BoxDecoration(color: Color(0xFFFF6868)),
//                   ),
//                   SizedBox(width: 10.w),
//                   Flexible(
//                     child: Column(
//                       children: [
//                         Text(
//                           message.customProperties!['reaplymsg'],
//                           style:
//                               TextStyle(color: Colors.white.withOpacity(0.8)),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 3.h),
//               Text(
//                 message.text,
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               )
//             ],
//           ),
//         ),
//         SizedBox(width: 9.w),
//       ],
//     );
//   }
// }


// class InboxresumesendPage extends StatefulWidget {
//   final Function onSend;
//   const InboxresumesendPage({super.key, required this.onSend});

//   @override
//   State<InboxresumesendPage> createState() => _InboxresumesendPageState();
// }

// class _InboxresumesendPageState extends State<InboxresumesendPage> {
//   final resumecontroll = Get.put(ResumeManagementController());

//   bool loading = false;

//   Future loaddata() async {
//     setState(() {
//       loading = true;
//     });
//     await resumecontroll.getallresume();
//     setState(() {
//       loading = false;
//     });
//   }

//   Resume? resume;

//   @override
//   void initState() {
//     loaddata();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: loading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Stack(
//               fit: StackFit.expand,
//               children: [
//                 ListView.builder(
//                   itemCount: resumecontroll.uploadresumelist!.resume!.length,
//                   itemBuilder: (context, index) {
//                     var data = resumecontroll.uploadresumelist!.resume![index];
//                     return ListTile(
//                       onTap: () {
//                         setState(() {
//                           resume = data;
//                         });
//                       },
//                       leading: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             height: 15.h,
//                             width: 15.w,
//                             decoration: BoxDecoration(
//                                 color: resume != null &&
//                                         resume!.resumes == data.resumes
//                                     ? Colors.indigo
//                                     : Colors.transparent,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(color: Colors.indigo)),
//                           ),
//                           SizedBox(width: 5.w),
//                           Image.asset("assets/images/pdf.png", height: 30.h),
//                         ],
//                       ),
//                       title: Text("Resume (${index + 1})"),
//                     );
//                   },
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: resume == null ? SizedBox() : bottom(),
//                 )
//               ],
//             ),
//     );
//   }

//   Widget bottom() {
//     return Row(
//       children: [
//         Expanded(
//           child: BottomNavWidget(
//             text: "Send",
//             onTap: () {
//               widget.onSend(resume, resumecontroll.uploadresumelist!.baseUrl);
//             },
//           ),
//         ),
//         Expanded(
//           child: BottomNavWidget(
//             text: "View",
//             onTap: () {
//               Get.to(UploadRecumeView(
//                 url: "${resumecontroll.uploadresumelist!.baseUrl}" +
//                     resume!.resumes!,
//               ));
//             },
//           ),
//         )
//       ],
//     );
//   }
// }

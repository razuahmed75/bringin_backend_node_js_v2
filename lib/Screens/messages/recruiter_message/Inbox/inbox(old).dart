// import 'dart:io';

// import 'package:bringin/res/color.dart';
// import 'package:bringin/utils/services/keys.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../../controllers/both_category/seeker_chat_controller.dart';
// import '../../../../../models/candidate_section/Chat/GroupChannel/groupchannel.dart';
// import '../../../../../res/constants/app_constants.dart';
// import '../../../../../utils/services/helpers.dart';
// import '../../../../Http/get.dart';
// import '../../../../Http/notification.dart';
// import '../../../../controllers/both_category/recruiter_chat_controll.dart';
// import '../../../../widgets/app_bottom_nav_widget.dart';
// import '../../../../widgets/file_imageview.dart';
// import '../../../../widgets/radio_tile.dart';
// import '../../candidate_message/Chat/Setting/setting.dart';
// import '../../candidate_message/Chat/VideoCall/seekervideocall.dart';

// // 1 = phone exchange
// // 2 = cv request
// // 3 = video call
// // 4 = not interest
// // 5 = image send
// // 6 = number send

// class RecruiterChatInboxPage extends StatefulWidget {
//   final Groupchannel groupchannel;

//   const RecruiterChatInboxPage({super.key, required this.groupchannel});

//   @override
//   State<RecruiterChatInboxPage> createState() => _RecruiterChatInboxPageState();
// }

// class _RecruiterChatInboxPageState extends State<RecruiterChatInboxPage> {
//   GetStorage box = GetStorage();
//   late int currenidindex = widget.groupchannel.userinfo!.indexWhere(
//       (element) => element.recruiterId == box.read(Keys.isrecruiterprofileid));
//   late Userinfo recruiterchatuser =
//       widget.groupchannel.userinfo![currenidindex];
//   late Userinfo seekeruser =
//       widget.groupchannel.userinfo![currenidindex == 0 ? 1 : 0];
//   late List<ChatMessage> messagelist = [];
//   final controll = Get.put(RecruiterChatControll());

//   bool active = false;

//   late Stream<QuerySnapshot<Map<String, dynamic>>> messagestream = controll
//       .receivemessage(widget.groupchannel.channelid!)
//       .asBroadcastStream();

//   ChatUser asDashChatUser() {
//     return ChatUser(
//         firstName: recruiterchatuser.firstname,
//         id: recruiterchatuser.recruiterId.toString(),
//         customProperties: {
//           "phone": recruiterchatuser.phone,
//           "email": recruiterchatuser.email
//         },
//         profileImage: AppConstants.imgurl + recruiterchatuser.photo!,
//         lastName: recruiterchatuser.lastname);
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
//           "messageid": messageid,
//           "request": 0,
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
//         chatuserid: recruiterchatuser,
//         userid: seekeruser,
//         msg: msg);
//   }

//   bool loading = false;

//   int different(DateTime _date2) {
//     DateTime date1 = DateTime.now();
//     DateTime date2 = _date2;
//     return date1.difference(date2).inSeconds;
//   }

//   MessageOptions messageOptions = MessageOptions();

//   late Stream<DocumentSnapshot> useractive =
//       controll.activecitydetect(seekeruser.id.toString());

//   void activicityget() {
//     useractive.listen((event) {
//       setState(() {
//         active = event['active'];
//       });
//     });
//   }

//   void messageseen(ChatMessage recmsg, String lastmsgid) async {
//     if (recmsg.user.id == seekeruser.id.toString()) {
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
//                 "seen": true
//               }),
//           lastmsgid: lastmsgid);
//     }
//   }

//   void onsend(ChatMessage message) async {
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
//     controll.messagesend(
//         messageid: messageid,
//         channelid: widget.groupchannel.channelid!,
//         chatuserid: recruiterchatuser,
//         userid: seekeruser,
//         msg: msg);
//     imgpaths.clear();
//     reaplymessag = null;
//     if (active == false) {
//       sendnotification(message: message.text);
//     }
//     setState(() {});
//   }

//   List<XFile> imgpaths = [];

//   Future imageupload() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       imgpaths.add(image);
//       setState(() {});
//     }
//   }

//   ChatMessage? reaplymessag;

//   String ntftoken = "";

//   Future settoken() async {
//     ntftoken = await controll.ntftokenget(seekeruser.id.toString());
//     print(ntftoken);
//     setState(() {});
//   }

//   Future sendnotification({required String message}) async {
//     await HttpNtf().notificationsend(
//         push: "${recruiterchatuser.firstname} message you",
//         message: message,
//         playerid: ntftoken);
//   }

//   @override
//   void initState() {
//     activicityget();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
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
//                     messageseen(
//                         ChatMessage.fromJson(snapshot.data!.docs.first.data()),
//                         snapshot.data!.docs.first.id);
//                   });
//                   return Expanded(
//                       child: DashChat(
//                           reaplychild:
//                               reaplymessag == null ? SizedBox() : reaplyui(),
//                           readOnly:
//                               widget.groupchannel.block!['${seekeruser.id}']!,
//                           messageListOptions: messageListOptions(),
//                           currentUser: asDashChatUser(),
//                           inputOptions: inputoption(),
//                           messages: messagelist,
//                           onSend: (message) => onsend(message),
//                           messageOptions: messageOption()));
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//               })
//         ],
//       ),
//     );
//   }

//   InputOptions inputoption() {
//     return InputOptions(leading: [
//       IconButton(
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               builder: (context) {
//                 return BottomSheet(
//                   seekeruser: seekeruser,
//                   voidcallback: (String text) {
//                     onsend(ChatMessage(
//                         user: ChatUser(id: recruiterchatuser.recruiterId!),
//                         createdAt: DateTime.now(),
//                         text: text));
//                   },
//                 );
//               },
//             );
//           },
//           icon: Image.asset("assets/icon2/greatingmessage.png")),
//       IconButton(
//           onPressed: () {
//             imageupload();
//           },
//           icon: Image.asset("assets/icon2/gallary.png"))
//     ]);
//   }

//   MessageListOptions messageListOptions() {
//     return MessageListOptions(
//         chatFooterBuilder: imgpaths.isNotEmpty
//             ? imagepathshow()
//             : widget.groupchannel.block!['${seekeruser.id}'] == false
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

//   AppBar customappbar() {
//     return AppBar(
//       actions: [
//         IconButton(
//             onPressed: () {}, icon: Image.asset("assets/images/vector.png")),
//         IconButton(
//             onPressed: () {
//               Get.to(ChatSettingPage(
//                   groupchannel: widget.groupchannel, user: seekeruser));
//             },
//             icon: Icon(Icons.more_vert)),
//       ],
//       title: ListTile(
//         contentPadding: EdgeInsets.zero,
//         leading: CircleAvatar(
//           radius: 25.r,
//           backgroundImage:
//               NetworkImage(AppConstants.imgurl + seekeruser.photo!),
//         ),
//         title: Text(seekeruser.firstname!),
//         subtitle: Text(active == true ? "online" : "ofline"),
//       ),
//     );
//   }

//   Widget exchange() {
//     return Column(
//       children: [
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Expanded(
//                 child: InkWell(
//               onTap: () {
//                 exchangerequest(type: 1, mgs: "request for number");
//               },
//               child: Column(
//                 children: [
//                   Image.asset("assets/images/phonenum.png"),
//                   SizedBox(height: 10),
//                   Text(
//                     "Ask Number",
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w300,
//                         color: Colors.black),
//                   )
//                 ],
//               ),
//             )),
//             Expanded(
//                 child: InkWell(
//               onTap: () {
//                 exchangerequest(type: 2, mgs: "request for cv");
//               },
//               child: Column(
//                 children: [
//                   Image.asset("assets/images/fileexchange.png"),
//                   SizedBox(height: 10),
//                   Text(
//                     "Ask Resume",
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w300,
//                         color: Colors.black),
//                   )
//                 ],
//               ),
//             )),
//             Expanded(
//                 child: InkWell(
//               onTap: () async {
//                 exchangerequest(type: 3, mgs: "request for video call");
//                 controll.recruiterinterviewcount();
//                 Get.to(SeekerVideoCall(groupchannel: widget.groupchannel));
//               },
//               child: Column(
//                 children: [
//                   Image.asset("assets/images/video.png"),
//                   SizedBox(height: 10),
//                   Text(
//                     "Video Interview",
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w300,
//                         color: Colors.black),
//                   )
//                 ],
//               ),
//             )),
//             Expanded(
//                 child: InkWell(
//               onTap: () {
//                 exchangerequest(type: 4, mgs: "not interest");
//               },
//               child: Column(
//                 children: [
//                   Image.asset("assets/images/Broken_heart_light.png"),
//                   SizedBox(height: 10),
//                   Text(
//                     "Not Interested",
//                     style: TextStyle(
//                         fontSize: 12,
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

//   Widget seekeruserreq(ChatMessage message) {
//     return Container(
//       constraints: BoxConstraints(
//         maxWidth: 218.w,
//       ),
//       child: Card(
//         child: Padding(
//           padding: EdgeInsets.all(5.r),
//           child: Text(
//             "${message.user.firstName} ${message.text}",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey, fontSize: 12.sp),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget sendphonenumberbox(ChatMessage message) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         DefaultUserName(user: message.user),
//         Row(
//           children: [
//             SizedBox(width: 5.w),
//             Card(
//               child: Container(
//                 padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
//                 width: 250.h,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${message.user.firstName!} mobile num:",
//                       style: TextStyle(
//                           fontSize: 14.sp, fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(height: 5.h),
//                     Text(
//                       "${message.user.customProperties!['phone']}",
//                       style: TextStyle(fontSize: 14.sp),
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                             child: MaterialButton(
//                           padding: EdgeInsets.zero,
//                           onPressed: () async {
//                             await launchUrl(Uri.parse(
//                                 "tel:${message.user.customProperties!['phone']}"));
//                           },
//                           child: Text("Call"),
//                         )),
//                         Container(
//                           height: 20.h,
//                           width: 1.w,
//                           color: Colors.grey,
//                         ),
//                         Expanded(
//                             child: MaterialButton(
//                           padding: EdgeInsets.zero,
//                           onPressed: () async {
//                             await Clipboard.setData(ClipboardData(
//                                 text: message.user.customProperties!['phone']));
//                           },
//                           child: Text("Copy"),
//                         ))
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   MessageOptions messageOption() {
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
//         } else if (message.user.id ==
//                 recruiterchatuser.recruiterId.toString() &&
//             (message.customProperties!['type'] == 1 ||
//                 message.customProperties!['type'] == 2)) {
//           return currentuserreq(message);
//         } else if (message.user.id == seekeruser.id.toString() &&
//             (message.customProperties!['type'] == 1 ||
//                 message.customProperties!['type'] == 2)) {
//           return seekeruserreq(message);
//         } else if (message.customProperties!['type'] == 6) {
//           return sendphonenumberbox(message);
//         } else if (message.customProperties!['type'] == 7) {
//           return reaplymessageui(message);
//         } else {
//           if (message.user.id == seekeruser.id.toString() &&
//               message.customProperties!['type'] != 3) {
//             return SizedBox();
//           } else {
//             return Container(
//               width: 250.w,
//               child: Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(5.r),
//                   child: Text(
//                     "${seekeruser.firstname} ${message.text}",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.grey, fontSize: 12.sp),
//                   ),
//                 ),
//               ),
//             );
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



// }

// class BottomSheet extends StatefulWidget {
//   final Function voidcallback;
//   final Userinfo seekeruser;
//   const BottomSheet(
//       {super.key, required this.voidcallback, required this.seekeruser});

//   @override
//   State<BottomSheet> createState() => _BottomSheetState();
// }

// class _BottomSheetState extends State<BottomSheet> {
//   late String welcomeMsg1 = box.read(Keys.isRecruiter)
//       ? "Hello ${widget.seekeruser.firstname}! I am interested in your profile, Let’s talk in details about the job post."
//       : "I would like to learn more about this job position, can we discuss it further?";
//   late String welcomeMsg2 = box.read(Keys.isRecruiter)
//       ? "Hey ${widget.seekeruser.firstname}, You have a good profile. Can I know your skills, qualifications & experiences in depth?"
//       : "Greetings Sir, I am interested in discussing how my skills and experience meet the requirements for the job. Can we talk for a while?";
//   late String welcomeMsg3 = box.read(Keys.isRecruiter)
//       ? "Hi ${widget.seekeruser.firstname}, Your resume looks amazing. We have an open position based on your profile, Considering your profile hope you’ll be a great fit for the position. Would you like to have a chat?"
//       : "Respectful Greetings Sir, My profile is suitable based on your job post. May I have a moment of your time?";
//   late String welcomeMsg4 = box.read(Keys.isRecruiter)
//       ? "Hey ${widget.seekeruser.firstname}, Are you available to response? I'd love to chat with you about our current job opening."
//       : "Hi, I am confident that my skills and experience make me a good fit for the job. Can we have a quick conversation about it?";
//   late String welcomeMsg5 = box.read(Keys.isRecruiter)
//       ? "Hello ${widget.seekeruser.firstname}, I am interested in your profile, can we have a talk? Please feel free to knock me back asap!"
//       : "Hi there, I am <name of the seeker>, and I would like to learn more about the job post. Could we schedule a meeting to discuss it further?";
//   late String welcomeMsg6 = box.read(Keys.isRecruiter)
//       ? "Hi ${widget.seekeruser.firstname}, I have read your bio. Would you please share me your details CV to learn more about your education & experiences?"
//       : "Hello Sir, I am interested in the job opening and I think I have the skills and experience you are looking for. Let’s have a details discussion.";
//   late String welcomeMsg7 = box.read(Keys.isRecruiter)
//       ? "Hi ${widget.seekeruser.firstname}! Upon reviewing your profile, Found you matched according to our requirements. Are you available for a quick chat now?"
//       : "Hi <name of the recruiter>, Good day! I am interested in discussing the job opening with you. Could we schedule a meeting at your convenience?";
//   late String welcomeMsg8 = box.read(Keys.isRecruiter)
//       ? "Hello ${widget.seekeruser.firstname}, I am interested in your profile. Would you please send me your resume or more details about yourself? "
//       : "Hello <name of the recruiter>, I would like to have a meeting with you to talk about the job post. Could we schedule a time that works for both of us?";

//   late List<String> greetingList = [
//     welcomeMsg1,
//     welcomeMsg2,
//     welcomeMsg3,
//     welcomeMsg4,
//     welcomeMsg5,
//     welcomeMsg6,
//     welcomeMsg7,
//     welcomeMsg8,
//   ];

//   String text = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           ListView.builder(
//             padding: EdgeInsets.all(10.r),
//             itemCount: greetingList.length,
//             itemBuilder: (context, index) {
//               return RadioTileWidget(
//                 value: index,
//                 groupValue: box.read(Keys.seekergreating) ?? 0,
//                 title: greetingList[index],
//                 onChanged: (value) {
//                   box.write(Keys.seekergreating, value);
//                   setState(() {
//                     text = greetingList[index];
//                   });
//                 },
//               );
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: BottomNavWidget(
//               text: "Send",
//               onTap: () {
//                 widget.voidcallback(text);
//                 Navigator.pop(context);
//               },
//             ),
//           )
//           // Align(
//           //   alignment: Alignment.bottomCenter,
//           //   child: Container(
//           //     height: 50.h,
//           //     width: 150.w,
//           //     decoration: BoxDecoration(color: AppColors.mainColor),
//           //     child: Text(
//           //       "Send",
//           //       style: TextStyle(),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//     ;
//   }
// }

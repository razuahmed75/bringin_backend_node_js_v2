// import 'package:bringin/Http/get.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

// import '../../models/candidate_section/Chat/GroupChannel/groupchannel.dart';
// import '../../models/candidate_section/candidate_profile_info_model.dart';
// import '../../models/recruiter_section/recruiter_profile_info_model.dart';
// import '../../utils/services/keys.dart';
// import '../recruiter_section/recruiter_edit_main_profile_controller.dart';

// class RecruiterChatControll extends GetxController with WidgetsBindingObserver {
//   Future usercreateandupdate(
//       {required RecruiterProfileInfoModel details}) async {
//     GetStorage box = GetStorage();
//     OneSignal.initialize("74463dd2-b8de-4624-a679-0221b4b0af85");
//     // box.write(Keys.isrecruiterprofileid, details.recruiterId);
//     var user = await FirebaseFirestore.instance.collection("user");
//     var token = await FirebaseFirestore.instance.collection("token");
//     var usertoken = await OneSignal.User.pushSubscription.id;
//     var usertoken2 = await OneSignal.User.pushSubscription.id;
//     // await user
//     //     .doc(details.recruiterId.toString())
//         // .set({"active": false, "user": details.toJson()});
//     // OneSignal.User.pushSubscription.addObserver((state) {
//     //   token
//     //       .doc(details.recruiterId.toString())
//     //       .set({"token": OneSignal.User.pushSubscription.id});
//     // });
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> channellistget() {
//     GetStorage box = GetStorage();
//     var channel = FirebaseFirestore.instance.collection("channel");
//     return channel.where('users', arrayContainsAny: [
//       int.parse(box.read(Keys.isrecruiterprofileid))
//     ]).snapshots();
//   }

//   Future messagesend(
//       {required String channelid,
//       required String messageid,
//       required ChatMessage msg,
//       required Userinfo chatuserid,
//       required Userinfo userid}) async {
//     var channel = await FirebaseFirestore.instance.collection("channel");
//     channel.doc(channelid).update({
//       "channelid": channelid,
//       "date": msg.createdAt.toUtc().toIso8601String(),
//       "lastmessage": msg.toJson(),
//       "seen": false,
//       "users": [int.parse(chatuserid.recruiterId!), userid.id],
//       "userinfo": [chatuserid.toJson(), userid.toJson()]
//     });
//     channel
//         .doc(channelid)
//         .collection("message")
//         .doc(messageid)
//         .set(msg.toJson());
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> receivemessage(String channelid) {
//     var channel = FirebaseFirestore.instance.collection("channel");
//     return channel
//         .doc(channelid)
//         .collection("message")
//         .orderBy("createdAt", descending: true)
//         .snapshots();
//   }

//   Future<QuerySnapshot<Map<String, dynamic>>> allmessageget(
//       String channelid) async {
//     var channel = await FirebaseFirestore.instance.collection("channel");
//     return await channel
//         .doc(channelid)
//         .collection("message")
//         .orderBy("createdAt", descending: true)
//         .get();
//   }

//   Future blockuser({required String channelid, required Map blockdata}) async {
//     var channel = await FirebaseFirestore.instance.collection("channel");
//     channel.doc(channelid).update({"block": blockdata});
//   }

//   Stream<DocumentSnapshot> activecitydetect(String userid) {
//     var user = FirebaseFirestore.instance.collection("user");
//     return user.doc(userid).snapshots();
//   }

//   Future updatecurrentuseractive(bool active) async {
//     final currentprofileinfo = Get.find<RecruiterEditMainProfileController>();
//     await currentprofileinfo.getRecruiterProfileInfoList();
//     var user = await FirebaseFirestore.instance.collection("user");
//     // await user
//     //     .doc(currentprofileinfo.recruiterProfileInfoList[0].recruiterId
//     //         .toString())
//     //     .update({
//     //   "active": active,
//     //   "user": currentprofileinfo.recruiterProfileInfoList[0].toJson()
//     // });
//   }

//   Future messageseenupdate(
//       {required String channelid,
//       required ChatMessage msg,
//       required String lastmsgid}) async {
//     var channel = await FirebaseFirestore.instance.collection("channel");
//     channel
//         .doc(channelid)
//         .collection("message")
//         .doc(lastmsgid)
//         .update(msg.toJson());
//     channel.doc(channelid).update({"lastmessage": msg.toJson()});
//   }

//   Future imageupload() async {}

//   Future ntftokenget(String userid) async {
//     var token = await FirebaseFirestore.instance.collection("token");
//     var data = await token.doc(userid).get();
//     return data['token'];
//   }

//   Future<QuerySnapshot<Map<String, dynamic>>> allchannellistget() async {
//     GetStorage box = GetStorage();
//     var channel = FirebaseFirestore.instance.collection("channel");
//     return channel.where('users', arrayContainsAny: [
//       int.parse(box.read(Keys.isrecruiterprofileid))
//     ]).get();
//   }

//   Future<DocumentSnapshot<Map<String, dynamic>>> channelcreate(
//       {required RecruiterProfileInfoModel recruiterdetails,
//       required CandidateProfileInfoModel seekerprofiledetails}) async {
//     var channel = await FirebaseFirestore.instance.collection("channel");
//     var channellist = await channel
//         .where('users', arrayContainsAny: [
//           seekerprofiledetails.sId,
//           // int.parse(recruiterdetails.recruiterId!)
//         ])
//         .limit(1)
//         .get();
//     if (channellist.docs.isEmpty) {
//       String id = channel.doc().id;
//       await channel.doc(id).set({
//         "channelid": id,
//         "date": DateTime.now().toUtc().toIso8601String(),
//         "lastmessage": null,
//         "seen": false,
//         "users": [
//           int.parse(seekerprofiledetails.sId.toString()),
//           // int.parse(recruiterdetails.recruiterId!)
//         ],
//         "userinfo": [seekerprofiledetails.toJson(), recruiterdetails.toJson()],
//         "block": {
//           "${seekerprofiledetails.sId}": false,
//           // "${recruiterdetails.recruiterId}": false,
//         }
//       });
//       await recruiterchatcount();
//       return await channel.doc(id).get();
//     } else {
//       return channellist.docs.first;
//     }
//   }

//   Future recruiterinterviewcount() async {
//     await Httphelp().getdata(ENDPOINT_URL: "/recruiters/interviews/count");
//   }

//   Future recruiterchatcount() async {
//     await Httphelp().getdata(ENDPOINT_URL: "/recruiters/chat/count");
//   }

//   @override
//   void onInit() {
//     WidgetsBinding.instance.addObserver(this);
//     updatecurrentuseractive(true);
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     updatecurrentuseractive(false);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       updatecurrentuseractive(true);
//     } else {
//       updatecurrentuseractive(false);
//     }
//     print('state = $state');
//   }

//   @override
//   void onClose() {
//     updatecurrentuseractive(false);
//     super.onClose();
//   }
// }

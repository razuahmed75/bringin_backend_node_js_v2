

// class SeekerChatController extends GetxController with WidgetsBindingObserver {
//   final currentprofileinfo = Get.find<CandidateEditMainProfileController>();

//   Future usercreateandupdate({required CandidateProfileInfoModel details}) async {
//     GetStorage box = GetStorage();
//     OneSignal.initialize("74463dd2-b8de-4624-a679-0221b4b0af85");
//     box.write(Keys.isseekerprofileid, details.sId);
//     var user = await FirebaseFirestore.instance.collection("user");
//     var token = await FirebaseFirestore.instance.collection("token");
//     var usertoken = await OneSignal.User.pushSubscription.id;
//     var usertoken2 = await OneSignal.User.pushSubscription.id;
//     await user
//         .doc(details.sId.toString())
//         .set({"active": false, "user": details.toJson()});

//     OneSignal.User.pushSubscription.addObserver((state) {
//       token
//           .doc(details.sId.toString())
//           .set({"token": OneSignal.User.pushSubscription.id});
//     });
//     update();
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> channellistget() {
//     GetStorage box = GetStorage();
//     var channel = FirebaseFirestore.instance.collection("channel");
//     return channel.where('users',
//         arrayContainsAny: [box.read(Keys.isseekerprofileid)]).snapshots();
//   }

//   Future messagesend(
//       {required String channelid,
//       required ChatMessage msg,
//       required Userinfo chatuserid,
//       required Userinfo userid,
//       required String messageid}) async {
//     var channel = await FirebaseFirestore.instance.collection("channel");
//     channel.doc(channelid).update({
//       "channelid": channelid,
//       "date": msg.createdAt.toUtc().toIso8601String(),
//       "lastmessage": msg.toJson(),
//       "seen": false,
//       "users": [chatuserid.id, int.parse(userid.recruiterId!)],
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

//   Future<DocumentSnapshot<Map<String, dynamic>>> channelcreate(
//       {required RecruiterProfileInfoModel recruiterdetails}) async {
//     var channel = await FirebaseFirestore.instance.collection("channel");
//     var channellist = await channel
//         .where('users', arrayContainsAny: [
//           currentprofileinfo.profileInfoList[0].sId,
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
//           int.parse(currentprofileinfo.profileInfoList[0].sId.toString()),
//           // int.parse(recruiterdetails.recruiterId!)
//         ],
//         "userinfo": [
//           currentprofileinfo.profileInfoList[0].toJson(),
//           recruiterdetails.toJson()
//         ],
//         "block": {
//           "${currentprofileinfo.profileInfoList[0].sId}": false,
//           // "${recruiterdetails.recruiterId}": false,
//         }
//       });
//       await sendchatcountupdate();
//       return await channel.doc(id).get();
//     } else {
//       return channellist.docs.first;
//     }
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
//     final currentprofileinfo = Get.find<CandidateEditMainProfileController>();
//     await currentprofileinfo.getProfileInfo();
//     var user = await FirebaseFirestore.instance.collection("user");
//     await user.doc(currentprofileinfo.profileInfoList[0].sId.toString()).update({
//       "active": active,
//       "user": currentprofileinfo.profileInfoList[0].toJson()
//     });
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

//   Future imageupload(String imgpath, String messageid, String channelid,
//       ChatMessage msg) async {
//     var channel = await FirebaseFirestore.instance.collection("channel");

//     var url = await Httphelp()
//         .imageupload(ENDPOINT_URL: AppConstants.imgupload, imgpath: imgpath);
//     msg.medias![0] = ChatMedia(
//         url: url,
//         fileName: msg.medias![0].fileName,
//         type: msg.medias![0].type,
//         customProperties: {"type": "img"},
//         isUploading: false,
//         uploadedDate: DateTime.now());
//     channel.doc(channelid).collection("message").doc(messageid).update({
//       "medias": FieldValue.arrayUnion(List.generate(
//           msg.medias!.length, (index) => msg.medias![index].toJson()))
//     });
//   }

//   Future requestmessageupdate(
//       {required String messageid, required String channelid}) async {
//     await FirebaseFirestore.instance
//         .collection("channel")
//         .doc(channelid)
//         .collection("message")
//         .doc(messageid)
//         .update({
//       "customProperties": {"request": 1}
//     });
//   }

//   Future ntftokenget(String userid) async {
//     var token = await FirebaseFirestore.instance.collection("token");
//     var data = await token.doc(userid).get();
//     return data['token'];
//   }

//   Future sendresumecuntupdate() async {
//     await Httphelp().getdata(ENDPOINT_URL: "/seekers/sent/resume/count");
//   }

//   Future sendchatcountupdate() async {
//     await Httphelp().getdata(ENDPOINT_URL: "/seekers/chat/count");
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

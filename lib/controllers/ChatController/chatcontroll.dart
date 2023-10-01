import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:bringin/Http/get.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/utils/services/keys.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../Hive/hive.dart';
import '../../Socket/socket.dart';
import '../../models/Chat/channelinfo.dart';
import '../../models/Chat/messagelist.dart';
import '../../res/constants/app_constants.dart';
import '../candidate_section/candidate_edit_main_profile_controller.dart';
import '../recruiter_section/recruiter_edit_main_profile_controller.dart';

class ChatControll extends GetxController with WidgetsBindingObserver {
  List<Messagelist> messageslist = [];
  List<ChatMessage> messages = [];
  String currentuserid = "";
  DateTime todaydate = DateTime.now();
  String? currentchannelid = null;
  List<ChannelInfo> chanellist = [];
  List<ChannelInfo> outboundlist = [];
  List<ChannelInfo> rejectlist = [];
  List<ChannelInfo> recruiter_today_conv = [];
  bool seekerblock = false;
  bool recruiterblock = false;
  ScrollController scrollController = ScrollController();
  bool channellistloading = true;
  bool messagelistloading = true;

  StreamSocket streamSocket = StreamSocket();

  Socket socket = io(
      AppConstants.socket,
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build());

  String? text;

  ChannelInfo? singlechannel;

  Future sokcetconnet() async {
    socket = io(
        AppConstants.socket,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.onConnect((_) {
      print('connect');
    });

    socket.on('channel', (channelid) {
      print(channelid);
    });
    socket.on("singlemsg", (data) {
      Messagelist messages2 = Messagelist.fromJson(data);
      messages.add(ChatMessage.fromJson(messages2.message!.toJson()));
      update();
    });
    socket.on("messagelist", (data) {
      messagelistloading = true;
      messageslist = messagelistFromJson(jsonEncode(data));
      messages.clear();
      messageslist.forEach(
        (element) {
          messages.add(ChatMessage.fromJson(element.message!.toJson()));
        },
      );
      update();
    });
    socket.on("block_user", (data) {
      seekerblock = data['seekerblock'];
      recruiterblock = data['recruiterblock'];
      update();
    });

    int differ(ChannelInfo element) {
      gettoday();
      DateTime today = DateTime(todaydate.year, todaydate.month, todaydate.day);
      DateTime msgdate = DateTime(element.recruitermsgdate!.year,
          element.recruitermsgdate!.month, element.recruitermsgdate!.day);
      return msgdate.difference(today).inDays;
    }

    socket.on("channellist", (data) {
     
      chanellist = channelInfoFromJson(jsonEncode(data));
      if (HiveHelp.read(Keys.isRecruiter)) {
        recruiter_today_conv = chanellist.where((element) {
          return element.recruitermsgdate != null &&
              element.lastmessage != null &&
              differ(element) == 0;
        }).toList();
        rejectlist = chanellist
            .where((element) =>
                element.type == 1 && element.recruiterReject == true)
            .toList();
        outboundlist =
            chanellist.where((element) => element.outbound == true).toList();
        // print('ashjcvaschv ${recruiter_today_conv}');
      }
      update();
    });

    socket.on("channellistloading", (data) {
      channellistloading = data;
      update();
    });

    socket.on("messagelistloading", (data) {
      messagelistloading = data;
      update();
    });
  }

  Future loadrecruiterchannel() async {
    var mapdata = {"isrecruiter": true, "currentid": currentuserid};
    socket.emit("channellist", mapdata);
  }

  void messageadd(ChatMessage message2) {
    messages.add(message2);
    update();
  }

  void leavechannel(String? channelid) {
    socket.emit("leave", channelid);
  }

  void channelconnect({String? channelid}) {
    socket.emit("channel", channelid);
  }

  void channellistevent() {
    var mapdata = {
      "isrecruiter": HiveHelp.read(Keys.isRecruiter),
      "currentid": currentuserid
    };
    socket.emit("channellist", mapdata);
  }

  Future<ChannelInfo> channelcreate(String seekerid, String recruiterid,
      String? jobid, String? candidate_fullprofile, bool outbound) async {
    var channeldata =
        await Httphelp.post(ENDPOINT_URL: "/channelcreate", fields: {
      "seekerid": seekerid,
      "recruiterid": recruiterid,
      "jobid": jobid,
      "candidate_fullprofile": candidate_fullprofile,
      "outbound": outbound
    });
    print("ahscbajshc ${channeldata.body}");
    return ChannelInfo.fromJson(jsonDecode(channeldata.body));
  }

  Future<ChannelInfo> singlechannelinfo(String channelid) async {
    var channeldata = await Httphelp.get(
      ENDPOINT_URL: "/single_channelinfo?channelid=${channelid}",
    );

    return ChannelInfo.fromJson(jsonDecode(channeldata.body));
  }

  Future messagelist(String channelid) async {
    socket.on("oldmessage${channelid}", (data) {
      print(data);
      text = """${jsonEncode(data)}""";
      messageslist = messagelistFromJson(jsonEncode(data));
      messages.clear();
      messageslist.forEach(
        (element) {
          messages.add(ChatMessage.fromJson(element.message!.toJson()));
        },
      );
    });
    update();
  }

  Future getsinglemessage() async {}

  Future getcurrentuserid() async {
    if (HiveHelp.read(Keys.isRecruiter) == false) {
      await Get.find<CandidateEditMainProfileController>().getProfileInfo();
    } else {
      await Get.find<RecruiterEditMainProfileController>()
          .getRecruiterProfileInfoList();
    }
    currentuserid = HiveHelp.read(Keys.currentuserid);
    bool isrecruiter = HiveHelp.read(Keys.isRecruiter);
    useractive();

    // _sub = channellist.listen((event) {
    //   chanellist = event;
    //   if (isrecruiter) {
    //     recruiter_today_conv = event
    //         .where((element) =>
    //             element.recruitermsgdate != null &&
    //             DateTime(
    //                     element.recruitermsgdate!.year,
    //                     element.recruitermsgdate!.month,
    //                     element.recruitermsgdate!.day) ==
    //                 DateTime(todaydate.year, todaydate.month, todaydate.day))
    //         .toList();
    //   }
    //   update();
    // });
    update();
  }

  // late final Stream<List<ChannelInfo>> channellist =
  //     Stream.periodic(const Duration(seconds: 2), (count) {
  //   return loadchannel();
  // }).asyncMap((event) async => await event);

  // late StreamSubscription<List<ChannelInfo>> _sub;

  // Stream<List<ChannelInfo>> loadallchanel() async* {
  //   yield await loadchannel();
  // }

  // Future<List<ChannelInfo>> loadchannel() async {
  //   var data = await Httphelp.get(
  //       ENDPOINT_URL:
  //           "/channellist?userid=${currentuserid}&seeker=${HiveHelp.read(Keys.isRecruiter)}");
  //   return channelInfoFromJson(data.body);
  // }

  Future sendmessageupdate({required String msgid}) async {
    await Httphelp.post(
        ENDPOINT_URL: "/message_update", fields: {"messageid": msgid});
  }

  void blockget(bool _seekerblock, bool _recruiterblock) {
    seekerblock = _seekerblock;
    recruiterblock = _recruiterblock;
    update();
  }

  Future candidate_reject(String candidateid) async {
    var data = await Httphelp.post(
        ENDPOINT_URL: "/candidate_reject",
        fields: {"candidateid": candidateid});
    loadrecruiterchannel();
    Helpers.showAlartMessage(msg: jsonDecode(data.body)['message']);
  }

  Future recruiterdateupdate(String channelid) async {
    await Httphelp.get(
        ENDPOINT_URL: "/recruiter_msg_date?channelid=${channelid}");
  }

  Future gettoday() async {
    var data = await Httphelp.get(ENDPOINT_URL: "/datetime");
    print("datetime ${data.body}");
    todaydate = DateTime.fromMillisecondsSinceEpoch(jsonDecode(data.body));
    update();
  }

  // cv send count

  Future cvsendcount() async {
    await Httphelp.get(ENDPOINT_URL: "/cv_send_count");
  }

  Future cvsendstore({String? recruiterid}) async {
    await Httphelp.get(
        ENDPOINT_URL: "/cv_send_store?recruiterid=${recruiterid}");
  }

  // Future streamclose() async {
  //   _sub.cancel();
  //   update();
  // }

  // Future streamload() async {
  //   getcurrentuserid();
  // }

  void useractive() {
    currentuserid = HiveHelp.read(Keys.currentuserid);
    print(currentuserid);
    bool isrecruiter = HiveHelp.read(Keys.isRecruiter);
    socket
        .emit("active", {"isrecruiter": isrecruiter, "userid": currentuserid});
    if (isrecruiter && currentchannelid != null) {
      socket.emit("recruiter_join", currentchannelid);
    } else if (!isrecruiter && currentchannelid != null) {
      socket.emit("seeker_join", currentchannelid);
    }
  }

  Future userinactive() async {
    currentuserid = HiveHelp.read(Keys.currentuserid);
    print("sacasjcajvsc ${currentuserid}");
    bool isrecruiter = HiveHelp.read(Keys.isRecruiter);
    socket.emit(
        "inactive", {"isrecruiter": isrecruiter, "userid": currentuserid});
    if (isrecruiter && currentchannelid != null) {
      socket.emit("recruiter_leave", currentchannelid);
    } else if (!isrecruiter && currentchannelid != null) {
      socket.emit("seeker_leave", currentchannelid);
    }
  }

  void setcurrentchannelid(String? id) {
    currentchannelid = id;
  }

  String dateformet(DateTime date) {
    DateTime today = DateTime.now();
    int differ = today.difference(date.toLocal()).inDays;

    if (differ < 1) {
      return DateFormat("HH:mm").format(date.toLocal());
    } else if (differ > 0 && differ < 2) {
      return "Yesterday";
    } else if (differ > 1) {
      return DateFormat("dd/MM/yy").format(date.toLocal());
    } else {
      return DateFormat("HH:mm").format(date.toLocal());
    }
  }

  Future bringin_assistent_generate() async {
    if (HiveHelp.read(Keys.isRecruiter) == false) {
      await Get.find<CandidateEditMainProfileController>().getProfileInfo();
    } else {
      await Get.find<RecruiterEditMainProfileController>()
          .getRecruiterProfileInfoList();
    }
    currentuserid = HiveHelp.read(Keys.currentuserid);
    bool isrecruiter = HiveHelp.read(Keys.isRecruiter);
    var mapdata = {"id": currentuserid, "isrecruiter": isrecruiter};
    socket.emit("assistent_create", mapdata);
  }

  int timestempsformet(int timestemp) {
    DateTime offlinedate =
        DateTime.fromMicrosecondsSinceEpoch(timestemp * 1000);
    DateTime today = DateTime.now();
    DateTime current = DateTime(today.year, today.month, today.day);
    DateTime userffline =
        DateTime(offlinedate.year, offlinedate.month, offlinedate.day);

    // int diffsec = current.difference(offlinedate).inSeconds;
    // int diffminute = current.difference(offlinedate).inMinutes;
    // int diffhour = current.difference(offlinedate).inHours;
    int diffday = current.difference(userffline).inDays;
    // if (diffminute < 1) {
    //   return "Active ${diffsec} sec ago";
    // } else if (diffhour < 1) {
    //   return "Active ${diffminute} mins ago";
    // } else if (diffday < 1) {
    //   return "Active ${diffhour} hour ago";
    // } else if (diffhour > 1 && diffhour < 2) {
    //   return "Yesterday";
    // } else {
    //   return "Active ${diffday} day ago";
    // }
    return diffday;
  }

  final player = AudioPlayer();

  // Future soundplay() async {
  //   await player.play(AssetSource("Send_2.mp3"));
  // }

  // Future receiveplay() async {
  //   await player.play(AssetSource("Recieve_2.mp3"));
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("ahsjcajshcv ${state}");
    if (state == AppLifecycleState.resumed) {
      useractive();
    } else {
      userinactive();
    }
    print('state = $state');
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    gettoday();
    sokcetconnet();
    // getcurrentuserid();
    super.onInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // _sub.cancel();
    super.dispose();
  }
}

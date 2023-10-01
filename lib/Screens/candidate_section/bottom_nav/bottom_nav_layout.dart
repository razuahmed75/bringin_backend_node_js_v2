import 'package:bringin/controllers/both_category/bottom_nav_controller.dart';
import 'package:bringin/controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
// import 'package:bringin/utils/services/pop_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../../Hive/hive.dart';
import '../../../controllers/ChatController/chatcontroll.dart';
import '../../../controllers/FilterControll/filter_controller.dart';
import '../../../controllers/both_category/push_notification_controller.dart';
import '../../../controllers/candidate_section/resume_management_controller.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/image_path.dart';
import '../../../res/dimensions.dart';
import '../../../utils/services/keys.dart';
import '../../messages/candidate_message/Chat/Inbox/chatscreen.dart';
import '../../messages/candidate_message/message_page.dart';
import '../../messages/recruiter_message/Inbox/inbox.dart';
import '../../messages/recruiter_message/recruiter_message_page.dart';
import '../../recruiter_section/job_details_screen.dart';
import '../../recruiter_section/recruiter_main_profile/recruiter_main_profile_screen.dart';
import 'candidate_main_profile/candidate_main_profile_screen.dart';
import 'candidates/candidates_screen.dart';
import 'jobs/jobs_screen.dart';

PageController pageController = PageController(initialPage: 0);
int pageindex = 0;

refreshBottomNavIndex() {
  pageindex = 0;
  pageController = PageController(initialPage: 0);
}

class BottomNavLayout extends StatefulWidget {
  const BottomNavLayout({super.key});

  @override
  State<BottomNavLayout> createState() => _BottomNavLayoutState();
}

class _BottomNavLayoutState extends State<BottomNavLayout> {
  var resumeControll = Get.put(ResumeManagementController());
  FilterControll filterControll = Get.put(FilterControll());
  bool isRecruiter = HiveHelp.read(Keys.isRecruiter);

  ChatControll chatControll = Get.put(ChatControll());

  BottomNavController _bottomNavController = Get.find();

  late List widgetOptions = [
    isRecruiter ? CandidatesScreen() : JobScreen(),
    isRecruiter ? RecuiterMessageScreen() : MessageScreen(),
    isRecruiter ? RecruiterMainProfileScreen() : CandidateMainProfileScreen(),
  ];

  /// BOTTOM NAV TEXT LIST
  late List<String> textList = <String>[
    isRecruiter ? "Candidates" : "Get Jobs",
    "Chats",
    "My Profile",
  ];

  /// BOTTOM NAV ICON LIST
  late List<String> iconList = <String>[
    isRecruiter ? AppImagePaths.candidates : AppImagePaths.jobsIcon,
    AppImagePaths.messageIcon,
    AppImagePaths.profile_icon,
  ];

  /// ICON LIST WHEN PRESS ON IT
  late List<String> iconList1 = <String>[
    isRecruiter ? AppImagePaths.candidates1 : AppImagePaths.jobs1,
    AppImagePaths.message1Icon,
    AppImagePaths.profile_icon1,
  ];

  void payload() {
    OneSignal.Notifications.addClickListener((openedResult) async {
      print("sjhdvcjshdvsd ${openedResult.notification.additionalData}");

      if (openedResult.notification.additionalData!['recruiter'] == false &&
          openedResult.notification.additionalData!['type'] == 1) {
        if (HiveHelp.read(Keys.isRecruiter) == true) {
          var data = await chatControll.singlechannelinfo(
              openedResult.notification.additionalData!['channelid']);
          chatControll.channelconnect(channelid: data.id);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecruiterChatScreen(data: data)));
        }
      } else if (openedResult.notification.additionalData!['recruiter'] ==
              true &&
          openedResult.notification.additionalData!['type'] == 1) {
        if (HiveHelp.read(Keys.isRecruiter) == false &&
            chatControll.socket.connected) {
          var data = await chatControll.singlechannelinfo(
              openedResult.notification.additionalData!['channelid']);
          print("asjhcajschv ${data.lastmessage!.message!.text}");
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ));
          chatControll.channelconnect(channelid: data.id);
          Get.to(SeekerChatScreen(
            data: data,
            notifi: true,
          ));
        }
      } else if (HiveHelp.read(Keys.isRecruiter) == false &&
          openedResult.notification.additionalData!['type'] == 2) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JobDetailsScreen(
                    jobid:
                        openedResult.notification.additionalData!['jobid'])));
      }
    });
  }

  @override
  void initState() {
    chatControll.getcurrentuserid();
    chatControll.gettoday();
    chatControll.bringin_assistent_generate();
    // chatControll.useractive();
    // chatControll.sokcetconnet();
    // if (chatControll.socket.disconnected) {
    //   chatControll.socket.disconnect();
    //   chatControll.sokcetconnet();
    // }
    print(HiveHelp.read(Keys.authToken));
    if (pageindex == 0) {
      PushNotificationController.to.getUserId();
      // PushNotificationController.to.pushNotification(
      //   fields: {
      //     "isrecruiter": isRecruiter,
      //     "pushnotification": PushNotificationController.to.userId == null ? "" : PushNotificationController.to.userId,
      //   }
      // );
    }
    payload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isRecruiter = HiveHelp.read(Keys.isRecruiter);

    return WillPopScope(
      onWillPop: () async {
        var data = await _bottomNavController.showwarning(context);
        return data!;
        //  return PopApp.onWillPop();
      },
      child: GestureDetector(
        child: Scaffold(
          // body: Obx(
          //     () => widgetOptions[_bottomNavController.selectedIndex.value]),
          body: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            itemCount: widgetOptions.length,
            itemBuilder: (context, index) {
              return widgetOptions[index];
            },
          ),
          bottomNavigationBar: SafeArea(
            child: Ink(
              color: AppColors.whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  iconList.length,
                  (index) {
                    return GetBuilder<BottomNavController>(builder: (_) {
                      return InkResponse(
                        onTap: () {
                          chatControll.channellistevent();
                          pageController.jumpToPage(index);
                          pageindex = index;
                          if (isRecruiter == false) {
                            if (index == 2 &&
                                resumeControll.uploadresumelist.isEmpty) {
                              resumeControll.getallresume();
                            }
                          } else {
                            if (index == 2) {
                              RecruiterEditMainProfileController.to
                                  .getRecruiterProfileInfoList();
                            }
                          }
                          setState(() {});
                        },
                        splashColor: AppColors.mainColor.withOpacity(.2),
                        highlightColor: AppColors.mainColor.withOpacity(.3),
                        radius: 27,
                        child: Ink(
                          padding: EdgeInsets.symmetric(
                              horizontal: width(
                                isRecruiter ? 15 : 34,
                              ),
                              vertical: height(11)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              index == 1
                                  ? SvgPicture.asset(
                                      pageindex == index
                                          ? iconList1[index]
                                          : iconList[index],
                                      width: height(20),
                                      height: height(20),
                                    )
                                  : SvgPicture.asset(
                                      pageindex == index
                                          ? iconList1[index]
                                          : iconList[index],
                                      width: height(20),
                                      height: height(20),
                                    ),
                              SizedBox(height: 3),
                              Text(
                                textList[index],
                                style: Styles.bodySmall1.copyWith(
                                    color: pageindex == index
                                        ? AppColors.mainColor
                                        : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

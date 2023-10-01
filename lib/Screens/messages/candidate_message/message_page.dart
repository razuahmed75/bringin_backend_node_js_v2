import 'package:bringin/Screens/messages/candidate_message/components/candidate_who_saved_me_tab.dart';
import 'package:bringin/Screens/messages/candidate_message/components/candidate_who_viewed_me_tab.dart';
import 'package:flutter/material.dart';
import 'package:nested_scroll_views/material.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/dimensions.dart';
import 'components/candidate_chats_tab.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>{
   final _tabs = ['Chats', 'Interactivity',];
  int _tabIndex = 0;
  TabController? mainTabController;
  TabController? subTabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Builder(builder: (context){
      mainTabController =  DefaultTabController.of(context)..addListener(() { setState(() {}); });
      _tabIndex = mainTabController!.index;
        return Scaffold(
          appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  labelPadding: EdgeInsets.only(left: 15,right: 15),
                  indicatorColor: Colors.transparent,
                  isScrollable: true,
                  tabs: List.generate(_tabs.length, (index) => Tab(
                    child: Text(
                      _tabs[index],
                      style: Styles.smallTitle.copyWith(
                        color: _tabIndex == index ? AppColors.blackColor : AppColors.blackColor.withOpacity(.6),
                        fontWeight: _tabIndex == index ? FontWeight.w800 : FontWeight.w400,
                        fontSize: _tabIndex == index ? font(29) : font(22),
                      ),
                    ),
                  )),
                ),
              ),
            ),
          ),
        ),
        body: NestedTabBarView(
          children: List.generate(_tabs.length, (index) {
            if (index != 0) {
              return DefaultTabController(
                length: 2,
                child: Builder(builder: (context){
                  subTabController = DefaultTabController.of(context)..addListener(() { setState(() {}); });
                  return Column(
                  children: <Widget>[
                    TabBar(
                      indicatorColor: Colors.transparent,
                      tabs: [
                        whoSavedMeTab(),
                        whoViewedMeTab(),
                      ],
                    ),
                    Expanded(
                      child: NestedTabBarView(
                        children: [
                          CandidateWhoSavedMeTab(),
                          CandidateWhoViewedMeTab(),
                        ],
                      ),
                    ),
                  ],
                );
                })
              );
            }
            return CandidateChatsTab();
          }).toList(),
        ),
      );
      })
    );
  }
  Widget whoViewedMeTab() {
    return Container(
                  height: height(25),
                  padding: EdgeInsets.symmetric(horizontal: width(4)),
                  decoration: BoxDecoration(
                    color: subTabController!.index == 1 ? AppColors.mainColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(radius(30)),
                    border: Border.all(
                      color: subTabController!.index == 1 ? Colors.transparent : AppColors.appBorder,
                      width: .5,
                    )
                  ),
                  child: Tab(
                    child: Text(
                      "Who viewed me",
                      style: Styles.bodyMedium1.copyWith(
                        color: subTabController!.index == 1 ? AppColors.whiteColor : AppColors.mainColor
                      ),
                    ),),
                );
  }

  Widget whoSavedMeTab() {
    return Container(
                  height: height(25),
                  padding: EdgeInsets.symmetric(horizontal: width(4)),
                  decoration: BoxDecoration(
                    color: subTabController!.index == 0 ? AppColors.mainColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(radius(30)),
                    border: Border.all(
                      color: subTabController!.index == 0 ? Colors.transparent : AppColors.appBorder,
                      width: .5,
                    )
                  ),
                  child: Tab(
                    child: Text(
                      "Who saved me",
                      style: Styles.bodyMedium1.copyWith(
                        color: subTabController!.index == 0 ? AppColors.whiteColor : AppColors.mainColor
                      ),
                    ),
                  ),
                );
  }
}

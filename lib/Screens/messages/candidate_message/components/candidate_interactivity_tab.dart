// import 'package:bringin/Screens/messages/candidate_message/components/candidate_who_viewed_me_tab.dart';
// import 'package:flutter/material.dart';
// import '../../../../res/app_font.dart';
// import '../../../../res/color.dart';
// import '../../../../res/dimensions.dart';
// import 'candidate_who_saved_me_tab.dart';

// class CandidateInteractivityTab extends StatefulWidget {
//   const CandidateInteractivityTab({super.key});

//   @override
//   State<CandidateInteractivityTab> createState() => _CandidateInteractivityTabState();
// }

// class _CandidateInteractivityTabState extends State<CandidateInteractivityTab>{
//  TabController? dTabController;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Builder(builder: (context){
//         dTabController = DefaultTabController.of(context)..addListener(() {setState(() {});});
//         return Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Theme(
//               data: ThemeData(
//                 splashColor: Colors.transparent,
//                 highlightColor: Colors.transparent,
//               ),
//               child: TabBar(
//                 isScrollable: true,
//                 labelPadding:
//                     EdgeInsets.only(right: width(40), left: width(35)),
//                 indicatorColor: Colors.transparent,
//                 tabs: [
//                   whoSavedMeTab(),
//                   whoViewedMeTab(),
//                 ],
//               ),
//             ),
    
    
//             /// tabbar view
//             Expanded(
//               child: TabBarView(
//                 children: [
//                 CandidateWhoSavedMeTab(),
//                 CandidateWhoViewedMeTab(),
//               ]),
//             ),
//           ],
//         ),
//       );
//       })
//     );
//   }

//   Container whoViewedMeTab() {
//     return Container(
//                   height: height(25),
//                   padding: EdgeInsets.symmetric(horizontal: width(4)),
//                   decoration: BoxDecoration(
//                     color: dTabController!.index == 1 ? AppColors.mainColor : Colors.transparent,
//                     borderRadius: BorderRadius.circular(radius(30)),
//                     border: Border.all(
//                       color: dTabController!.index == 1 ? Colors.transparent : AppColors.appBorder,
//                       width: .5,
//                     )
//                   ),
//                   child: Tab(
//                     child: Text(
//                       "Who viewed me",
//                       style: Styles.bodySmall1.copyWith(
//                         color: dTabController!.index == 1 ? AppColors.whiteColor : AppColors.mainColor
//                       ),
//                     ),),
//                 );
//   }

//   Container whoSavedMeTab() {
//     return Container(
//                   height: height(25),
//                   padding: EdgeInsets.symmetric(horizontal: width(4)),
//                   decoration: BoxDecoration(
//                     color: dTabController!.index == 0 ? AppColors.mainColor : Colors.transparent,
//                     borderRadius: BorderRadius.circular(radius(30)),
//                     border: Border.all(
//                       color: dTabController!.index == 0 ? Colors.transparent : AppColors.appBorder,
//                       width: .5,
//                     )
//                   ),
//                   child: Tab(
//                     child: Text(
//                       "Who saved me",
//                       style: Styles.bodySmall1.copyWith(
//                         color: dTabController!.index == 0 ? AppColors.whiteColor : AppColors.mainColor
//                       ),
//                     ),
//                   ),
//                 );
//   }
// }

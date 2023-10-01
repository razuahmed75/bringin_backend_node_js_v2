
// import 'package:bringin/Screens/messages/recruiter_message/components/recruiter_who_viewed_me_tab.dart';
// import 'package:flutter/material.dart';
// import '../../../../res/app_font.dart';
// import '../../../../res/color.dart';
// import '../../../../res/dimensions.dart';
// import 'recruiter_who_saved_me_tab.dart';

// class RecruiterInteractivityTab extends StatefulWidget {
//   const RecruiterInteractivityTab({super.key});

//   @override
//   State<RecruiterInteractivityTab> createState() => _RecruiterInteractivityTabState();
// }

// class _RecruiterInteractivityTabState extends State<RecruiterInteractivityTab>{
//  TabController? dTabController;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Builder(builder: (context){
//         dTabController = DefaultTabController.of(context)..addListener(() { 
//           setState(() {
            
//           });
//         });
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
//                 RecruiterWhoSavedMeTab(),
//                 RecruiterWhoViewedMeTab(),
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
//       alignment: Alignment.centerRight,
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
//       alignment: Alignment.centerLeft,
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
// // import 'package:flutter/material.dart';

// // class TestWidget extends StatefulWidget {
// //   TestWidget({Key key}) : super(key: key);

// //   @override
// //   _TestWidgetState createState() => _TestWidgetState();
// // }

// // class _TestWidgetState extends State<TestWidget> {
// //   int _selectedIndex = 0;

// //   PageController _pageController;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _pageController = PageController();
// //   }

// //   @override
// //   void dispose() {
// //     _pageController.dispose();
// //     super.dispose();
// //   }

// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Tab Bar"),
// //       ),
// //       body: Center(
// //         child: Column(
// //           children: <Widget>[ 
// //             Expanded(
// //               flex: 10,
// //               child: ButtonBar(
// //                 alignment: MainAxisAlignment.center,
// //                 children: <Widget>[
// //                   MaterialButton(
// //                     splashColor: Colors.blueAccent,
// //                     color: Colors.blue,
// //                     onPressed: () {
// //                       _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
// //                     },
// //                     child: Text("One",),
// //                   ),
// //                   MaterialButton(
// //                     splashColor: Colors.blueAccent,
// //                     color: Colors.blue,
// //                     onPressed: () {
// //                       _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
// //                     },
// //                     child: Text("Two",),
// //                   ),
// //                   MaterialButton(
// //                     splashColor: Colors.blueAccent,
// //                     color: Colors.blue,
// //                     onPressed: () {
// //                       _pageController.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.ease);
// //                     },
// //                     child: Text("Three",),
// //                   )
// //                 ],
// //               ),
// //             ),
// //             Expanded(
// //               flex: 40,
// //               child: PageView(
// //                 controller: _pageController,
// //                 children: [
// //                   Text("Page One"),
// //                   Text("Page Two"),
// //                   Text("Page Three")
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

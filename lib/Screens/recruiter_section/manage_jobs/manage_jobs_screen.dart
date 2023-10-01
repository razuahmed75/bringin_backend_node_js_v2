
import 'package:bringin/res/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../res/app_font.dart';
import '../../../res/color.dart';
import 'components/all.dart';
import 'components/closed_tab.dart';
import 'components/opening_tab.dart';
import 'components/rejected_tab.dart';

class ManageJobsScreen extends StatefulWidget {
  const ManageJobsScreen({super.key});

  @override
  State<ManageJobsScreen> createState() => _ManageJobsScreenState();
}

class _ManageJobsScreenState extends State<ManageJobsScreen> {

 late PageController _pageController;
 int _selectedIndex = 0;
 @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Manage Jobs",
            style: Styles.smallTitle,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(height(50)),
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                /// ALL TAB
                GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Ink(
                  padding: EdgeInsets.symmetric(
                    horizontal: width(10),
                    vertical: height(10),
                  ),
                  child: Text(
                    "All",
                    style: Styles.bodyMedium2.copyWith(
                          color: _selectedIndex == 0 ? AppColors.blackColor:Colors.grey.shade400,
                          fontWeight: _selectedIndex == 0 ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
              ),

                /// OPENING TAB
                GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Ink(
                  padding: EdgeInsets.symmetric(
                    horizontal: width(15),
                    vertical: height(10),
                  ),
                  child: Text(
                    "Opening",
                    style: Styles.bodyMedium2.copyWith(
                          color: _selectedIndex == 1 ? AppColors.blackColor:Colors.grey.shade400,
                          fontWeight: _selectedIndex == 1 ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
              ),

                /// CLOSED TAB
                GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    2,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
                child: Ink(
                  padding: EdgeInsets.symmetric(
                    horizontal: width(15),
                    vertical: height(10),
                  ),
                  child: Text(
                    "Closed",
                    style: Styles.bodyMedium2.copyWith(
                          color: _selectedIndex == 2 ? AppColors.blackColor:Colors.grey.shade400,
                          fontWeight: _selectedIndex == 2 ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
                
                /// REJECTED TAB
                GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    3,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
                child: Ink(
                  padding: EdgeInsets.symmetric(
                    horizontal: width(10),
                    vertical: height(10),
                  ),
                  child: Text(
                    "Rejected",
                    style: Styles.bodyMedium.copyWith(
                          color: _selectedIndex == 3 ? AppColors.blackColor:Colors.grey.shade400,
                          fontWeight: _selectedIndex == 3 ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (val){
            setState(() {
              _selectedIndex = val;
            });
          },
          children: [
          AllJob(),
          OpeningTab(),
          ClosedTab(),
          RejectedTab(),
        ]),
      ),
    );
  }
}

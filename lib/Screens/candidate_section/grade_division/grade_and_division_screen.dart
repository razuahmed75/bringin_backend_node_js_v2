// ignore_for_file: must_be_immutable, unused_element

import 'dart:developer';

import 'package:bringin/controllers/candidate_section/education_controller.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../Hive/hive.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/dimensions.dart';
import '../../../utils/services/keys.dart';
import '../../../widgets/app_bar.dart';
import 'components/tabbar_tile.dart';

class GradeAndDivisionScreen extends StatefulWidget {
   GradeAndDivisionScreen({super.key});

  @override
  State<GradeAndDivisionScreen> createState() => _GradeAndDivisionScreenState();
}

class _GradeAndDivisionScreenState extends State<GradeAndDivisionScreen> {
EducationController educationCtrlr = Get.find();
  var selectedGradeIndex;
  var selectedDivisionIndex;
  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
            tabController = DefaultTabController.of(context);

          tabController.addListener(() {
            educationCtrlr.tabControllerIndex = tabController.index;
            print(educationCtrlr.tabControllerIndex); 
            setState(() {
              
            });
          });
          return Scaffold(
            appBar: appBarWidget(
                title: "", 
                onBackPressed: () => Get.back(), 
                onSavedPressed: () {
                  /// if the result type is grade
                  if(HiveHelp.read(Keys.isGradeSelected) == true){
                     if(educationCtrlr.gradeTextFieldController.text.isEmpty || educationCtrlr.userResultFormate.value.isEmpty){
                      Helpers().showToastMessage(
                      msg: "Please select CGPA/GPA",
                      gravity: ToastGravity.CENTER,
                    );
                     }else{
                      educationCtrlr.selectedDivisionValue.value = "";
                      educationCtrlr.selectedGradeValue.value = educationCtrlr.gradeTextFieldController.text.trim();
                      educationCtrlr.userResultFormate.value;
                      print("press grade format: "+educationCtrlr.userResultFormate.value);
                      print("press grade selectedGrade: "+educationCtrlr.selectedGradeValue.value);
                      print("press grade: "+educationCtrlr.selectedDivisionValue.value);
                      Get.back();
                     }
                  }
                  /// if the isGradeSelected value is null
                  else if(HiveHelp.read(Keys.isGradeSelected) == null){
                    Helpers().showToastMessage(
                      msg: "Please select your grade or division",
                      gravity: ToastGravity.CENTER,
                    );
                  }
                  /// if the result type is division
                  else{
                    /// clear the grade value
                    educationCtrlr.selectedGradeValue.value = "";
                    educationCtrlr.gradeTextFieldController.clear();
                    educationCtrlr.userResultFormate.value = "";

                    educationCtrlr.selectedDivisionValue.value;
                    print("press division format: "+educationCtrlr.userResultFormate.value);
                    log("press division selectedDivision: "+educationCtrlr.selectedDivisionValue.value);
                    Get.back();
                  }
                    
                }
              ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimensions.kDefaultgapTop,

                /// tabbar
                Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: TabBar(
                    isScrollable: true,
                    labelPadding: Dimensions.kDefaultPadding,
                    indicatorColor: Colors.transparent,
                    labelColor: AppColors.blackColor,
                    unselectedLabelColor: AppColors.hintColor,
                    labelStyle: Styles.smallTitle.copyWith(fontWeight: FontWeight.w500),
                    splashBorderRadius: BorderRadius.circular(radius(6)),
                    unselectedLabelStyle: Styles.smallTitle.copyWith(fontWeight: FontWeight.w400),
                    tabs: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: height(1),horizontal: width(25)),
                         decoration: BoxDecoration(
                           border: Border.all(
                            color:  AppColors.borderColor,
                            width: .2,
                           ),
                          borderRadius: BorderRadius.circular(radius(9)),
                         ),
                          child: Tab(text: "Grade")),
                       Container(
                        padding: EdgeInsets.symmetric(vertical: height(1),horizontal: width(25)),
                         decoration: BoxDecoration(
                          color:  AppColors.whiteColor,
                           border: Border.all(
                            color:  AppColors.borderColor ,
                            width: .2,
                           ),
                          borderRadius: BorderRadius.circular(radius(9)),
                         ),
                        child: Tab(text: "Division")),
                    ],
                  ),
                ),
                const Gap(20),

                /// tabbar view
                Container(
                  height: height(200),
                  width: double.infinity,
                  margin: Dimensions.kDefaultPadding,
                  child: TabBarView(
                    children: [
                      TabbarTile(
                          onChanged: ( int? index){
                            setState(() {
                              selectedGradeIndex = index;
                              educationCtrlr.userResultFormate.value = educationCtrlr.gradeList[index!];
                              HiveHelp.write(Keys.isGradeSelected,true);
                              print("isGrade: "+ HiveHelp.read(Keys.isGradeSelected).toString());
                            });
                            print("From grade: "+ educationCtrlr.userResultFormate.value);
                          },
                          dropDownList: educationCtrlr.gradeList,
                          isGrade: true,
                          gradeHint: "Select Grade",
                          selectedValue: selectedGradeIndex,
                        ),
                      TabbarTile(
                          onChanged: ( int? index){
                            setState(() {
                              selectedDivisionIndex = index;
                              HiveHelp.write(Keys.isGradeSelected,false);
                              print("isGrade: "+ HiveHelp.read(Keys.isGradeSelected).toString());
                            });
                              educationCtrlr.selectedDivisionValue.value = educationCtrlr.divisionList[index!];
                              print("From division: "+educationCtrlr.selectedDivisionValue.value);
                          },
                          dropDownList: educationCtrlr.divisionList,
                          isGrade: false,
                          divisionHint: "Select Division",
                          selectedValue: selectedDivisionIndex,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

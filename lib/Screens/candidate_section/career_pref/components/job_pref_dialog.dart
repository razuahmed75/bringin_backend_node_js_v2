
import 'dart:developer';
import 'package:bringin/models/candidate_section/candidate_job_pref_sec/job_type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../controllers/candidate_section/candidate_career_pref_controller.dart';
import '../../../../../../res/app_font.dart';
import '../../../../../../res/color.dart';
import '../../../../../../res/dimensions.dart';
import '../../../../../../widgets/header_widget.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../widgets/cupertino_picker_middle_divider.dart';

class CareerPrefDialog {
  static CandidateCareerPrefController _candidateJobPrefController = Get.find();
  static var jobTypeVal = "";
  static var minSalaryVal = "";
  static var maxSalaryVal = "";
  static var currencyVal = "";
  static var minSalaryId = "";
  static var maxSalaryId = "";
  static var jobTypeId = "";

  /// JOB TYPE
  static Future<dynamic> buildJobType(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        insetPadding: EdgeInsets.zero,
        elevation: 0,
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: Dimensions.kDefaultPadding,
                margin: EdgeInsets.only(top: height(12)),
                child: HeaderWidget(
                  onBackPressed: () => Get.back(),
                  onSavePressed: () {
                    _candidateJobPrefController.jobTypeVal.value = jobTypeVal;
                    _candidateJobPrefController.jobTypeId.value = jobTypeId;
                    print(_candidateJobPrefController.jobTypeVal.value);
                    print(_candidateJobPrefController.jobTypeId.value);
                    Get.back();
                  },
                  margin: EdgeInsets.zero,
                  middleText: "Job Type",
                  isArrow: false,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  /// slider element
                  Obx(
                    () => _candidateJobPrefController.isLoading.value
                        ? SizedBox(
                            width: double.maxFinite,
                            height: height(230),
                            child: Stack(
                              children: [
                                Helpers.appLoader(heights: Dimensions.screenHeight*.5)
                              ],
                            ))
                        : _candidateJobPrefController.jobTypeList.isEmpty
                            ? Text("Not Found")
                            : Container(
                                width: double.maxFinite,
                                height: height(230),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(radius(20)),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: Dimensions.screenWidth-140,
                                      margin: EdgeInsets.only(bottom: height(20),top: height(10)),
                                      decoration: BoxDecoration(
                                        // color: AppColors.mainColor.withOpacity(.25),
                                      borderRadius:
                                          BorderRadius.circular(radius(20)),
                                    ),
                                      child: ListWheelScrollView(
                                        perspective: 0.01,
                                        itemExtent: 33,
                                        useMagnifier: true,
                                        magnification: 1.2,
                                        controller: FixedExtentScrollController(
                                            initialItem: _candidateJobPrefController
                                                .jobTypeSelectedIndex.value),
                                        physics: FixedExtentScrollPhysics(),
                                        onSelectedItemChanged: (int index) {
                                          _candidateJobPrefController
                                              .jobTypeSelectedIndex.value = index;
                                          jobTypeVal = _candidateJobPrefController
                                              .jobTypeList[index].worktype!;
                                          jobTypeId = _candidateJobPrefController
                                              .jobTypeList[index].sId!;
                                        },
                                        children: _candidateJobPrefController
                                            .jobTypeList
                                            .map((JobTypeModel e) {
                                          jobTypeVal = _candidateJobPrefController
                                              .jobTypeList[
                                                  _candidateJobPrefController
                                                      .jobTypeSelectedIndex.value]
                                              .worktype!;
                                          jobTypeId = _candidateJobPrefController
                                              .jobTypeList[
                                                  _candidateJobPrefController
                                                      .jobTypeSelectedIndex.value]
                                              .sId!;
                                          return Text(
                                            e.worktype ?? "",
                                            style: Styles.bodyLargeMedium.copyWith(
                                              fontWeight: _candidateJobPrefController
                                                          .jobTypeList
                                                          .indexOf(e) ==
                                                      _candidateJobPrefController
                                                          .jobTypeSelectedIndex
                                                          .value
                                                  ? FontWeight.w500
                                                  : FontWeight.w400,
                                              color: _candidateJobPrefController
                                                          .jobTypeList
                                                          .indexOf(e) ==
                                                      _candidateJobPrefController
                                                          .jobTypeSelectedIndex
                                                          .value
                                                  ? AppColors.blackColor
                                                  : AppColors.blackOpacity70,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: height(20)),
                                      child: CuperTinoMiddleDivider(
                                        color: AppColors.whiteColor,
                                        topDvdrMrgnBtm: 18,
                                        btmDvdrMrgnTop: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                  ),

                  /// middle indicator box
                  // CuperTinoMiddleDivider(
                  //   // topDvdrMrgnBtm: 50,
                  //   // btmDvdrMrgnTop: 0.0,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// expected salary
  static buildExpectedSalaryShit({context,bool? isFromJobPost = false}) {
    Get.bottomSheet(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius(18))),
        ),
        Container(
          width: width(300),
          height: height(300),
          child: Column(
            children: [
              /// header
              HeaderWidget(
                onBackPressed: () => Get.back(),
                onSavePressed: () {
                  _candidateJobPrefController.minSalaryVal.value = minSalaryVal;
                  _candidateJobPrefController.maxSalaryVal.value = maxSalaryVal;
                  _candidateJobPrefController.currencyVal.value = currencyVal;
                  _candidateJobPrefController.minSalaryId.value = minSalaryId;
                  _candidateJobPrefController.maxSalaryId.value = maxSalaryId;
                  log(_candidateJobPrefController.minSalaryVal.value);
                  log(_candidateJobPrefController.maxSalaryVal.value);
                  log("minId: "+ _candidateJobPrefController.minSalaryId.value);
                  log("maxId: "+ _candidateJobPrefController.maxSalaryId.value);
                  Get.back();
                },
                middleText: isFromJobPost == true ? "Offered Salary" : "Expected Salary",
                margin: EdgeInsets.symmetric(
                    horizontal: width(22), vertical: height(16)),
                isArrow: false,
              ),
              const Gap(7),

              /// dropdown slider
              Obx(()=>_candidateJobPrefController.isLoading.value ?
               Stack(
                 children: [
                   Helpers.appLoader(heights: Dimensions.screenHeight*.2)
                 ],
               )
            : _candidateJobPrefController.expectedSalaryList.isEmpty
                ? Text("Not Found")
                : Stack(
                    alignment: Alignment.center,
                      children: [
                        Container(
                        height: height(200),
                        width: width(290),
                        decoration: BoxDecoration(
                          // color: AppColors.mainColor.withOpacity(.25),
                        borderRadius:
                            BorderRadius.circular(radius(20)),
                      ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: width(139),
                                child: CupertinoPicker(
                                useMagnifier: true,
                                magnification: 1.3,
                                selectionOverlay: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.whiteColor,
                                      ),
                                      top: BorderSide(
                                        color: AppColors.whiteColor
                                      )
                                    )
                                  ),
                                ),
                                  scrollController: FixedExtentScrollController(initialItem: _candidateJobPrefController.initialMinIndex.value),
                                  itemExtent: height(30),
                                  onSelectedItemChanged: (int index) {
                                  _candidateJobPrefController.initialMinIndex.value = index;
                                   _candidateJobPrefController.mainIndex.value = index;
                                   minSalaryId = _candidateJobPrefController.expectedSalaryList[index].id!;
                                   minSalaryVal = _candidateJobPrefController.expectedSalaryList[index].salary.toString()+"K";
                                   currencyVal = _candidateJobPrefController.expectedSalaryList[index].currency.toString();
                                  },
                                  children: List<Widget>.generate(_candidateJobPrefController.expectedSalaryList.length, (int i) {
                                    var minData = _candidateJobPrefController.expectedSalaryList[i];
                                    minSalaryId = _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.initialMinIndex.value].id!;
                                    minSalaryVal = _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.initialMinIndex.value].type == 0 ? _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.initialMinIndex.value].salary : _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.initialMinIndex.value].salary.toString()+"K";
                                    currencyVal = _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.initialMinIndex.value].currency.toString();
                                    return Center(
                                      child: Text(
                                       minData.type == 0 ? minData.salary.toString() :  minData.salary.toString()+minData.simbol.toString(),
                                        style: Styles.bodyMedium1,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              /// middle divider
                              Container(
                                width: width(12),
                                height: height(200),
                                color: AppColors.whiteColor,
                              ),
                              SizedBox(
                                width: width(139),
                                child: CupertinoPicker(
                                useMagnifier: true,
                                magnification: 1.3,
                                selectionOverlay: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.whiteColor,
                                      ),
                                      top: BorderSide(
                                        color: AppColors.whiteColor
                                      )
                                    )
                                  ),
                                ),
                                  scrollController:
                                      FixedExtentScrollController(initialItem: _candidateJobPrefController.initialMaxIndex.value),
                                  itemExtent: height(30),
                                  onSelectedItemChanged: (int index) {
                                  _candidateJobPrefController.initialMaxIndex.value =  index;
                                  maxSalaryId = _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].type == 0 ? _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].otherSalary![0].id! : _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].otherSalary![index].id!;
                                  maxSalaryVal = _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].type == 0 ? _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].otherSalary![0].salary :  _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].otherSalary![index].salary.toString()+"K";
                                  },
                                  children: List<Widget>.generate(_candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].type == 0 ? 1: _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].otherSalary!.length, (int index) {
                                    var maxData = _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].otherSalary![index]; 
                                    if (_candidateJobPrefController.mainIndex.value < _candidateJobPrefController.expectedSalaryList.length) {
                                      var otherSalaryList = _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].otherSalary!;
                                      if (_candidateJobPrefController.initialMaxIndex.value < otherSalaryList.length) {
                                        maxSalaryId = _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].type == 0 ? otherSalaryList[0].id! : otherSalaryList[_candidateJobPrefController.initialMaxIndex.value].id!;
                                        maxSalaryVal = _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].type == 0 ? otherSalaryList[0].salary.toString() : otherSalaryList[_candidateJobPrefController.initialMaxIndex.value].salary.toString() + "K";
                                      }
                                    }
                                    // maxSalaryId = _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].otherSalary![_candidateJobPrefController.initialMaxIndex.value].id!; // range error in this line
                                    // maxSalaryVal = _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].otherSalary![_candidateJobPrefController.initialMaxIndex.value].salary.toString()+"K";
                                    return Center(
                                      child: Text(
                                        _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].type == 0 ? _candidateJobPrefController.expectedSalaryList[_candidateJobPrefController.mainIndex.value].otherSalary![index].salary.toString() : maxData.salary.toString()+maxData.simbol.toString()+" "+maxData.currency.toString(),
                                        style: Styles.bodyMedium1,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              ),
            ],
          ),
        ));
  }
}

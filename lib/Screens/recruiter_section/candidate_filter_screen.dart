import 'package:bringin/controllers/candidate_section/candidate_controll.dart';
import 'package:bringin/res/color.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/widgets/filter_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controllers/candidate_section/job_filter_controller.dart';
import '../../models/recruiter_section/post_candidate_filter_model.dart';
import '../../res/app_font.dart';
import '../../widgets/app_button.dart';

class CandidateFilterScreen extends StatefulWidget {
  const CandidateFilterScreen({super.key});

  @override
  State<CandidateFilterScreen> createState() => _CandidateFilterScreenState();
}

class _CandidateFilterScreenState extends State<CandidateFilterScreen> {
  JobFilterController filterController = Get.find<JobFilterController>();


  @override
  void initState() {
    Get.find<JobFilterController>().getJobFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          width: width(180),
          height: height(38),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(radius(21)),
          ),
          child: Text("Filter", style: Styles.bodyLargeMedium),
        ),
        actions: [
          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)),
          const Gap(20),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Obx(()=> JobFilterController.to.isLoading.value ? 
         Container(
          height: Dimensions.screenHeight*.6,
           child: Center(
            child: CircularProgressIndicator(),
           ),
         ) : Padding(
            padding: Dimensions.kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimensions.kDefaultgapTop,
        
                ///  Workplace Policy
                Text("Workplace Policy",
                    style:
                        Styles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(filterController.workplacePolicy.length,
                        (index) {
                      var wpVal =
                          filterController.workplacePolicy[index].value;
                      var wpKey =
                          filterController.workplacePolicy[index].name;
                      return Obx(
                        () => FilterTileWidget(
                          onTap: () {
                            if (filterController.selectedwpKey.length >= 1) {
                              filterController.selectedwpVal.clear();
                              filterController.selectedwpKey.clear();
                            }
                            if (!filterController.selectedwpKey
                                .contains(wpKey)) {
                              if(wpKey == "All"){
                                filterController.selectedwpVal.addAll(filterController.allWPolicy);
                                filterController.selectedwpKey.add(wpKey);
                              }else{
                                filterController.selectedwpVal.add(wpVal!);
                                filterController.selectedwpKey.add(wpKey);
                              }
                            }
                            filterController.selectedwpVal.refresh();
                            filterController.selectedwpKey.refresh();
                            print(filterController.selectedwpKey);
                            print(filterController.selectedwpVal);
                          },
                          text: wpKey!,
                          tileHeight: 40,
                          tileWidth: 100,
                          textColor:
                              filterController.selectedwpKey.contains(wpKey)
                                  ? AppColors.mainColor
                                  : AppColors.blackColor,
                          borderColor:
                              filterController.selectedwpKey.contains(wpKey)
                                  ? AppColors.mainColor
                                  : AppColors.borderColor.withOpacity(.5),
                          bgColor: index == 0 &&
                                  filterController.selectedwpKey.contains("All")
                              ? Colors.transparent
                              : (filterController.selectedwpKey
                                      .contains(wpKey)
                                  ? AppColors.mainColor.withOpacity(.04)
                                  : AppColors.scaffoldColor),
                        ),
                      );
                    }),
                  ],
                ),
                const Gap(25),
        
                ///  Required Education
                Text("Required Education",
                    style:
                        Styles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                const Gap(20),
                GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 12,
                        childAspectRatio: 5 / 1.3,
                      ),
                      itemCount: filterController.educationList.length,
                      itemBuilder: (BuildContext ctx, i) {
                        String eduVal =
                            filterController.educationList[i].id!;
                        String eduKey =
                            filterController.educationList[i].name!;
                        return Obx(() => FilterTileWidget(
                              onTap: () {
                                if (eduKey == "All") {
                                  if (filterController.selectedEduKey!
                                      .contains("All")) {
                                    filterController.selectedEduKey!.remove("All");
                                    filterController.selectedEduVal!.remove(filterController.allEdu);
                                  }else {
                                    filterController.selectedEduKey!.clear();
                                    filterController.selectedEduVal!.clear();
                                    filterController.selectedEduKey!.add("All");
                                    filterController.selectedEduVal!.addAll(filterController.allEdu);
                                  }
                              }else {
                                if (filterController.selectedEduKey!
                                    .contains("All")) {
                                  filterController.selectedEduKey!.remove("All");
                                  filterController.selectedEduVal!.clear();
                                  filterController.selectedEduKey!
                                      .add(eduKey);
                                  filterController.selectedEduVal!
                                      .add(eduVal);
                                }else {
                                  if(filterController.selectedEduKey!
                                      .contains(eduKey)) {
                                    filterController.selectedEduKey!
                                        .remove(eduKey);
                                    filterController.selectedEduVal!
                                        .remove(eduVal);
                                  }else {
                                    filterController.selectedEduKey!
                                        .add(eduKey);
                                    filterController.selectedEduVal!
                                        .add(eduVal);
                                  }
                                }
                              }
                                filterController.selectedEduKey!.refresh();
                                print(filterController.selectedEduKey);
                                filterController.selectedEduVal!.refresh();
                                print(filterController.selectedEduVal);
                              },
                              text: eduKey,
                              textColor: filterController.selectedEduKey!
                                      .contains(eduKey)
                                  ? AppColors.mainColor
                                  : AppColors.blackColor,
                              bgColor: filterController.selectedEduKey!
                                          .contains(eduKey) &&
                                      !(filterController.selectedEduKey!.contains("All"))
                                  ? AppColors.mainColor.withOpacity(.05)
                                  : eduKey == "All" &&
                                          filterController.selectedEduKey!
                                              .contains("All")
                                      ? Colors.transparent
                                      : AppColors.scaffoldColor,
                              borderColor: filterController.selectedEduKey!
                                      .contains(eduKey)
                                  ? AppColors.mainColor
                                  : AppColors.borderColor.withOpacity(.5),
                            ));
                      }),
                const Gap(15),
        
                /// Offered Salary (Monthly)
                Text("Offered Salary (Monthly)",
                    style:
                        Styles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                const Gap(20),
                 GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 12,
                        childAspectRatio: 5 / 1.3,
                      ),
                      itemCount:
                          filterController.customSalary.length,
                      itemBuilder: (BuildContext ctx, index) {
                        var salaryVal = filterController
                            .customSalary[index].id;
                        var salaryKey = filterController
                            .customSalary[index].salary;
                        return Obx(
                          () => FilterTileWidget(
                            onTap: () {
                              if (filterController.selectedSalaryKey.length >= 1) {
                                filterController.selectedSalaryVal.clear();
                                filterController.selectedSalaryKey.clear();
                              }
                              if (!filterController.selectedSalaryKey
                                  .contains(salaryKey)) {
                                if(filterController.selectedSalaryKey == "All"){
                                  filterController.selectedSalaryVal
                                    .addAll(filterController.allSalary);
                                  filterController.selectedSalaryKey.add("All");
                                }else{
                                  filterController.selectedSalaryVal.add(salaryVal!);
                                  filterController.selectedSalaryKey.add(salaryKey);
                                }
                              }
                              filterController.selectedSalaryVal.refresh();
                              filterController.selectedSalaryKey.refresh();
                              print(filterController.selectedSalaryKey);
                              print(filterController.selectedSalaryVal);
                            },
                            textColor: filterController.selectedSalaryKey
                                    .contains(salaryKey)
                                ? AppColors.mainColor
                                : AppColors.blackColor,
                            bgColor: index == 0 &&
                                    filterController.selectedSalaryKey.contains("All")
                                ? Colors.transparent
                                : filterController.selectedSalaryKey
                                        .contains(salaryKey)
                                    ? AppColors.mainColor.withOpacity(.04)
                                    : AppColors.scaffoldColor,
                            borderColor: filterController.selectedSalaryKey
                                    .contains(salaryKey)
                                ? AppColors.mainColor
                                : AppColors.borderColor.withOpacity(.5),
                            text: salaryKey!,
                          ),
                        );
                      }),
                const Gap(25),
        
                /// Required Experience
                Text("Required Experience",
                    style:
                        Styles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                const Gap(20),
                GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 12,
                        childAspectRatio: 5 / 1.3,
                      ),
                      itemCount: filterController.requiredExperienceList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        filterController.selectedExpVal!.addAll(filterController.allexp);
                        var expVal = filterController.requiredExperienceList[index].id;
                        var expKey = filterController.requiredExperienceList[index].name;
                        return Obx(
                          () => FilterTileWidget(
                            onTap: () {
                              if (expKey == "All") {
                                if (filterController.selectedExpKey!
                                    .contains("All")) {
                                  filterController.selectedExpKey!.remove("All");
                                  filterController.selectedExpVal!.remove(filterController.allexp);
                                } else {
                                  filterController.selectedExpKey!.clear();
                                  filterController.selectedExpVal!.clear();
                                  filterController.selectedExpKey!.add("All");
                                  filterController.selectedExpVal!.addAll(filterController.allexp);
                                }
                              } else {
                                if (filterController.selectedExpKey!
                                    .contains("All")) {
                                  filterController.selectedExpKey!.remove("All");
                                  filterController.selectedExpVal!.clear();
                                  filterController.selectedExpKey!
                                      .add(expKey);
                                  filterController.selectedExpVal!
                                      .add(expVal!);
                                } else {
                                  if (filterController.selectedExpKey!
                                      .contains(expVal)) {
                                    filterController.selectedExpKey!
                                        .remove(expKey);
                                    filterController.selectedExpVal!
                                        .remove(expVal);
                                  } else {
                                    filterController.selectedExpKey!
                                        .add(expKey);
                                    filterController.selectedExpVal!
                                        .add(expVal!);
                                  }
                                }
                              }
                              filterController.selectedExpKey!.refresh();
                              print(filterController.selectedExpKey);
                              filterController.selectedExpVal!.refresh();
                              print(filterController.selectedExpVal);
                            },
                            textColor: filterController.selectedExpKey!
                                    .contains(expKey)
                                ? AppColors.mainColor
                                : AppColors.blackColor,
                            bgColor: filterController.selectedExpKey!.contains(expKey) &&
                                    index == 0
                                ? Colors.transparent
                                : filterController.selectedExpKey!
                                        .contains(expKey)
                                    ? AppColors.mainColor.withOpacity(.04)
                                    : AppColors.scaffoldColor,
                            borderColor: filterController.selectedExpKey!
                                    .contains(expKey)
                                ? AppColors.mainColor
                                : AppColors.borderColor.withOpacity(.5),
                            text: expKey!,
                          ),
                        );
                      }),
                const Gap(15),
        
                /// Industry
                Text("Industry",
                    style:
                        Styles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                const Gap(20),
                 ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filterController.industryList.length,
                      itemBuilder: (context, index) {
                        var industryKey = filterController.industryList[index].industryname!;
                        var industryVal = filterController.industryList[index].id!;
                        return Container(
                          margin: EdgeInsets.only(bottom: height(8)),
                          child: Obx(()=> FilterTileWidget(
                                onTap: () {
                                  if (industryKey == "All") {
                                    if (filterController.selectedIndustryKey!
                                        .contains("All")) {
                                      filterController.selectedIndustryKey!.remove("All");
                                      filterController.selectedIndustryVal!.remove(filterController.allIndustry);
                                    }else {
                                      filterController.selectedIndustryKey!.clear();
                                      filterController.selectedIndustryVal!.clear();
                                      filterController.selectedIndustryKey!.add("All");
                                      filterController.selectedIndustryVal!.addAll(filterController.allIndustry);
                                    }
                                }else {
                                  if (filterController.selectedIndustryKey!
                                      .contains("All")) {
                                    filterController.selectedIndustryKey!.remove("All");
                                    filterController.selectedIndustryVal!.clear();
                                    filterController.selectedIndustryKey!
                                        .add(industryKey);
                                    filterController.selectedIndustryVal!
                                        .add(industryVal);
                                  }else {
                                    if(filterController.selectedIndustryKey!
                                        .contains(industryKey)) {
                                      filterController.selectedIndustryKey!
                                          .remove(industryKey);
                                      filterController.selectedIndustryVal!
                                          .remove(industryVal);
                                    }else {
                                      filterController.selectedIndustryKey!
                                          .add(industryKey);
                                      filterController.selectedIndustryVal!
                                          .add(industryVal);
                                    }
                                  }
                                }
                                  filterController.selectedIndustryKey!.refresh();
                                  print(filterController.selectedIndustryKey);
                                  filterController.selectedIndustryVal!.refresh();
                                  print(filterController.selectedIndustryVal);
                                },
                                textColor: filterController.selectedIndustryKey!.contains(industryKey) ?
                                 AppColors.mainColor:AppColors.blackColor, 
                                bgColor: index == 0 && filterController.selectedIndustryKey!.contains("All") ?
                                  Colors.transparent : filterController.selectedIndustryKey!.contains(industryKey) ? 
                                  AppColors.mainColor.withOpacity(.04):AppColors.scaffoldColor,   
                                borderColor: filterController.selectedIndustryKey!.contains(industryKey) ?
                                 AppColors.mainColor:AppColors.borderColor.withOpacity(.5),  
                                text: industryKey,
                              ),
                          ),
                        );
                      }),
                const Gap(50),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: height(45),
        width: double.maxFinite,
        padding: Dimensions.kDefaultPadding,
        margin: EdgeInsets.only(bottom: height(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AppButton(
                text: "Reset",
                textColor: AppColors.blackOpacity70,
                onTap: () {
                  filterController.resetFilterValue();
                  Get.toNamed(RouteHelper.getBottomNavRoute());
                },
                buttonHeight: height(45),
                bgColor: AppColors.buttonColor,
              ),
            ),
            const Gap(20),
            Expanded(
              child: AppButton(
                text: "Submit",
                textColor: AppColors.whiteColor,
                onTap: () async {
                  var body = PostCandidateFilterModel(
                    workplace: filterController.selectedwpVal,
                    education: filterController.selectedEduVal,
                    salary: filterController.selectedSalaryVal,
                    experience: filterController.selectedExpVal,
                    industry: filterController.selectedIndustryVal,
                  );
                  await CandidateControll.to.getCandidatelistFilteredData(fields: body);
                  Get.back();
                },
                buttonHeight: height(45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

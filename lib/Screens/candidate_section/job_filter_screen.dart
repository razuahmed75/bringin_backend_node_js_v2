import 'package:bringin/res/color.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/utils/services/keys.dart';
import 'package:bringin/widgets/filter_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../Hive/hive.dart';
import '../../controllers/FilterControll/filter_controller.dart';
import '../../controllers/candidate_section/candidate_controll.dart';
import '../../controllers/candidate_section/job_controll.dart';
import '../../models/Filter/filter.dart';
import '../../res/app_font.dart';
import '../../widgets/app_button.dart';

class JobFilterScreen extends StatefulWidget {
  final String functionalid;

  const JobFilterScreen(
      {super.key, required this.functionalid});

  @override
  State<JobFilterScreen> createState() => _JobFilterScreenState();
}

class _JobFilterScreenState extends State<JobFilterScreen> {
  final jobs = Get.find<JobControll>();
  final candidatecontroll = Get.put(CandidateControll());

  FilterControll filterControll = Get.find<FilterControll>();

  bool loading = false;

  Future loaddata() async {
    setState(() {
      loading = true;
    });
    await jobs.getjobfilter();
    setState(() {
      loading = false;
    });
  }

  // List<bool> workplacedata = [];
  // List<String> education = [];
  // List<Allsalary> salary = [];
  // List<String> experience = [];
  // List<String> industry = [];
  // List<String> _companysize = [];

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: loading
          ? Center(
              child: Helpers.appLoader2(),
            )
          : Obx(() => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: Dimensions.kDefaultPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      workplacefilter(filterControll),
                      educationfilter(filterControll),
                      salaryfilter(filterControll),
                      experiencefilter(filterControll),
                      industryfilter(filterControll),
                      if (HiveHelp.read(Keys.isRecruiter) == false)
                        companycfilter(filterControll),
                    ],
                  ),
                ),
              )),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: height(45),
          width: double.maxFinite,
          padding: Dimensions.kDefaultPadding,
          margin: EdgeInsets.only(bottom: height(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: AppButton(
                  text: "Reset",
                  textColor: AppColors.blackOpacity70,
                  borderRadius: BorderRadius.circular(radius(25)),
                  onTap: () {
                    filterControll.workplacedata.clear();
                    filterControll.education.clear();
                    filterControll.salary.clear();
                    filterControll.experience.clear();
                    filterControll.industry.clear();
                    filterControll.companysize.clear();
                    setState(() {});
      
                    // filterController.resetFilterValue();
                    // Get.toNamed(RouteHelper.getBottomNavRoute());
                  },
                  buttonHeight: height(45),
                  bgColor: AppColors.appBorder,
                ),
              ),
              const Gap(20),
              Expanded(
                flex: 4,
                child: AppButton(
                  text: "Apply",
                  textColor: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(radius(25)),
                  onTap: () async {
                    if (HiveHelp.read(Keys.isRecruiter) == true) {
                      var mapdata = {
                        "functionalareaid": widget.functionalid,
                        "workplace": filterControll.workplacedata,
                        "education": filterControll.education,
                        "salary": filterControll.salary,
                        "experience": filterControll.experience,
                        "industry": filterControll.industry,
                        "companysize": filterControll.companysize
                      };
                       candidatecontroll
                          .candidate_filter(fields: mapdata);
                      
                    } else {
                      var mapdata = {
                        "functionalareaid": widget.functionalid,
                        "workplace": filterControll.workplacedata,
                        "education": filterControll.education,
                        "salary": filterControll.salary,
                        "experience": filterControll.experience,
                        "industry": filterControll.industry,
                        "companysize": filterControll.companysize
                      };
                      jobs.filterjob(fields: mapdata);
                      
                    }
      
                    // var body = PostJobFilterModel(
                    //   workplace: filterController.selectedwpVal,
                    //   education: filterController.selectedEduVal,
                    //   salary: filterController.selectedSalaryVal,
                    //   experience: filterController.selectedExpVal,
                    //   industry: filterController.selectedIndustryVal,
                    //   companysize: filterController.selectedCompanyStrVal,
                    // );
                    // await JobControll.to.getjoblistFilteredData(fields: body);
                    Get.back();
                  },
                  buttonHeight: height(45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget workplacefilter(FilterControll filterControll) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Workplace Policy", style: Styles.bodyMediumSemiBold),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterTileWidget(
              onTap: () {
                setState(() {
                  if (filterControll.workplacedata.length ==
                      jobs.jobFilter!.allworkplace!.length) {
                    filterControll.workplacedata.clear();
                  } else {
                    filterControll.workplacedata.clear();
                    filterControll.workplaceadd(jobs.jobFilter!.allworkplace!);
                    print(filterControll.workplacedata);
                  }
                });
              },
              text: "All",
              tileHeight: 40,
              tileWidth: 100,
              textColor: filterControll.workplacedata.length ==
                      jobs.jobFilter!.allworkplace!.length
                  ? AppColors.mainColor
                  : AppColors.blackColor,
              borderColor: filterControll.workplacedata.length ==
                      jobs.jobFilter!.allworkplace!.length
                  ? AppColors.mainColor
                  : AppColors.appBorder,
              bgColor: filterControll.workplacedata.length ==
                      jobs.jobFilter!.allworkplace!.length
                  ? AppColors.mainColor.withOpacity(.05)
                  : Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                jobs.jobFilter!.workplace!.length,
                (index) => Container(
                  margin: EdgeInsets.only(right: 10.w),
                  child: FilterTileWidget(
                    onTap: () {
                      setState(() {
                        if (filterControll.workplacedata.any((element) =>
                            element ==
                            jobs.jobFilter!.workplace![index].value!)) {
                          filterControll.workplacedata
                              .remove(jobs.jobFilter!.workplace![index].value!);
                        } else {
                          filterControll.workplacedata
                              .add(jobs.jobFilter!.workplace![index].value!);
                        }
                      });
                    },
                    text: jobs.jobFilter!.workplace![index].name!,
                    tileHeight: 40,
                    tileWidth: 100,
                    textColor: filterControll.workplacedata.any((element) =>
                            element == jobs.jobFilter!.workplace![index].value!)
                        ? AppColors.mainColor
                        : AppColors.blackColor,
                    borderColor: filterControll.workplacedata.any((element) =>
                            element == jobs.jobFilter!.workplace![index].value!)
                        ? AppColors.mainColor
                        : AppColors.appBorder,
                    bgColor: filterControll.workplacedata.any((element) =>
                            element == jobs.jobFilter!.workplace![index].value!)
                        ? AppColors.mainColor.withOpacity(.05)
                        : Colors.transparent,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget educationfilter(FilterControll filterControll) {
    List<FilterValue> filtervalue = [];
    filtervalue.clear();
    filtervalue
        .add(FilterValue(id: jobs.jobFilter!.alleducation!, name: "All"));
    for (var i = 0; i < jobs.jobFilter!.education!.length; i++) {
      filtervalue.add(FilterValue(
          singleid: jobs.jobFilter!.education![i].id!,
          name: jobs.jobFilter!.education![i].name!));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text("Required Education", style: Styles.bodyMediumSemiBold),
        SizedBox(height: 10.h),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: filtervalue.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 12,
            childAspectRatio: 5 / 1.3,
          ),
          itemBuilder: (context, index) {
            var data = filtervalue[index];
            return FilterTileWidget(
              onTap: () {
                if (index == 0 &&
                    filterControll.education.length == data.id!.length) {
                  filterControll.education.clear();
                } else if (index == 0 &&
                    filterControll.education.length != data.id!.length) {
                  filterControll.education.clear();
                  filterControll.addeducation(data.id!);
                } else {
                  if (filterControll.education
                      .any((element) => element == data.singleid)) {
                    filterControll.education.remove(data.singleid);
                  } else {
                    filterControll.education.add(data.singleid!);
                  }
                }
                setState(() {});
                // setState(() {
                //   if (workplacedata.length ==
                //       jobs.jobFilter!.allworkplace!.length) {
                //     workplacedata.clear();
                //   } else {
                //     workplacedata.clear();
                //     workplacedata.addAll(jobs.jobFilter!.allworkplace!);
                //     print(workplacedata);
                //   }
                // });
              },
              text: data.name,
              tileHeight: 40,
              tileWidth: 100,
              textColor: index == 0 &&
                      filterControll.education.length ==
                          jobs.jobFilter!.alleducation!.length
                  ? AppColors.mainColor
                  : filterControll.education
                          .any((element) => element == data.singleid)
                      ? AppColors.mainColor
                      : AppColors.blackColor,
              borderColor: index == 0 &&
                      filterControll.education.length ==
                          jobs.jobFilter!.alleducation!.length
                  ? AppColors.mainColor
                  : filterControll.education
                          .any((element) => element == data.singleid)
                      ? AppColors.mainColor
                      : AppColors.appBorder,
              bgColor: index == 0 &&
                      filterControll.education.length ==
                          jobs.jobFilter!.alleducation!.length
                  ? AppColors.mainColor.withOpacity(.05)
                  : filterControll.education
                          .any((element) => element == data.singleid)
                      ? AppColors.mainColor.withOpacity(.05)
                      : Colors.transparent,
            );
          },
        )
      ],
    );
  }

  Widget salaryfilter(FilterControll filterControll) {
    List<FilterValue> filtervalue = [];
    filtervalue.clear();
    filtervalue
        .add(FilterValue(allsalary: jobs.jobFilter!.allsalary!, name: "All"));
    var jobf =
        jobs.jobFilter!.salary!.where((element) => element.type == 1).toList();
    for (var i = 0; i < jobf.length; i++) {
      filtervalue.add(FilterValue(salary: jobf[i], name: ""));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text("Offered Salary (Monthly)", style: Styles.bodyMediumSemiBold),
        SizedBox(height: 10.h),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: filtervalue.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 12,
            childAspectRatio: 5 / 1.3,
          ),
          itemBuilder: (context, index) {
            var data = filtervalue[index];
            return FilterTileWidget(
              onTap: () {
                if (index == 0 &&
                    filterControll.salary.length == data.allsalary!.length) {
                  filterControll.salary.clear();
                } else if (index == 0 &&
                    filterControll.salary.length != data.allsalary!.length) {
                  filterControll.salary.clear();
                  filterControll.salary.addAll(data.allsalary!);
                } else {
                  var sal = Allsalary(
                      minSalary: data.salary!.id,
                      maxSalary: data.salary!.otherSalary!.isEmpty
                          ? data.salary!.id
                          : data.salary!.otherSalary![0].id);
                  if (filterControll.salary.any((element) =>
                      element.minSalary == data.salary!.id &&
                      element.maxSalary ==
                          (data.salary!.otherSalary!.isEmpty
                              ? data.salary!.id
                              : data.salary!.otherSalary![0].id))) {
                    var indexfind = filterControll.salary.indexWhere(
                        (element) =>
                            element.minSalary == data.salary!.id &&
                            element.maxSalary ==
                                (data.salary!.otherSalary!.isEmpty
                                    ? data.salary!.id
                                    : data.salary!.otherSalary![0].id));
                    filterControll.salary.removeAt(indexfind);
                  } else {
                    filterControll.salary.add(sal);
                  }
                }
                setState(() {});
                // setState(() {
                //   if (workplacedata.length ==
                //       jobs.jobFilter!.allworkplace!.length) {
                //     workplacedata.clear();
                //   } else {
                //     workplacedata.clear();
                //     workplacedata.addAll(jobs.jobFilter!.allworkplace!);
                //     print(workplacedata);
                //   }
                // });
              },
              text: index == 0
                  ? "All"
                  : "${data.salary!.salary}${data.salary!.simbol}${data.salary!.otherSalary!.isEmpty ? "+" : "-"}${data.salary!.otherSalary!.isEmpty ? "" : data.salary!.otherSalary![0].salary}${data.salary!.otherSalary!.isNotEmpty ? data.salary!.otherSalary![0].simbol : ""}",
              tileHeight: 40,
              tileWidth: 100,
              textColor: index == 0 &&
                      filterControll.salary.length == data.allsalary!.length
                  ? AppColors.mainColor
                  : filterControll.salary.any((element) => index == 0
                          ? element == data.allsalary
                          : element.minSalary == data.salary!.id &&
                              element.maxSalary ==
                                  (data.salary!.otherSalary!.isEmpty
                                      ? data.salary!.id
                                      : data.salary!.otherSalary![0].id))
                      ? AppColors.mainColor
                      : AppColors.blackColor,
              borderColor: index == 0 &&
                      filterControll.salary.length == data.allsalary!.length
                  ? AppColors.mainColor
                  : filterControll.salary.any((element) => index == 0
                          ? element == data.allsalary
                          : element.minSalary == data.salary!.id &&
                              element.maxSalary ==
                                  (data.salary!.otherSalary!.isEmpty
                                      ? data.salary!.id
                                      : data.salary!.otherSalary![0].id))
                      ? AppColors.mainColor
                      : AppColors.appBorder,
              bgColor: index == 0 &&
                      filterControll.salary.length == data.allsalary!.length
                  ? AppColors.mainColor.withOpacity(.05)
                  : filterControll.salary.any((element) => index == 0
                          ? element == data.allsalary
                          : element.minSalary == data.salary!.id &&
                              element.maxSalary ==
                                  (data.salary!.otherSalary!.isEmpty
                                      ? data.salary!.id
                                      : data.salary!.otherSalary![0].id))
                      ? AppColors.mainColor.withOpacity(.05)
                      : Colors.transparent,
            );
          },
        )
      ],
    );
  }

  Widget experiencefilter(FilterControll filterControll) {
    List<FilterValue> filtervalue = [];
    filtervalue.clear();
    filtervalue.add(FilterValue(
        id: jobs.jobFilter!.allexperience!, name: "Any Experience"));
    for (var i = 0; i < jobs.jobFilter!.experience!.length; i++) {
      filtervalue.add(FilterValue(
          singleid: jobs.jobFilter!.experience![i].id!,
          name: jobs.jobFilter!.experience![i].name!));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text("Required Experience", style: Styles.bodyMediumSemiBold),
        SizedBox(height: 10.h),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: filtervalue.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 12,
            childAspectRatio: 5 / 1.3,
          ),
          itemBuilder: (context, index) {
            var data = filtervalue[index];
            return FilterTileWidget(
              onTap: () {
                if (index == 0 &&
                    filterControll.experience.length == data.id!.length) {
                  filterControll.experience.clear();
                } else if (index == 0 &&
                    filterControll.experience.length != data.id!.length) {
                  filterControll.experience.clear();
                  filterControll.experience.addAll(data.id!);
                } else {
                  if (filterControll.experience
                      .any((element) => element == data.singleid)) {
                    filterControll.experience.remove(data.singleid);
                  } else {
                    filterControll.experience.add(data.singleid!);
                  }
                }
                setState(() {});
              },
              text: data.name,
              tileHeight: 40,
              tileWidth: 100,
              textColor: index == 0 &&
                      filterControll.experience.length == data.id!.length
                  ? AppColors.mainColor
                  : filterControll.experience
                          .any((element) => element == data.singleid)
                      ? AppColors.mainColor
                      : AppColors.blackColor,
              borderColor: index == 0 &&
                      filterControll.experience.length == data.id!.length
                  ? AppColors.mainColor
                  : filterControll.experience
                          .any((element) => element == data.singleid)
                      ? AppColors.mainColor
                      : AppColors.appBorder,
              bgColor: index == 0 &&
                      filterControll.experience.length == data.id!.length
                  ? AppColors.mainColor.withOpacity(.05)
                  : filterControll.experience
                          .any((element) => element == data.singleid)
                      ? AppColors.mainColor.withOpacity(.05)
                      : Colors.transparent,
            );
          },
        )
      ],
    );
  }

  Widget industryfilter(FilterControll filterControll) {
    List<FilterValue> filtervalue = [];
    filtervalue.clear();
    filtervalue.add(
        FilterValue(id: jobs.jobFilter!.allindustry!, name: "Any Industry"));
    for (var i = 0; i < jobs.jobFilter!.industry!.length; i++) {
      filtervalue.add(FilterValue(
          singleid: jobs.jobFilter!.industry![i].id!,
          name: jobs.jobFilter!.industry![i].categoryname!));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text("Required Industry", style: Styles.bodyMediumSemiBold),
        SizedBox(height: 10.h),
        Wrap(
          direction: Axis.horizontal,
          spacing: width(10),
          runSpacing: width(10),
          children: [
            ...List.generate(filtervalue.length, (index) {
              var data = filtervalue[index];
              return InkWell(
                onTap: () {
                  if (index == 0 &&
                      filterControll.industry.length == data.id!.length) {
                    filterControll.industry.clear();
                  } else if (index == 0 &&
                      filterControll.industry.length != data.id!.length) {
                    filterControll.industry.clear();
                    filterControll.industry.addAll(data.id!);
                  } else {
                    if (filterControll.industry
                        .any((element) => element == data.singleid)) {
                      filterControll.industry.remove(data.singleid);
                    } else {
                      filterControll.industry.add(data.singleid!);
                    }
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width(10), vertical: height(10)),
                  decoration: BoxDecoration(
                    color: index == 0 &&
                            filterControll.industry.length == data.id!.length
                        ? AppColors.mainColor.withOpacity(.05)
                        : filterControll.industry
                                .any((element) => element == data.singleid)
                            ? AppColors.mainColor.withOpacity(.05)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(radius(25)),
                    border: Border.all(
                        color: index == 0 &&
                                filterControll.industry.length ==
                                    data.id!.length
                            ? AppColors.mainColor
                            : filterControll.industry
                                    .any((element) => element == data.singleid)
                                ? AppColors.mainColor
                                : AppColors.appBorder,
                        width: .5),
                  ),
                  child: Center(
                    child: Text(
                      data.name,
                      style: Styles.bodySmall1.copyWith(
                          color: index == 0 &&
                                  filterControll.industry.length ==
                                      data.id!.length
                              ? AppColors.mainColor
                              : filterControll.industry.any(
                                      (element) => element == data.singleid)
                                  ? AppColors.mainColor
                                  : AppColors.blackColor),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget companycfilter(FilterControll _) {
    List<FilterValue> filtervalue = [];
    filtervalue.clear();
    filtervalue
        .add(FilterValue(id: jobs.jobFilter!.allcompanysize!, name: "All"));
    for (var i = 0; i < jobs.jobFilter!.companysize!.length; i++) {
      filtervalue.add(FilterValue(
          singleid: jobs.jobFilter!.companysize![i].id!,
          name: jobs.jobFilter!.companysize![i].size!));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text("Company Strength", style: Styles.bodyMediumSemiBold),
        SizedBox(height: 10.h),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: filtervalue.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 12,
            childAspectRatio: 5 / 1.3,
          ),
          itemBuilder: (context, index) {
            var data = filtervalue[index];
            return FilterTileWidget(
              onTap: () {
                if (index == 0 && _.companysize.length == data.id!.length) {
                  filterControll.companysize.clear();
                } else if (index == 0 &&
                    filterControll.companysize.length != data.id!.length) {
                  filterControll.companysize.clear();
                  filterControll.companysize.addAll(data.id!);
                } else {
                  if (filterControll.companysize
                      .any((element) => element == data.singleid)) {
                    filterControll.companysize.remove(data.singleid);
                  } else {
                    filterControll.companysize.add(data.singleid!);
                  }
                }
                setState(() {});
              },
              text: data.name,
              tileHeight: 40,
              tileWidth: 100,
              textColor: index == 0 &&
                      filterControll.companysize.length == data.id!.length
                  ? AppColors.mainColor
                  : filterControll.companysize
                          .any((element) => element == data.singleid)
                      ? AppColors.mainColor
                      : AppColors.blackColor,
              borderColor: index == 0 &&
                      filterControll.companysize.length == data.id!.length
                  ? AppColors.mainColor
                  : filterControll.companysize
                          .any((element) => element == data.singleid)
                      ? AppColors.mainColor
                      : AppColors.appBorder,
              bgColor: index == 0 &&
                      filterControll.companysize.length == data.id!.length
                  ? AppColors.mainColor.withOpacity(.05)
                  : filterControll.companysize
                          .any((element) => element == data.singleid)
                      ? AppColors.mainColor.withOpacity(.05)
                      : Colors.transparent,
            );
          },
        )
      ],
    );
  }
}

class FilterValue {
  final String name;
  final List<String>? id;
  final String? singleid;
  final List<Allsalary>? allsalary;
  final SalaryElement? salary;
  const FilterValue(
      {this.id,
      required this.name,
      this.singleid,
      this.salary,
      this.allsalary});
}

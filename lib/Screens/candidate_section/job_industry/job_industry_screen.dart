// ignore_for_file: invalid_use_of_protected_member, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/Screens/candidate_section/job_industry/components/build_industry_dialog.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../../controllers/both_category/job_industry_controller.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/image_path.dart';
import '../../../res/constants/strings.dart';
import '../../../res/dimensions.dart';
import '../../../utils/services/helpers.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/app_search_form_field.dart';
import 'components/most_popular_section.dart';

class JobIndustryScreen extends StatelessWidget {
  JobIndustryScreen({super.key});

  TextEditingController searchext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    JobIndustryController jobIndustryController = Get.find();

    return GestureDetector(
        onTap: () => Helpers.hideKeyboard(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appBarWidget(
                title: "",
                onBackPressed: () {
                  Get.back();
                  jobIndustryController.searchInputText.value = "";
                  jobIndustryController.searchIndustryController.clear();
                },
                onSavedPressed: () {
                  Get.back();

                  jobIndustryController.searchInputText.value = "";
                  jobIndustryController.searchIndustryController.clear();
                }),
            body: Padding(
              padding: Dimensions.kDefaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Job Industry
                  jobindustry(jobIndustryController),

                  const Gap(15),
                  // searchindustry(context: context),
                  CustomSearchField(
                    controller: jobIndustryController.searchIndustryController,
                    hinText: 'Any Industry / Garments / SME etc.',
                    prefixIcon: SizedBox(width: 10.w),
                    onChanged: (p0) {
                      jobIndustryController.searchInputText.value = p0;
                      jobIndustryController.searchCategory(p0);
                    },
                  ),
                  const Gap(20),

                  /// Most Popular Industry
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Most Popular Industry",
                          style: Styles.bodyMediumSemiBold),
                    ],
                  ),
                  Obx(
                    () => jobIndustryController.searchInputText.value.isNotEmpty
                        ? jobIndustryController.searchCategoryList.value.isEmpty
                            ? SizedBox(
                                height: Dimensions.screenHeight * .4,
                                child: Center(
                                  child: Text("Not found",
                                      style: Styles.bodyMediumSemiBold),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: ScrollPhysics(),
                                    itemCount: jobIndustryController
                                        .searchCategoryList.value.length,
                                    //  shrinkWrap: true,
                                    itemBuilder: (BuildContext context, index) {
                                      var list = jobIndustryController
                                          .selectedlist.value;
                                      var data = jobIndustryController
                                          .searchCategoryList.value[index];
                                      return Obx(
                                        () => Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              border: Border(
                                                  bottom: BorderSide(
                                                color: AppColors.borderColor
                                                    .withOpacity(.3),
                                                width: .5,
                                              ))),
                                          child: ListTile(
                                            onTap: () {
                                              if (!list.contains(data.sId)) {
                                                if (list.length < 3) {
                                                  list.add(data.sId!);
                                                  print(list);
                                                } else {
                                                  list.remove(data.sId);
                                                  print(list);
                                                  Helpers().showToastMessage(
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      msg:
                                                          "You can select up to 3 industries");
                                                }
                                              } else {
                                                list.remove(data.sId);
                                              }
                                              jobIndustryController.selectedlist
                                                  .refresh();
                                              print(list);
                                              jobIndustryController
                                                  .searchInputText.value = "";
                                              jobIndustryController
                                                  .searchIndustryController
                                                  .clear();
                                              Helpers.hideKeyboard();
                                            },
                                            title: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 12,
                                                  right: 12,
                                                  bottom: 5),
                                              child: SubstringHighlight(
                                                text:
                                                    "${jobIndustryController.searchCategoryList.value[index].categoryname}", // each string needing highlighting
                                                term:
                                                    "${jobIndustryController.searchInputText.value}", // user typed "m4a"
                                                textStyle: TextStyle(
                                                  // non-highlight style
                                                  color: AppColors.blackColor,
                                                ),
                                                textStyleHighlight: TextStyle(
                                                  // highlight style
                                                  color: AppColors.mainColor,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                        : Expanded(
                            child: SingleChildScrollView(
                                child: MostPopularSection())),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Obx(() => jobIndustryController.isLoading.value
                ? SizedBox(
                    height: 1,
                    width: 1,
                  )
                : jobIndustryController.searchInputText.value.isNotEmpty
                    ? SizedBox(height: 1, width: 1)
                    : SafeArea(
                        child: Container(
                            height: Dimensions.buttonHeight + 5,
                            margin: EdgeInsets.only(
                                bottom: height(20),
                                left: width(15),
                                right: width(15)),
                            child:

                                /// Browse More Industry button
                                GestureDetector(
                              onTap: () {
                                Industryclass().buildIndustryDialog(context);
                              },
                              child: Container(
                                height: Dimensions.buttonHeight,
                                width: double.maxFinite,
                                padding:
                                    EdgeInsets.symmetric(horizontal: width(12)),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius:
                                      BorderRadius.circular(radius(6)),
                                  border: Border.all(
                                      color: AppColors.shadowColor, width: 0.5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.shadowColor,
                                      spreadRadius: 0.1,
                                      blurRadius: 2,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppImagePaths.browse,
                                          height: height(22),
                                          width: width(22),
                                        ),
                                        const Gap(18),
                                        Text("Explore More Industry",
                                            style: Styles.bodyLarge.copyWith(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    Obx(() => Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: jobIndustryController
                                                  .selectedlist.isEmpty
                                              ? Colors.transparent
                                              : AppColors.mainColor,
                                        ),
                                        child: Text(
                                          "${jobIndustryController.selectedlist.value.length}",
                                          style: TextStyle(
                                            color: jobIndustryController
                                                        .selectedlist
                                                        .value
                                                        .length ==
                                                    0
                                                ? Colors.transparent
                                                : AppColors.whiteColor,
                                          ),
                                        ))),
                                    Image.asset(
                                      AppImagePaths.forword_browse,
                                      height: height(18),
                                      width: width(18),
                                    ),
                                  ],
                                ),
                              ),

                              //      ),
                              //   ),
                              // ),
                            )),
                      ))));
  }

  Widget jobindustry(jobIndustryController) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Gap(40),
            Text("Field of Industry", style: Styles.mediumTitle),
            Spacer(),
            Row(
              children: [
                Obx(
                  () => Text(
                      "${jobIndustryController.selectedlist.value.length}",
                      style: Styles.mediumTitle),
                ),
                Text("/3",
                    style: Styles.mediumTitle
                        .copyWith(color: AppColors.mainColor)),
              ],
            ),
          ],
        ),
        const Gap(5),

        /// description
        Text(
          AppStrings.jobIndustryDes,
          style: Styles.subTitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

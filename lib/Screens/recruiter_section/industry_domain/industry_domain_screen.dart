// ignore_for_file: invalid_use_of_protected_member, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../../controllers/candidate_section/industry_controller.dart';
import '../../../models/both_category/job_industry_model.dart';
import '../../../res/app_font.dart';
import '../../../res/color.dart';
import '../../../res/constants/image_path.dart';
import '../../../res/dimensions.dart';
import '../../../utils/services/helpers.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/app_search_form_field.dart';
import '../../../widgets/popular_tile.dart';

class IndustryDomainScreen extends StatelessWidget {
  IndustryDomainScreen({super.key});

  TextEditingController searchext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    IndustryControler industryControler = Get.find();

      return GestureDetector(
        onTap: ()=> Helpers.hideKeyboard(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBarWidget(
              title: "",
              onBackPressed: () {
                Get.back();
                industryControler.searchInputText.value = "";
                industryControler.searchIndustryController.clear();
              },
              actions: [],
            ),
          body: Padding(
            padding: Dimensions.kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Job Industry
                jobindustry(industryControler),
      
                const Gap(10),
                CustomSearchField(
                      controller: industryControler.searchIndustryController,
                      hinText: 'Any Industry / Garments / SME etc.',
                      prefixIcon: SizedBox(width: 10.w),
                      onChanged: (p0) {
                        industryControler.searchInputText.value = p0;
                        industryControler.searchCategory(p0);
                      },
                    ),
                const Gap(20),
      
                /// Most Popular Industry
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Most Popular Job Industry",
                          style: Styles.bodyMediumSemiBold),
                    ],
                  ),
                  Obx(
                    () => industryControler.searchInputText.value.isNotEmpty
                        ?  industryControler
                             .searchCategoryList.value.isEmpty
                           ? SizedBox(
                            height: Dimensions.screenHeight*.4,
                             child: Center(
                              child: Text("Not found",style: Styles.bodyMediumSemiBold),
                             ),
                           )
                             : Expanded(
                            child: ListView.builder(
                                physics: ScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: industryControler
                                    .searchCategoryList.value.length,
                                // shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  var data = industryControler.searchCategoryList.value[index];
                                  return Obx(
                                    () => Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        border: Border(
                                          bottom: BorderSide(
                                            color: AppColors.borderColor.withOpacity(.3),
                                            width: .5,
                                          )
                                        )
                                        ),
                                      child: ListTile(
                                              onTap: () {
                                                 industryControler.jobIndustryName.value = data.categoryname!;
                                                 industryControler.categoryId.value = data.sId!;
                                                 print(data.sId);
                                                 industryControler.searchInputText.value = "";
                                                 industryControler.searchIndustryController.clear();
                                                 Helpers.hideKeyboard();
                                                 Get.back();
                                              },
                                              title: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 12,
                                                    right: 12,
                                                    bottom: 5),
                                                child: SubstringHighlight(
                                                  text:
                                                      "${industryControler.searchCategoryList.value[index].categoryname}", // each string needing highlighting
                                                  term:
                                                      "${industryControler.searchInputText.value}", // user typed "m4a"
                                                  textStyle: TextStyle(
                                                    // non-highlight style
                                                    color: 
                                                         AppColors
                                                            .hintColor,
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
                        : Expanded(child: SingleChildScrollView(child: mostPopularSection(industryControler))),
                  ),
                const Gap(20),
      
              ],
            ),
          ),
          bottomNavigationBar: Obx(()=> industryControler.isLoading.value
            ? SizedBox(height: 1,width:1)
            : industryControler.searchInputText.value.isNotEmpty 
            ? SizedBox(height: 1,width:1) : Container(
              height: Dimensions.buttonHeight+5,
              margin: EdgeInsets.only(bottom: height(20),left: width(15),right: width(15)),
              child: /// Browse More Industry button
                      GestureDetector(
                                onTap: () {
                                  buildIndustryDialog(context);
                                }
                                    ,
                                child: Container(
                                  height: Dimensions.buttonHeight,
                                  width: double.maxFinite,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: width(12)),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(radius(6)),
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
                                            child: Text(
                                              industryControler.jobIndustryName.value.isEmpty ? "0":"1",
                                              style: TextStyle(
                                                  color: industryControler.jobIndustryName.value.isEmpty
                                                      ? Colors.transparent
                                                      : Colors.white),
                                            ),
                                            decoration: BoxDecoration(
                                                color: industryControler.jobIndustryName.value.isEmpty
                                                    ? Colors.transparent
                                                    : AppColors.mainColor,
                                                shape: BoxShape.circle),
                                          )),
                                      Image.asset(
                                        AppImagePaths.forword_browse,
                                        height: height(18),
                                        width: width(18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
            ),
          ),
        ),
      );
  }


    int industrycount(IndustryControler industryControll, Industry data) {
    var total = data.category!
        .where((element) => industryControll.categoryId.value ==  element.sId)
        .toList()
        .length;

    return total;
  }
  Future<dynamic> buildIndustryDialog(context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius(20))),
      ),
      builder: (context) =>
          GetBuilder<IndustryControler>(builder: (industryControll) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.15,
          maxChildSize: 0.90,
          expand: false,
          snap: true,
          builder: (_, ScrollController) => Padding(
            padding: EdgeInsets.only(top: height(10)),
            child: Container(
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  Container(
                    width: width(40),
                    height: height(4),
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(radius(20)),
                    ),
                  ),
                  Expanded(
                      child: ExpandedTileList.builder(
                    scrollController: ScrollController,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    itemCount: industryControll.allIndustryList.length,
                    itemBuilder: (context, index, controller) {
                      var data = industryControll.allIndustryList[index];
                      return ExpandedTile(
                        theme : ExpandedTileThemeData(
                          contentBackgroundColor: AppColors.whiteColor,
                          headerColor: AppColors.whiteColor,
                        ),
                        title: Row(
                          children: [
                            
                            Text(data.industryname!),
                            Spacer(),
                            Obx(
                                  () => industrycount(industryControll, data) != 0 ? Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      industrycount(industryControll, data).toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        shape: BoxShape.circle),
                                  ) : SizedBox(),
                                )
                          ],
                        ),
                        content: Wrap(
                          spacing: 8,
                            children:
                                List.generate(industryControll.allIndustryList[index].category!.length, (i) {
                              var data2 = industryControll.allIndustryList[index].category![i];
                              return InkWell(
                                onTap: () {
                                  industryControll.jobIndustryName.value = data2.categoryname!;
                                  industryControll.categoryId.value = data2.sId!;
                                  print(data2.sId);
                                  Get.back();
                                  Get.back();
                                },
                                child: Obx(()=>PopularTile(
                                    text: data2.categoryname!,
                                    borderColor: industryControll.categoryId.value == data2.sId
                                        ? AppColors.mainColor.withOpacity(.5)
                                        : AppColors.borderColor.withOpacity(.5),
                                    textColor: industryControll.categoryId.value == data2.sId
                                        ? AppColors.mainColor
                                        : AppColors.blackOpacity70,
                                  ),
                                ),
                              );
                            }),
                          ),
                        controller: controller,
                      );
                    },
                  ),
                ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget mostPopularSection(IndustryControler industryControler) {
    return Padding(
      padding: EdgeInsets.only(top: height(20)),
      child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => industryControler.isLoading.value
                                      ? Helpers.appLoader()
                                      : industryControler.popularJobIndustryList.isEmpty ?
                                      SizedBox(
                                        height: Dimensions.screenHeight*.6,
                                        child: Center(
                                          child: Text("Not Found"),
                                        ),
                                      ) :
                                        Wrap(
                                          spacing: 12,
                                          children: List.generate(
                                             industryControler.popularJobIndustryList.length > 20 ? 20:industryControler.popularJobIndustryList.length,
                                              (index) {
                                                var clampedIndex = index.clamp(0, industryControler.popularJobIndustryList.length);
                                                var data = industryControler.popularJobIndustryList.value[clampedIndex];
                                            return InkWell(
                                              onTap: () {
                                                industryControler.jobIndustryName.value = data.categoryname!;
                                                industryControler.categoryId.value = data.sId!;
                                                print(data.sId);
                                                Get.back();
                                                
                                                },
                                              child: PopularTile(
                                                text: data.categoryname!,
                                                borderColor: industryControler.categoryId == data.sId
                                                    ? AppColors.mainColor.withOpacity(.6)
                                                    : Color(0xFF828282).withOpacity(0.4),
                                                textColor:industryControler.categoryId == data.sId
                                                    ? AppColors.mainColor
                                                    : AppColors.blackOpacity70,
                                              ),
                                            );
                                          }),
                                        ),
                                ),
                              ],
                            ),
    );
  }

  Widget jobindustry(IndustryControler jobIndustryController) {
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
                      jobIndustryController.jobIndustryName.value.isEmpty ? "0":"1",
                      style: Styles.mediumTitle),
                ),
                Text("/1",
                    style: Styles.mediumTitle
                        .copyWith(color: AppColors.mainColor)),
              ],
            ),
          ],
        ),
        const Gap(10),
    
        /// description
        Text(
          "Please select the industry field that corresponds to your company.",
          style: Styles.subTitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

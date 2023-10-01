// ignore_for_file: invalid_use_of_protected_member
import 'package:bringin/controllers/candidate_section/candidate_controll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../controllers/both_category/expertise_area_controller.dart';
import '../../controllers/candidate_section/work_experience_controller.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/strings.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/app_search_form_field.dart';

class ExpertiseAreaScreen extends StatefulWidget {
  final bool candidateiteam;
  ExpertiseAreaScreen({super.key, this.candidateiteam = false});
  @override
  State<ExpertiseAreaScreen> createState() => _ExpertiseAreaScreenState();
}

class _ExpertiseAreaScreenState extends State<ExpertiseAreaScreen> {
  ExpertiseAreaController _functilnalAreaController =
      Get.find<ExpertiseAreaController>();
  WorkExperienceController workExperienceController =
      Get.find<WorkExperienceController>();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
          appBarWidget(title: "", onBackPressed: () => Get.back(), actions: []),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Functional Area
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 25.w),
                    Text("Expertise Area", style: Styles.smallTitle),
                    Row(
                      children: [
                        Obx(() => Text(
                            _functilnalAreaController
                                    .selectedFuncationalNameValue.value.isEmpty
                                ? "0"
                                : "1",
                            style: Styles.smallTitle)),
                        Text("/1",
                            style: Styles.smallTitle
                                .copyWith(color: AppColors.mainColor)),
                      ],
                    ),
                  ],
                ),
                const Gap(6),

                /// description
                Text(
                  AppStrings.expertiseAreaDes,
                  style: Styles.bodyMedium2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Gap(22),

            /// search bar
            CustomSearchField(
              controller: _functilnalAreaController.searchTextController,
              hinText: 'Senior UI/UX Designer',
              onChanged: (p0) {
                _functilnalAreaController.searchInputText.value = p0;
                _functilnalAreaController.searchAreaName(p0);
              },
              prefixIcon: SizedBox(width: 10.w),
            ),
            Obx(
              () => _functilnalAreaController.searchInputText.value.isNotEmpty
                  ? _functilnalAreaController.categorySearchList.value.isEmpty
                      ? SizedBox(
                          height: Dimensions.screenHeight * .4,
                          child: Center(
                            child: Text("Not Found", style: Styles.bodyMedium),
                          ),
                        )
                      :

                      /// searching suggestions
                      Obx(
                          () => Expanded(
                            child: ListView.builder(
                                itemCount: _functilnalAreaController
                                    .categorySearchList.value.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, index) {
                                  var data = _functilnalAreaController
                                      .categorySearchList[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        border: Border(
                                            bottom: BorderSide(
                                          color: AppColors.borderColor
                                              .withOpacity(.3),
                                          width: .5,
                                        ))),
                                    child: ListTile(
                                      onTap: () async {
                                        if (widget.candidateiteam == true) {
                                          await CandidateControll.to
                                              .addFunctionalArea(data: {
                                            "expertice_area": data.areaId,
                                          });
                                          CandidateControll
                                                      .to.isLoading.value ==
                                                  false
                                              ? Get.back()
                                              : null;
                                        } else {
                                          _functilnalAreaController
                                              .selectedFuncationalNameValue
                                              .value = data.functionalname!;
                                          _functilnalAreaController
                                              .selectValueFunctionalNameId
                                              .value = data.areaId!;
                                          _functilnalAreaController.categoryId
                                              .value = data.categoryId!;
                                          _functilnalAreaController
                                                  .selectValueFuncationNamePath
                                                  .value =
                                              "${data.industryname}" +
                                                  " > " +
                                                  "${data.categoryname}" +
                                                  " > " +
                                                  "${data.functionalname}";
                                          print(data.areaId);
                                          print(_functilnalAreaController
                                              .selectValueFuncationNamePath
                                              .value);
                                          _functilnalAreaController
                                              .searchInputText.value = "";
                                          _functilnalAreaController
                                              .searchTextController
                                              .clear();
                                          Get.back();
                                        }
                                      },
                                      title: SubstringHighlight(
                                        text: _functilnalAreaController
                                            .categorySearchList[index]
                                            .functionalname!,
                                        term:
                                            "${_functilnalAreaController.searchInputText.value}",
                                        textStyle: TextStyle(
                                          color: AppColors.blackColor,
                                        ),
                                        textStyleHighlight: TextStyle(
                                          color: AppColors.mainColor,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${data.industryname}" +
                                            " > " +
                                            "${data.categoryname}" +
                                            " > " +
                                            "${data.functionalname}",
                                        style: Styles.smallText.copyWith(
                                          color: AppColors.blackColor
                                              .withOpacity(.4),
                                          fontWeight: FontWeight.w300,
                                          fontSize: font(11),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )

                  /// functional area data
                  : Obx(
                      () => _functilnalAreaController.isLoading.value
                          ? Helpers.appLoader()
                          : _functilnalAreaController.functionalAreaList.isEmpty
                              ? Container(
                                  width: Dimensions.screenWidth,
                                  height: Dimensions.screenHeight * .4,
                                  child: Center(
                                    child: Text("Not found"),
                                  ),
                                )
                              : DefaultTabController(
                                  initialIndex:
                                      _functilnalAreaController.mainIndex.value,
                                  length: _functilnalAreaController
                                      .functionalAreaList.value.length,
                                  child: Expanded(
                                    child: Column(
                                      children: [
                                        Obx(() => Container(
                                              height: 38.h,
                                              padding:
                                                  EdgeInsets.only(bottom: 6.h),
                                              margin:
                                                  EdgeInsets.only(top: 14.h),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                color: AppColors.borderColor
                                                    .withOpacity(.6),
                                                width: .6,
                                              ))),
                                              child: TabBar(
                                                onTap: (value) {
                                                  _functilnalAreaController
                                                      .mainIndex.value = value;
                                                  scrollController.position
                                                      .jumpTo(0.0);
                                                },
                                                tabs: List.generate(
                                                  _functilnalAreaController
                                                      .functionalAreaList
                                                      .value
                                                      .length,
                                                  (index) => Tab(
                                                      text:
                                                          _functilnalAreaController
                                                              .functionalAreaList
                                                              .value[index]
                                                              .industryname),
                                                ),
                                                labelColor: AppColors.mainColor,
                                                labelStyle: Styles.bodyMedium,
                                                unselectedLabelStyle:
                                                    Styles.bodyMedium1,
                                                unselectedLabelColor:
                                                    AppColors.blackOpacity70,
                                                isScrollable: true,
                                                indicator: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9.r),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .mainColor)),
                                              ),
                                            )),
                                        Obx(
                                          () =>
                                              _functilnalAreaController
                                                      .isLoading.value
                                                  ? SizedBox()
                                                  : Expanded(
                                                      flex: 2,
                                                      child:
                                                          SingleChildScrollView(
                                                        controller:
                                                            scrollController,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 8.0),
                                                          child: Wrap(
                                                            spacing:
                                                                8.0, // horizontal space between items
                                                            runSpacing:
                                                                8.0, // vertical space between rows
                                                            children: _functilnalAreaController
                                                                .functionalAreaList[
                                                                    _functilnalAreaController
                                                                        .mainIndex
                                                                        .value]
                                                                .category!
                                                                .map(
                                                                    (category) {
                                                              return Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Color(0xFF828282).withOpacity(
                                                                            0.1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(radius(9))),
                                                                    margin: EdgeInsets.only(
                                                                        bottom:
                                                                            10.h),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        40.h,
                                                                    child: Text(
                                                                      category
                                                                          .categoryname!,
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .fade,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center, // category name
                                                                      style: Styles
                                                                          .bodyMediumSemiBold,
                                                                    ),
                                                                  ),
                                                                  GridView(
                                                                    physics:
                                                                        NeverScrollableScrollPhysics(),
                                                                    shrinkWrap:
                                                                        true,
                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                        crossAxisCount:
                                                                            2,
                                                                        crossAxisSpacing: 10
                                                                            .w,
                                                                        mainAxisSpacing: 10
                                                                            .h,
                                                                        childAspectRatio:
                                                                            3.8), // horizontal space between items
                                                                    children: category
                                                                        .functionarea!
                                                                        .map(
                                                                            (e) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          if (widget.candidateiteam ==
                                                                              true) {
                                                                            await CandidateControll.to.addFunctionalArea(data: {
                                                                              "expertice_area": e.id,
                                                                            });
                                                                            CandidateControll.to.isLoading.value == false
                                                                                ? Get.back()
                                                                                : null;
                                                                          } else {
                                                                            _functilnalAreaController.selectedFuncationalNameValue.value =
                                                                                e.functionalname!;
                                                                            _functilnalAreaController.selectValueFunctionalNameId.value =
                                                                                e.id!;
                                                                            _functilnalAreaController.categoryId.value =
                                                                                e.categoryid!;
                                                                            print(e.categoryid);
                                                                            _functilnalAreaController.selectValueFuncationNamePath.value =
                                                                                "${_functilnalAreaController.functionalAreaList.value[_functilnalAreaController.mainIndex.value].industryname} > ${category.categoryname} > ${e.functionalname}";
                                                                            Get.back();
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 5.w,
                                                                              vertical: 4.h),
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: _functilnalAreaController.selectedFuncationalNameValue.value == e.functionalname ? AppColors.mainColor : Color(0xFF828282).withOpacity(0.2)),
                                                                              borderRadius: BorderRadius.circular(5.r)),
                                                                          child:
                                                                              Text(
                                                                            e.functionalname!,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.fade,
                                                                            style:
                                                                                Styles.bodyMedium1.copyWith(
                                                                              color: _functilnalAreaController.selectedFuncationalNameValue.value == e.functionalname ? AppColors.mainColor : AppColors.blackOpacity70,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                ],
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

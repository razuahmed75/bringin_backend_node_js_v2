import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controllers/candidate_section/education_controller.dart';
import '../../controllers/candidate_section/education_level_controller.dart';
import '../../models/candidate_section/education_level_model.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/image_path.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/app_bar.dart';

class EducationLevelScreen extends StatelessWidget {
  const EducationLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EducationLevelController educationLevelController =
        Get.find<EducationLevelController>();
    return Scaffold(
      appBar: appBarWidget(
          title: "",
          onBackPressed: () {
            educationLevelController.selectedIndex.value = "";
            Get.back();
          },
          onSavedPressed: () {
            educationLevelController.selectedDegree.value =
                educationLevelController.selectedIndex.value;
            Get.back();
          }),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kDefaultgapTop,

            /// EDUCTIONAL LEVEL TITLE
            Center(
              child: Column(  
                children: [
                  Text("Education Level & Degree", style: Styles.smallTitle),
                  const Gap(3),
                  Text("Please select your degree", style: Styles.bodyMedium2),
                ],
              ),
            ),
            const Gap(5),

            GetBuilder<EducationLevelController>(builder: (_) {
              return educationLevelController.isLoading
                  ? Helpers.appLoader()
                  : educationLevelController.educationLevelList.isEmpty
                      ? Container(
                        height: Dimensions.screenHeight*.5,
                        child: Center(
                            child: Text("Not Found", style: Styles.bodyMedium),
                          ),
                      )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                                itemCount: educationLevelController
                                    .educationLevelList.length,
                                itemBuilder: (_, index) {
                                  educationLevelController.expansionStates.value =
                                      List.generate(
                                          educationLevelController
                                              .educationLevelList.length,
                                          (_) => false);
                                  var degreeList = educationLevelController
                                      .educationLevelList[index].digree;
                                  if (degreeList!.length.isOdd) {
                                    degreeList.add(EducationLevelModel(name: ""));
                                  }
                                  var educationLevelName =
                                      educationLevelController
                                          .educationLevelList[index].name;
                                  var educationalLevelId =
                                      educationLevelController
                                          .educationLevelList[index].id;
                                  return Theme(
                                    data: Get.theme.copyWith(
                                        dividerColor: Colors.transparent),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: height(2)),
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        border: Border.all(
                                            color: AppColors.borderColor,
                                            width: .16),
                                        borderRadius:
                                            BorderRadius.circular(radius(3)),
                                      ),
                                      child: ExpansionTile(
                                          onExpansionChanged: (bool? val) {
                                            educationLevelController
                                                .expansionStates[index] = val!;
                                          },
                                          childrenPadding:
                                              Dimensions.kDefaultPadding,
                                          iconColor: AppColors.blackColor,
                                          trailing: Obx(
                                            () => Transform.rotate(
                                              angle: educationLevelController
                                                      .expansionStates[index]
                                                  ? 1.5
                                                  : -6.2,
                                              child: SvgPicture.asset(
                                                AppImagePaths.arrowForwardIcon,
                                                color: educationLevelController
                                                        .expansionStates[index]
                                                    ? AppColors.mainColor
                                                    : AppColors.blackColor,
                                              ),
                                            ),
                                          ),
                                          title: Text(educationLevelName!,
                                              style: Styles.bodyLarge),
                                          children: List.generate(
                                              degreeList.length
                                                      .toDouble() ~/
                                                  2, (i) {
                                            int a = 2 * i;
                                            int b = 2 * i + 1;
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  bottom: height(10)),
                                              child: Obx(
                                                () => Row(
                                                  children: [
                                                    _buildSubSectionTile(
                                                        text: degreeList[a].name,
                                                        textColor:
                                                            educationLevelController
                                                                        .selectedIndex
                                                                        .value ==
                                                                    degreeList[a]
                                                                        .name
                                                                ? AppColors
                                                                    .mainColor
                                                                : AppColors
                                                                    .blackColor,
                                                        bgColor:
                                                            educationLevelController
                                                                        .selectedIndex
                                                                        .value ==
                                                                    degreeList[a]
                                                                        .name
                                                                ? AppColors
                                                                    .mainColor
                                                                    .withOpacity(
                                                                        .3)
                                                                : AppColors
                                                                    .buttonColor
                                                                    .withOpacity(
                                                                        .5),
                                                        onTap: () async{
                                                          await EducationController.to.getSubjectaName(degreeId: degreeList[a].id!);
                                                          EducationController.to.selectedSubjectName.value = "";

                                                          educationLevelController
                                                                  .selectedIndex
                                                                  .value =
                                                              degreeList[a].name!;
                                                          educationLevelController
                                                                  .selectedEducationLevel
                                                                  .value =
                                                              educationLevelName;
                                                          print(
                                                              educationLevelName);
                                                          educationLevelController
                                                                  .selectedEducationLevellId
                                                                  .value =
                                                              educationalLevelId!;
                                                          educationLevelController
                                                              .selectedDegreeId
                                                              .value = degreeList[
                                                                  a]
                                                              .id!;
                                                          print(
                                                              degreeList[a].name);
                                                          print(
                                                              educationLevelController
                                                                  .selectedDegreeId
                                                                  .value);
                                                        }),
                                                    const Gap(15),
                                                    _buildSubSectionTile(
                                                        text: degreeList[b].name,
                                                        textColor:
                                                            educationLevelController
                                                                        .selectedIndex
                                                                        .value ==
                                                                    degreeList[b]
                                                                        .name
                                                                ? AppColors
                                                                    .mainColor
                                                                : AppColors
                                                                    .blackColor,
                                                        bgColor: degreeList[b]
                                                                    .name ==
                                                                ""
                                                            ? Colors.transparent
                                                            : educationLevelController
                                                                        .selectedIndex
                                                                        .value ==
                                                                    degreeList[
                                                                            b]
                                                                        .name
                                                                ? AppColors
                                                                    .mainColor
                                                                    .withOpacity(
                                                                        .3)
                                                                : AppColors
                                                                    .buttonColor
                                                                    .withOpacity(
                                                                        .5),
                                                        onTap: degreeList[b]
                                                                    .name ==
                                                                ""
                                                            ? null
                                                            : () async{
                                                              await EducationController.to.getSubjectaName(degreeId: degreeList[b].id!);
                                                              EducationController.to.selectedSubjectName.value = "";
                                                              
                                                                educationLevelController
                                                                        .selectedIndex
                                                                        .value =
                                                                    degreeList[b]
                                                                        .name!;
                                                                educationLevelController
                                                                        .selectedEducationLevel
                                                                        .value =
                                                                    educationLevelName;
                                                                educationLevelController
                                                                        .selectedEducationLevellId
                                                                        .value =
                                                                    educationalLevelId!;
                                                                educationLevelController
                                                                        .selectedDegreeId
                                                                        .value =
                                                                    degreeList[b]
                                                                        .id!;
                                                                print(
                                                                    educationLevelName);
                                                                print(
                                                                    degreeList[b]
                                                                        .name);
                                                                print(educationLevelController
                                                                    .selectedDegreeId
                                                                    .value);
                                                              }),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })),
                                    ),
                                  );
                                }),
                          ),
                        );
            })
          ],
        ),
      ),
    );
  }

  Widget _buildSubSectionTile(
      {required text, void Function()? onTap, Color? bgColor, textColor}) {
    return Expanded(
      child: InkWell(
        splashColor: AppColors.mainColor.withOpacity(.2),
        highlightColor: AppColors.mainColor.withOpacity(.2),
        onTap: onTap,
        child: Container(
          height: height(40),
          decoration: BoxDecoration(
            color: bgColor,
          ),
          child: Center(
              child: Text(text,
                  style: Styles.bodyMedium1.copyWith(color: textColor))),
        ),
      ),
    );
  }
}

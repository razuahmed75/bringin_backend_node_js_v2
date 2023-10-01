// ignore_for_file: invalid_use_of_protected_member
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/icon_and_text_btn.dart';
import 'package:bringin/widgets/length_counter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_bar.dart';
import '../../controllers/candidate_section/my_skills_controller.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/formfield_length_checker.dart';

class MySkillScreen extends StatelessWidget {
  final bool? isUserFromJobPostPage;
  final String? categoryId;
  const MySkillScreen(
      {super.key, this.isUserFromJobPostPage = false, this.categoryId});
  @override
  Widget build(BuildContext context) {
    Get.find<MySkillsController>().getDefaultSkill(categoryId: categoryId);
    MySkillsController mySkillsController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget(
        title: isUserFromJobPostPage == true ? "Required Skills" : "My Skills",
        onBackPressed: () {
          mySkillsController.selectedSkill.clear();
          Get.back();
        },
        onSavedPressed: () {
          mySkillsController.onSaved(isUserFromJobPostPage);
        },
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// SELECTED SKILLS
                      Obx(
                        () => mySkillsController.isskillUpdating.value == true
                            ? Center(
                                child: Helpers.appLoader2(),
                              )
                            : mySkillsController.selectedSkill.value.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(top: height(20)),
                                    child: Text(isUserFromJobPostPage == true
                                        ? "Please select or add your required skills"
                                        : "Please select or add your skills"),
                                  )
                                : Wrap(
                                    spacing: width(10),
                                    runSpacing: height(10),
                                    children: [
                                      ...List.generate(
                                          mySkillsController.selectedSkill.value
                                              .length, (index) {
                                        return Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: height(2)),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                color: AppColors.mainColor
                                                    .withOpacity(.3),
                                              ))),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    mySkillsController
                                                        .selectedSkill[index],
                                                    style: Styles.bodyMedium1
                                                        .copyWith(
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                  const Gap(5),
                                                  CloseButton(
                                                    onTap: () {
                                                      mySkillsController
                                                          .removeSkills(index);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                      ),
                      Obx(() => Gap(
                          mySkillsController.selectedSkill.value.isEmpty
                              ? 0
                              : 10)),

                      /// length counter
                      Obx(() => LengthCounter(
                          firstText:
                              "${mySkillsController.selectedSkill.value.length}",
                          secondText: "/05")),
                      const Gap(25),

                      /// bottom section
                      Obx(() {
                        if (mySkillsController.isLodding.value == true) {
                          return SizedBox(
                            child: Center(
                              child: Helpers.appLoader2(),
                            ),
                          );
                        }

                        /// DEFAULT SKILLS
                        return Wrap(
                          spacing: width(20),
                          runSpacing: height(12),
                          children: [
                            ...List.generate(
                                mySkillsController
                                    .defaultSkillList.value.length, (index) {
                              var defaultSkill = mySkillsController
                                  .defaultSkillList[index].functionalname;
                              return Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                      color: mySkillsController
                                              .selectedSkill.value
                                              .contains(
                                        defaultSkill,
                                      )
                                          ? AppColors.mainColor
                                          : AppColors.borderColor,
                                      width: .5,
                                    )),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          mySkillsController
                                              .selectSkill(defaultSkill);
                                        },
                                        child: Text(defaultSkill!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Styles.bodyMedium1.copyWith(
                                              color: mySkillsController
                                                      .selectedSkill.value
                                                      .contains(defaultSkill)
                                                  ? AppColors.mainColor
                                                  : AppColors.blackOpacity70,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      }),
                      const Gap(15),
                    ],
                  ),
                  const Gap(35),

                  /// add skill button
                  Align(
                    alignment: Alignment.center,
                    child: IconAndTextBtn(
                      text: "Add Skills",
                      onTap: () {
                        mySkillsController.characterLen.value = 0;
                        mySkillsController.textFieldController.clear();
                        Get.defaultDialog(
                          radius: 10,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          titlePadding: EdgeInsets.zero,
                          title: "",
                          content: Container(
                            width: double.maxFinite,
                            padding: Dimensions.kDefaultPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Text("Add Skills",
                                        style: Styles.bodyLargeSemiBold)),
                                const Gap(15),

                                /// text field
                                Container(
                                  padding: Dimensions.kDefaultPadding,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(radius(6)),
                                    border: Border.all(
                                      color: AppColors.appBorder,
                                      width: .5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: AppTextField(
                                          controller: mySkillsController
                                              .textFieldController,
                                          hinText: isUserFromJobPostPage == true
                                              ? "Please enter a skill"
                                              : "Please enter a skill tag",
                                          maxLen: 50,
                                          onChanged: (value) {
                                            mySkillsController.characterLen
                                                .value = value.length;
                                          },
                                        ),
                                      ),

                                      /// length counter
                                      Obx(() => Padding(
                                            padding: EdgeInsets.only(
                                                bottom: height(10)),
                                            child: FormFieldLengthChecker(
                                              characterLength:
                                                  mySkillsController
                                                      .characterLen.value,
                                              maxLength: 50,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                const Gap(15),

                                /// cancel, save
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("Cancel",
                                            style: Styles.bodyMedium)),
                                    const Gap(20),
                                    Obx(
                                      () => TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: mySkillsController
                                                      .characterLen.value >=
                                                  1
                                              ? AppColors.mainColor
                                              : AppColors.mainColor
                                                  .withOpacity(.1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                radius(6)),
                                          ),
                                        ),
                                        onPressed: () {
                                          mySkillsController.selectedSkill.add(
                                              mySkillsController
                                                  .textFieldController.text
                                                  .trim());
                                          mySkillsController.selectedSkill
                                              .refresh();
                                          Get.back();
                                        },
                                        child: Text(
                                          "Save",
                                          style: Styles.bodyMedium.copyWith(
                                              color: mySkillsController
                                                          .characterLen.value >=
                                                      1
                                                  ? AppColors.whiteColor
                                                  : AppColors.blackOpacity70),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget CloseButton({void Function()? onTap}) {
    return IconButton(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        onPressed: onTap,
        icon: Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close,
            color: AppColors.whiteColor,
            size: height(12),
          ),
        ));
  }
}

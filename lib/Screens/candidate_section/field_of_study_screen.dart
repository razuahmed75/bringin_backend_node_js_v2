// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:bringin/utils/services/bindings/bindings_controllers_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/app_search_form_field.dart';

class FieldOfStudyScreen extends StatelessWidget {
FieldOfStudyScreen({super.key});
EducationController educationQualificationsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget(
        title: "Subject (Major In)", 
        onBackPressed: () => Get.back(),
        actions: [],
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Obx(()=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDefaultgapTop,
             /// adding search option when subject data will be greater than 20
             educationQualificationsController.subjectList.length > 20 
             ? CustomSearchField(
                controller: educationQualificationsController.subjectTextField,
                hinText: 'e.g. Philosophy',
                prefixIcon: SizedBox(width: 10.w),
                onChanged: (p0) {
                  educationQualificationsController.subjectInputText.value = p0;
                  educationQualificationsController.searchSubjects(p0);
                },
              )
              :SizedBox(),
               Gap(educationQualificationsController.subjectList.length > 20 ? 10:0),
               /// list of subjects
               educationQualificationsController.isGettingSubjectName.value 
               ? Helpers.appLoader() 
                : educationQualificationsController.subjectList.isEmpty 
                ? Container(
                  height: Dimensions.screenWidth*.5,
                  child: Center(
                    child: Text(
                      "Not Found",
                      style: Styles.bodyMedium))) 
                    : educationQualificationsController.subjectInputText.value.isNotEmpty
                    ? educationQualificationsController.searchedSubjectList.isEmpty 
                    ? Container(
                  height: Dimensions.screenWidth*.5,
                  child: Center(
                    child: Text(
                      "Not Found",
                      style: Styles.bodyMedium)))
                    : searchedElement()
                    : allElement(),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget allElement() {
    return Expanded(
                  child: ListView.builder(
                    itemCount: educationQualificationsController.subjectList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context , index){
                      var data = educationQualificationsController.subjectList[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: height(10)),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(
                              color: AppColors.borderColor.withOpacity(.3),
                              width: .3,
                          )
                        ),
                        child: ListTile(
                          onTap: (){
                            educationQualificationsController.selectedSubjectName.value = data.name!;
                            educationQualificationsController.selectedSubjectId.value = data.id!;
                            Get.back();
                          },
                          title: SubstringHighlight(
                            text: "${educationQualificationsController.subjectList[index].name}",
                            term: "${educationQualificationsController.subjectInputText.value}",
                            textStyle: Styles.bodyMedium1,
                            textStyleHighlight: TextStyle(
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                );
  }

  Widget searchedElement() {
    return Expanded(
                             child: ListView.builder(
                                padding: EdgeInsets.zero,
                                 physics: ScrollPhysics(),
                                 itemCount: educationQualificationsController.searchedSubjectList.length,
                                 itemBuilder: (BuildContext context, index) {
                                  var data = educationQualificationsController.searchedSubjectList[index];
                                   return Obx(
                                     () => Container(
                                      margin: EdgeInsets.only(bottom: height(10)),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          border: Border.all(
                                              color: AppColors.borderColor.withOpacity(.3),
                                              width: .3,
                                          )
                                        ),
                                       child: ListTile(
                                               onTap: () {
                                                 educationQualificationsController.selectedSubjectName.value = data.name!;
                                                  educationQualificationsController.selectedSubjectId.value = data.id!;
                                                  educationQualificationsController.subjectTextField.clear();
                                                  educationQualificationsController.subjectInputText.value = "";
                                                  Get.back();
                                                  Helpers.hideKeyboard();
                                               },
                                               title: SubstringHighlight(
                                                 text:
                                                     "${educationQualificationsController.searchedSubjectList.value[index].name}", // each string needing highlighting
                                                 term:
                                                     "${educationQualificationsController.subjectInputText.value}", // user typed "m4a"
                                                 textStyle: TextStyle(
                                                   // non-highlight style
                                                   color: 
                                                        AppColors
                                                           .blackColor,
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
                                   );
                                 }),
                           );
  }
}

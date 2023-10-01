// ignore_for_file: invalid_use_of_protected_member

import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../../../../../controllers/recruiter_section/recruiter_job_post_controller.dart';
import '../../../../../../res/app_font.dart';
import '../../../../../../res/color.dart';
import '../../../../../../res/constants/strings.dart';
import '../../../../../../res/dimensions.dart';
import '../../../../../../widgets/app_bar.dart';
import '../../../../../../widgets/app_search_widget.dart';

class JobTitleScreen extends StatelessWidget {
  const JobTitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    RecruiterJobPostController recruiterJobPostController =
        Get.find<RecruiterJobPostController>();
    return WillPopScope(
    onWillPop: () async{
        var isTapped = recruiterJobPostController.isTapped.value;
        if(isTapped){
          recruiterJobPostController.isTapped.value = false;
          return true;
        }else{
          return true;
        }
      },
      child: Scaffold(
        appBar: appBarWidget(
          title: "",
          onBackPressed: (){
            recruiterJobPostController.isTapped.value = false;
            Get.back();
          },
          onSavedPressed: (){
            if(searchController.text.isEmpty){
              return Helpers().showValidationErrorDialog();
            }else{
              recruiterJobPostController.selectJobTitleName.value = searchController.text.trim();
              Get.back();
            }
          },
        ),
        body: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Job Title", style: Styles.smallTitle,textAlign: TextAlign.center,),
              const Gap(3),
              Text(AppStrings.jobTitleDes, style: Styles.subTitle),
              const Gap(10),
        
              /// job title searching field
              AppSearchWidget(
                controller: searchController,
                hinText: "Web developer, UI/UX Designer",
                onChanged: (value) {
                  if(value.isNotEmpty){
                    recruiterJobPostController.getJobTitle(userInput: value);
                  }else{
                    recruiterJobPostController.jobTitleList.clear();
                  }
                },
                child: Container(),
              ),
              const Gap(20),
        
              Obx(
                () => recruiterJobPostController.isjobTitleLodding.value == true
                    ? Center(child: Helpers.appLoader2())
                    : recruiterJobPostController.jobTitleList.value.isEmpty && recruiterJobPostController.isTapped.value?
                     SizedBox(
                      height: Dimensions.screenWidth*.5,
                       child: Center(
                        child: Text("Not found",style: Styles.bodyMedium),
                       ),
                     ) :
                     recruiterJobPostController.jobTitleList.isEmpty
                     ? SizedBox() 
                     :Expanded(
                        child: ListView.builder(
                            itemCount: recruiterJobPostController
                                .jobTitleList.value.length,
                            itemBuilder: (_, index) {
                              var data = recruiterJobPostController.jobTitleList.value[index];
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: AppColors.borderColor,
                                  width: 0.25,
                                ))),
                                child: ListTile(
                                  onTap: () {
                                    recruiterJobPostController
                                            .selectJobTitleName.value =
                                        recruiterJobPostController
                                            .jobTitleList.value[index].functionalname!;
                                    Get.back();
                                  },
                                  title: SubstringHighlight(
                                    text:
                                        "${data.functionalname}",
                                    term: "${searchController.text}",
                                    textStyleHighlight: TextStyle(
                                      // highlight style
                                      color: AppColors.mainColor,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  subtitle: Text(
                                        "${data.industryid!.industryname!}"+" > "+"${data.categoryid!.categoryname}"+" > "+ "${data.functionalname}",
                                        style: Styles.smallText.copyWith(
                                          color: AppColors.blackColor.withOpacity(.4),
                                          fontWeight: FontWeight.w300,
                                          fontSize: font(11),
                                        ),
                                      ),
                                ),
                              );
                            })),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: invalid_use_of_protected_member, must_be_immutable

import 'package:bringin/controllers/candidate_section/work_experience_controller.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/app_bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_search_widget.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../../../res/dimensions.dart';
import '../../Hive/hive.dart';
import '../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/image_path.dart';
import '../../utils/routes/route_helper.dart';
import '../../utils/services/keys.dart';

class CompanyNameScreen extends StatelessWidget {
  CompanyNameScreen({super.key});
  RecruiterEditMainProfileController _recruiterProfileInfoController =
      Get.find<RecruiterEditMainProfileController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var isTapped = _recruiterProfileInfoController.isTapped.value;
        if (isTapped) {
          _recruiterProfileInfoController.isTapped.value = false;
          return true;
        } else {
          return true;
        }
  },
      child: GestureDetector(
        onTap: () => Helpers.hideKeyboard(),
        child: Scaffold(
          appBar: HiveHelp.read(Keys.isRecruiter) ? appBarWidget(
            title:"",
            onBackPressed: (){
              Get.back();
              _recruiterProfileInfoController.isTapped.value = false;
            },
            actions: [],
          ):appBarWidget(
            title: "Company Name",
            onBackPressed: ()=> Get.back(),
            onSavedPressed: (){
              if(_recruiterProfileInfoController.companyNameSearchController.value.text.isEmpty){
                Helpers().showValidationErrorDialog();
              }
              else{
                WorkExperienceController.to.selectedCompanyName.value = _recruiterProfileInfoController.companyNameSearchController.value.text;
                Get.back();
              }
            },
          ),
          body: Padding(
            padding: Dimensions.kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimensions.kDefaultgapTop,
               HiveHelp.read(Keys.isRecruiter) ? Text("Company Legal Name",style: Styles.smallTitle):SizedBox(),
                 Gap(HiveHelp.read(Keys.isRecruiter) ? 3:0),
               HiveHelp.read(Keys.isRecruiter) ? Text("Please provide the full legal name of your company exactly as it appears on official documents.",
                style: Styles.subTitle,) :SizedBox(),
                 Gap(HiveHelp.read(Keys.isRecruiter) ? 10:0),
    
                GetBuilder<RecruiterEditMainProfileController>(builder: (_) {
                  return AppSearchWidget(
                    controller: _recruiterProfileInfoController
                        .companyNameSearchController.value,
                    hinText: "Search by your company name",
                    onChanged: (p0){
                      if(p0.isNotEmpty){
                        _recruiterProfileInfoController.searchCompanyName(
                          fields: {
                            "search" : "$p0",
                          }
                        );
                      }
                    },
                    onFieldSubmitted:(p0) {
                      if(_recruiterProfileInfoController.companyNameSearchController.value.text.isEmpty){
                        Helpers().showValidationErrorDialog();
                      }
                      else{
                        _recruiterProfileInfoController.searchCompanyName(
                                fields: {
                                  "search" : "$p0",
                                }
                              );
                      }
                    },
                    child: InkWell(
                            onTap: () {
                              Helpers.hideKeyboard();
                               if(_recruiterProfileInfoController.companyNameSearchController.value.text.isEmpty){
                                  Helpers().showValidationErrorDialog();
                                }
                              else{
                                _recruiterProfileInfoController.searchCompanyName(
                                fields: {
                                  "search" : "${_recruiterProfileInfoController.companyNameSearchController.value.text.trim()}",
                                }
                              );
                              }
                            },
                            child: SvgPicture.asset(
                            AppImagePaths.searchIcon,
                            color: AppColors.hintColor,
                            alignment: Alignment.center,
                          ),
                          ),
                  );
                }),
                SizedBox(height: 5.h),
                // searching suggestion
                Obx(
                  () => Expanded(
                    child: _recruiterProfileInfoController
                                .iscompanyLodding.value ==
                            true
                        ? Center(
                            child: Helpers.appLoader2(),
                          )
                          
                        : _recruiterProfileInfoController.recruiterCompanyList.isEmpty && _recruiterProfileInfoController.isTapped.value?
                        Center(
                          child: Text("No Company name found!"),
                        ) :
                        _recruiterProfileInfoController.recruiterCompanyList.isEmpty ?
                        SizedBox()
                        :ListView.builder(
                            shrinkWrap: true,
                            itemCount: _recruiterProfileInfoController
                                .recruiterCompanyList.value.length,
                            itemBuilder: (_, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 5.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9.r),
                                  border: Border.all(
                                      color: Color(0xFF828282).withOpacity(0.2)),
                                ),
                                child: ListTile(
                                  dense: true,
                                  onTap: () {
                                    /// if the user role is recruiter
                                    if(HiveHelp.read(Keys.isRecruiter)==true){
                                      _recruiterProfileInfoController
                                            .companyNameSearchController
                                            .value
                                            .text =
                                        _recruiterProfileInfoController
                                            .recruiterCompanyList
                                            .value[index]
                                            .legalName
                                            .toString();
                                    Get.toNamed(RouteHelper
                                        .getCompanyRegistrationRoute());
                                    }
                                    /// if the user role is seeker
                                    else{
                                      WorkExperienceController.to.selectedCompanyName.value = _recruiterProfileInfoController
                                            .recruiterCompanyList
                                            .value[index]
                                            .legalName!;
                                        Get.back();
                                    }
                                  },
                                  title: SubstringHighlight(
                                    text:
                                        "${_recruiterProfileInfoController.recruiterCompanyList.value[index].legalName}",
                                    term:
                                        "${_recruiterProfileInfoController.companyNameSearchController.value.text}",
                                    textStyle: TextStyle(
                                      color: AppColors.blackOpacity80,
                                    ),
                                    textStyleHighlight: TextStyle(
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                ),
                              );
                            }),
                  ),
                ),
                const Gap(10),
              ],
            ),
          ),
          bottomNavigationBar: HiveHelp.read(Keys.isRecruiter) ? BottomNavWidget(onTap: () {
            if (_recruiterProfileInfoController
                .companyNameSearchController.value.text.isNotEmpty) {
              Get.toNamed(RouteHelper.getCompanyRegistrationRoute());
              _recruiterProfileInfoController.selectedCompanyName.value = _recruiterProfileInfoController.companyNameSearchController.value.text;
              HiveHelp.write(
                  Keys.recruiterCompanyName,
                  _recruiterProfileInfoController
                      .companyNameSearchController.value.text);
             HiveHelp.write(
                  Keys.recruiterCompanyName,
                  _recruiterProfileInfoController
                      .companyNameSearchController.value.text);
            } else {
              Helpers().showValidationErrorDialog(
                  errorText: 'Please enter your company name then continue next');
            }
          }):Container(height: 0,width: 0,),
        ),
      ),
    );
  }
}

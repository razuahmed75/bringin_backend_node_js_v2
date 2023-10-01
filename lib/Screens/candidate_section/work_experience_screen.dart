import 'package:bringin/controllers/candidate_section/candidate_edit_main_profile_controller.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/app_bottom_nav_widget.dart';
import 'package:bringin/widgets/app_switch.dart';
import 'package:intl/intl.dart';
import '../../Hive/hive.dart';
import '../../controllers/both_category/expertise_area_controller.dart';
import '../../controllers/candidate_section/department_controller.dart';
import '../../controllers/candidate_section/industry_controller.dart';
import '../../controllers/candidate_section/my_designation_controller.dart';
import '../../controllers/candidate_section/my_resume_controller.dart';
import '../../controllers/candidate_section/career_milestone_controller.dart';
import '../../controllers/candidate_section/duties_and_responsibility_controller.dart';
import '../../controllers/candidate_section/work_experience_controller.dart';
import '../../models/both_category/work_experience_post_model.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/dimensions.dart';
import '../../utils/routes/route_helper.dart';
import '../../utils/services/keys.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_popup_dialog.dart';
import '../../widgets/experience_tile.dart';
import '../../widgets/header_widget.dart';




class WorkExperienceScreen extends StatelessWidget {
  final String? experienceId;
   WorkExperienceScreen({super.key, this.experienceId});
      WorkExperienceController workExperienceController = Get.find();
    MyDesignationController myDesignationController = Get.find();
    DepartmentController departmentController = Get.find();
    DutiesAndResponsibilitiesController rolesAndResponsibilitiesController =Get.find();
    CareerMileStoneController professionalAccomplishmentController =Get.find();
    IndustryControler industryControler = Get.find();
    ExpertiseAreaController functilnalAreaController = Get.find();
    CandidateEditMainProfileController candidateEditMainProfileController = Get.find();
    final myResumeController = Get.find<MyResumeController>();
    var selectedStartTimeMonth = "";
    var selectedStartTimeYear = "";
    var selectedEndTimeMonth = "";
    var selectedEndTimeYear = "";
    

  @override
  Widget build(BuildContext context) {
    var currentYear = DateTime.now().year.toString().substring(2);
    int indexedYear = int.parse(currentYear);
    return WillPopScope(
      onWillPop: (){
       return onBackPressed(context);
      },
      child: Scaffold(
        appBar: appBarWidget(
            title: "Work  Experience",
            onBackPressed: (){
              onBackPressed(context);
            },
            actions: []),
        body: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimensions.kDefaultgapTop,
          
                /// experiences section
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: height(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Company Name
                          Obx(()=> ExperienceTile(
                                onPressed: () {
                                  Get.toNamed(RouteHelper.getcompanyNameRoute());
                                },
                                firstText: "Company Name",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                secondText: workExperienceController.selectedCompanyName.value.isEmpty
                                ? "e.g. Bringin Technologies Ltd.":workExperienceController.selectedCompanyName.value,
                                secondTextColor: workExperienceController.selectedCompanyName.value.isEmpty
                                ? AppColors.hintColor : AppColors.blackColor,
                              ),
                          ),
                              
                          // Industry
                          Obx(()=>ExperienceTile(
                                onPressed: (){
                                  print(HiveHelp.read(Keys.authToken));
                                  if(industryControler.popularJobIndustryList.isEmpty){
                                    industryControler.getPopularJobIndustry();
                                    Get.toNamed(RouteHelper.getIndustryScreenRoute());
                                  }else{
                                    Get.toNamed(RouteHelper.getIndustryScreenRoute());
                                  }
                                },
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                firstText: "Industry",
                                secondText:industryControler.jobIndustryName.value.isEmpty ?"e.g. Information & Technology":industryControler.jobIndustryName.value,
                                secondTextColor:industryControler.jobIndustryName.value.isEmpty ?AppColors.hintColor:AppColors.blackColor,
                              ),
                          ),
                              
                          // Start - End 
                          Obx(
                            () => ExperienceTile(
                              onStartPressed: () {
                                Get.bottomSheet(
                                backgroundColor: AppColors.whiteColor,
                                 shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.vertical(top: Radius.circular(radius(18))),
                                ),
                                Container(
                                height: height(280),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(radius(18))
                                ),
                                 child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                   children: [
                                    HeaderWidget(
                                      onBackPressed: ()=> Get.back(), 
                                      onSavePressed: (){
                                        workExperienceController.selectedStartTime.value = selectedStartTimeMonth + " ${selectedStartTimeYear}";
                                        String dateStr = workExperienceController.selectedStartTime.value;
                                        DateFormat format = DateFormat('MMMM yyyy');
                                        DateTime dateTime = format.parse(dateStr);
                                        workExperienceController.formattedStartDateFromUi = DateFormat('yyy-MM-dd').format(dateTime);
                                        print(workExperienceController.formattedStartDateFromUi);
                                        Get.back();
                                      },
                                      middleText: "Start Time", 
                                      isArrow: false,
                                      margin: EdgeInsets.symmetric(
                                        vertical: height(20),
                                        horizontal: width(10),
                                      ),
                                    ),
                                     Container(
                                      height: height(200),
                                      width: width(220),
                                      decoration: BoxDecoration(
                                        // color: AppColors.mainColor.withOpacity(.25),
                                      borderRadius:
                                          BorderRadius.circular(radius(20)),
                                       ),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: <Widget>[
                                           SizedBox(
                                             width: width(120),
                                             child: CupertinoPicker(
                                              useMagnifier: true,
                                              magnification: 1.3,
                                              selectionOverlay: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: AppColors.whiteColor,
                                                ),
                                                top: BorderSide(
                                                  color: AppColors.whiteColor
                                                )
                                              )
                                            ),
                                          ),
                                              scrollController: FixedExtentScrollController(initialItem: workExperienceController.selectedStartTimeMonthIndex.value + 6),
                                               itemExtent: height(30),
                                               onSelectedItemChanged: (int index) {
                                                workExperienceController.selectedStartTimeMonthIndex.value = index;
                                                  selectedStartTimeMonth = candidateEditMainProfileController.months[index];
                                               },
                                               children: List<Widget>.generate(candidateEditMainProfileController.months.length, (int index) {
                                                selectedStartTimeMonth = candidateEditMainProfileController.months[workExperienceController.selectedStartTimeMonthIndex.value];
                                                 return Center(
                                                   child: Text(
                                                     candidateEditMainProfileController.months[index],
                                                     style: Styles.bodyMedium1,
                                                   ),
                                                 );
                                               }),
                                             ),
                                           ),
                                            /// middle divider
                                            // Container(
                                            //   width: width(12),
                                            //   height: height(2),
                                            //   color: AppColors.blackColor,
                                            // ),
                                           SizedBox(
                                             width: width(100),
                                             child: CupertinoPicker(
                                              useMagnifier: true,
                                              magnification: 1.3,
                                              selectionOverlay: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: AppColors.whiteColor,
                                                    ),
                                                    top: BorderSide(
                                                      color: AppColors.whiteColor
                                                    )
                                                  )
                                                ),
                                              ),
                                               scrollController:
                                                   FixedExtentScrollController(initialItem: workExperienceController.selectedStartTimeYearIndex.value+45),
                                               itemExtent: height(30),
                                               onSelectedItemChanged: (int index) {
                                                workExperienceController.selectedStartTimeYearIndex.value = index;
                                                  selectedStartTimeYear = "${1970 + index}";
                                               },
                                               children: List<Widget>.generate(31+indexedYear, (int index) {
                                                 selectedStartTimeYear = "${1970 + workExperienceController.selectedStartTimeYearIndex.value+45}";
                                                 return Center(
                                                   child: Text(
                                                     '${1970 + index}',
                                                     style: Styles.bodyMedium1,
                                                   ),
                                                 );
                                               }),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                               )
                              );
                              },
                              onEndPressed: (){
                                
                                 Get.bottomSheet(
                                backgroundColor: AppColors.whiteColor,
                                 shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.vertical(top: Radius.circular(radius(18))),
                                ),
                                Container(
                                height: height(280),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(radius(18))
                                ),
                                 child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                   children: [
                                    HeaderWidget(
                                      onBackPressed: ()=> Get.back(), 
                                      onSavePressed: (){
                                        int nowyear = DateTime.now().year;
                                        workExperienceController.selectedEndTime.value = int.parse(selectedEndTimeYear) > nowyear ? "Present" : selectedEndTimeMonth + " ${selectedEndTimeYear}";
                                        String dateStr = workExperienceController.selectedEndTime.value;
                                        // print("sjjshvbdjs ${int.parse(selectedEndTimeYear) > nowyear}");
                                        String prasentformet =  selectedEndTimeMonth + " ${int.parse(selectedEndTimeYear)+10}";
                                        print(prasentformet);
                                        DateFormat format = DateFormat('MMMM yyyy');
                                        DateTime dateTime = format.parse(int.parse(selectedEndTimeYear) > nowyear ? prasentformet :  dateStr);
                                        workExperienceController.formattedEndDateFromUi = DateFormat('yyy-MM-dd').format(dateTime);
                                        print(workExperienceController.formattedEndDateFromUi);
                                        Get.back();
                                      },
                                      middleText: "End Time", 
                                      isArrow: false,
                                      margin: EdgeInsets.symmetric(
                                        vertical: height(20),
                                        horizontal: width(10),
                                      ),
                                    ),
                                     Stack(
                                      alignment: Alignment.center,
                                       children: [
                                         Container(
                                          height: height(200),
                                          width: width(220),
                                          decoration: BoxDecoration(
                                            color: AppColors.mainColor.withOpacity(.25),
                                          borderRadius:
                                              BorderRadius.circular(radius(20)),
                                          ),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: <Widget>[
                                               SizedBox(
                                                 width: width(120),
                                                 child: CupertinoPicker(
                                                  useMagnifier: true,
                                                  magnification: 1.3,
                                                  selectionOverlay: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: AppColors.whiteColor,
                                                    ),
                                                    top: BorderSide(
                                                      color: AppColors.whiteColor
                                                    )
                                                  )
                                                ),
                                              ),
                                                   scrollController: FixedExtentScrollController(initialItem: workExperienceController.selectedEndTimeMonthIndex.value+7),
                                                   itemExtent: height(30),
                                                   onSelectedItemChanged: (int index) {
                                                    workExperienceController.selectedEndTimeMonthIndex.value = index;
                                                    selectedEndTimeMonth = candidateEditMainProfileController.months[index];
                                                   },
                                                   
                                                   children: List<Widget>.generate(candidateEditMainProfileController.months.length, (int index) {
                                                    selectedEndTimeMonth = candidateEditMainProfileController.months[workExperienceController.selectedEndTimeMonthIndex.value];
                                                     return Center(
                                                       child: Text(
                                                         candidateEditMainProfileController.months[index],
                                                         style: Styles.bodyMedium1,
                                                       ),
                                                     );
                                                   }),
                                                 ),
                                               ),
                                                /// middle divider
                                                // Container(
                                                //   width: width(12),
                                                //   height: height(2),
                                                //   color: AppColors.blackColor,
                                                // ),
                                               SizedBox(
                                                 width: width(100),
                                                 child: CupertinoPicker(
                                                  useMagnifier: true,
                                                  magnification: 1.3,
                                                  selectionOverlay: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: AppColors.whiteColor,
                                                    ),
                                                    top: BorderSide(
                                                      color: AppColors.whiteColor
                                                    )
                                                  )
                                                ),
                                              ),
                                                   scrollController:
                                                       FixedExtentScrollController(initialItem: workExperienceController.selectedEndTimeYearIndex.value+50),
                                                   itemExtent: height(30),
                                                   onSelectedItemChanged: (int index) {
                                                    
                                                    workExperienceController.selectedEndTimeYearIndex.value = index;
                                                    selectedEndTimeYear = "${1970 + index}";
                                                   },
                                                   
                                                   children: List<Widget>.generate(31+indexedYear+1, (int index) {
                                                  
                                                    selectedEndTimeYear = "${1970 + workExperienceController.selectedEndTimeYearIndex.value+50}";
                                                     return Center(
                                                       child: Text(
                                                         index == (31+indexedYear) ? "Present" : '${1970 + index}',
                                                         style: Styles.bodyMedium1,
                                                       ),
                                                     );
                                                   }),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                               )
                              );
                              },
                              isStartWorkingSection: true,
                              firstText: "Start - End",
                              secondText:
                                  workExperienceController.selectedStartTime.value.isEmpty
                                      ? "e.g. May 2019"
                                      : "${workExperienceController.selectedStartTime.value}",
                              secondTextColor:
                                  workExperienceController.selectedStartTime.value.isEmpty
                                      ? AppColors.hintColor
                                      : AppColors.blackColor,
                              thirdText: workExperienceController.selectedEndTime.value.isEmpty
                                  ? "e.g. April 2023"
                                  : "${workExperienceController.selectedEndTime.value}",
                              thirdTextColor:
                                  workExperienceController.selectedEndTime.value.isEmpty
                                      ? AppColors.hintColor
                                      : AppColors.blackColor,
                            ),
                          ),
                              
                          
                          // Expertise Area
                          Obx(() => ExperienceTile(
                              onPressed: (){
                                if(functilnalAreaController.functionalAreaList.isEmpty){
                                  Get.toNamed(RouteHelper.getExpertiseAreaRoute());
                                  functilnalAreaController.getFunctionalArea();
                                }else{
                                  Get.toNamed(RouteHelper.getExpertiseAreaRoute());
                                }
                                
                              },
                              maxLines: 1,
                              firstText: "Expertise Area" ,
                              secondText: functilnalAreaController.selectedFuncationalNameValue.value.isEmpty? "e.g. Flutter Developer": functilnalAreaController.selectedFuncationalNameValue.value,
                              secondTextColor:  functilnalAreaController.selectedFuncationalNameValue.value.isEmpty? AppColors.hintColor : AppColors.blackColor,
                            ),
                          ),
                          
                          // Designation
                          Obx(
                            () => ExperienceTile(
                              onPressed: () => Get.toNamed(RouteHelper.getMyDesignationRoute()),
                              firstText: "Designation",
                              maxLines: 1,
                              secondText: myDesignationController.selectedDesignation.isEmpty
                                  ? "e.g. Chief Designer"
                                  : myDesignationController.selectedDesignation.value,
                              secondTextColor: myDesignationController.selectedDesignation.isEmpty
                                  ? AppColors.hintColor
                                  : AppColors.blackColor,
                            ),
                          ),
                              
                          // Depertment
                          Obx(
                            () => ExperienceTile(
                              maxLines: 1,
                              onPressed: () => Get.toNamed(RouteHelper.getDepartmentRoute()),
                              firstText: "Department (Optional)",
                              secondText: departmentController.selectedDepartment.isEmpty
                                  ? "e.g. Development Team"
                                  : departmentController.selectedDepartment.value,
                              secondTextColor: departmentController.selectedDepartment.isEmpty
                                  ? AppColors.hintColor
                                  : AppColors.blackColor,
                            ),
                          ),
                              
                          // Resposibility
                          Obx(
                            () => ExperienceTile(
                              onPressed: () => Get.toNamed(RouteHelper.getDutiesAndResRoute()),
                              firstText: "Duties & Responsibilities",
                              secondTextSize: font(16),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              secondText: rolesAndResponsibilitiesController
                                      .selectedResponsibilities.value.isEmpty
                                  ? "e.g. Examine previous design feedback and briefs for new projects, and collaborate with the team"
                                  : rolesAndResponsibilitiesController
                                      .selectedResponsibilities.value,
                              secondTextColor: rolesAndResponsibilitiesController
                                      .selectedResponsibilities.value.isEmpty
                                  ? AppColors.hintColor
                                  : AppColors.blackColor,
                            ),
                          ),
                              
                          // Career Milestones (Optional)
                          Obx(
                            () => ExperienceTile(
                              onPressed: () =>
                                  Get.toNamed(RouteHelper.getCareerMileStoneRoute()),
                              firstText: "Career Milestones (Optional)",
                              secondTextSize: font(16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              secondText: professionalAccomplishmentController
                                      .selectedAccomplishment.value.isEmpty
                                  ? "e.g. My greatest achievement' examples could include: Giving a great presentation at work."
                                  : professionalAccomplishmentController
                                      .selectedAccomplishment.value,
                              secondTextColor: professionalAccomplishmentController
                                      .selectedAccomplishment.value.isEmpty
                                  ? AppColors.hintColor
                                  : AppColors.blackColor,
                            ),
                          ),
                          /// This was an internship
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("I have worked as an Intern", style: Styles.bodyLargeMedium),
                              Obx(()=> AppSwitch(
                                  value: workExperienceController.internValue.value,
                                  onChanged: (bool? val){
                                    workExperienceController.internValue.value = val!;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                    
                          /// Hide my information from this company
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Dimensions.screenWidth - 150,
                                child: Text("Hide my professional details from this company",
                                    style: Styles.bodyLargeMedium),
                              ),
                              Obx(()=>AppSwitch(
                                  value: workExperienceController.hideInformValue.value,
                                  onChanged: (bool? val){
                                    workExperienceController.hideInformValue.value = val!;
                                  },),
                              ),
                            ],
                          ),
                          const Gap(65),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
        bottomNavigationBar: Obx(()=> SafeArea(
          child: Row(
            children: [
            myResumeController.myresume == null || myResumeController.myresume!.workexperience == null ? SizedBox() : HiveHelp.read(Keys.isWorkExpDeleteOption) == true && myResumeController.myresume!.workexperience!.length > 1 ?  Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: width(15),bottom: height(10)),
                  child: AppButton(
                    text: workExperienceController.isDeleting.value ? "Deleting..." : "Delete",
                    onTap: workExperienceController.isDeleting.value ? null : (){
                      workExperienceController.deleteSingleWorkExps(id: experienceId);
                    },
                   textColor: AppColors.jobClosedColor,
                   bgColor: Colors.transparent,
                   borderColor: AppColors.borderColor,
                  ),
                ),
              ) : SizedBox(),
             myResumeController.myresume == null || myResumeController.myresume!.workexperience == null ? 
             Gap(0) : Gap(HiveHelp.read(Keys.isWorkExpDeleteOption) == true && myResumeController.myresume!.workexperience!.length > 1 ? 10:0),
              Expanded(
                child: BottomNavWidget(
                     text: workExperienceController.isLoading.value ? "Saving..." : HiveHelp.read(Keys.isWorkExpDeleteOption) == true ? "Save" : "Save & Next",
                     onTap: workExperienceController.isLoading.value ? null : () {
                      if(WorkExperienceController.to.selectedCompanyName.value.isEmpty){
                        Helpers().showToastMessage(
                          msg: "Company name is required.",
                          gravity: ToastGravity.CENTER
                        );
                      }
                       if(industryControler.jobIndustryName.value.isEmpty){
                        Helpers().showToastMessage(
                          msg: "Industry is required.",
                          gravity: ToastGravity.CENTER
                        );
                      }
                      else if(workExperienceController.selectedStartTime.value.isEmpty
                        || workExperienceController.selectedEndTime.value.isEmpty){
                        Helpers().showToastMessage(
                          msg: "Start & End Time is required.",
                          gravity: ToastGravity.CENTER
                        );
                      }
                      else if(functilnalAreaController.selectedFuncationalNameValue.value.isEmpty){
                        Helpers().showToastMessage(
                          msg: "Expertise Area is required.",
                          gravity: ToastGravity.CENTER
                        );
                      }
                      else if(myDesignationController.selectedDesignation.value.isEmpty){
                        Helpers().showToastMessage(
                          msg: "My Designation is required.",
                          gravity: ToastGravity.CENTER
                        );
                      }
                      else if(rolesAndResponsibilitiesController.selectedResponsibilities.value.isEmpty){
                        Helpers().showToastMessage(
                          msg: "Duties & Responsibilities is required.",
                          gravity: ToastGravity.CENTER
                        );
                      }else{
                        /// check, start date and end date value should not be a minus(-) value or negative value
                            var startYear = workExperienceController.selectedStartTime.split(" ").last;
                            var endYear;
                            if(workExperienceController.selectedEndTime.contains("Present")){
                              endYear = workExperienceController.selectedEndTime.replaceAll("Present", DateTime.now().year.toString());
                            }
                            if(!workExperienceController.selectedEndTime.contains("Present")){
                              endYear = workExperienceController.selectedEndTime.split(" ").last;
                            }
                            if(int.parse(endYear) < int.parse(startYear)){
                              Helpers().showValidationErrorDialog(
                                durationTime: 5,
                                messageText: Text("The end time must be greater than the start time and should not be a negative value.",
                                style: TextStyle(color: Colors.white),));
                            }
                          else{
                            WorkExperiencePostModel workExperiencePostModel = WorkExperiencePostModel(
                              category: industryControler.categoryId.value,
                              startdate: workExperienceController.formattedStartDateFromUi,
                              enddate: workExperienceController.formattedEndDateFromUi,
                              expertisearea: functilnalAreaController.selectValueFunctionalNameId.value,
                              designation: myDesignationController.selectedDesignation.value,
                              dutiesandresponsibilities: rolesAndResponsibilitiesController.selectedResponsibilities.value,
                              workintern:workExperienceController.internValue.value,
                              hidedetails:workExperienceController.hideInformValue.value,
                              companyname: workExperienceController.selectedCompanyName.value,
                              department: departmentController.selectedDepartment.value,
                              careermilestones: professionalAccomplishmentController.selectedAccomplishment.value,
                              
                            );
                            HiveHelp.read(Keys.isWorkExpDeleteOption) == true ?
                            workExperienceController.updateWorkExp(workExperiencePostModel: workExperiencePostModel,id: experienceId)
                            : 
                            workExperienceController.postWorkExperience(workExperiencePostModel);
                          }
                      }
                    },
                ),
              ),
            ],
          ),
        ),
           ),
      ),
    );
  }
  onBackPressed(context) {
            if(HiveHelp.read(Keys.isWorkExpDeleteOption) == false){
              if(WorkExperienceController.to.selectedCompanyName.value.isNotEmpty ||
                industryControler.jobIndustryName.value.isNotEmpty || 
                workExperienceController.selectedStartTime.value.isNotEmpty || 
                workExperienceController.selectedEndTime.value.isNotEmpty ||
                functilnalAreaController.selectedFuncationalNameValue.value.isNotEmpty ||
                myDesignationController.selectedDesignation.value.isNotEmpty ||
                rolesAndResponsibilitiesController.selectedResponsibilities.value.isNotEmpty){
                AppPopupDialog().showPopup(
                  context: context,
                  isTitle: true,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  titleText: "Authorization Request",
                  description: "The content has not been saved yet, do you want to exit?",
                  descriptionStyle: Styles.bodySmall2,
                  buttonOkText: "Exit anyway",
                  bRadius: 3,
                  insetPadding: Dimensions.kDefaultPadding,
                  buttonOkColor: Colors.transparent,
                  buttonOkTextColor: AppColors.mainColor,
                  buttonCancelColor: Colors.transparent,
                  buttonCancelTextColor: AppColors.blackColor.withOpacity(.5),
                  onOkPress: (){
                    Get.back();
                    Get.back();
                  },
                  onCancelPress: () => Get.back(),
                );
              }else{
                Get.back();
              }
            }
            else{
              Get.back();
            }
          }
}

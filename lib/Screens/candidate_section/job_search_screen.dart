import 'package:bringin/Screens/candidate_section/select_location/select_location_screen.dart';
import 'package:bringin/controllers/candidate_section/select_location_controller.dart';
import 'package:bringin/res/color.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../Hive/hive_collection_var.dart';
import '../../controllers/candidate_section/job_controll.dart';
import '../../controllers/recruiter_section/recruiter_job_post_controller.dart';
import '../../models/recent_job_search_model.dart';
import '../../res/app_font.dart';
import '../../res/constants/app_constants.dart';
import '../../res/constants/image_path.dart';
import '../../res/dimensions.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/app_search_form_field.dart';
import '../../widgets/app_search_widget.dart';
import '../../widgets/jobs_tile.dart';
import '../recruiter_section/job_details_screen.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {

  final jobcontroll = Get.put(JobControll());
  RecruiterJobPostController recruiterJobPostController =
        Get.find<RecruiterJobPostController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        jobcontroll.searchjob.clear();
        jobcontroll.jobTitleField.clear();
        jobcontroll.jobTitleField.text = "";
        jobcontroll.isSearchTapped.value = false;
        recruiterJobPostController.isTapped.value = false;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextButton(
              onPressed: () {
                jobcontroll.searchjob.clear();
                jobcontroll.jobTitleField.clear();
                jobcontroll.jobTitleField.text = "";
                jobcontroll.isSearchTapped.value = false;
                recruiterJobPostController.isTapped.value = false;
                Get.back();
              },
              child: Text("Cancel", style: Styles.bodyLargeSemiBold)),
          actions: [
            TextButton(
              onPressed: (){
                if(jobcontroll.jobLocationField.text.isEmpty || jobcontroll.jobTitleField.text.isEmpty){
                  Helpers().showValidationErrorDialog(
                    errorText: "Jot title and job location field is required."
                  );
                }
                else{
                  recruiterJobPostController.isTapped.value = false;
                  Helpers.hideKeyboard();
                  jobcontroll.jobSearch(jobcontroll.jobTitleField.text, jobcontroll.selectedDivision+"|"+jobcontroll.jobLocationField.text);
                  var recentData = RecentJobSearchModel(
                    jobTitle: jobcontroll.jobTitleField.text.trim(),
                    city: jobcontroll.jobLocationField.text.trim(),
                    division: jobcontroll.selectedDivision,
                  );
                  recentBox.put('key_${jobcontroll.jobTitleField.text.trim()}', recentData);
                }
              }, 
              child: Text("Search",style: Styles.bodyLargeSemiBold)),
           const Gap(20),
          ],
        ),
        body: Container(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            children: [
              InkWell(
                onTap: ()=>Get.to(()=> SearchPage()),
                child: IgnorePointer(
                  ignoring: true,
                  child: CustomSearchField(
                      controller: jobcontroll.jobTitleField,
                      hinText: 'Job Title',
                      // hinText: 'Job Title, Keyword, Industry',
                      radius: radius(24),
                      height: height(38),
                      onChanged: (value){
                        if(value.isNotEmpty){
                        recruiterJobPostController.getJobTitle(userInput: value);
                        setState(() {
                        
                      });
                      }else{
                        recruiterJobPostController.jobTitleList.clear();
                        setState(() {
                        
                      });
                      }
                      
                      },
                      prefixIcon: Padding(
                        padding: Dimensions.kDefaultPadding,
                        child: SvgPicture.asset(
                          AppImagePaths.searchIcon,
                          alignment: Alignment.center,
                          height: height(14),
                        ),
                      ),
                      suffixIcon: SizedBox()),
                ),
              ),
              const Gap(10),
              InkWell(
                onTap: (){
                  if(SelectLocationController.to.allLocationList.isEmpty){
                    SelectLocationController.to.getAllLocation();
                    Get.to(()=>SelectLocationScreen(isJobSearch: true));
                  }
                  else{
                    Get.to(()=>SelectLocationScreen(isJobSearch: true));
                  }
                },
                child: IgnorePointer(
                  ignoring: true,
                  child: CustomSearchField(
                      controller: jobcontroll.jobLocationField,
                      hinText: 'Location, City',
                      radius: radius(24),
                      height: height(38),
                      prefixIcon: Padding(
                        padding: Dimensions.kDefaultPadding,
                        child: SvgPicture.asset(
                          AppImagePaths.locationIcon,
                          alignment: Alignment.center,
                          height: height(14),
                        ),
                      ),
                      suffixIcon: SizedBox()),
                ),
              ),
              SizedBox(
                height: height(15),
              ),
              GetBuilder<JobControll>(builder: (_){
                return Flexible(child:  Obx(() => jobcontroll.isSearching.value
                      ? Center(child: Helpers.appLoader2())
                      : jobcontroll.searchjob.isEmpty && jobcontroll.isSearchTapped.value
                          ? Center(
                              child: Text("No jobs found"),
                            )
                          : jobcontroll.searchjob.isEmpty
                          ? recentBox != null && recentBox.isNotEmpty
                          ? RecentSearch(onClear: ()=> jobcontroll.clearAll())
                          : SizedBox()
                          : SearchedJobList()),
               );
              })
            ],
          ),
        ),
      ),
    );
  }


 Widget SearchedJobList() {
    return ListView.builder(
                            itemCount: jobcontroll.searchjob.length,
                            itemBuilder: (context, index) {
                              var data = jobcontroll.searchjob[index];
                              return InkWell(
                                  onTap: () async{
                                    await jobcontroll.jobViewCount(fields: {
                                      "jobid": data.id,
                                      "jobpost_userid": data.userid!.id,
                                    });
                                    Get.to(JobDetailsScreen(jobid: data.id!));
                                  },
                                  child: JobsTile(
                        jobTitle: data!.jobTitle ?? "",
                        salary: data.salary == null
                            ? ""
                            : data.salary!.minSalary!.type == 0 && data.salary!.maxSalary!.type == 0 
                                   ? "Negotiable" : data.salary!.minSalary!.salary.toString() +
                                      "K-" +
                                      data.salary!.maxSalary!.salary.toString() +
                                      "K " +
                                      data.salary!.minSalary!.currency!,
                        child: Text(
                          data.jobDescription ?? "",
                          style: Styles.smallText2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        experienceLevel: data.experience == null
                            ? ""
                            : "${data.experience!.name}",
                        educationLevel: data.education == null
                            ? ""
                            : "${data.education!.name}",
                        companyName: data.company == null
                            ? "null"
                            : "${data.company!.legalName}",
                        employeeSize: data.company == null
                            ? ""
                            : "${data.company!.cSize!.size} Employees",
                        userPhoto: data.userid == null
                            ? "https://www.w3schools.com/howto/img_avatar.png"
                            : "${AppConstants.imgurl}" +
                                "${data.userid!.image}",
                        userName: data.userid == null
                            ? ""
                            : "${data.userid!.firstname}" +
                                " ${data.userid!.lastname}",
                        designation: data.userid == null
                            ? ""
                            : "${data.userid!.designation}",
                        location: data.jobLocation == null ?
                            data.company!.cLocation!.divisiondata!.divisionname! + ", "+ data.company!.cLocation!.divisiondata!.cityid!.name!
                            : data.jobLocation!.divisiondata!.divisionname! + ", "+ data.jobLocation!.divisiondata!.cityid!.name!,
                                            isPremium:
                                                    data.userid == null
                                                ? false
                                                : data.userid!.other!.premium,
                                            isRemote:  data.remote,
                      ),);
                            });
  }
 Widget RecentSearch({void Function()? onClear}){
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.appBorder,width: .5),
      borderRadius: BorderRadius.circular(radius(9)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: width(15),
            right: width(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Searches",style: Styles.bodyLarge),
              IconButton(
                onPressed: onClear,
                icon: Icon(Icons.delete_outlined,color: Colors.grey[600]),
              )
            ],
          ),
        ),
        const Gap(10),
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            child: ListView.builder(
              itemCount: recentBox.length,
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (_,index){
                RecentJobSearchModel recent = recentBox.getAt(index);
                return ListTile(
                  onTap: (){
                    jobcontroll.jobSearch(recent.jobTitle, recent.division+"|"+recent.city);
                    jobcontroll.jobTitleField.text = recent.jobTitle;
                    jobcontroll.selectedDivision = recent.division;
                    jobcontroll.jobLocationField.text = recent.city;
                  },
                  title: Text(recent.jobTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.bodyLarge),
                  subtitle: Text(
                    recent.city+", "+ recent.division,
                    maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                    style: Styles.bodyMedium3,),
                  trailing: SvgPicture.asset(AppImagePaths.arrowForwardIcon),
                );
              }
            ),
          ),
        ),
      ],
    ),
  );
 }
}
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    RecruiterJobPostController recruiterJobPostController =
        Get.find<RecruiterJobPostController>();
        final jobcontroll = Get.put(JobControll());
    return WillPopScope(
      onWillPop: () async{
        var isTapped = recruiterJobPostController.isTapped.value;
        if(isTapped){
          recruiterJobPostController.isTapped.value = false;
          recruiterJobPostController.jobTitleList.clear();
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
              recruiterJobPostController.jobTitleList.clear();
              Get.back();
            },
            actions: []
          ),
          body: Padding(
            padding: Dimensions.kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                /// job title searching field
                AppSearchWidget(
                  autofocus: true,
                  controller: searchController,
                  hinText: 'Job Title',
                  borderRadius: BorderRadius.circular(radius(24)),
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
                      : recruiterJobPostController.jobTitleList.isEmpty && recruiterJobPostController.isTapped.value?
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
                                  .jobTitleList.length,
                              itemBuilder: (_, index) {
                                var data = recruiterJobPostController.jobTitleList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: AppColors.borderColor,
                                    width: 0.25,
                                  ))),
                                  child: ListTile(
                                    onTap: () {
                                       jobcontroll.jobTitleField.text =
                                          recruiterJobPostController
                                              .jobTitleList[index].functionalname!;
                                      recruiterJobPostController.isTapped.value = false;
                                      recruiterJobPostController.jobTitleList.clear();
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

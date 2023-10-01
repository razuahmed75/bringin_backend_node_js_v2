import 'package:bringin/controllers/candidate_section/job_controll.dart';
import 'package:bringin/Screens/recruiter_section/job_details_screen.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../res/dimensions.dart';
import '../../../../utils/services/keys.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/jobs_tile.dart';
import '../../Hive/hive.dart';


class CvSentHistoryScreen extends StatelessWidget {
  const CvSentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JobControll.to.getCvSentHistory();
    JobControll jobControll = Get.find();
    return Scaffold(
      appBar: appBarWidget(
          title: "CV Sent", onBackPressed: () => Get.back(), actions: []),
      body: SafeArea(
        child: Padding(
          padding: Dimensions.kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimensions.kDefaultgapTop,

              /// JOB TITLE
              Obx(
                () => jobControll.isLoading.value
                    ? Helpers.appLoader()
                    : jobControll.cvSentHistoryList.isEmpty
                        ? Container(
                            height: Dimensions.screenHeight * .5,
                            width: double.maxFinite,
                            child: Center(
                              child: Text("Not found"),
                            ),
                          )
                        : Expanded(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount:
                                      jobControll.cvSentHistoryList.length,
                                  itemBuilder: (_, index) {
                                    var data =
                                        jobControll.cvSentHistoryList[index];
                                    return InkWell(
                                      onTap: () {
                                        print(HiveHelp.read(Keys.authToken));
                                        print(
                                            "Job id is=========================" +
                                                data.id.toString());
                                        if (data.id != null) {
                                          Get.to(() =>
                                              JobDetailsScreen(jobid: data.id));
                                        } else {
                                          Helpers().showToastMessage(
                                              msg: "Something went wrong");
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          JobsTile(
                                            jobTitle: data == null
                                                ? ""
                                                : data.jobTitle ?? "",
                                            salary: data == null
                                                ? ""
                                                : data.salary == null
                                                    ? ""
                                                    : data.salary!.minSalary!
                                                                    .type ==
                                                                0 &&
                                                            data.salary!.maxSalary!
                                                                    .type ==
                                                                0
                                                        ? "Negotiable"
                                                        : data.salary!
                                                                .minSalary!.salary
                                                                .toString() +
                                                            "K-" +
                                                            data
                                                                .salary!
                                                                .maxSalary!
                                                                .salary
                                                                .toString() +
                                                            "K " +
                                                            data
                                                                .salary!
                                                                .minSalary!
                                                                .currency!,
                                            jobDescription: data!.jobDescription ?? "",
                                            experienceLevel: 
                                                    data.experience == null
                                                ? ""
                                                : "${data.experience!.name}",
                                            educationLevel: 
                                                    data.education == null
                                                ? ""
                                                : "${data.education!.name}",
                                            companyName: 
                                                    data.company == null
                                                ? "null"
                                                : "${data.company!.legalName}",
                                            employeeSize: 
                                                    data.company == null
                                                ? ""
                                                : "${data.company!.cSize!.size} Employees",
                                            userPhoto:
                                                    data.userid == null
                                                ? "https://www.w3schools.com/howto/img_avatar.png"
                                                : "${AppConstants.imgurl}" +
                                                    "${data.userid!.image}",
                                            userName: 
                                                    data.userid == null
                                                ? ""
                                                : "${data.userid!.firstname}" +
                                                    " ${data.userid!.lastname}",
                                            designation: 
                                                    data.userid == null
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
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

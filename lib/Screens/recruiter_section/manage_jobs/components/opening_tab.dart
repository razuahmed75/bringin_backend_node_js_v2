

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/recruiter_section/job_post_preview_controller.dart';
import '../../../../controllers/recruiter_section/managejob_controll.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../widgets/empty_job_post_tile.dart';
import '../../../../widgets/jobs_opening_tile.dart';
import '../../job_post_preview_page.dart';

class OpeningTab extends StatefulWidget {
  const OpeningTab({super.key});

  @override
  State<OpeningTab> createState() => _OpeningTabState();
}

class _OpeningTabState extends State<OpeningTab> {
  final managejobcontrol = Get.put(ManagejobControll());

  bool loading = true;

  Future loaddata() async {
    await managejobcontrol.getopenjob();
    if(mounted){
      setState(() {
      loading = false;
    });
    }
  }

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Helpers.appLoader()
        : SingleChildScrollView(
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Obx((){
                return managejobcontrol.openingJoblist.isEmpty 
                ? Center(child: EmptyJobPostTile(text: "There are no opening jobs"))
                : Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: managejobcontrol.openingJoblist.length,
                      itemBuilder: (_, index) {
                        var data = managejobcontrol.openingJoblist[index];
                        return JobsOpeningTile(
                          onTap: () {
                          log(data.id.toString());
                          Get.put(JobPostPreviewController())
                              .getJobPreviewData(jobId: data.id);
                          Get.to(JobPostPreviewPage(managejob: true, tabindex: 1, jobid: data.id));
                        },
                          jobTitle: data!.jobTitle ?? "", 
                          jobDescription: data.jobDescription ?? "",
                          salary: data.salary == null ? "":data.salary!.minSalary!.type == 0 && data.salary!.maxSalary!.type == 0 
                                       ? "Negotiable" : data.salary!.minSalary!.salary.toString() +
                                          "K-" +
                                          data.salary!.maxSalary!.salary.toString() +
                                          "K " +
                                          data.salary!.minSalary!.currency!, 
                          experienceLevel: data.experience == null ? "":data.experience!.name ?? "", 
                          educationLevel: data.education == null ? "":data.education!.name ?? "", 
                          location: data.jobLocation == null ?
                            data.company!.cLocation!.divisiondata!.divisionname! + ", "+ data.company!.cLocation!.divisiondata!.cityid!.name!
                            : data.jobLocation!.divisiondata!.divisionname! + ", "+ data.jobLocation!.divisiondata!.cityid!.name!,
                        );
                      }),
                );
               }),
              ],
            )),
          );
  }
}

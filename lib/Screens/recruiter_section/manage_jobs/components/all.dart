
import 'dart:developer';

import 'package:bringin/utils/routes/screen_lists.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/recruiter_section/job_post_preview_controller.dart';
import '../../../../controllers/recruiter_section/managejob_controll.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../widgets/empty_job_post_tile.dart';
import '../../../../widgets/jobs_opening_tile.dart';


class AllJob extends StatefulWidget {
  const AllJob({super.key});

  @override
  State<AllJob> createState() => _AllJobState();
}

class _AllJobState extends State<AllJob> {
  final managejobcontrol = Get.put(ManagejobControll());

  bool loading = true;

  Future loaddata() async {
    await managejobcontrol.getalljob();
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
        : Obx(()=> managejobcontrol.allJoblist.isEmpty 
        ? EmptyJobPostTile(text: "There are no job posts") 
        :  ListView.builder(
              itemCount: managejobcontrol.allJoblist.length,
              itemBuilder: (context, index) {
                
                var data = managejobcontrol.allJoblist[index];
                return JobsOpeningTile(
                  onTap: () {
                      log(data.id!);
                      Get.put(JobPostPreviewController()).getJobPreviewData(jobId: data.id);
                      Get.to(JobPostPreviewPage(managejob: true, tabindex: 0,jobid: data.id));
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
              },
            ),
        );
  }
  
}

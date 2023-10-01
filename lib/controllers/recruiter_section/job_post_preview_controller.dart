import 'dart:convert';

import 'package:bringin/res/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Http/get.dart';
import '../../models/recruiter_section/job_post_preview_model.dart';

class JobPostPreviewController extends GetxController{
  static JobPostPreviewController get to => Get.find();

  RxBool isLoading = false.obs;
  List<JobPreviewModel> jobList = [];
  var formattedJobPostDate;

  Future<void> getJobPreviewData({required jobId}) async{
    isLoading.value = true;
    print("Getting data..................");
    await Httphelp.get(
      ENDPOINT_URL: "${AppConstants.jobDetailsUrl}" "?jobid=$jobId").then((data){
        jobList=[];
        jobList.add(JobPreviewModel.fromJson(jsonDecode(data.body)));

        // isLoading.value  = false;
        if(data.statusCode==200){
          /// FORMAT DATE TIME
        var d = "2023-07-05T11:15:18.154Z";
        DateTime date = DateTime.parse(jobList[0].postdate == null ? d : jobList[0].postdate.toString());
         formattedJobPostDate = DateFormat('dd MMMM yyyy').format(date);
          print(formattedJobPostDate);  // Output as like: 27 May 2023
          isLoading.value = false;
        }
        else{
          jobList=[];
          print(data.body);
          isLoading.value = false;
        }
      });
  }
}
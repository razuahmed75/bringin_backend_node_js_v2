import 'dart:convert';
import 'package:bringin/Http/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../models/Reject_Candidate/reject_candidate.dart';
import '../../models/recruiter_section/job_post_preview_model.dart';
import '../../models/recruiter_section/job_post_update_model.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/app_constants.dart';
import '../../res/constants/image_path.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';

class ManagejobControll extends GetxController {
  var allJoblist = <JobPreviewModel?>[].obs;
  var openingJoblist = <JobPreviewModel?>[].obs;
  var closedJoblist = <JobPreviewModel?>[].obs;

  /// ALL JOBS
  Future<void> getalljob() async {
    var data = await Httphelp.get(
        ENDPOINT_URL: AppConstants.manageJobsUrl + "?type=0");
    allJoblist.clear();
    if (data.statusCode == 200) {
      allJoblist.value = jobPreviewModelFromJson(data.body);
      // joblist.reversed.toList();
      allJoblist.sort((a, b) => b!.createdAt!.compareTo(a!.createdAt!));
    } else {
      allJoblist.value = [];
    }
  }

  /// OPENING JOBS
  RxBool isOpeningJob = false.obs;
  Future getopenjob() async {
    isOpeningJob.value = true;
    var data = await Httphelp.get(
        ENDPOINT_URL: AppConstants.manageJobsUrl + "?type=1");
    openingJoblist.clear();
    if (data.statusCode == 200) {
      openingJoblist.value = jobPreviewModelFromJson(data.body);
    } else {
      openingJoblist.value = [];
    }
  }

  /// GET CLOSE JOBS
  RxBool isClosingJob = false.obs;
  Future getclosejob() async {
    isClosingJob.value = true;
    var data = await Httphelp.get(
        ENDPOINT_URL: AppConstants.manageJobsUrl + "?type=2");
    closedJoblist.clear();
    if (data.statusCode == 200) {
      closedJoblist.value = jobPreviewModelFromJson(data.body);
    } else {
      closedJoblist.value = [];
    }
  }

  /// GET REJECTED JOBS
  List<RejectCandidate> rejectedCandidateList = <RejectCandidate>[].obs;
  Future getrejectjob() async {
    var data = await Httphelp.get(ENDPOINT_URL: AppConstants.rejectedJobsUrl);
    rejectedCandidateList.clear();
    if (data.statusCode == 200) {
      rejectedCandidateList = rejectCandidateFromJson(data.body);
    } else {
      rejectedCandidateList = [];
    }
    update();
  }

  /// REPOST JOB
  Future repost_closejob({String? jobid, Map<String, dynamic>? fields}) async {
    print("reposting......");
    Helpers().showToastMessage(msg: "Reposting job...");
    var data = await Httphelp.post(
        ENDPOINT_URL: AppConstants.updateJobPostUrl + "?jobid=$jobid",
        fields: fields);
    if (data.statusCode == 200) {
      getclosejob();
      Helpers().showToastMessage(msg: "Successfully Reposted");
    } else {
      Helpers().showToastMessage(msg: jsonDecode(data.body)['message']);
      print(data.body);
    }

    update();
  }

  /// DELETE JOB
  Future deleteJob(String jobId) async {
    print("deleting.....");
    Helpers().showToastMessage(msg: "Deleting job...");
    var data = await Httphelp.delete(
        ENDPOINT_URL: AppConstants.updateJobPostUrl + "?jobid=$jobId");
    if (data.statusCode == 200) {
      getclosejob();
      Helpers().showToastMessage(msg: "Successfully Deleted");
      print(data.body);
    } else {
      Helpers().showToastMessage(msg: jsonDecode(data.body)['message']);
      print(data.body);
    }

    Get.back();
    update();
  }

  /// CLOSE A JOB
  Future closejob({String? jobId, Map<String, dynamic>? fields}) async {
    print("closing job...");
    Helpers().showToastMessage(msg: "Closing job...");
    var data = await Httphelp.post(
        ENDPOINT_URL: AppConstants.updateJobPostUrl + "?jobid=$jobId",
        fields: fields);
    if (data.statusCode == 200) {
      getopenjob();
      print(data.body);
    } else {
      Helpers().showToastMessage(msg: jsonDecode(data.body)['message']);
      print(data);
    }
    update();
  }

  /// UPDATE JOB POST
  RxBool isUpdatingJobPost = false.obs;
  Future<void> updateJobPost({String? jobId, JobPostUpdateModel? data}) async {
    print("updating job post....");
    Helpers().showToastMessage(
        msg: "Updating your job post", gravity: ToastGravity.CENTER);
    isUpdatingJobPost.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.updateJobPostUrl + "?jobid=$jobId",
            fields: data!.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        isUpdatingJobPost.value = false;
        Helpers().showToastMessage(msg: "Successfully updated");
        Get.back();
        Get.back();
        print(value.body);
      } else {
        isUpdatingJobPost.value = false;
        print(value);
        Helpers().showToastMessage(msg: jsonDecode(value.body)['message']);
      }
    });
  }

  AlertDialog alert = AlertDialog(
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius(10))),
    actions: [
      Padding(
        padding:
            EdgeInsets.symmetric(vertical: height(21), horizontal: width(15)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImagePaths.deleteIcon2,
              height: height(49),
              width: height(49),
            ),
            Gap(width(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Closed job post has been archived to ',
                          style: Styles.bodyLarge
                              .copyWith(color: AppColors.blackOpacity70),
                        ),
                        TextSpan(
                          text: 'Manage Jobs.',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get
                              ..back()
                              ..back()
                              ..back(),
                          style: Styles.bodyLarge
                              .copyWith(color: AppColors.mainColor),
                        ),
                      ],
                    ),
                  ),
                  Gap(height(12)),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'If you want you can ',
                            style: Styles.bodyLarge
                                .copyWith(color: AppColors.blackOpacity70)),
                        TextSpan(
                            text: 'repost.', style: Styles.bodyLargeMedium),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
  dialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

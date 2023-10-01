import 'package:bringin/res/constants/app_constants.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controllers/candidate_section/job_controll.dart';
import '../../../../../models/recruiter_section/job_post_preview_model.dart';
import '../../../../../widgets/jobs_tile.dart';
import '../../../../../widgets/shimmer_effect.dart';
import '../../../../recruiter_section/job_details_screen.dart';

class JobListPage extends StatefulWidget {
  final int index;
  const JobListPage({Key? key, required this.index}) : super(key: key);

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  final jobs = Get.find<JobControll>();

  // LatLng? _initialPosition;
  // final mapcontroll = Get.put(MapControll());

  // Future location() async {
  //   await mapcontroll.determinePosition();
  //   _initialPosition = LatLng(
  //     mapcontroll.position!.latitude,
  //     mapcontroll.position!.longitude,
  //   );
  //   // HttpMap().reverseGeocodeLatLng(_initialPosition!);
  //   setState(() {});
  // }

  bool loading = false;
  List<JobPreviewModel?>? joblist = [];
  Future loaddata() async {
    setState(() {
      loading = true;
    });
    joblist = await jobs.getjoblist(index: widget.index);
    jobs.tabIndex = widget.index;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // print(box.read(Keys.authToken));
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobControll>(builder: (jobcontroll) {
      return Scaffold(
          body: loading
              ? ShimmerEffect()
              : joblist!.isEmpty
                  ? Center(
                      child: Text("No jobs found"),
                    )
                  : Obx(
                      () => ListView.builder(
                          itemCount: jobs.joblistfilter.value
                              ? jobs.joblistfilterdata.length
                              : jobs.isLocationFilter.value
                                  ? jobs.filteredJob.length
                                  : joblist!.length,
                          itemBuilder: (context, index) {
                            var data = jobs.joblistfilter.value
                                ? jobs.joblistfilterdata[index]
                                : jobs.isLocationFilter.value
                                    ? jobs.filteredJob[index]
                                    : joblist![index];
                            return InkWell(
                              onTap: () async {
                                await jobcontroll.jobViewCount(fields: {
                                  "jobid": data.id,
                                  "jobpost_userid": data.userid!.id,
                                });
                                Get.to(() => JobDetailsScreen(
                                      jobid: data.id,
                                    ));

                                print("job id is: " + data.id.toString());
                                print("recruiter id is: " +
                                    data.userid!.id.toString());
                              },
                              child: Padding(
                                padding: Dimensions.kDefaultPadding,
                                child: JobsTile(
                                  jobTitle: data!.jobTitle ?? "",
                                  salary: data.salary == null
                                      ? ""
                                      : data.salary!.minSalary!.type == 0 &&
                                              data.salary!.maxSalary!.type == 0
                                          ? "Negotiable"
                                          : data.salary!.minSalary!.salary
                                                  .toString() +
                                              "K-" +
                                              data.salary!.maxSalary!.salary
                                                  .toString() +
                                              "K " +
                                              data.salary!.minSalary!.currency!,
                                  jobDescription: data.jobDescription ?? "",
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
                                  location: data.jobLocation == null
                                      ? data.company!.cLocation!.divisiondata!
                                              .divisionname! +
                                          ", " +
                                          data.company!.cLocation!.divisiondata!
                                              .cityid!.name!
                                      : data.jobLocation!.divisiondata!
                                              .divisionname! +
                                          ", " +
                                          data.jobLocation!.divisiondata!
                                              .cityid!.name!,
                                  isPremium: data.userid == null ||
                                          data.userid!.other == null
                                      ? false
                                      : data.userid!.other!.premium,
                                  isRemote: data.remote,
                                ),
                              ),
                            );
                          }),
                    ));
    });
  }
}

import 'package:bringin/Screens/candidate_section/select_location/select_location_screen.dart';
import 'package:bringin/controllers/candidate_section/candidate_main_profile_controller.dart';
import 'package:bringin/controllers/candidate_section/my_resume_controller.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/utils/services/bindings/bindings_controllers_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';
import '../../../../Hive/hive.dart';
import '../../../../controllers/candidate_section/job_controll.dart';
import '../../../../controllers/recruiter_section/map_controll.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/dimensions.dart';
import '../../../../utils/routes/routes_name.dart';
import '../../../../utils/services/keys.dart';
import '../../../../widgets/filter_box_tile.dart';
import '../../../both_section/Map/pick_map_screen.dart';
import '../../job_filter_screen.dart';
import 'Tab/joblist.dart';

class JobScreen extends StatefulWidget {
  JobScreen({Key? key}) : super(key: key);

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen>
    with SingleTickerProviderStateMixin {
  final jobs = Get.put(JobControll());
  TabController? tabController;
  PageController pageController = PageController();
  bool loading = false;

  Future loaddata() async {
    setState(() {
      loading = true;
    });
    if (jobs.tablist.length < 2) {
      await jobs.getfnctionalarea();
    }

    setState(() {
      loading = false;
    });
  }

  LatLng? _initialPosition;
  final mapcontroll = Get.put(MapControll());
  Future location() async {
    await mapcontroll.determinePosition();
    _initialPosition = LatLng(
      mapcontroll.position!.latitude,
      mapcontroll.position!.longitude,
    );
    setState(() {});
  }

  void showPlacePicker(BuildContext context) async {
    LocationResult result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          kGoogleApiKey,
          defaultLocation: _initialPosition,
        ),
      ),
    );
    jobs.divisionName.value =
        result.administrativeAreaLevel1!.name!.split(" ").first;
    print("divisionName is: ===================" + jobs.divisionName.value);
    jobs.getjoblist(
        index: jobs.tabIndex, divisionName: jobs.divisionName.value, type: "0");
  }

  @override
  void initState() {
    loaddata();
    location();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobControll>(builder: (jobcontroll) {
      return DefaultTabController(
        length: jobcontroll.tablist.length,
        child: Builder(builder: (context) {
          tabController = DefaultTabController.of(context);
          tabController!.addListener(() {
            jobcontroll.joblistfilter.value = false;
            jobcontroll.tabindexchange(tabController!.index);
            jobs.jobfunctionindex.value = tabController!.index;
          });

          // if (HiveHelp.read("tab") == true) {
          //   tabController!.animateTo(0,
          //       duration: Duration(seconds: 1), curve: Curves.easeIn);
          //   HiveHelp.write("tab", false);
          // }

          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tabbox(jobcontroll),
                  loading
                      ? SizedBox()
                      : Flexible(
                          child: TabBarView(
                              dragStartBehavior: DragStartBehavior.start,
                              controller: tabController,
                              children: List.generate(
                                  jobcontroll.tablist.length,
                                  (index) => JobListPage(index: index)))
                          // child: PageView.builder(
                          //   controller: pageController,
                          //   onPageChanged: (value) {
                          //     jobcontroll.tabindexchange(value);
                          //     tabController!.animateTo(value);
                          //   },
                          //   itemCount: jobcontroll.tablist.length,
                          //   itemBuilder: (context, index) {
                          //     return JobListPage(index: index);
                          //   },
                          // ),
                          ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }

  Widget tabbox(JobControll jobcontroll) {
    return PreferredSize(
        child: Container(
          decoration: BoxDecoration(
              color: loading ? Colors.grey.shade100 : Colors.transparent,
              border: Border(
                  bottom: BorderSide(
                width: 4,
                color: AppColors.greyColor.withOpacity(.4),
              ))),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TabBar(
                          onTap: (value) {
                            jobcontroll.tabindexchange(value);
                            pageController.jumpToPage(value);
                          },
                          automaticIndicatorColorAdjustment: true,
                          controller: tabController,
                          tabs: List.generate(jobcontroll.tablist.length,
                              (index) {
                            return Tab(
                                child: Text(
                              jobcontroll.tablist[index],
                              style: TextStyle(
                                  fontSize: index == jobcontroll.tabindex
                                      ? 22.sp
                                      : 16.sp,
                                  fontWeight: index == jobcontroll.tabindex
                                      ? FontWeight.w500
                                      : FontWeight.w400),
                            ));
                          }),
                          labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
                          labelColor: Colors.black,
                          indicatorColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true)),
                  InkWell(
                    onTap: () async {
                      MyResumeController.to.getMyResume();
                      CandidateMainProfileController.to.getCandidateInfo();
                      HiveHelp.write("tab", true);
                      Get.toNamed(RouteHelper.getCareerPreferenceRoute());
                      print(HiveHelp.read(Keys.authToken));
                      HiveHelp.write(Keys.isSeekerFromJobPage, true);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: SvgPicture.asset(
                        AppImagePaths.addIcon,
                        color: AppColors.blackColor,
                        height: 19.h,
                        width: 19.w,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteName.jobSearchScreen);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: SvgPicture.asset(
                        AppImagePaths.search2Icon,
                        color: AppColors.blackColor,
                        height: 21.h,
                        width: 22.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
              Obx(() =>
                  jobs.jobfunctionindex.value != 0 ? filter() : SizedBox())
            ],
          ),
        ),
        preferredSize: Size.fromHeight(50));
  }

  Widget filter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        padding: EdgeInsets.only(bottom: height(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterbox(
              name: "For You",
              textColor: AppColors.blackColor,
              index: 0,
              onTap: () {
                loaddata();
              },
            ),
            filterbox(
              name: "Nearby",
              textColor: AppColors.blackColor.withOpacity(.6),
              index: 1,
              onTap: () {
                showPlacePicker(context);
              },
            ),
            filterbox(
              name: "New",
              textColor: AppColors.blackColor.withOpacity(.6),
              index: 2,
              onTap: () {
                jobs.getjoblist(type: "1", index: jobs.tabIndex);
              },
            ),
            Obx(
              () => filterbox(
                name:
                    SelectLocationController.to.selectedCityValue.value.isEmpty
                        ? "location"
                        : SelectLocationController.to.selectedCityValue.value,
                isIcon: true,
                bgColor: AppColors.iconBgColor,
                textColor: AppColors.blackColor,
                index: 3,
                onTap: () {
                  SelectLocationController.to.getAllLocation();
                  Get.to(SelectLocationScreen(isJobByLocation: true));
                },
              ),
            ),
            filterbox(
              name: "Filter",
              isIcon: true,
              bgColor: AppColors.iconBgColor,
              textColor: AppColors.blackColor,
              index: 4,
              onTap: () {
                Get.to(JobFilterScreen(
                    functionalid: jobs
                        .functionalarea[jobs.jobfunctionindex.value - 1]
                        .functionalarea!
                        .id!));
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bringin/utils/routes/screen_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/place_picker.dart';
import '../../../../controllers/both_category/expertise_area_controller.dart';
import '../../../../controllers/candidate_section/candidate_controll.dart';
import '../../../../controllers/candidate_section/select_location_controller.dart';
import '../../../../controllers/recruiter_section/map_controll.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../widgets/filter_box_tile.dart';
import 'Widget/candidate_item.dart';
import 'Widget/candidatesearch_screen.dart';

class CandidatesScreen extends StatefulWidget {
  const CandidatesScreen({super.key});

  @override
  State<CandidatesScreen> createState() => _CandidatesScreenState();
}

class _CandidatesScreenState extends State<CandidatesScreen>
    with SingleTickerProviderStateMixin {
  final candidatecontroll = Get.put(CandidateControll());
  TabController? tabController;
  bool loading = false;

  Future loaddata() async {
    setState(() {
      loading = true;
    });
    if (candidatecontroll.tablist.length < 2) {
      await candidatecontroll.getcandidatefunctionalarea();
    }

    // await location();
    setState(() {
      loading = false;
    });
  }

  bool showfilter = false;
  int filterindex = 0;

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
    candidatecontroll.divisionName.value =
        result.administrativeAreaLevel1!.name!.split(" ").first;
    print("divisionName is: ===================" +
        candidatecontroll.divisionName.value);
    candidatecontroll.loadcandidate(
        index: candidatecontroll.tabIndex.value,
        location: candidatecontroll.divisionName.value,
        type: "0");
  }

  @override
  void initState() {
    loaddata();
    location();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CandidateControll>(builder: (controller) {
      return SafeArea(
        child: DefaultTabController(
            length: controller.tablist.length,
            child: Builder(builder: (context) {
              tabController = DefaultTabController.of(context)
                ..addListener(() {
                  setState(() {});
                });
              tabController!.addListener(() {
                candidatecontroll.candidatefilter.value = false;
                candidatecontroll.candidatetabindex.value =
                    tabController!.index;
              });
              return Scaffold(
                body: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: loading
                              ? Colors.grey.shade100
                              : Colors.transparent,
                          border: Border(
                              bottom: BorderSide(
                            width: 4,
                            color: AppColors.greyColor.withOpacity(.4),
                          ))),
                      child: PreferredSize(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: tabbar(
                                          controller, tabController!.index)),
                                  SizedBox(width: 5.w),
                                  InkWell(
                                    onTap: () async {
                                      // if (controller.tablist.length >= 6) {
                                      //   Helpers().showToastMessage(
                                      //       msg: "Already 5 expertise area has added");
                                      // } else {
                                      //   Get.put(ExpertiseAreaController())
                                      //       .getFunctionalArea();

                                      //   Get.to(ExpertiseAreaScreen(
                                      //     candidateiteam: true,
                                      //   ))!
                                      //       .then((value) async {
                                      //     await loaddata();
                                      //   });
                                      // }
                                      Get.put(ExpertiseAreaController())
                                          .getFunctionalArea();

                                      Get.to(ExpertiseAreaScreen(
                                        candidateiteam: true,
                                      ))!
                                          .then((value) async {
                                        await loaddata();
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 5.h),
                                      child: SvgPicture.asset(
                                        AppImagePaths.addIcon,
                                        theme: SvgTheme(
                                            currentColor: AppColors.blackColor),
                                        height: 19.h,
                                        width: 19.w,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => CandidatesearchScreen());
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 5.h),
                                      child: SvgPicture.asset(
                                        AppImagePaths.search2Icon,
                                        theme: SvgTheme(
                                            currentColor: AppColors.blackColor),
                                        height: 21.h,
                                        width: 22.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                ],
                              ),
                              Obx(() =>
                                  candidatecontroll.candidatetabindex.value == 0
                                      ? SizedBox()
                                      : filter())
                            ],
                          ),
                          preferredSize: Size.fromHeight(50.h)),
                    ),
                    Flexible(
                      child: TabBarView(
                          children:
                              List.generate(controller.tablist.length, (index) {
                        return CandidateItemPage(
                          index: index,
                        );
                      })),
                    ),
                  ],
                ),
              );
            })),
      );
    });
  }

  Widget tabbar(CandidateControll controller, int tabIndex) {
    return TabBar(
      tabs: List.generate(controller.tablist.length, (index) {
        return Tab(
          child: Text(
            controller.tablist[index],
            style: TextStyle(
                color: index == tabIndex
                    ? AppColors.blackColor
                    : AppColors.blackColor.withOpacity(.5),
                fontSize: index == tabIndex ? 22.sp : 16.sp,
                fontWeight:
                    index == tabIndex ? FontWeight.w500 : FontWeight.w400),
          ),
        );
      }),
      indicatorColor: Colors.transparent,
      labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
      isScrollable: true,
    );
  }

  Widget filter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
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
            index: 0,
            onTap: () {
              showPlacePicker(context);
            },
          ),
          filterbox(
            name: "New",
            textColor: AppColors.blackColor.withOpacity(.6),
            index: 1,
            onTap: () {
              candidatecontroll.loadcandidate(
                  type: "1", index: candidatecontroll.tabIndex.value);
            },
          ),
          Obx(
            () => filterbox(
              name: SelectLocationController.to.selectedCityValue.value.isEmpty
                  ? "location"
                  : SelectLocationController.to.selectedCityValue.value,
              isIcon: true,
              bgColor: AppColors.iconBgColor,
              textColor: AppColors.blackColor,
              index: 3,
              onTap: () {
                SelectLocationController.to.getAllLocation();
                Get.to(SelectLocationScreen(isCandidateByLocation: true));
              },
            ),
          ),
          filterbox(
            name: "Filter",
            isIcon: true,
            bgColor: AppColors.iconBgColor,
            textColor: AppColors.blackColor,
            index: 3,
            onTap: () {
              Get.to(JobFilterScreen(
                  functionalid: candidatecontroll
                      .candidatefunctionalarea[
                          candidatecontroll.candidatetabindex.value - 1]
                      .experticeArea!
                      .id!));
            },
          )
        ],
      ),
    );
  }
}

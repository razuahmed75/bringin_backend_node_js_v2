// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:bringin/Hive/hive.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/candidate_section/candidate_controll.dart';
import '../../../../controllers/candidate_section/job_controll.dart';
import '../../../../controllers/candidate_section/select_location_controller.dart';
import '../../../../controllers/recruiter_section/company_registration_controller.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../utils/services/helpers.dart';
import '../../../../utils/services/keys.dart';

class CitiesAndArea extends StatelessWidget {
  final bool? isJobSearching;
  final bool? isCandidateSearching;
  final bool? isJobByLocation;
  final bool? isCandidateByLocation;
  CitiesAndArea(
      {super.key,
      this.isJobSearching,
      this.isCandidateSearching,
      this.isJobByLocation, this.isCandidateByLocation});
  SelectLocationController _selectLocationController =
      Get.put(SelectLocationController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _selectLocationController.isLoading.value
          ? Helpers.appLoader()
          : _selectLocationController.allLocationList.isEmpty
              ? SizedBox(
                  height: Dimensions.screenHeight * .5,
                  child: Center(
                    child: Text("Not Found"),
                  ),
                )
              : Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// first column
                      Container(
                        width: 155.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// divisions
                            ListTile(
                              title: Text("Divisional Cities",
                                  style: Styles.bodyLargeSemiBold),
                            ),
                            Obx(
                              () => Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            color: AppColors.blackColor
                                                .withOpacity(.2),
                                            width: .7)),
                                  ),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    // physics: NeverScrollableScrollPhysics(),
                                    // shrinkWrap: true,
                                    itemCount: _selectLocationController
                                        .allLocationList.value.length,
                                    itemBuilder: (_, index) {
                                      var data = _selectLocationController
                                          .allLocationList.value[index];
                                      _selectLocationController
                                              .arrowList.value =
                                          List.generate(
                                              _selectLocationController
                                                  .allLocationList.value.length,
                                              (index) => false);
                                      if (_selectLocationController
                                          .arrowList.isNotEmpty) {
                                        _selectLocationController.arrowList[0] =
                                            true;
                                      }
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              _selectLocationController
                                                  .selectedIndex.value = index;
                                              _selectLocationController
                                                  .togleFunc(index);
                                            },
                                            title: Obx(
                                              () => Text("${data.name}",
                                                  style: Styles.bodyMedium2.copyWith(
                                                      color: _selectLocationController
                                                                      .selectedDivision
                                                                      .value ==
                                                                  data ||
                                                              _selectLocationController
                                                                      .selectedIndex
                                                                      .value ==
                                                                  index
                                                          ? AppColors.mainColor
                                                          : AppColors
                                                              .blackOpacity80)),
                                            ),
                                            trailing: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 7.w),
                                              child: Obx(
                                                () => Transform.rotate(
                                                    angle:
                                                        _selectLocationController
                                                                .arrowList
                                                                .value[index]
                                                            ? 1.5
                                                            : -6.2,
                                                    child: SvgPicture.asset(
                                                      AppImagePaths
                                                          .arrowForwardIcon,
                                                      color: _selectLocationController
                                                                      .arrowList
                                                                      .value[
                                                                  index] ==
                                                              true
                                                          ? AppColors.mainColor
                                                          : AppColors
                                                              .blackColor,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// second column
                      Container(
                        width: 160.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text("Popular Area",
                                  style: Styles.bodyLargeSemiBold),
                            ),
                            Obx(
                              () => _selectLocationController.isLoading.value
                                  ? SizedBox.shrink()
                                  : Expanded(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: _selectLocationController
                                            .allLocationList
                                            .value[_selectLocationController
                                                .selectedIndex.value]
                                            .divisionid!
                                            .length,
                                        itemBuilder: (_, index) {
                                          var data = _selectLocationController
                                              .allLocationList
                                              .value[_selectLocationController
                                                  .selectedIndex.value]
                                              .divisionid![index];
                                          return InkWell(
                                            onTap: () {
                                              if (isJobSearching == true) {
                                                JobControll.to.jobLocationField
                                                    .text = data.divisionname!;
                                                JobControll
                                                        .to.selectedDivision =
                                                    data.cityid!.name!;
                                                //           print(data.divisionname);
                                                // print(data.cityid!.name);
                                                Get.back();
                                              } else if (isCandidateSearching ==
                                                  true) {
                                                CandidateControll
                                                    .to
                                                    .candidateLocationField
                                                    .text = data.divisionname!;
                                                CandidateControll.to
                                                        .candidatelocationid =
                                                    data.cityid!.id!;
                                                Get.back();
                                              } else if (isJobByLocation ==
                                                  true) {
                                                JobControll.to.getjoblist(
                                                    divisionId: data.id,
                                                    type: "2",
                                                    index: JobControll
                                                        .to.tabIndex);
                                                _selectLocationController
                                                    .selectedCityValue
                                                    .value = data.divisionname!;
                                                print(data.id);
                                                print(HiveHelp.read(
                                                    Keys.authToken));
                                                Get.back();
                                              } else if (isCandidateByLocation == true) {
                                          CandidateControll.to.loadcandidate(
                                              divisionId: data.id, type: "2",index: CandidateControll.to.tabIndex.value);
                                          _selectLocationController
                                              .selectedCityValue
                                              .value = data.divisionname!;
                                          Get.back();
                                        }
                                              else {
                                                if (HiveHelp.read(
                                                        Keys.isRecruiter) ==
                                                    true) {
                                                  CompanyRegistrationController
                                                      .to
                                                      .selectedLocation
                                                      .value = data
                                                          .divisionname! +
                                                      ", " +
                                                      _selectLocationController
                                                          .allLocationList[
                                                              _selectLocationController
                                                                  .selectedIndex
                                                                  .value]
                                                          .name!;
                                                  CompanyRegistrationController
                                                      .to
                                                      .selectedLocationId
                                                      .value = data.id!;
                                                  print("Location: " +
                                                      CompanyRegistrationController
                                                          .to
                                                          .selectedLocation
                                                          .value);
                                                  print("division id: " +
                                                      CompanyRegistrationController
                                                          .to
                                                          .selectedLocationId
                                                          .value);
                                                  Get.back();
                                                } else {
                                                  _selectLocationController
                                                          .selectedCityValue
                                                          .value =
                                                      data.divisionname
                                                          .toString();
                                                  _selectLocationController
                                                          .selectedDivision
                                                          .value =
                                                      _selectLocationController
                                                          .allLocationList[
                                                              _selectLocationController
                                                                  .selectedIndex
                                                                  .value]
                                                          .name!;
                                                  _selectLocationController
                                                      .selectedDivisionId
                                                      .value = data.id!;
                                                  print(
                                                      _selectLocationController
                                                          .selectedDivisionId
                                                          .value);
                                                  Get.back();
                                                }
                                              }
                                            },
                                            child: ListTile(
                                              dense: true,
                                              title: Text(
                                                "${data.divisionname}",
                                                style: Styles.bodyMedium2,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

// ignore_for_file: invalid_use_of_protected_member

import 'package:bringin/Hive/hive.dart';
import 'package:bringin/controllers/candidate_section/candidate_controll.dart';
import 'package:bringin/controllers/candidate_section/job_controll.dart';
import 'package:bringin/controllers/candidate_section/select_location_controller.dart';
import 'package:bringin/controllers/recruiter_section/company_registration_controller.dart';
import 'package:bringin/res/color.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../../res/app_font.dart';
import '../../../res/dimensions.dart';
import '../../../utils/services/keys.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/app_search_form_field.dart';
import 'components/cities_and_area.dart';

class SelectLocationScreen extends StatelessWidget {
  final bool? isJobSearch;
  final bool? isCandidateSearch;
  final bool? isChangeRecruiterCLocation;
  final bool? isJobByLocation;
  final bool? isCandidateByLocation;
  const SelectLocationScreen(
      {super.key,
      this.isJobSearch = false,
      this.isCandidateSearch = false,
      this.isChangeRecruiterCLocation = false,
      this.isJobByLocation = false, this.isCandidateByLocation=false});

  @override
  Widget build(BuildContext context) {
    SelectLocationController selectLocationController =
        Get.put(SelectLocationController());
    return GestureDetector(
      onTap: () => Helpers.hideKeyboard(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBarWidget(
            title: isChangeRecruiterCLocation == true
                ? "City & Division"
                : "Preferred Location",
            onBackPressed: () => Get.back(),
            actions: []),
        body: Container(
          margin: Dimensions.kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// description
              Text(
                HiveHelp.read(Keys.isRecruiter)
                    ? isChangeRecruiterCLocation == true
                        ? "Detailed job location helps the candidates to find your company more easily."
                        : "Select your preferred location to find nearby candidates."
                    : "Select your preferred location to find nearby job opportunities.",
                style: Styles.subTitle,
                textAlign: TextAlign.center,
              ),
              const Gap(25),

              /// search bar
              CustomSearchField(
                controller:
                    selectLocationController.searchFieldController.value,
                hinText: 'Search for cities/district',
                prefixIcon: SizedBox(width: 10.w),
                onChanged: (p0) {
                  selectLocationController.searchInputText.value = p0;
                  selectLocationController.querySearch(p0);
                },
              ),
              const Gap(2),

              /// body section
              Obx(() => selectLocationController
                      .searchInputText.value.isNotEmpty
                  ? Container(
                      child: selectLocationController
                              .querySearchList.value.isEmpty
                          ? SizedBox(
                              height: Dimensions.screenHeight * .4,
                              child: Center(
                                child: Text("Not found"),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: selectLocationController
                                      .querySearchList.value.length,
                                  // shrinkWrap: true,
                                  itemBuilder: (BuildContext context, index) {
                                    var data = selectLocationController
                                        .querySearchList.value[index];
                                    return InkWell(
                                      onTap: () {
                                        if (isJobSearch == true) {
                                          JobControll.to.jobLocationField.text =
                                              data.divisionname!;
                                          JobControll.to.selectedDivision =
                                              data.cityid!.name!;
                                          // print(data.divisionname);
                                          // print(data.cityid!.name);
                                          selectLocationController
                                              .searchFieldController.value
                                              .clear();
                                          selectLocationController
                                              .searchInputText.value = "";
                                          Get.back();
                                        } else if (isCandidateSearch == true) {
                                          CandidateControll
                                              .to
                                              .candidateLocationField
                                              .text = data.divisionname!;
                                          CandidateControll
                                                  .to.candidatelocationid =
                                              data.cityid!.id!;
                                          print("${data.cityid!.name}");
                                          selectLocationController
                                              .searchFieldController.value
                                              .clear();
                                          selectLocationController
                                              .searchInputText.value = "";
                                          // Get.back();
                                        } else if (isJobByLocation == true) {
                                          JobControll.to.getjoblist(
                                              divisionId: data.id, type: "2",index: JobControll.to.tabIndex);
                                          selectLocationController
                                              .selectedCityValue
                                              .value = data.divisionname!;
                                          Get.back();
                                        }else if (isCandidateByLocation == true) {
                                          CandidateControll.to.loadcandidate(
                                              divisionId: data.id, type: "2",index: CandidateControll.to.tabIndex.value);
                                          selectLocationController
                                              .selectedCityValue
                                              .value = data.divisionname!;
                                          Get.back();
                                        } else {
                                          if (HiveHelp.read(Keys.isRecruiter) ==
                                              true) {
                                            CompanyRegistrationController
                                                    .to.selectedLocation.value =
                                                data.divisionname! +
                                                    ", " +
                                                    data.cityid!.name!;
                                            CompanyRegistrationController
                                                .to
                                                .selectedLocationId
                                                .value = data.id!;
                                            selectLocationController
                                                .searchFieldController.value
                                                .clear();
                                            selectLocationController
                                                .searchInputText.value = "";
                                            print("Location: " +
                                                CompanyRegistrationController
                                                    .to.selectedLocation.value);
                                            print("Division id: " +
                                                CompanyRegistrationController.to
                                                    .selectedLocationId.value);
                                            Get.back();
                                          } else {
                                            selectLocationController
                                                .selectedCityValue
                                                .value = data.divisionname!;
                                            selectLocationController
                                                .selectedDivision
                                                .value = data.cityid!.name!;
                                            selectLocationController
                                                .selectedDivisionId
                                                .value = data.id!;
                                            selectLocationController
                                                .searchFieldController.value
                                                .clear();
                                            selectLocationController
                                                .searchInputText.value = "";
                                            print("CityId: " +
                                                selectLocationController
                                                    .selectedDivisionId.value);
                                            print("Division: " +
                                                data.cityid!.name!);
                                            Get.back();
                                          }
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            border: Border(
                                                bottom: BorderSide(
                                              color: AppColors.borderColor
                                                  .withOpacity(.3),
                                              width: .5,
                                            ))),
                                        child: ListTile(
                                          title: SubstringHighlight(
                                            text: data.divisionname!,
                                            term: selectLocationController
                                                .searchInputText.value,
                                            textStyle: TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 17,
                                            ),
                                            textStyleHighlight: TextStyle(
                                              color: AppColors.mainColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                          subtitle: Text(
                                            data.cityid!.name! +
                                                " > " +
                                                data.divisionname!,
                                            style: Styles.smallText.copyWith(
                                              color: AppColors.blackColor
                                                  .withOpacity(.4),
                                              fontWeight: FontWeight.w300,
                                              fontSize: font(11),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                    )
                  : CitiesAndArea(
                      isJobSearching: isJobSearch,
                      isCandidateSearching: isCandidateSearch,
                      isJobByLocation: isJobByLocation,
                      isCandidateByLocation: isCandidateByLocation,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}

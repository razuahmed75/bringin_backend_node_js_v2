import 'package:bringin/Screens/recruiter_section/company_location_page.dart';
import 'package:bringin/controllers/candidate_section/industry_controller.dart';
import 'package:bringin/models/recruiter_section/company_registration_model.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/widgets/experience_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_bar.dart';
import '../../Hive/hive.dart';
import '../../controllers/recruiter_section/company_registration_controller.dart';
import '../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/image_path.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';
import '../../utils/services/keys.dart';
import '../../widgets/app_bottom_nav_widget.dart';

class CompanyRegistrationScreen extends StatelessWidget {
  const CompanyRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RecruiterEditMainProfileController recruiterEditProfileController =
        Get.find<RecruiterEditMainProfileController>();
    CompanyRegistrationController companyRegistrationController =
        Get.find<CompanyRegistrationController>();
    IndustryControler industryController = Get.find<IndustryControler>();
    return GestureDetector(
      onTap: () => Helpers.hideKeyboard(),
      child: Scaffold(
        appBar: appBarWidget(
          title: "Register Your Company",
          onBackPressed: () => Get.back(),
          actions: [],
        ),
        body: Padding(
          padding: Dimensions.kDefaultPadding,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("Introduce your company to the candidates.",
                      style: Styles.bodyMedium2),
                ),
                const Gap(15),

                // company legal name
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.r),
                      border:
                          Border.all(color: Color(0xFF828282).withOpacity(0.2)),
                      color: Colors.white),
                  child: GestureDetector(
                    onTap: () {
                      if (recruiterEditProfileController
                          .recruiterCompanyList.isEmpty) {
                        Get.toNamed(RouteHelper.getcompanyNameRoute());
                      } else {
                        Get.toNamed(RouteHelper.getcompanyNameRoute());
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius(6)),
                            ),
                            child: Image.asset(
                              "assets/icon2/company_name.png",
                              width: 26.w,
                              height: 26.h,
                            )),
                        const Gap(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Company Legal Name",
                                style: Styles.bodyMedium2),
                            const Gap(3),
                            Obx(
                              () => Text(
                                  recruiterEditProfileController
                                          .companyNameSearchController
                                          .value
                                          .text
                                          .isEmpty
                                      ? "No company selected"
                                      : recruiterEditProfileController
                                          .companyNameSearchController
                                          .value
                                          .text,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.bodyLargeMedium),
                            ),
                          ],
                        ),
                        Spacer(),
                        InkResponse(
                          onTap: () {
                            if (recruiterEditProfileController
                                .recruiterCompanyList.isEmpty) {
                              Get.toNamed(RouteHelper.getcompanyNameRoute());
                            } else {
                              Get.toNamed(RouteHelper.getcompanyNameRoute());
                            }
                          },
                          radius: 20,
                          child: Container(
                            margin: EdgeInsets.only(top: height(20)),
                            child: Image.asset(
                              AppImagePaths.forword_browse,
                              height: height(18),
                              width: width(18),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ),
                ),
                const Gap(10),

                // company info section
                Container(
                  width: double.maxFinite,
                  decoration: Dimensions.kDecoration,
                  padding: EdgeInsets.symmetric(
                      vertical: height(8), horizontal: height(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Short Name of Company
                      Obx(
                        () => ExperienceTile(
                          onPressed: () {
                            Get.toNamed(
                                RouteHelper.getCompanyShortNameScreenRoute());
                          },
                          firstText: "Short Name of Company",
                          secondText: companyRegistrationController
                                  .selectedCShortName.value.isEmpty
                              ? "e.g. Bringin"
                              : companyRegistrationController
                                  .selectedCShortName.value,
                          secondTextColor: companyRegistrationController
                                  .selectedCShortName.value.isEmpty
                              ? AppColors.hintColor
                              : AppColors.blackColor,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),

                      // Field of Industry
                      Obx(
                        () => ExperienceTile(
                          onPressed: () {
                            if (industryController.allIndustryList.isEmpty) {
                              industryController.getPopularJobIndustry();
                              Get.toNamed(
                                  RouteHelper.getIndustryDomainScreenRoute());
                              Helpers.hideKeyboard();
                            } else {
                              Get.toNamed(
                                  RouteHelper.getIndustryDomainScreenRoute());
                              Helpers.hideKeyboard();
                            }
                          },
                          firstText: "Field of Industry",
                          secondText:
                              industryController.jobIndustryName.value.isEmpty
                                  ? "e.g. Technology"
                                  : industryController.jobIndustryName.value,
                          secondTextColor:
                              industryController.jobIndustryName.value.isEmpty
                                  ? AppColors.hintColor
                                  : AppColors.blackColor,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),

                      // Company Size
                      Obx(
                        () => ExperienceTile(
                          onPressed: () {
                            if (companyRegistrationController
                                .employeeList.isEmpty) {
                              companyRegistrationController.getEmployeeSizes();
                              Get.toNamed(RouteHelper.getCompanySizeRoute());
                              Helpers.hideKeyboard();
                            } else {
                              Get.toNamed(RouteHelper.getCompanySizeRoute());
                              Helpers.hideKeyboard();
                            }
                          },
                          firstText: "Company Size",
                          secondText: companyRegistrationController
                                  .companyEmployeesSize.value.isEmpty
                              ? "e.g. 0-19 Employees"
                              : "${companyRegistrationController.companyEmployeesSize.value} Employees",
                          secondTextColor: companyRegistrationController
                                  .companyEmployeesSize.value.isEmpty
                              ? AppColors.hintColor
                              : AppColors.blackColor,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),

                      // Company Location
                      GetBuilder<CompanyRegistrationController>(builder: (_) {
                        return ExperienceTile(
                          onPressed: () => Get.to(() =>
                              CompanyLocationPage(isCompanyRegistration: true)),
                          firstText: "Company Location",
                          secondText: _.companyaddress == ""
                              ? "add company address"
                              : _.companyaddress,
                          secondTextColor: _.companyaddress == ""
                              ? AppColors.hintColor
                              : AppColors.blackColor,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        );
                      }),

                      // Company Website
                      Obx(
                        () => ExperienceTile(
                          onPressed: () {
                            Get.toNamed(
                              RouteHelper.getRecruiterCompanyWebsiteRoute(),
                            );
                            Helpers.hideKeyboard();
                          },
                          firstText: "Company Website",
                          secondText: companyRegistrationController
                                  .selectedCompanyWebsiteVal.value.isEmpty
                              ? "e.g. https://bringin.io"
                              : companyRegistrationController
                                  .selectedCompanyWebsiteVal.value,
                          secondTextColor: companyRegistrationController
                                  .selectedCompanyWebsiteVal.value.isEmpty
                              ? AppColors.hintColor
                              : AppColors.blackColor,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavWidget(
              text: companyRegistrationController.isRegistrationLoading.value
                  ? "Registering..."
                  : "Register",
              onTap: companyRegistrationController.isRegistrationLoading.value
                  ? null
                  : () {
                      if (recruiterEditProfileController
                          .companyNameSearchController.value.text.isEmpty) {
                        Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "Company Legal Name is required");
                      } else if (companyRegistrationController
                          .selectedCShortName.value.isEmpty) {
                        Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "Short Name is required");
                      } else if (industryController
                          .jobIndustryName.value.isEmpty) {
                        Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "Field of Industry is required");
                      } else if (companyRegistrationController
                          .companyEmployeesSize.value.isEmpty) {
                        Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "Company Size is required");
                      }
                      // else if (companyRegistrationController
                      //     .selectedCompanyWebsiteVal.value.isEmpty) {
                      //   Helpers().showToastMessage(
                      //       gravity: ToastGravity.CENTER,
                      //       msg: "company Website is required");
                      // }
                      else if (companyRegistrationController.companyaddress ==
                          "") {
                        Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "Company Location is required");
                      } else if (companyRegistrationController
                          .selectedLocation.value.isEmpty) {
                        Helpers().showToastMessage(
                            gravity: ToastGravity.CENTER,
                            msg: "Select City is required");
                      } else {
                        final body = CompanyRegistrationModel(
                          legalName: recruiterEditProfileController
                              .companyNameSearchController.value.text
                              .trim(),
                          sortName: companyRegistrationController
                              .selectedCShortName.value,
                          industry: industryController.categoryId.value,
                          cSize: companyRegistrationController
                              .companyEmployeeSizeId.value,
                          cLocation: CLocation(
                            lat: companyRegistrationController.latlng!.latitude,
                            lon:
                                companyRegistrationController.latlng!.longitude,
                            formetAddress:
                                companyRegistrationController.companyaddress,
                            locationoptional: companyRegistrationController
                                .selectedOptionLocation.value,
                            divisiondata: companyRegistrationController
                                .selectedLocationId.value,
                            // lat: 23.7956,
                            // lon: 90.3537,
                            // city: "Mirpur 1,Dhaka",
                            // formetAddress: "Mirpur 1, Priyanka housing, Dhaka",
                          ),
                          cWebsite: companyRegistrationController
                              .selectedCompanyWebsiteVal.value,
                        );
                        companyRegistrationController
                            .postCompanyRegistration(body);
                        HiveHelp.write(Keys.isRecruiterNewJoined, true);
                      }
                    }),
        ),
      ),
    );
  }
}

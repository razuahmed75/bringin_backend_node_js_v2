import 'package:bringin/Screens/candidate_section/select_location/select_location_screen.dart';
import 'package:bringin/controllers/candidate_section/select_location_controller.dart';
import 'package:bringin/utils/routes/route_helper.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:bringin/widgets/app_bar.dart';
import 'package:place_picker/place_picker.dart';
import '../../controllers/recruiter_section/company_registration_controller.dart';
import '../../controllers/recruiter_section/map_controll.dart';
import '../../controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/image_path.dart';
import '../../res/constants/strings.dart';
import '../../res/dimensions.dart';
import '../../widgets/formfield_length_checker.dart';
import '../../widgets/profile_info_tile.dart';
import '../both_section/Map/pick_map_screen.dart';

class CompanyLocationPage extends StatefulWidget {
  final bool? isCompanyRegistration;
  const CompanyLocationPage({super.key, this.isCompanyRegistration = false});

  @override
  State<CompanyLocationPage> createState() => _CompanyLocationPageState();
}

class _CompanyLocationPageState extends State<CompanyLocationPage> {
  LatLng? _initialPosition;
  final mapcontroll = Get.put(MapControll());
  CompanyRegistrationController companyRegistrationController =
      Get.find<CompanyRegistrationController>();
  RecruiterEditMainProfileController recruiterEditMainProfileController =
      Get.put(RecruiterEditMainProfileController());
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

    // Handle the result in your way
    companyRegistrationController.addcompanyaddress(
      result.formattedAddress!,
      result.latLng!,
    );
  }

  @override
  void initState() {
    location();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "",
        onBackPressed: () => Get.back(),
        onSavedPressed: () {
          if (widget.isCompanyRegistration == true) {
            if (companyRegistrationController.companyaddress == "") {
              Helpers().showToastMessage(msg: "Company Location is Required");
            } else if (companyRegistrationController
                .selectedLocation.value.isEmpty) {
              Helpers().showToastMessage(msg: "Select City is Required");
            } else {
              Get.back();
            }
          } else {
            Get.back();
          }
        },
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Company Location", style: Styles.smallTitle),
              const Gap(3),
              Text(
                  widget.isCompanyRegistration == true
                      ? AppStrings.companyLocationDes
                      : AppStrings.companyLocationDes1,
                  style: Styles.subTitle),
              const Gap(15),

              // Company Address
              if (widget.isCompanyRegistration == false) ...[
                GetBuilder<CompanyRegistrationController>(builder: (_) {
                  return ProfileInfoTile(
                    onPressed: () {
                      showPlacePicker(context);
                    },
                    firstText: "Company Address",
                    secondTextColor: AppColors.blackColor,
                    secondText:
                        companyRegistrationController.companyaddress == ""
                            ? recruiterEditMainProfileController
                                    .recruiterProfileInfoList.isEmpty
                                ? ""
                                : recruiterEditMainProfileController
                                    .recruiterProfileInfoList[0]
                                    .companyname!
                                    .cLocation!
                                    .formetAddress
                            : companyRegistrationController.companyaddress,
                    iconPath: AppImagePaths.done,
                    iconColor: null,
                  );
                }),
              ],
              if (widget.isCompanyRegistration == true) ...[
                GetBuilder<CompanyRegistrationController>(builder: (_) {
                  return ProfileInfoTile(
                    onPressed: () {
                      showPlacePicker(context);
                    },
                    firstText: "Company Address",
                    secondTextColor: _.companyaddress == ""
                        ? AppColors.hintColor
                        : AppColors.blackColor,
                    secondText: _.companyaddress == ""
                        ? "Name of the office building etc."
                        : _.companyaddress,
                    iconPath: _.companyaddress.isNotEmpty
                        ? AppImagePaths.done
                        : AppImagePaths.arrowForwardIcon,
                    iconColor: _.companyaddress.isNotEmpty
                        ? null
                        : AppColors.blackColor.withOpacity(.4),
                  );
                }),
              ],
              SizedBox(height: 10.h),
              if (widget.isCompanyRegistration == false) ...[
                Obx(
                  () => recruiterEditMainProfileController
                          .recruiterProfileInfoList.isEmpty
                      ? SizedBox()
                      : ProfileInfoTile(
                          onPressed: () => Get.toNamed(
                              RouteHelper.getCompanyAddresseRoute()),
                          firstText: "Company Address (optional)",
                          child: FormFieldLengthChecker(
                            characterLength: companyRegistrationController
                                .characterLength.value,
                            maxLength: 100,
                            isMargin: false,
                          ),
                          secondTextColor: companyRegistrationController
                                      .selectedOptionLocation.value.isEmpty &&
                                  recruiterEditMainProfileController
                                          .recruiterProfileInfoList[0]
                                          .companyname!
                                          .cLocation!
                                          .locationoptional ==
                                      null
                              ? AppColors.hintColor
                              : AppColors.blackColor,
                          secondText: companyRegistrationController
                                  .selectedOptionLocation.value.isEmpty
                              ? recruiterEditMainProfileController
                                      .recruiterProfileInfoList.isEmpty
                                  ? ""
                                  : recruiterEditMainProfileController
                                          .recruiterProfileInfoList[0]
                                          .companyname!
                                          .cLocation!
                                          .locationoptional ??
                                      ""
                              : companyRegistrationController
                                  .selectedOptionLocation.value,
                          iconPath: AppImagePaths.done,
                          iconColor: null,
                        ),
                ),
              ],
              if (widget.isCompanyRegistration == true) ...[
                Obx(
                  () => recruiterEditMainProfileController
                          .recruiterProfileInfoList.isEmpty
                      ? SizedBox()
                      : ProfileInfoTile(
                          onPressed: () => Get.toNamed(
                              RouteHelper.getCompanyAddresseRoute()),
                          firstText: "Company Address (optional)",
                          child: FormFieldLengthChecker(
                            characterLength: companyRegistrationController
                                .characterLength.value,
                            maxLength: 100,
                            isMargin: false,
                          ),
                          secondTextColor: companyRegistrationController
                                  .selectedOptionLocation.value.isEmpty
                              ? AppColors.hintColor
                              : AppColors.blackColor,
                          secondText: companyRegistrationController
                                  .selectedOptionLocation.value.isEmpty
                              ? ""
                              : companyRegistrationController
                                  .selectedOptionLocation.value,
                          iconPath: companyRegistrationController
                                  .selectedOptionLocation.value.isEmpty
                              ? AppImagePaths.arrowForwardIcon
                              : AppImagePaths.done,
                          iconColor: companyRegistrationController
                                  .selectedOptionLocation.value.isEmpty
                              ? AppColors.blackColor.withOpacity(.4)
                              : null,
                        ),
                ),
              ],
              SizedBox(height: 10.h),
              if (widget.isCompanyRegistration == false) ...[
                Obx(() => ProfileInfoTile(
                    onPressed: () {
                      if (SelectLocationController.to.allLocationList.isEmpty) {
                        SelectLocationController.to.getAllLocation();
                        Get.to(() => SelectLocationScreen(
                            isChangeRecruiterCLocation: true));
                      } else {
                        Get.to(() => SelectLocationScreen(
                            isChangeRecruiterCLocation: true));
                      }
                    },
                    firstText: "Select City",
                    secondTextColor: AppColors.blackColor,
                    secondText: companyRegistrationController
                            .selectedLocation.value.isEmpty
                        ? recruiterEditMainProfileController
                                .recruiterProfileInfoList.isEmpty
                            ? ""
                            : recruiterEditMainProfileController
                                    .recruiterProfileInfoList[0]
                                    .companyname!
                                    .cLocation!
                                    .divisiondata!
                                    .divisionname! +
                                ", " +
                                recruiterEditMainProfileController
                                    .recruiterProfileInfoList[0]
                                    .companyname!
                                    .cLocation!
                                    .divisiondata!
                                    .cityid!
                                    .name!
                        : companyRegistrationController.selectedLocation.value,
                    iconPath: AppImagePaths.done,
                    iconColor: null)),
              ],
              if (widget.isCompanyRegistration == true) ...[
                Obx(() => ProfileInfoTile(
                      onPressed: () {
                        if (SelectLocationController
                            .to.allLocationList.isEmpty) {
                          SelectLocationController.to.getAllLocation();
                          Get.to(() => SelectLocationScreen(
                              isChangeRecruiterCLocation: true));
                        } else {
                          Get.to(() => SelectLocationScreen(
                              isChangeRecruiterCLocation: true));
                        }
                      },
                      firstText: "Select City",
                      secondTextColor: companyRegistrationController
                                  .selectedLocation.value ==
                              ""
                          ? AppColors.hintColor
                          : AppColors.blackColor,
                      secondText: companyRegistrationController
                                  .selectedLocation.value ==
                              ""
                          ? "Uttara, Dhaka"
                          : companyRegistrationController
                              .selectedLocation.value,
                      iconPath: companyRegistrationController
                              .selectedLocation.value.isNotEmpty
                          ? AppImagePaths.done
                          : AppImagePaths.arrowForwardIcon,
                      iconColor: companyRegistrationController
                              .selectedLocation.value.isNotEmpty
                          ? null
                          : AppColors.blackColor.withOpacity(.4),
                    )),
              ],

              const Gap(35),
            ],
          ),
        ),
      ),
    );
  }
}

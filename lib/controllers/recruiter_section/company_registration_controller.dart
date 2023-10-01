import 'dart:convert';

import 'package:bringin/Http/get.dart';
import 'package:bringin/controllers/recruiter_section/recruiter_edit_main_profile_controller.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';
import '../../models/recruiter_section/company_registration_model.dart';
import '../../res/constants/app_constants.dart';
import '../../utils/routes/route_helper.dart';

class CompanyRegistrationController extends GetxController {
  static CompanyRegistrationController get to => Get.find();

  /// INDUSTRY DOMAIN
  var searchController = TextEditingController();
  RxBool isLoading = false.obs;

  /// COMPANY WEBSITE
  var companyInputText = "".obs;
  var characterLength = 0.obs;
  var companyWebEditinCtrlr = TextEditingController();
  var companyAddrEditinCtrlr = TextEditingController();
  var selectedCompanyWebsiteVal = "".obs;
  var selectedOptionLocation = "".obs;
  String companyaddress = "";
  var selectedLocation = "".obs;
  var selectedLocationId = "".obs;
  LatLng? latlng;
  // String city = "";
  // String division = "";

  void latUpdate(double lat, double lng) {
    latlng = LatLng(lat, lng);
    update();
  }

  /// COMPANY LOCATION
  var companyLocation = "".obs;

  /// SHORT NAME OF COMPANY
  var companyShortnameEditingCtrlr = TextEditingController();
  var selectedCShortName = "".obs;

  /// COMPANY SIZE
  RxList<EmployeeSizesModel> employeeList = <EmployeeSizesModel>[].obs;
  var isLoddingEmployee = false.obs;
  RxInt selectedEmployeeGroupValue = 100.obs;
  var companyEmployeesSize = "".obs;
  var companyEmployeeSizeId = "".obs;

  Future getEmployeeSizes() async {
    isLoddingEmployee.value = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.employeeSizeUrl)
        .then((value) {
      employeeList.value = [];
      if (value.statusCode == 200) {
        isLoddingEmployee.value = false;
        for (var i in jsonDecode(value.body)) {
          employeeList.add(EmployeeSizesModel.fromJson(i));
        }
      } else {
        isLoddingEmployee.value = false;
        employeeList.value = [];
      }
    });
  }

  /// POST METHOD OF COMPANY REGISTRATION
  var isRegistrationLoading = false.obs;
  var registrationStatusCode = 0.obs;
  Future<void> postCompanyRegistration(CompanyRegistrationModel? data) async {
    isRegistrationLoading.value = true;
    await Httphelp.post(
            ENDPOINT_URL: AppConstants.companyRegistrationUrl,
            fields: data!.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        Helpers().showToastMessage(msg: "Successfully Registered");
        RecruiterEditMainProfileController.to.getRecruiterProfileInfoList();
        Get.toNamed(RouteHelper.getRecruiterEditMainProfileRoute());

        registrationStatusCode.value = value.statusCode;
        isRegistrationLoading.value = false;
        print(value.body);
      } else {
        isRegistrationLoading.value = false;
        registrationStatusCode.value = value.statusCode;
        print(value.body);
        Helpers().showToastMessage(msg: value.body.toString());
      }
    });
  }

  void addcompanyaddress(
      String address, LatLng latlng2) {
    companyaddress = address;
    latlng = latlng2;
    // city = _city;
    // division = _division;
    update();
  }
}

class EmployeeSizesModel {
  String? sId;
  String? size;
  int? iV;

  EmployeeSizesModel({this.sId, this.size, this.iV});

  EmployeeSizesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    size = json['size'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['size'] = this.size;
    data['__v'] = this.iV;
    return data;
  }
}

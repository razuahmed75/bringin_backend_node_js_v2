import 'dart:convert';
import 'dart:developer';

import 'package:bringin/Http/get.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:get/get.dart';

import '../../models/Package/packagelist.dart';
import '../../models/Package/payment_history_model.dart';
import '../../res/constants/app_constants.dart';
import '../recruiter_section/recruiter_edit_main_profile_controller.dart';

class PackageController extends GetxController {
  static PackageController get to => Get.find();
  var packagelist = <PackageList>[].obs;

  var pckloading = false.obs;
  Future getpackagelist() async {
    pckloading.value = true;
    var package = await Httphelp.get(ENDPOINT_URL: AppConstants.packageListUrl);
    packagelist.value = packageListFromJson(package.body);
    pckloading.value = false;
  }

  Future packagebuy({String? packageid, String? transactionID}) async {
    final recuiterprofile = Get.find<RecruiterEditMainProfileController>();
    var field = {"packageid": packageid, "transactionID": transactionID};
    var data = await Httphelp.post(ENDPOINT_URL: "/packagebuy", fields: field);
    await recuiterprofile.getRecruiterProfileInfoList();
    log(data.body);
  }
  
  /// CALCEL SUBSCRIPTION
  RxBool isLoading = false.obs;
  RxBool isCancelled = false.obs;
  Future<void> cancelSubscription({String? id})async{
    isLoading.value = true;
    Helpers().showToastMessage(msg: "Cancelling your subscription...");
    await Httphelp.post(
      ENDPOINT_URL: AppConstants.cancelSubscriptionUrl,fields: {"id" : id}).then((response){
        isLoading.value = false;
        if(response.statusCode==200){
          isCancelled.value = true;
          print(response.body);
          RecruiterEditMainProfileController.to.getRecruiterProfileInfoList();
        }else{
          print(response.body);
          Helpers().showToastMessage(msg: "Something went wrong");
        }
      });
  }

  /// PAYMENT HISTROY
  List<String> payHistoryTitlelist =[
    "Date",
    "Package",
    "Method",
    "Amount",
  ];
  List<PaymentHistoryModel> paymentHistoryList = [];
  Future<void> getPaymentHitory() async{
    isLoading.value = true;
   var response = await Httphelp.get(ENDPOINT_URL: AppConstants.userPaymentHistoryUrl);
   paymentHistoryList = [];
    if(response.statusCode==200){
      isLoading.value = false;
      jsonDecode(response.body).forEach((data){
        paymentHistoryList.add(PaymentHistoryModel.fromJson(data));
      });
      log(paymentHistoryList.length.toString());
    }else{
      isLoading.value = false;
      print(response.body);
      paymentHistoryList=[];
    }
  }
}

// ignore_for_file: invalid_use_of_protect

import 'package:bringin/Http/get.dart';
import 'package:bringin/res/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/candidate_section/select_location_model.dart';
import '../../res/color.dart';

class SelectLocationController extends GetxController{
  static SelectLocationController get to => Get.find();
  
  RxList<bool> arrowList = <bool>[].obs;
  togleFunc(index){
    for (int i = 0; i < arrowList.length; i++) {
      arrowList[i] = i == index; 
    }
  }
  RxList<AllLocationModel> allLocationList = <AllLocationModel>[].obs;
  RxList<Divisionid> querySearchList = <Divisionid>[].obs;
  var selectedIndex = 0.obs;
  var selectedCityValue = "".obs;
  var selectedDivisionId = "".obs;
  var selectedDivision = "".obs;
  var locationErrorBorderClr = AppColors.buttonColor.obs;
  var isLoading = false.obs;
  var searchFieldController = TextEditingController().obs;
  RxString searchInputText = "".obs;

  Future getAllLocation() async{
    isLoading.value = true;
    allLocationList.value = [];
    await Httphelp.get(ENDPOINT_URL: AppConstants.selectLocationUrl).then((data){
       
      if(data.statusCode==200){
        isLoading.value = false;
        allLocationList.value = allLocationModelFromJson(data.body);
      }
      else{
        isLoading.value = false;
        allLocationList.value=[];
      }
    });
  }

  /// highlight search
  querySearch(String query){
    querySearchList.value = allLocationList.expand((e) => 
    e.divisionid!.where((p0) => 
    p0.divisionname!.toLowerCase().contains(searchInputText.toLowerCase()))).toList();
  }


}
// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:bringin/Http/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/both_category/job_industry_model.dart';
import '../../res/color.dart';
import '../../res/constants/app_constants.dart';

class JobIndustryController extends GetxController {
  RxList<Category> popularJobIndustryList =
      <Category>[].obs;
  
  RxList<Category> searchCategoryList = <Category>[].obs;
  RxList<Industry> allIndustryList = <Industry>[].obs;
  RxList<String> selectedlist = <String>[].obs;
  final searchIndustryController = TextEditingController();
  var industryErrorBorderClr = AppColors.buttonColor.obs;

  var jobIndustryName = "".obs;
  var categoryId = "".obs;
  var isLoading = false.obs;
  final searchInputText = "".obs;

  Future getPopularJobIndustry() async {
    print("Getting industries...");
    isLoading.value = true; // SHOW LOADING
    await Httphelp.get(ENDPOINT_URL: AppConstants.allJobIndustryUrl)
        .then((data) {
        
        if(data.statusCode==200){
           popularJobIndustryList.value = [];
          allIndustryList.value = [];
          popularJobIndustryList.addAll(JobIndustryModel.fromJson(jsonDecode(data.body)).category!);
          allIndustryList.addAll(JobIndustryModel.fromJson(jsonDecode(data.body)).industry!);
          isLoading.value = false; // HIDE LOADING
        }
        else{
          isLoading.value = false;
          print(data.body);
          popularJobIndustryList.value=[];
          allIndustryList.value=[];
        }
     
    });
  }

  /// search category
  void searchCategory(String query){
   searchCategoryList.value = allIndustryList.expand((mainList) => 
   mainList.category!.where((category) => 
   category.categoryname!.toLowerCase().contains(searchInputText.value.toLowerCase()))).toList();
  }

/// category count
RxList idsList =[].obs;
RxString cateLen = "".obs;
categorySelectionCount(List<Category> data){
  idsList.value=[];
  for(var i=0; i < selectedlist.value.length; i++){
      if(data.any((element) => element.sId == selectedlist[i])){
      idsList.add(selectedlist[i]);
      idsList.refresh();
      // print("idsLIst: "+idsList.toString());
    }
  }
  cateLen.value = "${idsList.length}";
  // update();
  return cateLen.value;
}
}


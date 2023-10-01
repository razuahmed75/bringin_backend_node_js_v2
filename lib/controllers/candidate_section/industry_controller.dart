import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Http/get.dart';
import '../../models/both_category/job_industry_model.dart';
import '../../res/constants/app_constants.dart';


class IndustryControler extends GetxController{
  static IndustryControler get to => Get.find();

RxList<Category> popularJobIndustryList =<Category>[].obs;
RxList<Category> searchCategoryList = <Category>[].obs;
RxList<Industry> allIndustryList = <Industry>[].obs;
RxList selectedlist = [].obs;
final searchIndustryController = TextEditingController();
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



}



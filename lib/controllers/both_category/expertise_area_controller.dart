// ignore_for_file: invalid_use_of_protected_member


import 'package:bringin/Http/get.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/both_category/functional_area_model.dart';
import '../../res/color.dart';
import '../../res/constants/app_constants.dart';

class ExpertiseAreaController extends GetxController {
  static ExpertiseAreaController get to => Get.find();

  RxList<FunctionalAreaModel> functionalAreaList = <FunctionalAreaModel>[].obs;
  var isLoading = false.obs;
  RxInt mainIndex = 0.obs;

  //post type data
  RxString selectedFuncationalNameValue = "".obs;
  RxString categoryId = "".obs;
  RxString selectValueFuncationNamePath = "".obs;
  RxString selectValueFunctionalNameId = "".obs;
  List<CustomArea> filteredList = [];

  var searchTextController = TextEditingController();
  RxString searchInputText = "".obs;
  var functionalAreaErrorBorderClr = AppColors.buttonColor.obs;

  Future getFunctionalArea() async {
    isLoading.value = true;
    await Httphelp.get(ENDPOINT_URL: AppConstants.functionalAreaUrl)
        .then((data) {
      functionalAreaList.value=[];
      filteredList=[];
      if (data.statusCode==200) {
        isLoading.value = false;
        functionalAreaList.value = functionalAreaModelFromJson(data.body);
        filterArea();
      }
      else{
        isLoading.value = false;
        Helpers.showAlartMessage();
        functionalAreaList.value = [];
      }
    });
  }
  filterArea(){
    for(int _x = 0; _x<functionalAreaList.length; _x+=1){
          for(int _y = 0; _y<functionalAreaList[_x].category!.length; _y+=1){
            for(int _z = 0; _z<functionalAreaList[_x].category![_y].functionarea!.length; _z+=1){
              filteredList.add(CustomArea(
                industryname: functionalAreaList[_x].industryname,
                categoryname: functionalAreaList[_x].category![_y].categoryname,
                functionalname: functionalAreaList[_x].category![_y].functionarea![_z].functionalname,
                areaId: functionalAreaList[_x].category![_y].functionarea![_z].id,
                categoryId: functionalAreaList[_x].category![_y].functionarea![_z].categoryid,
              ));
            }
          }   
        }
  }
  /// search functional area 
  RxList<CustomArea> categorySearchList = <CustomArea>[].obs;
   List<CustomArea>searchAreaName(String query){
    categorySearchList.value = filteredList.where((element) => 
    element.functionalname!.toLowerCase().contains(searchInputText.value.toLowerCase())).toList();
    return categorySearchList.value;
  }
  // RxList<Functionarea> categorySearchList = <Functionarea>[].obs;
  //  List<Functionarea>searchAreaName(String query){
  //   categorySearchList.value = functionalAreaList.expand((a1) => 
  //   a1.category!.expand((a2) => a2.functionarea!.where((element) => 
  //   element.functionalname!.toLowerCase().contains(searchInputText.value.toLowerCase())))).toList();
  //   return categorySearchList.value;
  // }

 
}

class CustomArea {
    String? areaId;
    String? categoryId;
    String? functionalname;
    String? industryname;
    String? categoryname;

    CustomArea({
        this.areaId,
        this.categoryId,
        this.functionalname,
        this.industryname,
        this.categoryname,
    });
}


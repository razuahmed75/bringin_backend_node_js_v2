
// ignore_for_file: invalid_use_of_protected_member

import 'package:bringin/controllers/candidate_section/education_controller.dart';
import 'package:bringin/utils/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../res/constants/image_path.dart';
import '../../res/dimensions.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/app_search_widget.dart';

class InstituteNameScreen extends StatelessWidget {
  InstituteNameScreen({super.key});
 final EducationController _qualificationController = Get.put(EducationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
      title: "Institute Name", 
      onBackPressed: () => Get.back(), 
      onSavedPressed: () {
        if(_qualificationController.instituteNameController.text.isEmpty){
          Helpers().showValidationErrorDialog();
        }else{
          _qualificationController.institueName.value = _qualificationController.instituteNameController.text.trim();
          Get.back();
        }
      }
     ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kDefaultgapTop,
            
            /// search bar
            GetBuilder<EducationController>(builder: (_){
              return AppSearchWidget(
                hinText: "University/Institute Name",
                controller: _.instituteNameController,
                child: _.instituteNameController.value.text.isEmpty ? SizedBox() : InkWell(
                  onTap: () {
                    _.instituteNameController.clear();
                  },
                  child: SvgPicture.asset(
                    AppImagePaths.close_icon,
                    height: height(15),
                    width: width(15),
                  ),
                 ),
                );
            }),
          ],
        ),
      ),
    );
  }
}

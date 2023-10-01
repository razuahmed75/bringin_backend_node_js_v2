import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controllers/candidate_section/department_controller.dart';
import '../../res/constants/image_path.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/app_search_widget.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DepartmentController controller = Get.find();
    return Scaffold(
      appBar: appBarWidget(
          title: "Department", 
          onBackPressed: () => Get.back(), 
          onSavedPressed: () {
             if(controller.textFieldCtrlr.text.isEmpty){
            Helpers().showValidationErrorDialog();
            }
            else if(controller.textFieldCtrlr.text.length<=1){
            Helpers().showValidationErrorDialog(
              errorText: "Enter a valid Department",
              durationTime: 4,
            );
            }else{
              controller.selectedDepartment.value = controller.textFieldCtrlr.text.trim();
              Get.back();
            }
          }),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kDefaultgapTop,

            /// search bar
            GetBuilder<DepartmentController>(builder: (_){
             return AppSearchWidget(
              hinText: "Development",
              controller: controller.textFieldCtrlr,
              child:controller.textFieldCtrlr.text.isEmpty
               ?SizedBox():InkWell(
                onTap: () {
                  controller.textFieldCtrlr.clear();
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

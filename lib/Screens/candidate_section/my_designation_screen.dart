import 'package:bringin/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controllers/candidate_section/my_designation_controller.dart';
import '../../res/app_font.dart';
import '../../res/constants/image_path.dart';
import '../../res/dimensions.dart';
import '../../utils/services/helpers.dart';
import '../../widgets/app_search_widget.dart';


class MyDesignationScreen extends StatelessWidget {
  const MyDesignationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyDesignationController controller = Get.find();
    return Scaffold(
      appBar: appBarWidget(
          title: "My Designation", 
          onBackPressed: () => Get.back(), 
          onSavedPressed: () {
             if(controller.textFieldCtrlr.text.isEmpty){
            Helpers().showValidationErrorDialog();
            }
            else if(controller.textFieldCtrlr.text.length<=1){
            Helpers().showValidationErrorDialog(
              errorText: "Enter your valid Designation",
              durationTime: 4,
            );
            }else{
              controller.selectedDesignation.value = controller.textFieldCtrlr.text.trim();
              Get.back();
            }
          },
        ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text("Please mention the designation of your last job.",style: Styles.bodySmall1)),
            const Gap(10),

            /// search bar
            GetBuilder<MyDesignationController>(builder: (_){
              return AppSearchWidget(
              hinText: "Chief Designer",
              controller: controller.textFieldCtrlr,
              child: controller.textFieldCtrlr.text.isEmpty
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
            const Gap(15),
          ],
        ),
      ),
    );
  }
}

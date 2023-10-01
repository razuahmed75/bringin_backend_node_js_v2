

import 'package:bringin/widgets/app_bar.dart';
import 'package:bringin/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/image_path.dart';
import '../../res/dimensions.dart';

class TargetLocationScreen extends StatelessWidget {
  const TargetLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "Target Location",
        onBackPressed: ()=> Get.back(),
        actions: [],
      ),
      body: Padding(
        padding: Dimensions.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kDefaultgapTop,

            AppTextField(
              controller: TextEditingController(), 
              hinText: "Search by location",
            ),
            const Gap(30),

            GestureDetector(
              onTap: (){},
              child: Container(
                child: Row(
                  children: [
                    SvgPicture.asset(AppImagePaths.navigationIcon),
                    const Gap(10),
                    Text(
                      "use my current location",
                      style: Styles.bodySmall.copyWith(
                        color: AppColors.mainColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
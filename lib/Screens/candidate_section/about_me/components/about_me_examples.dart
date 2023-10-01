import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../controllers/candidate_section/about_me_controller.dart';
import '../../../../res/app_dummy_models/mybio_dummy_model.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/dimensions.dart';

class AboutMeExample extends StatelessWidget {
  final AboutMeController _aboutMeController = Get.find();
  AboutMeExample({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  /// image
                  Container(
                    height: height(35),
                    width: height(35),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(aboutMeList[
                                  _aboutMeController.exampleIndex.value]
                              .avatar),
                          fit: BoxFit.fill),
                    ),
                  ),
                  const Gap(10),

                  /// candidate position
                  Text(
                      aboutMeList[_aboutMeController.exampleIndex.value]
                          .proficiency,
                      style: Styles.bodyMedium),
                ],
              ),

              /// NEXT EXAMPLE
              InkWell(
                onTap: () {
                  _aboutMeController.slideExample();
                },
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width(15), vertical: height(9)),
                    decoration: BoxDecoration(
                      color: AppColors.shadowColor.withOpacity(.4),
                      borderRadius: BorderRadius.circular(radius(24)),
                    ),
                    child: Text("Next",
                        style: Styles.bodySmall1.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor,
                        ))),
              ),
            ],
          ),
          const Gap(15),
          Text(aboutMeList[_aboutMeController.exampleIndex.value].description,
              style: Styles.bodyMedium2),
          Gap(_aboutMeController.exampleIndex.value == 1 ? 58 : 40),

          /// example counter
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: "0${_aboutMeController.exampleIndex.value + 1}",
                    style: Styles.bodyMedium1
                        .copyWith(color: AppColors.mainColor),
                  ),
                  TextSpan(text: "/05", style: Styles.bodyMedium1),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}

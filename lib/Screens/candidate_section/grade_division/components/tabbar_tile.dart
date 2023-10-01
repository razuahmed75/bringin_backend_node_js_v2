import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/candidate_section/education_controller.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/constants/image_path.dart';
import '../../../../res/dimensions.dart';
import '../../../../widgets/app_text_field.dart';

class TabbarTile extends StatelessWidget {
  final int? selectedValue;
  final void Function(int?)? onChanged;
  final List<String> dropDownList;
  final bool isGrade;
  final String? gradeHint, divisionHint;

  const TabbarTile({
    super.key,
    this.onChanged,
    required this.dropDownList,
    this.selectedValue,
    required this.isGrade,
    this.gradeHint,
    this.divisionHint,
  });

  @override
  Widget build(BuildContext context) {
    EducationController _qualificationsController = Get.find();
    return Stack(
      children: [
        Container(
          height: height(48),
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: width(25)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius(6)),
            border: Border.all(width: 0.25, color: AppColors.borderColor),
          ),
          child: Row(
            children: [
              isGrade
                  ? Container(
                      width: width(70),
                      height: height(48),
                      alignment: Alignment.center,
                      child: AppTextField(
                        controller:
                            _qualificationsController.gradeTextFieldController,
                        hinText: "3.21",
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(
                                r'^\d{0,4}(\.\d{0,2})?$'), // Allow up to 4 digits and an optional dot with up to 2 decimal places
                          ),
                        ],
                        maxLen: 4,
                      ),
                    )
                  : SizedBox.shrink(),
              DropdownButton(
                hint: Text(isGrade ? "$gradeHint" : "$divisionHint"),
                value: selectedValue,
                items: [
                  for (int i = 0; i < dropDownList.length; i++)
                    DropdownMenuItem(
                        value: i,
                        child:
                            Text(dropDownList[i], style: Styles.bodyMedium1)),
                ],
                onChanged: onChanged,
                underline: Divider(
                  color: Colors.transparent,
                ),
                icon: Container(
                  margin: EdgeInsets.only(left: width(10)),
                  child: Transform.rotate(
                    angle: 1.6,
                    child: SvgPicture.asset(
                      AppImagePaths.arrowForwardIcon,
                      height: height(11),
                      width: height(11),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

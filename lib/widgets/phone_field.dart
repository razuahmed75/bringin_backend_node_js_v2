import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:bringin/widgets/app_text_field.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final bool isCloseIcon;
  final void Function()? onCloseTapped;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const PhoneField({
    super.key,
    required this.controller,
    this.isCloseIcon = false,
    this.onCloseTapped,
    this.onChanged, this.validator,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: isCloseIcon == true? height(30) : 52,
      width: double.maxFinite,
      padding: EdgeInsets.only(left: width(24), right: width(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius(9)),
        boxShadow: [
          BoxShadow(
            color: AppColors.borderColor.withOpacity(0.5),
            blurRadius: 1,
            spreadRadius: 0.1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("+ 880",
              style: Styles.bodyMedium1
                  .copyWith(color: AppColors.blackColor.withOpacity(.4))),
          const Gap(15),
          Container(
            height: height(15),
            width: 0.5,
            color: AppColors.blackColor.withOpacity(.4),
          ),
          const Gap(15),
          Expanded(
            child: AppTextField(
              controller: controller,
              onChanged: onChanged,
              validator: validator,
              hinText: "Enter 10 digit mobile number",
              keyboardType: TextInputType.number,
              maxLen: 10,
              inputFormatters: inputFormatters,
            ),
          ),
          isCloseIcon == true
              ? InkResponse(
                  radius: 25,
                  onTap: onCloseTapped,
                  child: Padding(
                    padding: EdgeInsets.all(height(8)),
                    child: SvgPicture.asset(
                      AppImagePaths.close_icon,
                      height: height(15),
                      width: width(15),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

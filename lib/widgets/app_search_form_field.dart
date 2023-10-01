import 'package:bringin/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../res/app_font.dart';
import '../res/constants/image_path.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  final Function(String)? onChanged;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final double? radius;
  final double? height;
  const CustomSearchField({
    super.key,
    required this.controller,
    required this.hinText,
    this.onChanged,
    required this.prefixIcon,
    this.suffixIcon,
    this.onFieldSubmitted, 
    this.textInputAction, 
    this.radius, this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 34.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(radius ?? 9.r),
        border: Border.all(
          color: Color(0xFF828282).withOpacity(0.25),
          width: .9,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          prefixIcon,
          Expanded(
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              textInputAction: textInputAction,
              onFieldSubmitted: onFieldSubmitted,
              style: Styles.bodyMedium1,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                isCollapsed: true,
                hintText: hinText,
                hintStyle:
                    Styles.bodyMedium1.copyWith(color: AppColors.hintColor.withOpacity(.6)),
              ),
            ),
          ),
          suffixIcon ?? Padding(
                        padding: EdgeInsets.only(top: 6.h,bottom: 6.h,right: 24.w),
                        child: SvgPicture.asset(
                          AppImagePaths.searchIcon,
                          color: AppColors.hintColor,
                          alignment: Alignment.center,
                        ),
                      ),
        ],
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../res/app_font.dart';
import '../res/color.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';

class SelectionButton2 extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final String? subtext;
  final Color? textColor, borderColor;
  final double? borderWidth;
  final bool? isFunctionalArea;
  final String img;
  final String title;

  const SelectionButton2({
    super.key,
    required this.onTap,
    required this.text,
    this.subtext,
    this.textColor,
    this.isFunctionalArea = false,
    this.borderColor,
    required this.img,
    required this.title, 
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9.r),
      child: Ink(
        decoration: Dimensions.kDecoration.copyWith(
          border: Border.all(
            color: borderColor ?? AppColors.borderColor.withOpacity(.6),
            width: borderWidth ?? .25,
          ),
        ),
        padding: EdgeInsets.all(height(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(img, height: 26.h),
            const Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: Styles.bodyMedium3),
                  Gap(isFunctionalArea == true ? 5:10),
                  Text(
                    text,
                    style: Styles.bodyLarge.copyWith(
                      color: textColor ?? AppColors.hintColor
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                 isFunctionalArea == true ? Text(
                    subtext!,
                    style: Styles.smallText.copyWith(
                      color:  AppColors.hintColor
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ):SizedBox(),
                ],
              ),
            ),
            Column(
              children: [
                 SizedBox(height: 15.h),
                Image.asset(
                  AppImagePaths.forword_browse,
                  height: height(18),
                  width: width(18),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}

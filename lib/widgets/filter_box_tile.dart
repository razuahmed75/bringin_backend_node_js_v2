
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../res/app_font.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';

Widget filterbox(
      {String? name, 
      GestureTapCallback? onTap, 
      required int index,
      Color? textColor,
      bool? isIcon = false,
      Color? bgColor}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
            color: bgColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          children: [
            Text(
              name!,
              style: Styles.bodySmall1.copyWith(
                color: textColor,
              ),
            ),
           isIcon == true ? Container(
              margin: EdgeInsets.only(top: height(8),left: width(1)),
              child: SvgPicture.asset(
                AppImagePaths.drop_down,
              ),
            )
            :SizedBox(),
          ],
        ),
      ),
    );
  }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';

class SelectionButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final String? subtext;
  final bool? islodding;
  final Color? textColor, borderColor;
  final String? img;
  final bool? isArrowIcon;

  const SelectionButton({
    super.key,
    required this.onTap,
    required this.text,
    this.subtext,
    this.islodding = false,
    this.textColor,
    this.borderColor,
    this.img, 
    this.isArrowIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius(6)),
      child: Ink(
        height: Dimensions.buttonHeight,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: width(15)),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(radius(6)),
          border: Border.all(color: borderColor ?? AppColors.buttonColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (img != null) Image.asset(img!,height: 25.h,width: 25.h),
                if (img != null) SizedBox(width: 15.w),
                Text(text,
                    style: Styles.bodyMedium1.copyWith(color: textColor)),
                Spacer(),
               isArrowIcon == true ? SvgPicture.asset(
                  AppImagePaths.arrowForwardIcon,
                  height: height(11),
                  width: width(11),
                ) :
                Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: Image.asset(
                    AppImagePaths.editIcon,
                    height: height(14),
                    width: height(14),
                  ),
                ),
              ],
            ),
            subtext == null
                ? SizedBox()
                : Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "${subtext}",
                        style: Styles.bodyMedium1.copyWith(
                            fontSize: 10,
                            color: AppColors.blackColor.withOpacity(0.4)),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

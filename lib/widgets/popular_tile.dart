import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class PopularTile extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  final Color? borderColor;
  final Color? iconColor;
  final bool isIcon;
  final void Function()? onIconPressed;

  const PopularTile({
    super.key,
    required this.text,
    this.style,
    this.padding,
    this.textColor,
    this.borderColor,
    this.iconColor,
    this.isIcon = false,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.only(bottom: 10.h),
      // height: 39.h,
      padding: padding ??
          EdgeInsets.symmetric(
              vertical: height(isIcon ? 4 : 10), horizontal: width(8)),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? AppColors.tileColor),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
              style: style ??
                  Styles.smallText1.copyWith(
                      color: textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,)),
          isIcon
              ? IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: onIconPressed,
                  icon: Icon(
                    Icons.close,
                    color: iconColor ?? AppColors.mainColor,
                    size: height(14),
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}

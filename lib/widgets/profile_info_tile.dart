import 'package:bringin/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../res/app_font.dart';
import '../res/dimensions.dart';

class ProfileInfoTile extends StatelessWidget {
  final String? firstText, secondText, iconPath;
  final Color? iconColor;
  final Color? secondTextColor;
  final void Function()? onPressed;
  final double? heights, widths;
  final Widget? child;

  const ProfileInfoTile({
    super.key,
    required this.firstText,
    this.secondText,
    required this.iconPath,
    this.iconColor,
    this.secondTextColor,
    this.onPressed,
    this.heights,
    this.widths, this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.r, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.r),
        border: Border.all(
          color: AppColors.appBorder,
          width: .5,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: height(6)),
              height: height(59),
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius(6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(firstText!, style: Styles.bodyMedium2),
                            child ?? SizedBox(),
                          ],
                        ),
                        Container(
                            height: height(25),
                            child: Text(
                              secondText ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Styles.bodyLarge
                                  .copyWith(color: secondTextColor),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height(20)),
                    child: SvgPicture.asset(
                      iconPath!,
                      color: iconColor,
                      height: heights ?? height(11),
                      width: widths ?? width(11),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

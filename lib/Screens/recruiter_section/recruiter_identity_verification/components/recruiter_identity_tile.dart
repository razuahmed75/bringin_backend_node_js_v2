import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../res/app_font.dart';
import '../../../../res/dimensions.dart';

class RecruiterIdentityTile extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String iconPath;
  final void Function()? onTap;

  const RecruiterIdentityTile({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        color: Colors.transparent,
        height: height(70),
        padding: EdgeInsets.symmetric(
          horizontal: width(15),
          vertical: height(12),
        ),
        margin: EdgeInsets.only(bottom: height(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Image.asset(iconPath,height: 20.h,width: 20.h,fit: BoxFit.fitHeight,),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(firstText, style: Styles.bodyMedium),
                const Gap(7),
                Text(
                  secondText,
                  style: Styles.bodySmall3,
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 15.h),
                Image.asset("assets/icon2/forword.png"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

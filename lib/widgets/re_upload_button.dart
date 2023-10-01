import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class ReUploadButton extends StatelessWidget {
  final void Function()? onTap;
  const ReUploadButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(radius(16)),
              child: Ink(
                width: width(130),
                height: height(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius(37)),
                  border: Border.all(color: AppColors.mainColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icon2/upload.png",height: 12.h,width: 12.h,fit: BoxFit.fitHeight),
                    const Gap(10),
                    Text("Re-Upload",
                        style: Styles.bodySmall1
                            .copyWith(color: AppColors.mainColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

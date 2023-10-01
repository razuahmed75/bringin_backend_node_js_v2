// ignore_for_file: must_be_immutable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class FileUploaderWidget extends StatelessWidget {
  void Function()? onUploadPressed;
  FileUploaderWidget({super.key, this.onUploadPressed});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 240.w,
          height: 202.h,
          decoration: BoxDecoration(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(radius(6)),
          ),
          child: DottedBorder(
            borderType: BorderType.RRect,
            dashPattern : [7, 6],
            color: AppColors.mainColor,
            radius: Radius.circular(6.r),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 41.h),
                  Image.asset("assets/icon2/imageupload.png",height: 55.h,width: 55.h,),
                  Spacer(),
                  InkWell(
                    onTap: onUploadPressed,
                    child: Container(
                      width: width(111),
                      height: height(40),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.mainColor,
                        ),
                        borderRadius: BorderRadius.circular(radius(37)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icon2/upload.png",height: 12.h,width: 12.h,fit: BoxFit.fitHeight),
                          const Gap(10),
                          Text("Upload", style: Styles.bodySmall1.copyWith(
                            color: AppColors.mainColor,
                          )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 41.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

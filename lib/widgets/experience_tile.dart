import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';

class ExperienceTile extends StatelessWidget {
  final String firstText, secondText, thirdText;
  final Widget? subText;
  final Color? secondTextColor,thirdTextColor;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? secondTextSize;
  final void Function()? onPressed;
  final void Function()? onStartPressed;
  final void Function()? onEndPressed;
  final bool? isStartWorkingSection;

  const ExperienceTile({
    super.key,
    required this.firstText,
    required this.secondText,
    this.subText,
    this.secondTextColor,
    this.thirdTextColor,
    this.secondTextSize,
    this.onPressed,
    this.maxLines = null,
    this.overflow = TextOverflow.ellipsis,
    this.isStartWorkingSection = false,
    this.onStartPressed,
    this.onEndPressed,
    this.thirdText = "",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: height(4)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(radius(6)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: height(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(firstText, style: Styles.bodyMedium2.copyWith(color: AppColors.blackColor.withOpacity(.5))),
              Gap(isStartWorkingSection == true ? 0 : 5),
              Row(
                children: [
                  isStartWorkingSection == true
                      ? InkWell(
                          onTap: onStartPressed,
                          child: Container(
                              padding: EdgeInsets.only(top: height(7),bottom: height(7),right: width(7)),
                              child: Text(secondText, style: Styles.bodyLarge.copyWith(color: secondTextColor))),
                        )
                      : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              secondText,
                              overflow: overflow,
                              maxLines: maxLines,
                              style: Styles.bodyLarge.copyWith(fontSize: secondTextSize,color: secondTextColor)),
                            subText?? SizedBox(),
                          ],
                        ),
                      ),
                  isStartWorkingSection == true
                      ? Container(
                          width: width(8),
                          height: 2,
                          color: AppColors.blackColor.withOpacity(.5),
                        )
                      : SizedBox.shrink(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isStartWorkingSection == true
                          ? InkWell(
                              onTap: onEndPressed,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width(7),
                                      vertical: height(7)),
                                  child: Text(thirdText,
                                      style: Styles.bodyLarge
                                          .copyWith(fontSize: secondTextSize,color: thirdTextColor))),
                            )
                          : SizedBox.shrink(),
                      
                    ],
                  ),
                  SvgPicture.asset(
                        AppImagePaths.arrowForwardIcon,
                        height: height(13),
                        width: height(13),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

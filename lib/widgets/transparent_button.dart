import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';


class TransparentButton extends StatelessWidget {
  final void Function()? onTap;
  final double? widths, fontSize, heights;
  final Color? bgColor, borderColor, textColor, emojiColor;
  final String iconPath, text;
  final AlignmentGeometry? alignment;
  final FontWeight? fontWeight;
  final bool isPaddingLeft, isIcon;

  const TransparentButton({
    super.key,
    this.onTap,
    this.widths,
    this.bgColor = Colors.transparent,
    this.borderColor,
    this.textColor = AppColors.blackColor,
    this.emojiColor,
    required this.iconPath,
    required this.text,
    this.fontSize,
    this.alignment = Alignment.center,
    required this.isPaddingLeft,
    required this.isIcon,
    this.fontWeight = FontWeight.w500,
    this.heights,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius(3)),
          child: Container(
            width: widths ?? width(258),
            height: heights ?? height(48),
            padding: EdgeInsets.only(left: width(isPaddingLeft ? 20 : 0)),
            alignment: alignment,
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(
                  width: 0.5, color: borderColor ?? AppColors.mainColor),
              borderRadius: BorderRadius.circular(radius(3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isIcon
                    ? SvgPicture.asset(
                        iconPath,
                        color: emojiColor,
                        height: height(20),
                        width: height(20),
                      )
                    : SizedBox.shrink(),
                Gap(isIcon ? 10 : 0),
                Text(text,
                    style: Styles.bodyMedium.copyWith(
                        color: textColor,
                        fontWeight: fontWeight,
                        fontSize: fontSize)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

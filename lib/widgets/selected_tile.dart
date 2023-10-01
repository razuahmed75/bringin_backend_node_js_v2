import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class SelectedTile extends StatelessWidget {
  final String text;
  final bool? isIcon;
  final Color? bgColor;
  final void Function()? onCancelPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;

  const SelectedTile({
    super.key,
    required this.text,
    this.onCancelPressed,
    this.isIcon = true,
    this.bgColor = AppColors.tileColor,
    this.padding, this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: padding ??
          EdgeInsets.symmetric(horizontal: width(10), vertical: height(5)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius(3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style:style?? Styles.bodySmall1),
          Gap(isIcon == true ? 5 : 0),
          isIcon == true
              ? Container(
                  width: width(12),
                  child: IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: onCancelPressed,
                    icon: Icon(
                      Icons.close,
                      size: height(12),
                      color: AppColors.blackOpacity70,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

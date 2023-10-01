import 'package:flutter/material.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class SelectedSectorTile extends StatelessWidget {
  final void Function()? onCancelPressed;
  final String text;
  final Color? textColor, iconColor, bgColor;
  final double? fonts;

  const SelectedSectorTile({
    super.key,
    this.onCancelPressed,
    required this.text,
    this.textColor,
    this.iconColor,
    this.bgColor,
    this.fonts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: width(18)),
      constraints: BoxConstraints(
        minWidth: width(75),
        maxWidth: width(100),
        minHeight: height(30),
        maxHeight: height(70),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius(3)),
        color: bgColor ?? AppColors.mainColor,
      ),
      child: Stack(
        children: [
          Positioned(
            top: height(2),
            right: width(5),
            child: Container(
                width: width(12),
                height: height(12),
                alignment: Alignment.center,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onCancelPressed,
                    icon: Icon(
                      Icons.close,
                      color: iconColor ?? AppColors.whiteColor,
                      size: height(10),
                    ))),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: height(10),
                  left: width(18),
                  bottom: height(10),
                  right: width(15)),
              child: Text(
                text,
                style: Styles.bodySmall.copyWith(
                  color: textColor ?? AppColors.whiteColor,
                  fontSize: fonts ?? font(13),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

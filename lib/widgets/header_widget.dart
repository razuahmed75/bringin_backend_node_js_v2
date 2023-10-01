import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../res/app_font.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';
import 'save_button.dart';

class HeaderWidget extends StatelessWidget {
  final void Function()? onBackPressed;
  final void Function()? onSavePressed;
  final String middleText;
  final EdgeInsetsGeometry? margin;
  final bool isArrow;

  const HeaderWidget({
    super.key,
    required this.onBackPressed,
    this.onSavePressed,
    required this.middleText,
    required this.isArrow,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(top: height(45)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isArrow
              ? GestureDetector(
                  onTap: onBackPressed,
                  child: SvgPicture.asset(
                    AppImagePaths.arrowBackIcon,
                    width: width(22),
                    height: width(22),
                  ),
                )
              : Container(
                  width: width(58),
                  height: height(34),
                  child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: onBackPressed,
                      child: Text("Cancel", style: Styles.bodyMedium1)),
                ),
          Text(middleText, style: Styles.bodyLargeSemiBold),
          SaveButton(onSavePressed: onSavePressed)
        ],
      ),
    );
  }
}

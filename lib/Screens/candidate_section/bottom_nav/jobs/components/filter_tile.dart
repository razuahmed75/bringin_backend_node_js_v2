import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/color.dart';
import '../../../../../res/constants/image_path.dart';
import '../../../../../res/dimensions.dart';


class FilterTile extends StatelessWidget {
  final String text;
  final Color? bgColor,textColor;
  final void Function()? onTap;

  const FilterTile({
    super.key,
    required this.text,
    this.onTap, this.bgColor, this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius(12)),
      splashColor: AppColors.mainColor.withOpacity(.3),
      highlightColor: AppColors.mainColor.withOpacity(.3),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height(10)),
        padding: EdgeInsets.symmetric(
          horizontal: width(9),
          vertical: height(4),
        ),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(radius(12)),
        ),
        child: Row(
          children: [
            Text(text, style: Styles.bodySmall2.copyWith(
              color: textColor
            )),
            Padding(
              padding: EdgeInsets.only(top: height(10)),
              child: SvgPicture.asset(AppImagePaths.drop_down),
            ),
          ],
        ),
      ),
    );
  }
}

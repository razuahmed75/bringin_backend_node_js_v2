import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/constants/image_path.dart';
import '../../../../../res/dimensions.dart';

class MainProfileTile extends StatelessWidget {
  final void Function()? onTap;
  final String iconPath;
  final String text, additionalText;
  final String? img;
  final Color? imgColor;

  const MainProfileTile({
    super.key,
    this.onTap,
    required this.iconPath,
    required this.text,
    required this.additionalText,
    this.img, this.imgColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius(8)),
      child: Ink(
        padding: EdgeInsets.only(
            top: height(10), bottom: height(10), right: width(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (img == null)
                  SvgPicture.asset(
                    iconPath,
                    color: imgColor,
                    height: height(24),
                    width: width(24),
                  ),
                if (img != null)
                  Image.asset(
                    img!,
                    color: imgColor,
                    height: height(24),
                    width: width(24),
                  ),
                const Gap(13),
                Text(text, style: Styles.bodyMedium1),
              ],
            ),
            Row(
              children: [
                Text(additionalText, style: Styles.smallText3),
                const Gap(32),
                SvgPicture.asset(
                  AppImagePaths.arrowForwardIcon,
                  height: height(11),
                  width: width(11),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/color.dart';
import '../../../../../res/constants/image_path.dart';
import '../../../../../res/dimensions.dart';


class RadioTileWidget extends StatelessWidget {
  final String title;
  final int value, groupValue;
  final Color? color, selectedColor;
  final void Function(int?)? onChanged;

  RadioTileWidget({
    super.key,
    required this.value,
    required this.groupValue,
    this.color = Colors.transparent,
    this.selectedColor = AppColors.mainColor,
    this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: height(20)),
      child: InkWell(
        onTap: () => onChanged!(value),
        borderRadius: BorderRadius.circular(6),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(top: 1.5),
                decoration: BoxDecoration(
                  color: value == groupValue ? selectedColor : color,
                  shape: BoxShape.circle,
                  border: Border.all(width: 0.5, color: AppColors.mainColor),
                ),
                child: Padding(
                  padding: EdgeInsets.all(height(4)),
                  child: value == groupValue
                      ? SvgPicture.asset(
                          AppImagePaths.done2,
                          height: height(10),
                          width: height(10),
                          color: AppColors.whiteColor,
                        )
                      : SvgPicture.asset(
                          AppImagePaths.done2,
                          height: height(10),
                          width: height(10),
                          color: Colors.transparent,
                        ),
                )),
            const Gap(10),
            Container(
              width: width(285),
              child: Text(title, style: Styles.bodyMedium1),
            ),
          ],
        ),
      ),
    );
  }
}

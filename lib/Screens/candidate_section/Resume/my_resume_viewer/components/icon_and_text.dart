import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/dimensions.dart';

class IconAndText extends StatelessWidget {
  final String iconPath;
  final double? iconSize;
  final String text;

  const IconAndText(
      {super.key, required this.iconPath, required this.text, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: SvgPicture.asset(
            iconPath,
            height: iconSize ?? height(23),
            width: iconSize ?? height(23),
          ),
        ),
        const Gap(5),
        Expanded(
          child: Text(
            text, 
            style: Styles.bodySmall1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
      ],
    );
  }
}

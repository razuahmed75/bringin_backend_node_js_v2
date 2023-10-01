import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../res/app_font.dart';
import '../../../../res/dimensions.dart';

class JobRecuirementTile extends StatelessWidget {
  final String firstText, secondText;
  final Color? firstTextColor,secondTextColor;
  final void Function()? onTap;

  const JobRecuirementTile({
    super.key,
    required this.firstText,
    required this.secondText,
    this.firstTextColor,
    this.secondTextColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: width(95),
        height: height(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(firstText, style: Styles.bodySmall1.copyWith(color: firstTextColor)),
            const Gap(8),
            Text(secondText, textAlign: TextAlign.center, style: Styles.smallText1.copyWith(color: secondTextColor)),
          ],
        ),
      ),
    );
  }
}

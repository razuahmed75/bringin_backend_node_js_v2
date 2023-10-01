import 'package:bringin/Hive/hive.dart';
import 'package:bringin/widgets/transparent_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';
import '../utils/services/keys.dart';

class EmptyWhoSavedMe extends StatelessWidget {
  final void Function()? onTap;
  final String icon,description;
  const EmptyWhoSavedMe({super.key, this.onTap, required this.icon, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
    child: Column(
      children: [
        const Gap(50),
        Image.asset(
          icon,
          height: height(94),
          width: height(94),
        ),
        const Gap(25),
        Container(
          width: width(263),
          child: Text(
            description,
            style: Styles.bodyMedium1.copyWith(
              color: AppColors.blackColor.withOpacity(.5),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(25),
        TransparentButton(
          onTap: onTap,
          widths: width(235),
          heights: height(40),
          bgColor: AppColors.mainColor,
          textColor: AppColors.whiteColor,
          iconPath: "",
          text: HiveHelp.read(Keys.isRecruiter) ? "Find Candidates" : "Find Recruiters",
          fontWeight: FontWeight.w600,
          isPaddingLeft: false,
          isIcon: false,
        ),
      ],
    ),
  );
  }
}
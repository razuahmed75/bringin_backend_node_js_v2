import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class JobsOpeningCount extends StatelessWidget {
  final String text;
  const JobsOpeningCount({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: Dimensions.kDefaultPadding,
          child: Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: height(10)),
            decoration: BoxDecoration(
              color: Color(0XFFF1F1F1),
              borderRadius: BorderRadius.circular(radius(6)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Jobs Opening",
                  style: Styles.bodyMedium,
                ),
                const Gap(9),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: height(4)),
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(2)),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Styles.bodyMedium.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
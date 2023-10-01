import 'package:flutter/material.dart';

import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class MySkillsTile extends StatelessWidget {
  final Color? indicatorColor;
  final String text;
  const MySkillsTile({super.key, this.indicatorColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: indicatorColor!,
                  width: .5))),
      child: Text(
        text,
        style: Styles.bodySmall1
            .copyWith(color: AppColors.mainColor, fontSize: font(15)),
      ),
    );
  }
}

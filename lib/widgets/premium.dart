import 'package:flutter/material.dart';

import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class Premium extends StatelessWidget {
  const Premium({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.symmetric(vertical: height(1),horizontal: width(2)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: AppColors.yellowColor,
                width: .25,
              ),
            ),
            child: Text("Premium",style: Styles.smallText.copyWith(
              color: AppColors.yellowColor,
              fontSize: font(11),
            )),
          );
  }
}
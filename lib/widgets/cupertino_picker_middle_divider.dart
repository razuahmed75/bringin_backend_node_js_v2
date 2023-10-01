import 'package:flutter/material.dart';

import '../res/color.dart';
import '../res/dimensions.dart';

class CuperTinoMiddleDivider extends StatelessWidget {
  final double? btmDvdrMrgnTop;
  final double? topDvdrMrgnBtm;
  final Color? color;
  const CuperTinoMiddleDivider({super.key, this.btmDvdrMrgnTop, this.topDvdrMrgnBtm, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 1,
          width: double.maxFinite,
          margin: EdgeInsets.only(bottom: height(topDvdrMrgnBtm ?? 20)),
          color: color?? AppColors.borderColor.withOpacity(.5),
        ),
        Container(
          height: 1,
          width: double.maxFinite,
          margin: EdgeInsets.only(top: height(btmDvdrMrgnTop ?? 20)),
          color: color?? AppColors.borderColor.withOpacity(.5),
        ),
      ],
    );
  }
}
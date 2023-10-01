import 'package:flutter/material.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

Widget thinDivider() {
  return Container(
    margin: Dimensions.kDefaultPadding,
    height: .4,
    width: double.infinity,
    color: AppColors.borderColor.withOpacity(.4),
  );
}

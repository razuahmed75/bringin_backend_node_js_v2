// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import '../res/color.dart';


class AppSwitch extends StatelessWidget {
  bool value;
  final void Function(bool)? onChanged;
  AppSwitch({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .75,
      child: CupertinoSwitch(
          activeColor: AppColors.mainColor,
          value: value,
          onChanged: onChanged,
          ),
    );
  }
}

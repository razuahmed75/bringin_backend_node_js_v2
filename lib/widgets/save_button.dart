import 'package:flutter/material.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class SaveButton extends StatelessWidget {
  final Function()? onSavePressed;
  const SaveButton({super.key, this.onSavePressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSavePressed,
      child: Container(
          width: width(58),
          height: height(28),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text("Save",
              style: Styles.bodyMedium2.copyWith(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w500,
              ))),
    );
  }
}

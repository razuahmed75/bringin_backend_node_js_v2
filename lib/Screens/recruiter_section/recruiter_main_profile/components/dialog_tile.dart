import 'package:flutter/material.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/color.dart';
import '../../../../../res/dimensions.dart';

class DialogTile extends StatelessWidget {
  final String leading, trailing;

  const DialogTile({super.key, required this.leading, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(360),
      height: height(60),
      padding: EdgeInsets.symmetric(horizontal: width(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading, style: Styles.bodyLargeMedium),
          Text(trailing,
              style: Styles.bodyMedium1.copyWith(color: AppColors.mainColor)),
        ],
      ),
    );
  }
}

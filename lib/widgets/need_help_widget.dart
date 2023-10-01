import 'package:flutter/material.dart';

import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';
import 'build_contact_dialog.dart';

class NeedHelpWidget extends StatelessWidget {
  const NeedHelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () => buildContactDialog(context),
                  child: Container(
                    alignment: Alignment.center,
                    width: width(90),
                    height: height(30),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(radius(21)),
                    ),
                    child: Text("Need Help?", style: Styles.bodySmall1.copyWith(
                      color: AppColors.whiteColor
                    ))),
                ),
              ],
            );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../res/app_font.dart';
import '../res/color.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';

class Remote extends StatelessWidget {
  const Remote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.symmetric(horizontal: width(2),vertical: height(1)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppImagePaths.homeIcon,
                    width: height(9),
                  ),
                  const Gap(3),
                  Text("Remote",style: Styles.smallText.copyWith(color: AppColors.mainColor,fontSize: font(11))),
                ],
              ));
            
  }
}
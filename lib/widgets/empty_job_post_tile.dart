

import 'package:bringin/res/color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../res/app_font.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';

Widget EmptyJobPostTile({
  final String? text, imagePath,
}) {
    return Container(
              margin: EdgeInsets.only(top: height(100)),
               child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image.asset(
                    imagePath ?? AppImagePaths.empty_job_post,
                     fit: BoxFit.cover,
                     width: height(100),
                     height: height(100),
                   ),
                   const Gap(10),
                   Text(
                     text!,
                     style: Styles.bodyLargeMedium.copyWith(
                      color: AppColors.blackOpacity70,
                     ),
                   ),
                 ],
               ),
             );
  }
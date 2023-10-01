// ignore_for_file: must_be_immutable

import 'package:bringin/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/constants/image_path.dart';
import '../../../../../res/dimensions.dart';

class WorkExperienceTile extends StatelessWidget {
  final bool? isIcon;
  final String? companyName,designation,expertise_area;
  final String? workDuration;
  final String? jobDescriptionScreen;
  final int? jobDescriptionMaxLines;
  final TextOverflow? jobDescriptionOverflow;
  WorkExperienceTile(
      {super.key,
      this.isIcon = true,
      this.companyName,
      this.workDuration,
      this.jobDescriptionScreen, 
      this.designation, this.expertise_area, 
      this.jobDescriptionMaxLines=2, 
      this.jobDescriptionOverflow=TextOverflow.ellipsis,
    });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Expanded(
              flex: 5,
               child: Container(
                alignment: Alignment.centerLeft,
                 child: Text(
                  companyName ?? "",
                  style: Styles.bodySmall1.copyWith(fontSize: font(15)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                             ),
               ),
             ),
            const Gap(20),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(workDuration ?? "",
                style: Styles.smallText1.copyWith(fontSize: font(13)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                          ),
              ),
            ),
            isIcon == true ? Gap(10) : SizedBox.shrink(),
           
            isIcon == true
                ? Container(
                    margin: EdgeInsets.only(right: width(6)),
                    child: SvgPicture.asset(AppImagePaths.arrowForward2Icon))
                : SizedBox.shrink(),
          ],
        ),
        const Gap(5),
         Row(
           children: [
             Expanded(
               child: RichText(
                    text: TextSpan(
                      text: designation == null ? "" : designation,
                      style: Styles.smallText2.copyWith(fontSize: font(13)),
                      children: [
                        TextSpan(
                          text: expertise_area == null ? "" : " | " + expertise_area!,
                          style: Styles.smallText2.copyWith(fontSize: font(13)),
                        ),
                      ]
                    ),
                    
                  ),
             ),
           ],
         ),
        SizedBox(height: height(7)),
        Text(
          jobDescriptionScreen ?? "",
          maxLines: jobDescriptionMaxLines,
          overflow: jobDescriptionOverflow,
          style: Styles.bodySmall.copyWith(
            color: AppColors.blackOpacity70,
            fontWeight: FontWeight.w300,
            fontSize: font(15),
          ),
        ),
      ],
    );
  }
}

import 'package:bringin/res/color.dart';
import 'package:bringin/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/constants/image_path.dart';

class EducationQualify extends StatelessWidget {
  final bool? isArrowIcon;
  final String? instituteName;
  final String? educationLevel;
  final String? gradePoint;
  final String? educationDuration;
  final String? otherActivities;
  final int? otherActivitiesMaxLines;
  final TextOverflow? otherActivitiesOverflow;
  const EducationQualify(
      {super.key,
      this.isArrowIcon = true,
      this.instituteName,
      this.educationDuration,
      this.educationLevel,
      this.gradePoint, 
      this.otherActivities, 
      this.otherActivitiesMaxLines=2, 
      this.otherActivitiesOverflow=TextOverflow.ellipsis,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: otherActivities == "" ? 0:height(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    instituteName!, 
                    style: Styles.bodySmall1.copyWith(fontSize: font(15)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Gap(20),
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: 
                  Text(educationDuration!, 
                  style: Styles.smallText1.copyWith(fontSize: font(13)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
              ),
              Gap(isArrowIcon == true ? 10 : 0),
              isArrowIcon == true
                  ? Container(
                      // margin: EdgeInsets.only(top: height(30)),
                      child: SvgPicture.asset(AppImagePaths.arrowForward2Icon))
                  : SizedBox(),
            ],
          ),
          Gap(isArrowIcon == true ? 5 : 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  educationLevel!, 
                  style: Styles.smallText2.copyWith(fontSize: font(13)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
            Gap(7),
            Text(gradePoint!,
            style: Styles.smallText1.copyWith(
              color: AppColors.blackOpacity70,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          otherActivities == null ? SizedBox() : const Gap(5),
          Text(
          otherActivities ?? "",
          maxLines: otherActivitiesMaxLines,
          overflow: otherActivitiesOverflow,
          style: Styles.bodySmall.copyWith(
            color: AppColors.blackOpacity70,
            fontWeight: FontWeight.w300,
            fontSize: font(15),
          ),
        ),
        ],
      ),
    );
  }
}

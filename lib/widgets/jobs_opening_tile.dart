import 'package:bringin/widgets/remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';

class JobsOpeningTile extends StatelessWidget {
  final String jobTitle;
  final bool? isCrossBtn,isRespotBtn;
  final void Function()? onClosePressed,onRepostPressed;
  final String salary;
  final String jobDescription;
  final String experienceLevel,educationLevel;
  final String location;
  final bool? isRemote;
  final void Function()? onTap;
  
  const JobsOpeningTile({
    super.key, 
    required this.jobTitle, 
    required this.salary, 
    required this.jobDescription, 
    required this.experienceLevel, 
    required this.educationLevel, 
    required this.location, 
    this.isRemote=true, 
    this.onTap, 
    this.isCrossBtn=false, 
    this.isRespotBtn=false, 
    this.onClosePressed, 
    this.onRepostPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: height(10)),
      child: InkWell(
        onTap: onTap,
        child: Container(
                padding: Dimensions.kDefaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// job title, salary
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: width(175),
                              ),
                              child: Text(
                                jobTitle,
                                style: Styles.bodyLargeSemiBold,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                              /// JOB CLOSE BUTTON
                              Gap(isCrossBtn == true ?5:0),
                                isCrossBtn == true ? IconButton(
                                  onPressed: onClosePressed,
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Container(
                                    height: height(15),
                                    width: height(15),
                                    decoration: BoxDecoration(
                                      color: AppColors.jobClosedColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.close,
                                    color: AppColors.whiteColor,
                                    size: height(10)),
                                  ),):SizedBox(),
                          ],
                        ),
    
                        Spacer(),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(height(3)),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.mainColor.withOpacity(.2),width: .7),
                            borderRadius: BorderRadius.circular(radius(10)),
                          ),
                          child: Text(
                            salary,
                            style: Styles.smallText1.copyWith(
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: font(13),
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    Text(jobDescription,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.bodySmall2),
                    Gap(12),
                    Row(
                      children: [
                        _tile(text: experienceLevel),
                        const Gap(5),
                        _tile(text: educationLevel),
                        Spacer(),
                        /// REPOST BUTTON
                      isRespotBtn == true ? SizedBox(
                        height: height(35),
                        child: TextButton(
                          onPressed: onRepostPressed, 
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.mainColor.withOpacity(.1),
                          ),
                          child: Text("Repost")),
                        ):SizedBox(),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                        children: [
                          SvgPicture.asset(
                            AppImagePaths.locationIcon,
                            height: height(11),
                          ),
                          const Gap(1),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: Dimensions.screenWidth*.49,
                            ),
                            child: Text(location,
                            style: Styles.smallText3.copyWith(fontSize: font(13)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      isRemote == true ?
                        Remote()
                        :SizedBox(),
                      ],
                    ),
                    const Gap(10),
                    Container(
                      height: height(4),
                      width: double.maxFinite,
                      color: AppColors.greyColor.withOpacity(.4),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
  Container _tile({required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height(2),horizontal: width(2)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appBorder,width: .5),
        borderRadius: BorderRadius.circular(radius(8)),
      ),
      child: Text(text, style: Styles.smallText2.copyWith(fontSize: font(13))),
    );
  }
}
import 'package:bringin/res/dimensions.dart';
import 'package:bringin/widgets/premium.dart';
import 'package:bringin/widgets/remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../res/app_font.dart';
import '../../res/color.dart';
import '../../res/constants/image_path.dart';
import 'package:dotted_line/dotted_line.dart';

class JobsTile extends StatelessWidget {
  final String jobTitle;
  final String? salary;
  final Widget? child;
  final String experienceLevel;
  final String educationLevel;
  final String userPhoto;
  final String userName;
  final String designation;
  final bool? isPremium;
  final bool? isRemote;
  final String companyName;
  final String employeeSize;
  final String location;
  final String? jobDescription;

  const JobsTile({
    super.key,
    required this.jobTitle,
    required this.salary,
    this.child,
    required this.experienceLevel,
    required this.educationLevel,
    required this.userPhoto,
    required this.userName,
    required this.designation,
    this.isPremium = true,
    this.isRemote = true,
    required this.companyName,
    required this.employeeSize,
    required this.location, 
    this.jobDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Dimensions.kDefaultgapTop,

        /// job title, salary
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 6,
                child: Text(
                  jobTitle,
                  style: Styles.bodyLargeSemiBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
            Gap(10),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(height(3)),
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.mainColor.withOpacity(.2), width: .7),
                borderRadius: BorderRadius.circular(radius(10)),
              ),
              child: Text(
                salary!,
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
        const Gap(6),

        /// job description or others
          child ?? SizedBox(),
         jobDescription == null ? SizedBox() : Text(jobDescription!,style: Styles.smallText2.copyWith(fontSize: font(14)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
        const Gap(8),

        /// experience year, education level, location
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tile(text: experienceLevel),
            const Gap(5),
            _tile(text: educationLevel),
            Spacer(),
            Row(
              children: [
                SvgPicture.asset(
                  AppImagePaths.locationIcon,
                  height: height(11),
                ),
                const Gap(1),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: Dimensions.screenWidth * .24,
                  ),
                  child: Text(location,
                      style: Styles.smallText3.copyWith(fontSize: font(13)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                // Container(
                //   // color: Colors.amber,
                //   width: Dimensions.screenWidth*.24,
                //   // constraints: BoxConstraints(
                //   //   maxWidth: Dimensions.screenWidth*.24,
                //   // ),
                //   child: Text(location,
                //   style: Styles.smallText3,
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis),
                // ),
              ],
            ),
          ],
        ),
        const Gap(14),

        /// recruiter and company details
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    children: [
                      /// image
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipOval(
                            child: Container(
                              height: height(27),
                              width: height(27),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: userPhoto,
                                maxHeightDiskCache: 75,
                                maxWidthDiskCache: 75,
                                fit: BoxFit.cover,
                                errorWidget: (context, error, stackTrace) =>
                                    Icon(Icons.error, size: height(28)),
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            AppImagePaths.verifiedIcon,
                            height: height(14),
                            width: width(11),
                          ),
                        ],
                      ),
                      const Gap(5),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// name, designation
                            // Text(
                            //   userName +" • "+designation,
                            //   style: Styles.smallText1,
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                            RichText(
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: userName,
                                    style: Styles.smallText1.copyWith(fontSize: font(13)),
                                  ),
                                  TextSpan(
                                    text: " • ",
                                    style: Styles.smallText3.copyWith(
                                      fontSize: font(13),
                                      color:
                                          Color(0xff898989CC).withOpacity(.8),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: designation,
                                    style: Styles.smallText1.copyWith(fontSize: font(13)),
                                  ),
                                ])),
                            // Row(
                            //   children: [

                            // const Gap(5),
                            // Expanded(
                            //   flex: 1,
                            //   child: Container(
                            //     color: Colors.red,
                            //     child: Padding(
                            //       padding: EdgeInsets.only(top: height(3)),
                            //       child: Text("•",style: Styles.bodyLargeSemiBold.copyWith(color: AppColors.borderColor)),
                            //     ),
                            //   ),
                            // ),
                            // const Gap(5),
                            // Expanded(
                            //   flex: 12,
                            //   // constraints: BoxConstraints(
                            //   //   maxWidth: width(55)
                            //   // ),
                            //   child: Container(
                            //     color: Colors.amber,
                            //     child: Text(
                            //       designation,
                            //       style: Styles.smallText1,
                            //       maxLines: 1,
                            //       overflow: TextOverflow.ellipsis,
                            //     ),
                            //   )),
                            //   ],
                            // ),

                            /// isPremium
                            isPremium == true ? Premium() : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // const Gap(5),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  /// divider
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: height(5),
                        width: height(5),
                        decoration: BoxDecoration(
                          color: Color(0xff898989CC).withOpacity(.8),
                          shape: BoxShape.circle,
                        ),
                      ),
                      DottedLine(
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        lineLength: 15,
                        lineThickness: .5,
                        dashLength: 1,
                        dashColor: Color(0xff898989CC).withOpacity(.8),
                        dashRadius: 0.0,
                        dashGapLength: 1,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      // Container(
                      //   width: .25,
                      //   height: height(15),
                      //   color: AppColors.borderColor,
                      // ),
                      Container(
                        height: height(5),
                        width: height(5),
                        decoration: BoxDecoration(
                          color: Color(0xff898989CC).withOpacity(.8),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const Gap(7),

                  /// company name and employee size
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          companyName,
                          style: Styles.smallText2.copyWith(fontSize: font(13)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(2),
                        Text(
                          employeeSize,
                          style: Styles.smallText2.copyWith(fontSize: font(13)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // const Gap(9),

        /// isRemote
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            isRemote == true ? Remote() : SizedBox(),
          ],
        ),
        const Gap(9),
        Container(
          height: height(4),
          width: double.maxFinite,
          color: AppColors.greyColor.withOpacity(.4),
        ),
      ],
    );
  }

  Container _tile({required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height(2), horizontal: width(2)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appBorder, width: .5),
        borderRadius: BorderRadius.circular(radius(8)),
      ),
      child: Text(text, style: Styles.smallText2.copyWith(fontSize: font(13))),
    );
  }
}

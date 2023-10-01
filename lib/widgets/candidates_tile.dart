import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';

class CandidatesTile extends StatelessWidget {
  final String name;
  final String designation;
  final String avatar;
  final String educational_level;
  final String experienceLevel;
  final String salaryRange;
  final String instituteName;
  final String subject_name;
  final List<String> skills;
  final String location;
  final String? description;
  final Widget? child;
  final String companyName;
  final String workDuration;

  const CandidatesTile({
    super.key,
    required this.name,
    required this.designation,
    required this.avatar,
    required this.educational_level,
    required this.experienceLevel,
    required this.salaryRange,
    required this.instituteName,
    required this.subject_name,
    required this.skills,
    required this.location,
    this.description,
    this.child,
    required this.companyName,
    required this.workDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: height(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// name, designation, experence_lvl, education_lvl, salary range
          Row(
            children: [
              SizedBox(width: 10.w),
              Padding(
                padding: EdgeInsets.only(right: width(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipOval(
                      child: Container(
                        height: height(45),
                        width: height(45),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: avatar,
                          maxHeightDiskCache: 80,
                          maxWidthDiskCache: 80,
                          fit: BoxFit.cover,
                          errorWidget: (context, error, stackTrace) =>
                              Icon(Icons.error, size: height(45)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// first name, designation
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              name +
                                  "${designation == "" ? "" : " • $designation"}",
                              style: Styles.bodyLargeSemiBold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(4),

                    /// graduation, experience level, salary range
                    Wrap(
                      spacing: 5,
                      children: [
                        TileWidget(text: experienceLevel),
                        educational_level == ""
                            ? SizedBox()
                            : TileWidget(text: educational_level),
                        TileWidget(text: salaryRange),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// about me
          const Gap(5),
          child == null
              ? SizedBox()
              : Padding(
                  padding: Dimensions.kDefaultPadding,
                  child: child ?? SizedBox(),
                ),
          description == null
              ? SizedBox()
              : Padding(
                  padding: Dimensions.kDefaultPadding,
                  child: Text(
                    description ?? "",
                    style: Styles.bodySmall2
                        .copyWith(color: AppColors.blackOpacity70),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
          const Gap(7),

          /// company name, working duration
          instituteName == ""
              ? SizedBox()
              : Padding(
                  padding: Dimensions.kDefaultPadding,
                  child: Row(
                    children: [
                      Image.asset(
                        AppImagePaths.graduationIcon,
                        height: height(13),
                        width: height(12),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          instituteName + " • " + subject_name,
                          style: Styles.bodySmall2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
          const Gap(3),
          companyName == ""
              ? SizedBox()
              : Padding(
                  padding: Dimensions.kDefaultPadding,
                  child: Row(
                    children: [
                      SizedBox(width: 0.5.w),
                      Image.asset(
                        AppImagePaths.suitcase,
                        height: height(13),
                        width: height(12),
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(.85),
                      ),
                      SizedBox(width: 4.w),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: Dimensions.screenWidth * .55,
                        ),
                        child: Text(
                          companyName,
                          style: Styles.bodySmall2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          " • " + workDuration,
                          style: Styles.bodySmall2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

          /// skills, location
          const Gap(7),
          Padding(
            padding: Dimensions.kDefaultPadding,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    // color: Colors.red,
                    child: Row(
                      children: [
                        SizedBox(width: 2.w),
                        SvgPicture.asset(
                          AppImagePaths.locationIcon,
                          height: height(13),
                          width: height(12),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            location,
                            style: Styles.textStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    // color: Colors.amber,
                    alignment: Alignment.centerRight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                              skills.length,
                              (index) => Text(
                                    skills.length - 1 == index
                                        ? skills[index]
                                        : skills[index] + ", ",
                                    style: Styles.smallText1.copyWith(
                                      color: Color(0xFF00A0DC),
                                      fontSize: font(13),
                                    ),
                                  )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Gap(9),
          Container(
            margin: Dimensions.kDefaultPadding,
            height: height(4),
            width: Dimensions.screenWidth,
            color: AppColors.greyColor.withOpacity(.4),
          ),
        ],
      ),
    );
  }

  Widget TileWidget({required String text}) {
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

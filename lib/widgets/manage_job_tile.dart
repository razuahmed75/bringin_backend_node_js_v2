// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gap/gap.dart';

// import '../res/app_font.dart';
// import '../res/color.dart';
// import '../res/constants/image_path.dart';
// import '../res/dimensions.dart';

// class ManageJobTileWidget extends StatelessWidget {
//   final String jobTitle;
//   final String salary;
//   final String location;
//   final bool? isCrossBtn,isRespotBtn;
//   final void Function()? onClosePressed,onRepostPressed;
//   final String experienceLevel;
//   final String educationLevel;

//   const ManageJobTileWidget({
//     super.key, 
//     required this.jobTitle, 
//     required this.salary, 
//     this.isCrossBtn = false, 
//     this.isRespotBtn = false, 
//     this.onClosePressed,
//     this.onRepostPressed, 
//     required this.experienceLevel,
//      required this.educationLevel, required this.location});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor
//       ),
//                       padding: EdgeInsets.symmetric(horizontal: width(15),vertical: height(15)),
//                       margin: EdgeInsets.only(bottom: height(10),top: height(10)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     constraints: BoxConstraints(
//                                       maxWidth: width(175),
//                                     ),
//                                     child: Text(
//                                       jobTitle,
//                                       style: Styles.bodyLargeSemiBold,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     )),
//                                      Gap(isCrossBtn == true ?5:0),
//                                     isCrossBtn == true ? IconButton(
//                                       onPressed: onClosePressed,
//                                       padding: EdgeInsets.zero,
//                                       constraints: BoxConstraints(),
//                                       icon: Container(
//                                         height: height(15),
//                                         width: height(15),
//                                         // alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                           color: AppColors.jobClosedColor,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: Icon(Icons.close,
//                                         color: AppColors.whiteColor,
//                                         size: height(10)),
//                                       ),):SizedBox(),
//                                 ],
//                               ),
//                                 Gap(8),

//                               Spacer(),
//                               Container(
//                                 alignment: Alignment.center,
//                                 padding: EdgeInsets.symmetric(vertical: height(8),horizontal: width(7)),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.mainColor,
//                                   borderRadius: BorderRadius.circular(radius(15)),
//                                 ),
//                                 child: Text(
//                                   salary,
//                                   style: Styles.bodyMedium.copyWith(color: AppColors.whiteColor),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ],
//                           ),
//                            /// experience year, education level
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _tile(text: experienceLevel),
//                             const Gap(10),
//                             _tile(text: educationLevel),
//                           ],
//                         ),
//                         const Gap(17),
//                         /// location
//                         Row(
//                           children: [
//                             Row(
//                               children: [
//                                 SvgPicture.asset(
//                                   AppImagePaths.locationIcon,
//                                   height: height(11),
//                                 ),
//                                 const Gap(6),
//                                 Text(
//                                   location,
//                                   style: Styles.smallText3,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                             Spacer(),
                   
//                           isRespotBtn == true ? SizedBox(
//                             height: height(35),
//                             child: TextButton(
//                               onPressed: onRepostPressed, 
//                               style: TextButton.styleFrom(
//                                 backgroundColor: AppColors.mainColor.withOpacity(.1),
//                               ),
//                               child: Text("Repost")
//                                         ),
//                           ):SizedBox()
//                         ],
//                       ),
                          
//                             ],
//                       ),
//                           );
//   }
//   Container _tile({required String text}) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: height(5), horizontal: width(10)),
//       decoration: BoxDecoration(
//         color: AppColors.mainColor.withOpacity(.10),
//         borderRadius: BorderRadius.circular(radius(18)),
//       ),
//       child: Text(text, style: Styles.textStyle),
//     );
//   }
// }
import 'package:bringin/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../res/app_font.dart';
import '../../../../res/color.dart';
import '../../../../res/dimensions.dart';

class ChatsTile extends StatelessWidget {
  final String photo;
  final String name;
  final String companyName;
  final String position;
  final String message;
  final String date;
  final Widget deliveredIcon;
  final bool isGap;

  final String? currentUserId;

  const ChatsTile({
    super.key,
    required this.photo,
    required this.name,
    required this.companyName,
    required this.message,
    required this.date,
    required this.deliveredIcon,
    this.isGap = true,
    required this.position,
 
    this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        /// photo
        
          ClipOval(
            child: Image.asset(
              photo,
              height: height(50),
              width: height(50),
              fit: BoxFit.cover,
            ),
          ),
       
        const Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width(270),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// name
                  // if (channel == null)
                    ExpandableText(
                      text: name,
                      style: Styles.bodyMedium,
                      textWidth: 20,
                    ),

                  // if (channel != null)
                    // ChannelTitleTextView(channel!, currentUserId),

                  /// date
                  // Text(
                  //   "${channel == null || channel!.lastMessage == null ? "" : DateFormat("hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(channel!.lastMessage!.createdAt))}",
                  //   style: Styles.smallText3.copyWith(
                  //     fontWeight: FontWeight.w300,
                  //   ),
                  // ),
                ],
              ),
            ),
            Gap(isGap == true ? 0 : 8),

            /// position
            isGap == false
                ? SizedBox.shrink()
                : Row(
                    children: [
                      ExpandableText(
                        textWidth: 25,
                        text: companyName,
                        style: Styles.smallText3.copyWith(
                          fontWeight: FontWeight.w300,
                          color: AppColors.blackColor.withOpacity(.35),
                        ),
                      ),
                      const Gap(5),
                      Text("•",style: Styles.bodySmall.copyWith(
                        fontSize: font(13),
                        color: AppColors.blackColor.withOpacity(.25),
                        fontWeight: FontWeight.w200,
                      )),
                      const Gap(5),
                      ExpandableText(
                          textWidth: 20,
                          text: position,
                          style: Styles.smallText3.copyWith(
                            fontWeight: FontWeight.w300,
                            color: AppColors.blackColor.withOpacity(.35),
                          )),
                    ],
                  ),
            Row(
              children: [
                deliveredIcon,
                const Gap(3),

                /// message
                // isGap == true
                //     ? SizedBox(
                //         width: width(250),
                //         child: Text(
                //           messagelast,
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //           style: Styles.bodySmall1.copyWith(
                //             color: AppColors.blackColor.withOpacity(.6),
                //           ),
                //         ),
                //       )
                //     : 
                    ExpandableText(
                        textWidth: 50,
                        text: message,
                        style: Styles.smallText1.copyWith(
                          color: AppColors.blackColor.withOpacity(.6),
                        ),
                      )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

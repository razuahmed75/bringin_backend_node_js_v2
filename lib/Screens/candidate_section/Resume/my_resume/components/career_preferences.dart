import 'package:bringin/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/constants/image_path.dart';
import '../../../../../res/dimensions.dart';


class CareerPreferenceWidget extends StatelessWidget {
  final bool? isArrowIcon;
  final String? functionalArea;
  final String? location;
  final String? salary;
  final List<String>? industryList;
  const CareerPreferenceWidget(
      {super.key,
      this.isArrowIcon = true,
      this.functionalArea,
      this.location,
      this.salary, 
      required this.industryList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 0, bottom: height(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    functionalArea!, 
                    style: Styles.bodyMedium1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                flex: 1,
                child: Container(

                  alignment: Alignment.centerRight,
                child: Text(
                salary!, 
                style: Styles.smallText1.copyWith(fontSize: font(13)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Gap(isArrowIcon == true ? 10 : 0),
              isArrowIcon == true
                  ? Container(
                      margin: EdgeInsets.only(top: height(15)),
                      child: SvgPicture.asset(AppImagePaths.arrowForward2Icon))
                  : SizedBox(),
            ],
          ),
          Gap(isArrowIcon == true ? 0 : 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 3,
                child: Wrap(
                  children: List.generate(industryList!.length, (i) {
                    return Container(
                      // constraints: BoxConstraints(
                      //   maxWidth: width(190),
                      // ),
                      child: Container(
                        // color: Colors.amber,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                // color: Colors.amber,
                                child: Text(
                                  i != industryList!.length - 1 ? industryList![i] +" "+ "|" : industryList![i],
                                  style: Styles.smallText3.copyWith(
                                    fontSize: font(13),
                                    color: AppColors.blackOpacity70.withOpacity(0.9),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            // const Gap(4),
                            // if (i != industryList!.length - 1)
                            //   Text(
                            //     "|",
                            //     style: Styles.bodySmall.copyWith(
                            //       fontSize: font(12),
                            //       color: AppColors.blackOpacity70.withOpacity(0.4),
                            //     ),
                            //   ),
                            // const Gap(4),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerRight,
                  // color: Colors.red,
                  child: Text(
                    location!,
                    style: Styles.smallText1.copyWith(
                      fontWeight: FontWeight.w300,
                      color: AppColors.blackOpacity70,
                      fontSize: font(13),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Gap(isArrowIcon == true ? 20 : 0),
            ],
          ),

        ],
      ),
    );
  }
}

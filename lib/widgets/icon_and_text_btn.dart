import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../res/app_font.dart';
import '../res/color.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';

class IconAndTextBtn extends StatelessWidget {
  final String? text;
  final double? btnwidth, btnheight; 
  final double? borderRadius;
  final void Function()? onTap;
  final Color? borderColor,bgColor;
  
  const IconAndTextBtn({
    super.key, 
    this.text, 
    this.btnwidth, 
    this.btnheight,
    this.borderRadius, 
    this.onTap, 
    this.borderColor = Colors.transparent, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
                         onTap: onTap,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: bgColor ?? AppColors.shadowColor,
                               border: Border.all(
                                color: borderColor!,
                                width: .5,
                              ),
                              borderRadius: BorderRadius.circular(radius(borderRadius ?? 6)),
                            ),
                            width: btnwidth ??  width(230),
                            height: btnheight ?? height(40),
                            // text: 
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    shape: BoxShape.circle,
                                    
                                  ),
                                  child: SvgPicture.asset(
                                    AppImagePaths.add_button,
                                    color: AppColors.blackColor,
                                    height: height(8),
                                  ),
                                ),
                                const Gap(24),
                                Text(
                                  text!,
                                  style: Styles.bodyMedium.copyWith(
                                    color: AppColors.blackOpacity70,
                                  ),
                                ),
                              ],
                            ),
                          ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../res/app_font.dart';
import '../../../../../res/color.dart';
import '../../../../../res/constants/image_path.dart';
import '../../../../../res/dimensions.dart';

class RowLayout extends StatelessWidget {
  final String? firstImagePath, secondImagePath,text;
  final void Function()? onTap;
  final bool? isIcon;
  final double? firstIconSize;
  
  const RowLayout({
    super.key, 
    this.firstImagePath, 
    this.secondImagePath, 
    this.text, this.onTap, 
    this.isIcon = true, 
    this.firstIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: width(15)),
          child: Text(text!,style: Styles.bodyMedium.copyWith(color: Color(0xFF005C8C)))),
       isIcon == true? Container(
         child: IconButton(
            onPressed: onTap,
            icon: Container(
              padding: EdgeInsets.all(height(secondImagePath == AppImagePaths.edit1 ? 5:4)),
              decoration: BoxDecoration(
              color: AppColors.mainColor,
              shape: BoxShape.circle,
            ),
              child: SvgPicture.asset(
              secondImagePath ?? AppImagePaths.add_button,
              height: height(secondImagePath == AppImagePaths.edit1 ? 11:13),
              width: height(secondImagePath == AppImagePaths.edit1 ? 11:13),
                      ),
            )),
       ) : SizedBox(),
      ],
    );
  }
}

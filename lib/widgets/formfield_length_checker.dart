import 'package:flutter/material.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class FormFieldLengthChecker extends StatelessWidget {
  final int characterLength;
  final int maxLength;
  final bool? isMargin;
  const FormFieldLengthChecker(
      {super.key, required this.characterLength, required this.maxLength, this.isMargin=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isMargin == true ? EdgeInsets.only(top: height(10), right: width(5)):EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: characterLength.toString(),
                style: Styles.bodyMedium.copyWith(
                  color: characterLength == maxLength
                      ? Colors.red
                      : AppColors.mainColor,
                      
                       
                      
                ),
              ),
              TextSpan(
                text: "/$maxLength",
                style: Styles.bodyMedium.copyWith(
                  color: characterLength == maxLength
                      ? AppColors.hintColor
                      : AppColors.blackColor,
                      
                      
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

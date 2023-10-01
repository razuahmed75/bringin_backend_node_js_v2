import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class AppPopupDialog {
  Future showPopup({
    context,
    String? description,
    String? buttonCancelText,
    String? buttonOkText,
    void Function()? onOkPress,
    void Function()? onCancelPress,
    bool? isTitle = false,
    String? titleText,
    CrossAxisAlignment? crossAxisAlignment,
    Color? buttonCancelColor,buttonCancelTextColor,
    Color? buttonOkColor,buttonOkTextColor,
    EdgeInsets? insetPadding,
    TextStyle? descriptionStyle,
    double ? bRadius,
    
  }){
   return showGeneralDialog(
      transitionDuration: Duration(milliseconds: 300),
      barrierLabel: '',
      context: context,
      barrierDismissible: true,
      pageBuilder: (context, animation1, animation2) {
        return Text('PAGE BUILDER');
      },
      barrierColor: AppColors.blackColor.withOpacity(0.70),
      transitionBuilder: (context, a1, a2, child) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              insetPadding: insetPadding ?? EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius(bRadius ?? 20)),
              ),
              elevation: 0,
              content: Column(
                crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                 isTitle == true? Container(
                  padding: EdgeInsets.only(bottom: height(15)),
                   child: Text(
                      titleText ?? "",
                      style: Styles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                 ):SizedBox(),
                  Text(
                    description?? "Do you want to exit the app?",
                    style: descriptionStyle ?? Styles.bodyMedium,
                  ),
                  const Gap(22),
                  Row(
                    children: [
                     isTitle == true ? Spacer():SizedBox(),
                      Expanded(
                        child: GestureDetector(
                          onTap: onCancelPress,
                          child: Container(
                            height: height(40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: buttonCancelColor ?? AppColors.mainColor,
                              borderRadius: BorderRadius.circular(radius(27)),
                            ),
                           child: Text(
                            buttonCancelText?? "Cancel",
                            style: Styles.bodyMedium.copyWith(
                              color: buttonCancelTextColor ?? AppColors.whiteColor,
                            ),
                          ),
                          ),
                        ),
                      ),
                       Gap(isTitle == true ? 0 : 20),
                      Expanded(
                        child: GestureDetector(
                          onTap: onOkPress,
                            child: Container(
                            height: height(40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: buttonOkColor ?? AppColors.borderColor),
                              borderRadius: BorderRadius.circular(radius(27)),
                            ),
                           child: Text(
                             buttonOkText ?? "Exit",
                            style: Styles.bodyMedium.copyWith(
                              color: buttonOkTextColor ?? AppColors.blackColor,
                            )
                          ),
                          ),
                        ),
                      ),
                    ],
                  ),
              
                ]
              ),
            ),
          ),
        );
      },
    );
  }
}
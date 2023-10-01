import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../res/color.dart';
import '../res/dimensions.dart';
import 'app_text_field.dart';

class AppSearchWidget extends StatelessWidget {
  final String hinText;
  final double? inputTextSize;
  final TextEditingController controller;
  final bool? autofocus;
  final Function(String)? onChanged;
  final Widget child;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onFieldSubmitted;
  final int? maxLen;
  final BorderRadiusGeometry? borderRadius;
  
  const AppSearchWidget(
      {super.key,
      required this.hinText,
      required this.child,
      required this.controller,  
      this.autofocus = false,
      this.inputTextSize, 
      this.onChanged, 
      this.onFieldSubmitted, 
      this.textInputAction, 
      this.keyboardType, 
      this.inputFormatters, this.maxLen, this.borderRadius,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(40),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: width(15)),
      decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(radius(6)),
          border: Border.all(width: .3,color: AppColors.borderColor.withOpacity(.5)),
          color: AppColors.whiteColor),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              textInputAction: textInputAction,
              onFieldSubmitted: onFieldSubmitted,
              maxLen: maxLen ?? 50,
              autofocus: autofocus!,
              onChanged: onChanged,
              hinText: hinText,
              inputTextSize:inputTextSize?? font(16),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

import 'package:bringin/res/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool autofocus;
  final String hinText;

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int maxLen;
  final MaxLengthEnforcement maxLengthEnforcement;
  final EdgeInsetsGeometry? contentPadding;
  final FontWeight? inputTextWeight;
  final double? inputTextSize;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  const AppTextField({
    super.key,
    required this.controller,
    this.autofocus = true,
    required this.hinText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textAlign,
    this.onChanged,
    this.maxLen = 20,
    this.maxLengthEnforcement = MaxLengthEnforcement.enforced,
    this.contentPadding = EdgeInsets.zero,
    this.inputTextWeight = FontWeight.w500, 
    this.inputTextSize, 
    this.validator, this.onFieldSubmitted, this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      autofocus: autofocus,
      onChanged: onChanged,
      validator: validator,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters ?? [
        LengthLimitingTextInputFormatter(maxLen),
      ],
      maxLengthEnforcement: maxLengthEnforcement,
      style: Styles.bodyLarge.copyWith(fontWeight: inputTextWeight,fontSize: inputTextSize?? font(18)),
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      textAlign: textAlign ?? TextAlign.start,
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        contentPadding: contentPadding,
        filled: true,
        fillColor: Colors.transparent,
        hintText: hinText,
        hintStyle: Styles.bodyMedium1.copyWith(color: AppColors.hintColor,fontSize: inputTextSize?? font(16)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class CustomExpandTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? autofocus;
  final String hinText;
  final TextInputType? keyboardType;
  final int? maxLines, maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final Function(String)? onChanged;
  final double? minHeight, maxHeight;

  const CustomExpandTextField({
    super.key,
    required this.controller,
    this.autofocus = true,
    required this.hinText,
    this.keyboardType = TextInputType.multiline,
    this.maxLines = null,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.minHeight,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(
        minHeight: height(minHeight ?? 150),
        maxHeight: height(maxHeight ?? 500),
      ),
      padding: EdgeInsets.only(
        left: width(4),
        right: width(4),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius(6)),
        border: Border.all(color: AppColors.borderColor, width: 0.25),
      ),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        keyboardType: keyboardType,
        autofocus: autofocus!,
        maxLines: maxLines,
        // maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        onChanged: onChanged,
        inputFormatters: [
          // CommaNewLineInputFormatter(),
          LengthLimitingTextInputFormatter(maxLength),
        ],
        toolbarOptions: ToolbarOptions(
          copy: true,
          cut: true,
          paste: true,
        ),
        style: Styles.bodyMedium1,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterStyle: TextStyle(color: Colors.transparent),
          hintText: hinText,
          hintMaxLines: 2,
          hintStyle: Styles.bodyMedium1.copyWith(color: AppColors.hintColor),
        ),
      ),
    );
  }
}

class CommaNewLineInputFormatter extends TextInputFormatter {
  final StringBuffer _newText = StringBuffer();
  final List<int> _separatorCodeUnits = '\n,'.codeUnits;

  bool _useOldValueNext = false;

  int get _newLineCodeUnit => _separatorCodeUnits.first;

  int get _commaCodeUnit => _separatorCodeUnits.last;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_useOldValueNext) {
      _useOldValueNext = false;
      return oldValue;
    }

    final int selectionIdx = newValue.selection.baseOffset - 1;
    final int selectionCodeUnit = newValue.text.codeUnitAt(selectionIdx);

    if (newValue.text.length < oldValue.text.length) {
      int minusSelectionOffset = 0;
      _newText.clear();

      if (selectionCodeUnit == _newLineCodeUnit) {
        _newText.write(newValue.text);
        _useOldValueNext = true;
      } else if (selectionCodeUnit == _commaCodeUnit) {
        _newText.writeAll([
          newValue.text.substring(0, selectionIdx),
          newValue.text.substring(selectionIdx + 1),
        ]);
        minusSelectionOffset = 1;
        _useOldValueNext = true;
      } else {
        return newValue;
      }

      return newValue.copyWith(
        text: _newText.toString(),
        selection: newValue.selection.copyWith(
          baseOffset: newValue.selection.baseOffset - minusSelectionOffset,
          extentOffset: newValue.selection.extentOffset - minusSelectionOffset,
        ),
      );
    } else if (selectionCodeUnit == _newLineCodeUnit ||
        selectionCodeUnit == _commaCodeUnit) {
      final int prevCharCodeUnit = newValue.text.codeUnitAt(selectionIdx - 1);
      final bool isPrevCharSeparator = prevCharCodeUnit == _newLineCodeUnit ||
          prevCharCodeUnit == _commaCodeUnit;
      int addSelectionOffset = 1;

      if (selectionCodeUnit == _newLineCodeUnit &&
          prevCharCodeUnit == _newLineCodeUnit) {
        // Do not move cursor if previous and new character is a new line
        // because the new character won't be added.
        addSelectionOffset = -1;
      } else if (isPrevCharSeparator) {
        // Move cursor by 1 if "," is typed after a "," in the TextField.
        addSelectionOffset = 0;
      }

      _newText.clear();
      _newText.writeAll([
        newValue.text.substring(0, selectionIdx),
        if (!isPrevCharSeparator) ',\n',
        newValue.text.substring(selectionIdx + 1),
      ]);

      return newValue.copyWith(
        text: _newText.toString(),
        selection: newValue.selection.copyWith(
          baseOffset: newValue.selection.baseOffset + addSelectionOffset,
          extentOffset: newValue.selection.extentOffset + addSelectionOffset,
        ),
      );
    }

    return newValue;
  }
}

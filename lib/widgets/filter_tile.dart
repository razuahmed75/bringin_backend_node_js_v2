import 'package:flutter/material.dart';

import '../res/app_font.dart';
import '../res/dimensions.dart';

class FilterTileWidget extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final double? tileWidth, tileHeight;
  final Color? borderColor, bgColor, textColor;
  final EdgeInsetsGeometry? padding;

  const FilterTileWidget({
    super.key, 
    this.onTap, 
    required this.text, 
    this.tileWidth, 
    this.tileHeight, 
    this.borderColor, 
    this.bgColor, 
    this.textColor, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
              onTap: onTap,
              child: Ink(
                padding: padding,
                width: width(tileWidth ?? 140),
                height: height(tileHeight ?? 40),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(radius(25)),
                  border: Border.all(
                    color: borderColor!,
                    width: .5
                  ),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: Styles.bodySmall1.copyWith(color: textColor,fontSize: font(15)),
                  ),
                ),
              ),
            );
  }
}
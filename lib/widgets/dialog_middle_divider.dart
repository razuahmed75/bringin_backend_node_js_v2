import 'package:flutter/material.dart';
import '../res/color.dart';
import '../res/dimensions.dart';

class DialogMiddleDivider extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final double magnificationScale;
  const DialogMiddleDivider({
    super.key, 
    this.margin, 
    this.magnificationScale=1.1
 });
  @override
  Widget build(BuildContext context) {
    return Container(
              margin: margin?? EdgeInsets.only(bottom: height(30)),
              child: RawMagnifier(
                 size: Size(double.maxFinite, height(35)),
                 magnificationScale: magnificationScale,
                 decoration: MagnifierDecoration(                       
                 shape: OutlineInputBorder(
                 borderSide:BorderSide(
                    width: 0.35,
                    color: AppColors.hintColor,
            ),
          ),
        ),
      ),
    );
  }
}

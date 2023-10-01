// import 'package:flutter/material.dart';
// import '../res/dimensions.dart';

// class SmallText extends StatelessWidget {
//   final String text;
//   final double? size;
//   final FontWeight? fontWeight;
//   final Color? textColor;
//   final TextDecoration? decoration;
//   final FontStyle? fontStyle;
//   final TextAlign? textAlign;
//   final int? maxLines;
//   final TextOverflow? overflow;

//   const SmallText({
//     super.key,
//     required this.text,
//     this.size,
//     this.fontWeight = FontWeight.w400,
//     this.textColor = const Color(0xFF000000),
//     this.decoration,
//     this.fontStyle = FontStyle.normal,
//     this.textAlign = TextAlign.left,
//     this.maxLines = null,
//     this.overflow = TextOverflow.visible,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       textAlign: textAlign,
//       maxLines: maxLines,
//       overflow: overflow,
//       style: TextStyle(
//         fontFamily: "Roboto",
//         fontStyle: fontStyle,
//         decoration: decoration,
//         color: textColor,
//         fontSize: size ?? font(14),
//         fontWeight: fontWeight,
//       ),
//     );
//   }
// }

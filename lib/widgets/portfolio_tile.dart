import 'package:flutter/material.dart';

import '../res/app_font.dart';
import '../res/dimensions.dart';

class PortfolioTile extends StatelessWidget {
  final String text;
  const PortfolioTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: height(10)),
      width: double.maxFinite,
      padding: EdgeInsets.only(left: width(15)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text,
              style: Styles.bodySmall1.copyWith(fontSize: font(15))),
        ],
      ),
    );
  }
}

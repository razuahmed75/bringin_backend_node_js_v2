import 'package:flutter/material.dart';
import '../res/app_font.dart';

class ExpandableText extends StatefulWidget {
  final String? text;
  final int? textWidth;
  final TextStyle? style;

  ExpandableText({
    super.key,
    this.text = "",
    this.textWidth = 10,
    this.style,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;

  @override
  void initState() {
    if (widget.text!.length > widget.textWidth!) {
      firstHalf = widget.text!.substring(0, widget.textWidth);
    } else {
      firstHalf = widget.text!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.text!.length <= widget.textWidth!
          ? Text(firstHalf, style: widget.style ?? Styles.bodyMedium1)
          : Text(firstHalf + "...", style: widget.style ?? Styles.bodyMedium1),
      // child: Text(
      //   widget.text,
      //   style: widget.style ?? Styles.bodyMedium1,
      //   overflow: TextOverflow.ellipsis,
      //   maxLines: 1,
      // ),
    );
  }
}

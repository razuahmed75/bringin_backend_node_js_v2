import 'package:bringin/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../res/app_font.dart';
import '../res/color.dart';
import '../res/constants/image_path.dart';
import '../res/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar appBarWidget({
  required String title,
  void Function()? onBackPressed,
  void Function()? onSavedPressed,
  List<Widget>? actions,
  double? titleSize,
  bool? isArrow = true,
  Widget? leading,
  Color? bgColor = AppColors.whiteColor,
}) {
  return AppBar(
    toolbarHeight: height(48),
    leading: isArrow == true
        ? IconButton(
            padding: EdgeInsets.only(left: width(8)),
            onPressed: onBackPressed,
            icon: SvgPicture.asset(
              AppImagePaths.arrowBackIcon,
              width: width(16),
              height: width(16),
            ),
          )
        : leading,
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: Styles.smallTitle.copyWith(fontSize: titleSize ?? font(22)),
    ),
    centerTitle: true,
    backgroundColor: bgColor,
    elevation: 0,
    actions: actions ??
        [
          Stack(
            alignment: Alignment.center,
            children: [
              SaveButton(onSavePressed: onSavedPressed),
            ],
          ),
          const Gap(15),
        ],
  );
}

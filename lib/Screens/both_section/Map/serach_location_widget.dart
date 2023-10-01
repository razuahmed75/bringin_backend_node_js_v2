// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'location_search_dialog.dart';

class SearchLocationWidget extends StatelessWidget {
  final String pickedAddress;
  final bool isEnabled;
  final bool? isPickedUp;
  final String? hint;
  const SearchLocationWidget(
      {required this.pickedAddress,
      required this.isEnabled,
      this.isPickedUp,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.dialog(LocationSearchDialog(isPickedUp: isPickedUp));
        if (isEnabled != null) {
          // Get.find<ParcelController>().setIsPickedUp(isPickedUp, true);
        }
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          border: isEnabled != null
              ? Border.all(
                  color: isEnabled
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
                  width: isEnabled ? 2 : 1,
                )
              : null,
        ),
        child: Row(children: [
          Icon(
            Icons.location_on,
            size: 25,
            color: (isEnabled == null || isEnabled)
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
          ),
          SizedBox(width: 10),
          Expanded(
            child: (pickedAddress != null && pickedAddress.isNotEmpty)
                ? Text(
                    pickedAddress,
                    // style: robotoRegular.copyWith(), maxLines: 1, overflow: TextOverflow.ellipsis,
                  )
                : Text(
                    hint ?? '',
                    // style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
          ),
          SizedBox(width: 10),
          Icon(Icons.search,
              size: 25, color: Theme.of(context).textTheme.bodyText1!.color),
        ]),
      ),
    );
  }
}

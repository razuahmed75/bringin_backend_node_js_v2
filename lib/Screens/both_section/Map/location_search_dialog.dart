import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/recruiter_section/map_controll.dart';


class LocationSearchDialog extends StatelessWidget {
  final bool? isPickedUp;
  LocationSearchDialog({this.isPickedUp});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return GetBuilder<MapControll>(builder: (mapcontroll) {
      return Container(
        height: 50,
        margin: EdgeInsets.only(top: 50),
        padding: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
              width: 400,
              height: 50,
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  // textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    hintText: 'search_location'.tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(style: BorderStyle.none, width: 0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(fontSize: 14),
                    fillColor: Theme.of(context).cardColor,
                  ),
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 15),
                ),
                suggestionsCallback: (pattern) async {
                  return await mapcontroll.fetchSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      Icon(Icons.location_on),
                      Expanded(
                        child: Text(suggestion.description!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    fontSize: 15)),
                      ),
                    ]),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  // if (isPickedUp == null) {
                  //   Get.find<LocationController>().setLocation(suggestion.placeId,
                  //       suggestion.description, mapController);
                  // } else {
                  //   Get.find<ParcelController>().setLocationFromPlace(
                  //       suggestion.placeId, suggestion.description, isPickedUp);
                  // }
                  Get.back();
                },
              )),
        ),
      );
    });
  }
}

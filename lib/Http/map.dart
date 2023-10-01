import 'dart:convert';
import 'package:place_picker/place_picker.dart';
import 'package:http/http.dart' as http;

import '../Screens/both_section/Map/pick_map_screen.dart';

class HttpMap {
  Future reverseGeocodeLatLng(LatLng latLng) async {
    print(latLng);
    try {
      final url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?"
          "latlng=${latLng.latitude},${latLng.longitude}&"
          "language=en&"
          "key=${kGoogleApiKey}");

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['results'] == null) {
        throw Error();
      }

      final result = responseJson['results'][0];

      if (result['address_components'] is List<dynamic> &&
          result['address_components'].length != null &&
          result['address_components'].length > 0) {
        var data = result['address_components']
            .where((e) => e['types'].contains("political") == true)
            .toList();

        // for (var i = 0; i < result['address_components'].length; i++) {
        //   var tmp = result['address_components'][i];
        //   var types = tmp["types"] as List<dynamic>;
        //   var shortName = tmp['short_name'];
        //   if (types == null) {
        //     continue;
        //   }
        //   if (i == 0) {
        //     // [street_number]
        //     // name = shortName;
        //     isOnStreet = types.contains('political');
        //     // other index 0 types
        //     // [establishment, point_of_interest, subway_station, transit_station]
        //     // [premise]
        //     // [route]
        //   } else if (i == 1 && isOnStreet) {
        //     if (types.contains('political')) {
        //       // name += ", $shortName";
        //       name = tmp['short_name'];
        //     }
        //   } else {
        //     if (types.contains("sublocality_level_1")) {
        //       subLocalityLevel1 = shortName;
        //     } else if (types.contains("sublocality_level_2")) {
        //       subLocalityLevel2 = shortName;
        //     } else if (types.contains("locality")) {
        //       locality = shortName;
        //     } else if (types.contains("administrative_area_level_2")) {
        //       administrativeAreaLevel2 = shortName;
        //     } else if (types.contains("administrative_area_level_1")) {
        //       administrativeAreaLevel1 = shortName;
        //     } else if (types.contains("country")) {
        //       country = shortName;
        //     } else if (types.contains('postal_code')) {
        //       postalCode = shortName;
        //     }
        //   }
        // }

        return data[0]['long_name'];
      }
    } catch (e) {
      print(e);
    }
  }
}

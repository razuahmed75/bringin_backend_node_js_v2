import 'dart:convert';
import 'package:get/state_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../../models/recruiter_section/Map/placesearch.dart';

class MapControll extends GetxController {
  Position? position;

  Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition();

    update();
  }

  Future<List<PredictionModel>> fetchSuggestions(String input) async {
    String url =
        "https://fixmygari.in/admin/api/v1/config/place-api-autocomplete?search_text=$input";

    var request = await http.get(Uri.parse(url));
    print(request.statusCode);
    if (request.statusCode == 200) {
      _predictionList = [];
      jsonDecode(request.body)['predictions'].forEach((prediction) =>
          _predictionList.add(PredictionModel.fromJson(prediction)));

      return _predictionList;
    } else {
      return [];
    }
  }

  List<PredictionModel> _predictionList = [];

  // Future<List<PredictionModel>> searchLocation(
  //     BuildContext context, String text) async {
  //   if (text != null && text.isNotEmpty) {
  //     Response response = await fetchSuggestions(text);
  //     if (response.statusCode == 200 && response.body['status'] == 'OK') {
  //       _predictionList = [];
  //       response.body['predictions'].forEach((prediction) =>
  //           _predictionList.add(PredictionModel.fromJson(prediction)));
  //     } else {}
  //   }
  //   return _predictionList;
  // }
}

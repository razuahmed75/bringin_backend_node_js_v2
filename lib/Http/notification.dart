import 'dart:convert';

import 'package:bringin/Http/get.dart';
import 'package:http/http.dart' as http;

class HttpNtf {
  Future notificationsend(
      {required String push,
      required Map<String, dynamic> data,
      required String message,
      required String playerid}) async {
     Httphelp.post(ENDPOINT_URL: "/single_notification_send", fields: {
      "message": message,
      "title": push,
      "playerid": playerid,
      "data": data
    });
  }
}

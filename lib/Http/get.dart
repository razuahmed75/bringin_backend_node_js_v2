import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Hive/hive.dart';
import '../res/constants/app_constants.dart';
import '../utils/services/keys.dart';
import "dart:math" as math;

class Httphelp {
  static String BASE_URL = AppConstants.baseUrl;

  //=======================Return type response=======================
  static Future<http.Response> get({required String ENDPOINT_URL}) async {
    var headers = {
      'Authorization': 'Bearer ${HiveHelp.read(Keys.authToken)}',
      'Accept': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(BASE_URL + ENDPOINT_URL));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);
    return responsedata;
  }

  static Future<http.Response> post(
      {required String ENDPOINT_URL,
      Map<String, dynamic>? fields,
      String? type = 'POST'}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${HiveHelp.read(Keys.authToken)}',
    };
    var request = http.Request('$type', Uri.parse(BASE_URL + ENDPOINT_URL));
    request.body = json.encode(fields);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);
    print(responsedata);
    return responsedata;
  }

  static Future<http.Response> uploadFile(
      {required String ENDPOINT_URL,
      String? imgpath,
      String? fieldName = "image"}) async {
    var headers = {
      'Authorization': 'Bearer ${HiveHelp.read(Keys.authToken)}',
      'Accept': 'application/json'
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(BASE_URL + ENDPOINT_URL));
    request.files
        .add(await http.MultipartFile.fromPath('$fieldName', imgpath!));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    return responsedata;
  }

  static Future<http.Response> uploadAssetImg(
      {required String ENDPOINT_URL, bytes}) async {
    var headers = {
      'Authorization': 'Bearer ${HiveHelp.read(Keys.authToken)}',
      'Accept': 'application/json'
    };
    var ren = math.Random();

    var request =
        http.MultipartRequest('POST', Uri.parse(BASE_URL + ENDPOINT_URL));
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: 'image${ren.nextInt(999999)}.jpg',
      ),
    );

    // request.files.add(await http.MultipartFile.fromPath('$fieldName', imgpath!));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    return responsedata;
  }

  static Future<http.Response> delete({required String ENDPOINT_URL}) async {
    var headers = {'Authorization': 'Bearer ${HiveHelp.read(Keys.authToken)}'};
    var request = http.Request('DELETE', Uri.parse(BASE_URL + ENDPOINT_URL));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    return responsedata;
  }

  Future<http.Response> recruiter_verify_doc_upload(
      {required String ENDPOINT_URL,
      required String? type,
      String? path}) async {
    var headers = {
      'Authorization': 'Bearer ${HiveHelp.read(Keys.authToken)}',
      'Accept': 'application/json'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(BASE_URL + ENDPOINT_URL));
    request.fields.addAll({'type': type!});
    request.files.add(await http.MultipartFile.fromPath('image', path!));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    return responsedata;
  }

  static Future<http.Response> report(
      {required String ENDPOINT_URL,
      String? path,
      Map<String, String>? fields}) async {
    var headers = {
      'Authorization': 'Bearer ${HiveHelp.read(Keys.authToken)}',
      'Accept': 'application/json'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(BASE_URL + ENDPOINT_URL));
    request.fields.addAll(fields!);
    if(path != null){
      request.files.add(await http.MultipartFile.fromPath('image', path));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    return responsedata;
  }

  static Future<http.Response> report2(
      {required String ENDPOINT_URL,
      String? path,
      Map<String, String>? fields,
      List<String>? report,
      String? key}) async {
    var headers = {
      'Authorization': 'Bearer ${HiveHelp.read(Keys.authToken)}',
      'Accept': 'application/json'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(BASE_URL + ENDPOINT_URL));
    request.fields.addAll(fields!);
    if (path != null)
      request.files.add(await http.MultipartFile.fromPath('image', path));
    request.headers.addAll(headers);
    for (var i = 0; i < report!.length; i++) {
      Map<String, String> body = {
        "${key}[$i]": report[i].toString(),
      };
      request.fields.addAll(body);
    }

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    return responsedata;
  }
}

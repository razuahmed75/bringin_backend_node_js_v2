// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
    String? message;
    String? token;
    bool? seekerprofile;
    int? carearpre;

    OtpModel({
        this.message,
        this.token,
        this.seekerprofile,
        this.carearpre,
    });

    factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        message: json["message"],
        token: json["token"],
        seekerprofile: json["seekerprofile"],
        carearpre: json["carearpre"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "seekerprofile": seekerprofile,
        "carearpre": carearpre,
    };
}

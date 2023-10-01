// To parse this JSON data, do
//
//     final jobTitleArea = jobTitleAreaFromJson(jsonString);

import 'dart:convert';

List<JobTitleArea> jobTitleAreaFromJson(String str) => List<JobTitleArea>.from(json.decode(str).map((x) => JobTitleArea.fromJson(x)));

String jobTitleAreaToJson(List<JobTitleArea> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobTitleArea {
    String? id;
    Industryid? industryid;
    Categoryid? categoryid;
    String? functionalname;
    int? v;
    DateTime? updatedAt;

    JobTitleArea({
        this.id,
        this.industryid,
        this.categoryid,
        this.functionalname,
        this.v,
        this.updatedAt,
    });

    factory JobTitleArea.fromJson(Map<String, dynamic> json) => JobTitleArea(
        id: json["_id"],
        industryid: json["industryid"] == null ? null : Industryid.fromJson(json["industryid"]),
        categoryid: json["categoryid"] == null ? null : Categoryid.fromJson(json["categoryid"]),
        functionalname: json["functionalname"],
        v: json["__v"],
        updatedAt: json["updatedAt"] == null ? null :  DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryid": industryid!.toJson(),
        "categoryid": categoryid!.toJson(),
        "functionalname": functionalname,
        "__v": v,
        "updatedAt": updatedAt!.toIso8601String(),
    };
}

class Categoryid {
    String? id;
    String? industryid;
    String? categoryname;
    int? v;
    DateTime? updatedAt;

    Categoryid({
        this.id,
        this.industryid,
        this.categoryname,
        this.v,
        this.updatedAt,
    });

    factory Categoryid.fromJson(Map<String, dynamic> json) => Categoryid(
        id: json["_id"],
        industryid: json["industryid"],
        categoryname: json["categoryname"],
        v: json["__v"],
        updatedAt: json["updatedAt"] == null ? null :  DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryid": industryid,
        "categoryname": categoryname,
        "__v": v,
        "updatedAt": updatedAt!.toIso8601String(),
    };
}

class Industryid {
    String? id;
    String? industryname;
    int? v;
    DateTime? updatedAt;

    Industryid({
        this.id,
        this.industryname,
        this.v,
        this.updatedAt,
    });

    factory Industryid.fromJson(Map<String, dynamic> json) => Industryid(
        id: json["_id"],
        industryname: json["industryname"],
        v: json["__v"],
        updatedAt: json["updatedAt"] == null ? null :  DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryname": industryname,
        "__v": v,
        "updatedAt": updatedAt!.toIso8601String(),
    };
}

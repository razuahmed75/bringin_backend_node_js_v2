

import 'dart:convert';

List<AllLocationModel> allLocationModelFromJson(String str) => List<AllLocationModel>.from(json.decode(str).map((x) => AllLocationModel.fromJson(x)));

String allLocationModelToJson(List<AllLocationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class AllLocationModel {
    String? id;
    String? name;
    List<Divisionid>? divisionid;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    AllLocationModel({
        this.id,
        this.name,
        this.divisionid,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory AllLocationModel.fromJson(Map<String, dynamic> json) => AllLocationModel(
        id: json["_id"],
        name: json["name"],
        divisionid: json["divisionid"] == null ? [] : List<Divisionid>.from(json["divisionid"].map((x) => Divisionid.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "divisionid": List<dynamic>.from(divisionid!.map((x) => x.toJson())),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}
class Divisionid {
    String? id;
    String? divisionname;
    AllLocationModel? cityid;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Divisionid({
        this.id,
        this.divisionname,
        this.cityid,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Divisionid.fromJson(Map<String, dynamic> json) => Divisionid(
        id: json["_id"],
        divisionname: json["divisionname"],
        cityid: json["cityid"] == null ? null : AllLocationModel.fromJson(json["cityid"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "divisionname": divisionname,
        "cityid": cityid!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}



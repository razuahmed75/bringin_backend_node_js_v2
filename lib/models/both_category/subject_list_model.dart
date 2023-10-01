// To parse this JSON data, do
//
//     final subjectListModel = subjectListModelFromJson(jsonString);

import 'dart:convert';

List<SubjectListModel> subjectListModelFromJson(String str) => List<SubjectListModel>.from(json.decode(str).map((x) => SubjectListModel.fromJson(x)));

String subjectListModelToJson(List<SubjectListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectListModel {
    String? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    SubjectListModel({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory SubjectListModel.fromJson(Map<String, dynamic> json) => SubjectListModel(
        id: json["_id"],
        name: json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

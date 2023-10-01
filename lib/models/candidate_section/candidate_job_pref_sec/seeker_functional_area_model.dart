// To parse this JSON data, do
//
//     final seekerFunctionalAreaModel = seekerFunctionalAreaModelFromJson(jsonString);

import 'dart:convert';

List<SeekerFunctionalAreaModel> seekerFunctionalAreaModelFromJson(String str) => List<SeekerFunctionalAreaModel>.from(json.decode(str).map((x) => SeekerFunctionalAreaModel.fromJson(x)));

String seekerFunctionalAreaModelToJson(List<SeekerFunctionalAreaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeekerFunctionalAreaModel {
    String? id;
    Functionalarea? functionalarea;

    SeekerFunctionalAreaModel({
        this.id,
        this.functionalarea,
    });

    factory SeekerFunctionalAreaModel.fromJson(Map<String, dynamic> json) => SeekerFunctionalAreaModel(
        id: json["_id"],
        functionalarea: json["functionalarea"] == null ? null : Functionalarea.fromJson(json["functionalarea"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "functionalarea": functionalarea?.toJson(),
    };
}

class Functionalarea {
    String? id;
    String? industryid;
    String? categoryid;
    String? functionalname;
    int? v;

    Functionalarea({
        this.id,
        this.industryid,
        this.categoryid,
        this.functionalname,
        this.v,
    });

    factory Functionalarea.fromJson(Map<String, dynamic> json) => Functionalarea(
        id: json["_id"],
        industryid: json["industryid"],
        categoryid: json["categoryid"],
        functionalname: json["functionalname"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryid": industryid,
        "categoryid": categoryid,
        "functionalname": functionalname,
        "__v": v,
    };
}

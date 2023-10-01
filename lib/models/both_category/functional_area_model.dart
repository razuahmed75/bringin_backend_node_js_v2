

import 'dart:convert';

List<FunctionalAreaModel> functionalAreaModelFromJson(String str) => List<FunctionalAreaModel>.from(json.decode(str).map((x) => FunctionalAreaModel.fromJson(x)));

String functionalAreaModelToJson(List<FunctionalAreaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FunctionalAreaModel {
    String? id;
    String? industryname;
    int? v;
    List<FunctionalCategory>? category;

    FunctionalAreaModel({
        this.id,
        this.industryname,
        this.v,
        this.category,
    });

    factory FunctionalAreaModel.fromJson(Map<String, dynamic> json) => FunctionalAreaModel(
        id: json["_id"],
        industryname: json["industryname"],
        v: json["__v"],
        category: List<FunctionalCategory>.from(json["category"].map((x) => FunctionalCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryname": industryname,
        "__v": v,
        "category": List<dynamic>.from(category!.map((x) => x.toJson())),
    };
}

class FunctionalCategory {
    String? id;
    String? industryid;
    String? categoryname;
    int? v;
    List<Functionarea>? functionarea;

    FunctionalCategory({
        this.id,
        this.industryid,
        this.categoryname,
        this.v,
        this.functionarea,
    });

    factory FunctionalCategory.fromJson(Map<String, dynamic> json) => FunctionalCategory(
        id: json["_id"],
        industryid: json["industryid"],
        categoryname: json["categoryname"],
        v: json["__v"],
        functionarea: List<Functionarea>.from(json["functionarea"].map((x) => Functionarea.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryid": industryid,
        "categoryname": categoryname,
        "__v": v,
        "functionarea": List<dynamic>.from(functionarea!.map((x) => x.toJson())),
    };
}

class Functionarea {
    String? id;
    String? industryid;
    String? categoryid;
    String? functionalname;
    int? v;

    Functionarea({
        this.id,
        this.industryid,
        this.categoryid,
        this.functionalname,
        this.v,
    });

    factory Functionarea.fromJson(Map<String, dynamic> json) => Functionarea(
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



import 'dart:convert';

List<ExpectedSalaryModel> expectedSalaryModelFromJson(String str) => List<ExpectedSalaryModel>.from(json.decode(str).map((x) => ExpectedSalaryModel.fromJson(x)));

String expectedSalaryModelToJson(List<ExpectedSalaryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpectedSalaryModel {
    String? id;
    dynamic salary;
    int? type;
    String? simbol;
    String? currency;
    List<OtherSalary>? otherSalary;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    ExpectedSalaryModel({
        this.id,
        this.salary,
        this.type,
        this.simbol,
        this.currency,
        this.otherSalary,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory ExpectedSalaryModel.fromJson(Map<String, dynamic> json) => ExpectedSalaryModel(
        id: json["_id"],
        salary: json["salary"],
        type: json["type"],
        simbol: json["simbol"],
        currency: json["currency"],
        otherSalary: json["other_salary"] == null ? null : List<OtherSalary>.from(json["other_salary"].map((x) => OtherSalary.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "salary": salary,
        "type": type,
        "simbol": simbol,
        "currency": currency,
        "other_salary": List<dynamic>.from(otherSalary!.map((x) => x.toJson())),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

class OtherSalary {
    String? id;
    dynamic salary;
    int? type;
    String? simbol;
    String? currency;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    OtherSalary({
        this.id,
        this.salary,
        this.type,
        this.simbol,
        this.currency,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory OtherSalary.fromJson(Map<String, dynamic> json) => OtherSalary(
        id: json["_id"],
        salary: json["salary"],
        type: json["type"],
        simbol: json["simbol"],
        currency: json["currency"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "salary": salary,
        "type": type,
        "simbol": simbol,
        "currency": currency,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}



import 'dart:convert';

List<PackageListModel> packageListModelFromJson(String str) => List<PackageListModel>.from(json.decode(str).map((x) => PackageListModel.fromJson(x)));

String packageListModelToJson(List<PackageListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PackageListModel {
    String? id;
    String? name;
    String? suggestname;
    int? chat;
    int? amount;
    String? currency;
    int? durationTime;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    PackageListModel({
        this.id,
        this.name,
        this.suggestname,
        this.chat,
        this.amount,
        this.currency,
        this.durationTime,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory PackageListModel.fromJson(Map<String, dynamic> json) => PackageListModel(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        suggestname: json["suggestname"] ?? "",
        chat: json["chat"] ?? "",
        amount: json["amount"] ?? "",
        currency: json["currency"] ?? "",
        durationTime: json["duration_time"] ?? "",
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "suggestname": suggestname,
        "chat": chat,
        "amount": amount,
        "currency": currency,
        "duration_time": durationTime,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

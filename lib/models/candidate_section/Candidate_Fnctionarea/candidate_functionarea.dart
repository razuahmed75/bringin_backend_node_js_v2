// To parse this JSON data, do
//
//     final candidatefunctionalarea = candidatefunctionalareaFromJson(jsonString);

import 'dart:convert';

List<Candidatefunctionalarea> candidatefunctionalareaFromJson(String str) => List<Candidatefunctionalarea>.from(json.decode(str).map((x) => Candidatefunctionalarea.fromJson(x)));

String candidatefunctionalareaToJson(List<Candidatefunctionalarea> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Candidatefunctionalarea {
    String? id;
    ExperticeArea? experticeArea;

    Candidatefunctionalarea({
        this.id,
        this.experticeArea,
    });

    factory Candidatefunctionalarea.fromJson(Map<String, dynamic> json) => Candidatefunctionalarea(
        id: json["_id"],
        experticeArea: json["expertice_area"] == null ? null : ExperticeArea.fromJson(json["expertice_area"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "expertice_area": experticeArea?.toJson(),
    };
}

class ExperticeArea {
    String? id;
    String? functionalname;

    ExperticeArea({
        this.id,
        this.functionalname,
    });

    factory ExperticeArea.fromJson(Map<String, dynamic> json) => ExperticeArea(
        id: json["_id"],
        functionalname: json["functionalname"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "functionalname": functionalname,
    };
}

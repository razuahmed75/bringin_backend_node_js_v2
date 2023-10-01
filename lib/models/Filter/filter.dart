// To parse this JSON data, do
//
//     final jobFilter = jobFilterFromJson(jsonString);

import 'dart:convert';

JobFilter jobFilterFromJson(String str) => JobFilter.fromJson(json.decode(str));

String jobFilterToJson(JobFilter data) => json.encode(data.toJson());

class JobFilter {
    List<bool>? allworkplace;
    List<Workplace>? workplace;
    List<String>? alleducation;
    List<Education>? education;
    List<Allsalary>? allsalary;
    List<SalaryElement>? salary;
    List<String>? allexperience;
    List<Companysize>? experience;
    List<String>? allindustry;
    List<Industry>? industry;
    List<String>? allcompanysize;
    List<Companysize>? companysize;

    JobFilter({
        this.allworkplace,
        this.workplace,
        this.alleducation,
        this.education,
        this.allsalary,
        this.salary,
        this.allexperience,
        this.experience,
        this.allindustry,
        this.industry,
        this.allcompanysize,
        this.companysize,
    });

    factory JobFilter.fromJson(Map<String, dynamic> json) => JobFilter(
        allworkplace: json["allworkplace"] == null ? [] : List<bool>.from(json["allworkplace"]!.map((x) => x)),
        workplace: json["workplace"] == null ? [] : List<Workplace>.from(json["workplace"]!.map((x) => Workplace.fromJson(x))),
        alleducation: json["alleducation"] == null ? [] : List<String>.from(json["alleducation"]!.map((x) => x)),
        education: json["education"] == null ? [] : List<Education>.from(json["education"]!.map((x) => Education.fromJson(x))),
        allsalary: json["allsalary"] == null ? [] : List<Allsalary>.from(json["allsalary"]!.map((x) => Allsalary.fromJson(x))),
        salary: json["salary"] == null ? [] : List<SalaryElement>.from(json["salary"]!.map((x) => SalaryElement.fromJson(x))),
        allexperience: json["allexperience"] == null ? [] : List<String>.from(json["allexperience"]!.map((x) => x)),
        experience: json["experience"] == null ? [] : List<Companysize>.from(json["experience"]!.map((x) => Companysize.fromJson(x))),
        allindustry: json["allindustry"] == null ? [] : List<String>.from(json["allindustry"]!.map((x) => x)),
        industry: json["industry"] == null ? [] : List<Industry>.from(json["industry"]!.map((x) => Industry.fromJson(x))),
        allcompanysize: json["allcompanysize"] == null ? [] : List<String>.from(json["allcompanysize"]!.map((x) => x)),
        companysize: json["companysize"] == null ? [] : List<Companysize>.from(json["companysize"]!.map((x) => Companysize.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "allworkplace": allworkplace == null ? [] : List<dynamic>.from(allworkplace!.map((x) => x)),
        "workplace": workplace == null ? [] : List<dynamic>.from(workplace!.map((x) => x.toJson())),
        "alleducation": alleducation == null ? [] : List<dynamic>.from(alleducation!.map((x) => x)),
        "education": education == null ? [] : List<dynamic>.from(education!.map((x) => x.toJson())),
        "allsalary": allsalary == null ? [] : List<dynamic>.from(allsalary!.map((x) => x.toJson())),
        "salary": salary == null ? [] : List<dynamic>.from(salary!.map((x) => x.toJson())),
        "allexperience": allexperience == null ? [] : List<dynamic>.from(allexperience!.map((x) => x)),
        "experience": experience == null ? [] : List<dynamic>.from(experience!.map((x) => x.toJson())),
        "allindustry": allindustry == null ? [] : List<dynamic>.from(allindustry!.map((x) => x)),
        "industry": industry == null ? [] : List<dynamic>.from(industry!.map((x) => x.toJson())),
        "allcompanysize": allcompanysize == null ? [] : List<dynamic>.from(allcompanysize!.map((x) => x)),
        "companysize": companysize == null ? [] : List<dynamic>.from(companysize!.map((x) => x.toJson())),
    };
}

class Allsalary {
    String? minSalary;
    String? maxSalary;

    Allsalary({
        this.minSalary,
        this.maxSalary,
    });

    factory Allsalary.fromJson(Map<String, dynamic> json) => Allsalary(
        minSalary: json["min_salary"],
        maxSalary: json["max_salary"],
    );

    Map<String, dynamic> toJson() => {
        "min_salary": minSalary,
        "max_salary": maxSalary,
    };
}

class Companysize {
    String? id;
    String? size;
    int? v;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? name;

    Companysize({
        this.id,
        this.size,
        this.v,
        this.createdAt,
        this.updatedAt,
        this.name,
    });

    factory Companysize.fromJson(Map<String, dynamic> json) => Companysize(
        id: json["_id"],
        size: json["size"],
        v: json["__v"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "size": size,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "name": name,
    };
}

class Education {
    String? id;
    String? name;

    Education({
        this.id,
        this.name,
    });

    factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}

class Industry {
    String? id;
    String? industryid;
    String? categoryname;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Industry({
        this.id,
        this.industryid,
        this.categoryname,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        id: json["_id"],
        industryid: json["industryid"],
        categoryname: json["categoryname"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryid": industryid,
        "categoryname": categoryname,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}


class SalaryElement {
    String? id;
    dynamic salary;
    int? type;
    String? simbol;
    String? currency;
    List<SalaryElement>? otherSalary;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    SalaryElement({
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

    factory SalaryElement.fromJson(Map<String, dynamic> json) => SalaryElement(
        id: json["_id"],
        salary: json["salary"],
        type: json["type"],
        simbol: json["simbol"],
        currency: json["currency"],
        otherSalary: json["other_salary"] == null ? [] : List<SalaryElement>.from(json["other_salary"]!.map((x) => SalaryElement.fromJson(x))),
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
        "other_salary": otherSalary == null ? [] : List<dynamic>.from(otherSalary!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Workplace {
    String? name;
    bool? value;

    Workplace({
        this.name,
        this.value,
    });

    factory Workplace.fromJson(Map<String, dynamic> json) => Workplace(
        name: json["name"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
    };
}

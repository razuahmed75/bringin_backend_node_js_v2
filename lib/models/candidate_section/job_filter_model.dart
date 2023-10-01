// To parse this JSON data, do
//
//     final jobFilterModel = jobFilterModelFromJson(jsonString);

import 'dart:convert';

JobFilterModel jobFilterModelFromJson(String str) => JobFilterModel.fromJson(json.decode(str));

String jobFilterModelToJson(JobFilterModel data) => json.encode(data.toJson());

class JobFilterModel {
    List<bool>? allworkplace;
    List<Workplace>? workplace;
    List<String>? alleducation;
    List<Education>? education;
    List<String>? allsalary;
    List<Salary>? salary;
    List<String>? allexperience;
    List<Experience>? experience;
    List<String>? allindustry;
    List<Industry>? industry;
    List<String>? allcompanysize;
    List<Companysize>? companysize;

    JobFilterModel({
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

    factory JobFilterModel.fromJson(Map<String, dynamic> json) => JobFilterModel(
        allworkplace: List<bool>.from(json["allworkplace"].map((x) => x)),
        workplace: List<Workplace>.from(json["workplace"].map((x) => Workplace.fromJson(x))),
        alleducation: List<String>.from(json["alleducation"].map((x) => x)),
        education: List<Education>.from(json["education"].map((x) => Education.fromJson(x))),
        allsalary: List<String>.from(json["allsalary"].map((x) => x)),
        salary: List<Salary>.from(json["salary"].map((x) => Salary.fromJson(x))),
        allexperience: List<String>.from(json["allexperience"].map((x) => x)),
        experience: List<Experience>.from(json["experience"].map((x) => Experience.fromJson(x))),
        allindustry: List<String>.from(json["allindustry"].map((x) => x)),
        industry: List<Industry>.from(json["industry"].map((x) => Industry.fromJson(x))),
        allcompanysize: List<String>.from(json["allcompanysize"].map((x) => x)),
        companysize: List<Companysize>.from(json["companysize"].map((x) => Companysize.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "allworkplace": List<dynamic>.from(allworkplace!.map((x) => x)),
        "workplace": List<dynamic>.from(workplace!.map((x) => x.toJson())),
        "alleducation": List<dynamic>.from(alleducation!.map((x) => x)),
        "education": List<dynamic>.from(education!.map((x) => x.toJson())),
        "allsalary": List<dynamic>.from(allsalary!.map((x) => x)),
        "salary": List<dynamic>.from(salary!.map((x) => x.toJson())),
        "allexperience": List<dynamic>.from(allexperience!.map((x) => x)),
        "experience": List<dynamic>.from(experience!.map((x) => x.toJson())),
        "allindustry": List<dynamic>.from(allindustry!.map((x) => x)),
        "industry": List<dynamic>.from(industry!.map((x) => x.toJson())),
        "allcompanysize": List<dynamic>.from(allcompanysize!.map((x) => x)),
        "companysize": List<dynamic>.from(companysize!.map((x) => x.toJson())),
    };
}

class Companysize {
    String? id;
    String? size;
    int? v;

    Companysize({
        this.id,
        this.size,
        this.v,
    });

    factory Companysize.fromJson(Map<String, dynamic> json) => Companysize(
        id: json["_id"],
        size: json["size"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "size": size,
        "__v": v,
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

class Experience {
    String? id;
    String? name;
    int? v;

    Experience({
        this.id,
        this.name,
        this.v,
    });

    factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["_id"],
        name: json["name"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
    };
}

class Industry {
    String? id;
    String? industryname;

    Industry({
        this.id,
        this.industryname,
    });

    factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        id: json["_id"],
        industryname: json["industryname"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryname": industryname,
    };
}

class Salary {
    String? id;
    String? minSalary;
    String? maxSalary;
    String? currency;
    int? v;

    Salary({
        this.id,
        this.minSalary,
        this.maxSalary,
        this.currency,
        this.v,
    });

    factory Salary.fromJson(Map<String, dynamic> json) => Salary(
        id: json["_id"],
        minSalary: json["min_salary"],
        maxSalary: json["max_salary"],
        currency: json["currency"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "min_salary": minSalary,
        "max_salary": maxSalary,
        "currency": currency,
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

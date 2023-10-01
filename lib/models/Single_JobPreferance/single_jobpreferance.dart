// To parse this JSON data, do
//
//     final singleJobPreferance = singleJobPreferanceFromJson(jsonString);

import 'dart:convert';

List<SingleJobPreferance> singleJobPreferanceFromJson(String str) => List<SingleJobPreferance>.from(json.decode(str).map((x) => SingleJobPreferance.fromJson(x)));

String singleJobPreferanceToJson(List<SingleJobPreferance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SingleJobPreferance {
    int? id;
    String? userId;
    String? prefId;
    String? jobTypeId;
    String? functionalAreaId;
    String? expectedCategoryId;
    String? expectedSalaryId;
    String? preferredCity;
    String? isLooking;
    DateTime? createdAt;
    DateTime? updatedAt;
    FunctionalArea? functionalArea;
    City? city;
    dynamic education;
    Salary? salary;
    Jobtype? jobtype;
    List<FunctionalArea>? parentIndustries;

    SingleJobPreferance({
        this.id,
        this.userId,
        this.prefId,
        this.jobTypeId,
        this.functionalAreaId,
        this.expectedCategoryId,
        this.expectedSalaryId,
        this.preferredCity,
        this.isLooking,
        this.createdAt,
        this.updatedAt,
        this.functionalArea,
        this.city,
        this.education,
        this.salary,
        this.jobtype,
        this.parentIndustries,
    });

    factory SingleJobPreferance.fromJson(Map<String, dynamic> json) => SingleJobPreferance(
        id: json["id"],
        userId: json["user_id"],
        prefId: json["pref_id"],
        jobTypeId: json["job_type_id"],
        functionalAreaId: json["functional_area_id"],
        expectedCategoryId: json["expected_category_id"],
        expectedSalaryId: json["expected_salary_id"],
        preferredCity: json["preferred_city"],
        isLooking: json["isLooking"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        functionalArea: json["functional_area"] == null ? null : FunctionalArea.fromJson(json["functional_area"]),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        education: json["education"],
        salary: json["salary"] == null ? null : Salary.fromJson(json["salary"]),
        jobtype: json["jobtype"] == null ? null : Jobtype.fromJson(json["jobtype"]),
        parentIndustries: json["parent_industries"] == null ? [] : List<FunctionalArea>.from(json["parent_industries"]!.map((x) => FunctionalArea.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "pref_id": prefId,
        "job_type_id": jobTypeId,
        "functional_area_id": functionalAreaId,
        "expected_category_id": expectedCategoryId,
        "expected_salary_id": expectedSalaryId,
        "preferred_city": preferredCity,
        "isLooking": isLooking,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "functional_area": functionalArea?.toJson(),
        "city": city?.toJson(),
        "education": education,
        "salary": salary?.toJson(),
        "jobtype": jobtype?.toJson(),
        "parent_industries": parentIndustries == null ? [] : List<dynamic>.from(parentIndustries!.map((x) => x.toJson())),
    };
}

class City {
    int? id;
    String? name;
    String? parentDivisionName;
    DateTime? createdAt;
    DateTime? updatedAt;

    City({
        this.id,
        this.name,
        this.parentDivisionName,
        this.createdAt,
        this.updatedAt,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        parentDivisionName: json["parent_division_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_division_name": parentDivisionName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class FunctionalArea {
    int? id;
    String? name;
    String? parentIndustryName;
    String? parentCategoryName;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? featured;

    FunctionalArea({
        this.id,
        this.name,
        this.parentIndustryName,
        this.parentCategoryName,
        this.createdAt,
        this.updatedAt,
        this.featured,
    });

    factory FunctionalArea.fromJson(Map<String, dynamic> json) => FunctionalArea(
        id: json["id"],
        name: json["name"],
        parentIndustryName: json["parent_industry_name"],
        parentCategoryName: json["parent_category_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        featured: json["featured"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_industry_name": parentIndustryName,
        "parent_category_name": parentCategoryName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "featured": featured,
    };
}

class Jobtype {
    int? id;
    String? type;
    DateTime? createdAt;
    DateTime? updatedAt;

    Jobtype({
        this.id,
        this.type,
        this.createdAt,
        this.updatedAt,
    });

    factory Jobtype.fromJson(Map<String, dynamic> json) => Jobtype(
        id: json["id"],
        type: json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Salary {
    int? id;
    String? minSalary;
    String? maxSalary;
    String? currency;
    DateTime? createdAt;
    DateTime? updatedAt;

    Salary({
        this.id,
        this.minSalary,
        this.maxSalary,
        this.currency,
        this.createdAt,
        this.updatedAt,
    });

    factory Salary.fromJson(Map<String, dynamic> json) => Salary(
        id: json["id"],
        minSalary: json["min_salary"],
        maxSalary: json["max_salary"],
        currency: json["currency"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "min_salary": minSalary,
        "max_salary": maxSalary,
        "currency": currency,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

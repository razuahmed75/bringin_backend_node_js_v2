
import 'dart:convert';

JobPreferenceModelPost jobPreferenceModelPostFromJson(String str) => JobPreferenceModelPost.fromJson(json.decode(str));

String jobPreferenceModelPostToJson(JobPreferenceModelPost data) => json.encode(data.toJson());

class JobPreferenceModelPost {
    List<String>? category;
    String? functionalarea;
    String? division;
    String? jobtype;
    Salaray? salaray;

    JobPreferenceModelPost({
        this.category,
        this.functionalarea,
        this.division,
        this.jobtype,
        this.salaray,
    });

    factory JobPreferenceModelPost.fromJson(Map<String, dynamic> json) => JobPreferenceModelPost(
        category: List<String>.from(json["category"].map((x) => x)),
        functionalarea: json["functionalarea"],
        division: json["division"],
        jobtype: json["jobtype"],
        salaray: Salaray.fromJson(json["salaray"]),
    );

    Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category!.map((x) => x)),
        "functionalarea": functionalarea,
        "division": division,
        "jobtype": jobtype,
        "salaray": salaray!.toJson(),
    };
}

class Salaray {
    String? minSalary;
    String? maxSalary;

    Salaray({
        this.minSalary,
        this.maxSalary,
    });

    factory Salaray.fromJson(Map<String, dynamic> json) => Salaray(
        minSalary: json["min_salary"],
        maxSalary: json["max_salary"],
    );

    Map<String, dynamic> toJson() => {
        "min_salary": minSalary,
        "max_salary": maxSalary,
    };
}

import 'dart:convert';

RecruiterJobPostModel recruiterJobPostModelFromJson(String str) =>
    RecruiterJobPostModel.fromJson(json.decode(str));

String recruiterJobPostModelToJson(RecruiterJobPostModel data) =>
    json.encode(data.toJson());

class RecruiterJobPostModel {
  String? jobTitle;
  String? experticeArea;
  String? jobDescription;
  String? experience;
  String? education;
  Salary? salary;
  String? company;
  List<String>? skill;
  String? jobtype;
  JobLocation? jobLocation;
  bool? remote;
  String? companyname;

  RecruiterJobPostModel({
    this.jobTitle,
    this.experticeArea,
    this.jobDescription,
    this.experience,
    this.education,
    this.salary,
    this.company,
    this.skill,
    this.jobtype,
    this.jobLocation,
    this.remote,
    this.companyname,
  });

  factory RecruiterJobPostModel.fromJson(Map<String, dynamic> json) =>
      RecruiterJobPostModel(
        jobTitle: json["job_title"],
        experticeArea: json["expertice_area"],
        jobDescription: json["job_description"],
        experience: json["experience"],
        education: json["education"],
        salary: json["salary"] == null ? null : Salary.fromJson(json["salary"]),
        company: json["company"],
        skill: json["skill"] == null
            ? []
            : List<String>.from(json["skill"].map((x) => x)),
        jobtype: json["jobtype"],
        jobLocation: json["job_location"] == null
            ? null
            : JobLocation.fromJson(json["job_location"]),
        remote: json["remote"],
        companyname: json['companyname'] == null ? "" : json['companyname']
      );

  Map<String, dynamic> toJson() => {
        "job_title": jobTitle,
        "expertice_area": experticeArea,
        "job_description": jobDescription,
        "experience": experience,
        "education": education,
        "salary": salary!.toJson(),
        "company": company,
        "skill": List<dynamic>.from(skill!.map((x) => x)),
        "jobtype": jobtype,
        "job_location": jobLocation!.toJson(),
        "remote": remote,
        "companyname": companyname
      };
}

class JobLocation {
  double? lat;
  double? lon;
  String? formetAddress;
  String? locationoptional;
  String? divisiondata;


  JobLocation({
    this.lat,
    this.lon,
    this.formetAddress,
    this.locationoptional,
    this.divisiondata,
  });

  factory JobLocation.fromJson(Map<String, dynamic> json) => JobLocation(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        formetAddress: json["formet_address"],
        locationoptional: json["locationoptional"],
        divisiondata: json["divisiondata"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "formet_address": formetAddress,
        "locationoptional": locationoptional,
        "divisiondata": divisiondata,
      };
}

class Salary {
  String? minSalary;
  String? maxSalary;

  Salary({
    this.minSalary,
    this.maxSalary,
  });

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
        minSalary: json["min_salary"],
        maxSalary: json["max_salary"],
      );

  Map<String, dynamic> toJson() => {
        "min_salary": minSalary,
        "max_salary": maxSalary,
      };
}

import 'dart:convert';

JobPostUpdateModel jobPostUpdateModelFromJson(String str) =>
    JobPostUpdateModel.fromJson(json.decode(str));

String jobPostUpdateModelToJson(JobPostUpdateModel data) =>
    json.encode(data.toJson());

class JobPostUpdateModel {
  String? jobTitle;
  String? experticeArea;
  String? jobDescription;
  String? experience;
  String? education;
  Expected_Salary? salary;
  String? company;
  List<String>? skill;
  String? jobtype;
  Job_Location? jobLocation;
  bool? remote;
  int? jobStatusType;
  String? companyname;

  JobPostUpdateModel({
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
    this.jobStatusType,
    this.companyname
  });

  factory JobPostUpdateModel.fromJson(Map<String, dynamic> json) =>
      JobPostUpdateModel(
        jobTitle: json["job_title"],
        experticeArea: json["expertice_area"],
        jobDescription: json["job_description"],
        experience: json["experience"],
        education: json["education"],
        salary: Expected_Salary.fromJson(json["salary"]),
        company: json["company"],
        skill: List<String>.from(json["skill"].map((x) => x)),
        jobtype: json["jobtype"],
        jobLocation: Job_Location.fromJson(json["job_location"]),
        remote: json["remote"],
        jobStatusType: json["job_status_type"],
        companyname: json['companyname'],
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
        "job_status_type": jobStatusType,
        "companyname": companyname
      };
}

class Job_Location {
  double? lat;
  double? lon;
  String? formetAddress;
  String? city;
  String? division;
  String? locationoptional;
  String? divisiondata;

  Job_Location({
    this.lat,
    this.lon,
    this.formetAddress,
    this.city,
    this.division,
    this.locationoptional,
    this.divisiondata,
  });

  factory Job_Location.fromJson(Map<String, dynamic> json) => Job_Location(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        formetAddress: json["formet_address"],
        city: json["city"],
        division: json["division"],
        locationoptional: json["locationoptional"],
        divisiondata: json["divisiondata"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "formet_address": formetAddress,
        "city": city,
        "division": division,
        "locationoptional": locationoptional,
        "divisiondata": divisiondata,
      };
}

class Expected_Salary {
  String? minSalary;
  String? maxSalary;

  Expected_Salary({
    this.minSalary,
    this.maxSalary,
  });

  factory Expected_Salary.fromJson(Map<String, dynamic> json) =>
      Expected_Salary(
        minSalary: json["min_salary"],
        maxSalary: json["max_salary"],
      );

  Map<String, dynamic> toJson() => {
        "min_salary": minSalary,
        "max_salary": maxSalary,
      };
}

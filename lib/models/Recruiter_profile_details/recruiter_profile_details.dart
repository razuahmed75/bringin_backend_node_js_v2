// To parse this JSON data, do
//
//     final recruiterprofiledetails = recruiterprofiledetailsFromJson(jsonString);

import 'dart:convert';

Recruiterprofiledetails recruiterprofiledetailsFromJson(String str) =>
    Recruiterprofiledetails.fromJson(json.decode(str));

String recruiterprofiledetailsToJson(Recruiterprofiledetails data) =>
    json.encode(data.toJson());

class Recruiterprofiledetails {
  Recruiter? recruiter;
  List<Joblist>? joblist;

  Recruiterprofiledetails({
    this.recruiter,
    this.joblist,
  });

  factory Recruiterprofiledetails.fromJson(Map<String, dynamic> json) =>
      Recruiterprofiledetails(
        recruiter: json["recruiter"] == null
            ? null
            : Recruiter.fromJson(json["recruiter"]),
        joblist: json["joblist"] == null
            ? []
            : List<Joblist>.from(
                json["joblist"]!.map((x) => Joblist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recruiter": recruiter?.toJson(),
        "joblist": joblist == null
            ? []
            : List<dynamic>.from(joblist!.map((x) => x.toJson())),
      };
}

class Joblist {
  Salary? salary;
  Location? jobLocation;
  String? id;
  Userid? userid;
  String? jobTitle;
  String? companyname;
  ExperticeArea? experticeArea;
  String? jobDescription;
  Experience? experience;
  Education? education;
  Company? company;
  List<String>? skill;
  Jobtype? jobtype;
  bool? remote;
  int? jobStatusType;
  String? jobStatus;
  DateTime? postdate;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Joblist({
    this.salary,
    this.jobLocation,
    this.id,
    this.userid,
    this.jobTitle,
    this.companyname,
    this.experticeArea,
    this.jobDescription,
    this.experience,
    this.education,
    this.company,
    this.skill,
    this.jobtype,
    this.remote,
    this.jobStatusType,
    this.jobStatus,
    this.postdate,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Joblist.fromJson(Map<String, dynamic> json) => Joblist(
        salary: json["salary"] == null ? null : Salary.fromJson(json["salary"]),
        jobLocation: json["job_location"] == null
            ? null
            : Location.fromJson(json["job_location"]),
        id: json["_id"],
        userid: json["userid"] == null ? null : Userid.fromJson(json["userid"]),
        jobTitle: json["job_title"],
        companyname: json["companyname"],
        experticeArea: json["expertice_area"] == null
            ? null
            : ExperticeArea.fromJson(json["expertice_area"]),
        jobDescription: json["job_description"],
        experience: json["experience"] == null
            ? null
            : Experience.fromJson(json["experience"]),
        education: json["education"] == null
            ? null
            : Education.fromJson(json["education"]),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        skill: json["skill"] == null
            ? []
            : List<String>.from(json["skill"].map((x) => x)),
        jobtype:
            json["jobtype"] == null ? null : Jobtype.fromJson(json["jobtype"]),
        remote: json["remote"],
        jobStatusType: json["job_status_type"],
        jobStatus: json["job_status"],
        postdate:
            json["postdate"] == null ? null : DateTime.parse(json["postdate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "salary": salary?.toJson(),
        "job_location": jobLocation?.toJson(),
        "_id": id,
        "userid": userid?.toJson(),
        "job_title": jobTitle,
        "companyname": companyname,
        "expertice_area": experticeArea?.toJson(),
        "job_description": jobDescription,
        "experience": experience?.toJson(),
        "education": education?.toJson(),
        "company": company?.toJson(),
        "skill": skill == null ? [] : List<String>.from(skill!.map((x) => x)),
        "jobtype": jobtype?.toJson(),
        "remote": remote,
        "job_status_type": jobStatusType,
        "job_status": jobStatus,
        "postdate": postdate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Company {
  Location? cLocation;
  String? id;
  String? userid;
  String? legalName;
  String? sortName;
  Industry? industry;
  CSize? cSize;
  String? cWebsite;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Company({
    this.cLocation,
    this.id,
    this.userid,
    this.legalName,
    this.sortName,
    this.industry,
    this.cSize,
    this.cWebsite,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        cLocation: json["c_location"] == null
            ? null
            : Location.fromJson(json["c_location"]),
        id: json["_id"],
        userid: json["userid"],
        legalName: json["legal_name"],
        sortName: json["sort_name"],
        industry: json["industry"] == null
            ? null
            : Industry.fromJson(json["industry"]),
        cSize: json["c_size"] == null ? null : CSize.fromJson(json["c_size"]),
        cWebsite: json["c_website"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "c_location": cLocation?.toJson(),
        "_id": id,
        "userid": userid,
        "legal_name": legalName,
        "sort_name": sortName,
        "industry": industry?.toJson(),
        "c_size": cSize?.toJson(),
        "c_website": cWebsite,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Location {
  double? lat;
  double? lon;
  String? formetAddress;
  String? locationoptional;
  DivisionData? divisiondata;

  Location({this.lat, this.lon, this.formetAddress,this.divisiondata,this.locationoptional});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] == 0 ? 0.0 : json['lat'];
    lon = json['lon'] == 0 ? 0.0 : json['lon'];
    formetAddress = json['formet_address'];
    locationoptional = json['locationoptional'];
    divisiondata = json['divisiondata'] == null ? null : DivisionData.fromJson(json['divisiondata']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['formet_address'] = this.formetAddress;
    data['locationoptional'] = this.locationoptional;
    if(this.divisiondata != null){
      data['divisiondata'] = this.divisiondata!.toJson();
    }
    return data;
  }
}
class DivisionData {
    String? id;
    String? divisionname;
    Cityid? cityid;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    DivisionData({
        this.id,
        this.divisionname,
        this.cityid,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory DivisionData.fromJson(Map<String, dynamic> json) => DivisionData(
        id: json["_id"],
        divisionname: json["divisionname"],
        cityid: json["cityid"] == null ? null : Cityid.fromJson(json["cityid"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "divisionname": divisionname,
        "cityid": cityid!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

class Cityid {
    String? id;
    String? name;

    Cityid({
        this.id,
        this.name,
    });

    factory Cityid.fromJson(Map<String, dynamic> json) => Cityid(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}

class CSize {
  String? id;
  String? size;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CSize({
    this.id,
    this.size,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CSize.fromJson(Map<String, dynamic> json) => CSize(
        id: json["_id"],
        size: json["size"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "size": size,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
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
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "industryid": industryid,
        "categoryname": categoryname,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Education {
  String? id;
  String? name;
  List<String>? digree;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Education({
    this.id,
    this.name,
    this.digree,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["_id"],
        name: json["name"],
        digree: json["digree"] == null
            ? []
            : List<String>.from(json["digree"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "digree":
            digree == null ? [] : List<dynamic>.from(digree!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Experience {
  String? id;
  String? name;
  int? v;
  DateTime? updatedAt;

  Experience({
    this.id,
    this.name,
    this.v,
    this.updatedAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["_id"],
        name: json["name"],
        v: json["__v"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class ExperticeArea {
  String? id;
  String? industryid;
  String? categoryid;
  String? functionalname;
  int? v;

  ExperticeArea({
    this.id,
    this.industryid,
    this.categoryid,
    this.functionalname,
    this.v,
  });

  factory ExperticeArea.fromJson(Map<String, dynamic> json) => ExperticeArea(
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

class Jobtype {
  String? id;
  String? worktype;
  int? v;

  Jobtype({
    this.id,
    this.worktype,
    this.v,
  });

  factory Jobtype.fromJson(Map<String, dynamic> json) => Jobtype(
        id: json["_id"],
        worktype: json["worktype"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "worktype": worktype,
        "__v": v,
      };
}

class Salary {
  MaxSalaryClass? minSalary;
  MaxSalaryClass? maxSalary;

  Salary({
    this.minSalary,
    this.maxSalary,
  });

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
        minSalary: json["min_salary"] == null
            ? null
            : MaxSalaryClass.fromJson(json["min_salary"]),
        maxSalary: json["max_salary"] == null
            ? null
            : MaxSalaryClass.fromJson(json["max_salary"]),
      );

  Map<String, dynamic> toJson() => {
        "min_salary": minSalary?.toJson(),
        "max_salary": maxSalary?.toJson(),
      };
}

class MaxSalaryClass {
  String? id;
  dynamic salary;
  int? type;
  String? simbol;
  String? currency;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MaxSalaryClass({
    this.id,
    this.salary,
    this.type,
    this.simbol,
    this.currency,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MaxSalaryClass.fromJson(Map<String, dynamic> json) => MaxSalaryClass(
        id: json["_id"],
        salary: json["salary"],
        type: json["type"],
        simbol: json["simbol"],
        currency: json["currency"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "salary": salary,
        "type": type,
        "simbol": simbol,
        "currency": currency,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Userid {
  Other? other;
  String? id;
  String? number;
  String? firstname;
  String? lastname;
  String? companyname;
  String? designation;
  String? email;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Userid({
    this.other,
    this.id,
    this.number,
    this.firstname,
    this.lastname,
    this.companyname,
    this.designation,
    this.email,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Userid.fromJson(Map<String, dynamic> json) => Userid(
        other: json["other"] == null ? null : Other.fromJson(json["other"]),
        id: json["_id"],
        number: json["number"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        companyname: json["companyname"],
        designation: json["designation"],
        email: json["email"],
        image: json["image"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "other": other?.toJson(),
        "_id": id,
        "number": number,
        "firstname": firstname,
        "lastname": lastname,
        "companyname": companyname,
        "designation": designation,
        "email": email,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Other {
  Notification? notification;
  int? totaljob;
  dynamic package;
  String? latestjobid;
  bool? companyVerify;
  bool? profileVerify;
  int? profileVerifyType;
  int? companyVerifyType;
  bool? companyDocupload;
  bool? profileDocupload;
  DateTime? profileVerifyDate;
  bool? premium;
  int? totalChat;
  int? savecandidate;
  int? interview;
  int? candidateView;
  int? totalStep;
  int? incomplete;
  int? complete;
  bool? online;
  int? offlinedate;
  String? pushnotification;

  Other({
    this.notification,
    this.totaljob,
    this.package,
    this.latestjobid,
    this.companyVerify,
    this.profileVerify,
    this.profileVerifyType,
    this.companyVerifyType,
    this.companyDocupload,
    this.profileDocupload,
    this.profileVerifyDate,
    this.premium,
    this.totalChat,
    this.savecandidate,
    this.interview,
    this.candidateView,
    this.totalStep,
    this.incomplete,
    this.complete,
    this.online,
    this.offlinedate,
    this.pushnotification,
  });

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        notification: json["notification"] == null
            ? null
            : Notification.fromJson(json["notification"]),
        totaljob: json["totaljob"],
        package: json["package"],
        latestjobid: json["latestjobid"],
        companyVerify: json["company_verify"],
        profileVerify: json["profile_verify"],
        profileVerifyType: json["profile_verify_type"],
        companyVerifyType: json["company_verify_type"],
        companyDocupload: json["company_docupload"],
        profileDocupload: json["profile_docupload"],
        profileVerifyDate: json["profile_verify_date"] == null
            ? null
            : DateTime.parse(json["profile_verify_date"]),
        premium: json["premium"],
        totalChat: json["total_chat"],
        savecandidate: json["savecandidate"],
        interview: json["interview"],
        candidateView: json["candidate_view"],
        totalStep: json["total_step"],
        incomplete: json["incomplete"],
        complete: json["complete"],
        online: json["online"],
        offlinedate: json["offlinedate"],
        pushnotification: json["pushnotification"],
      );

  Map<String, dynamic> toJson() => {
        "notification": notification?.toJson(),
        "totaljob": totaljob,
        "package": package,
        "latestjobid": latestjobid,
        "company_verify": companyVerify,
        "profile_verify": profileVerify,
        "profile_verify_type": profileVerifyType,
        "company_verify_type": companyVerifyType,
        "company_docupload": companyDocupload,
        "profile_docupload": profileDocupload,
        "profile_verify_date": profileVerifyDate?.toIso8601String(),
        "premium": premium,
        "total_chat": totalChat,
        "savecandidate": savecandidate,
        "interview": interview,
        "candidate_view": candidateView,
        "total_step": totalStep,
        "incomplete": incomplete,
        "complete": complete,
        "online": online,
        "offlinedate": offlinedate,
        "pushnotification": pushnotification,
      };
}

class Notification {
  bool? pushNotification;
  bool? whatsappNotification;
  bool? smsNotification;
  bool? jobRecommandation;

  Notification({
    this.pushNotification,
    this.whatsappNotification,
    this.smsNotification,
    this.jobRecommandation,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        pushNotification: json["push_notification"],
        whatsappNotification: json["whatsapp_notification"],
        smsNotification: json["sms_notification"],
        jobRecommandation: json["job_recommandation"],
      );

  Map<String, dynamic> toJson() => {
        "push_notification": pushNotification,
        "whatsapp_notification": whatsappNotification,
        "sms_notification": smsNotification,
        "job_recommandation": jobRecommandation,
      };
}

class Recruiter {
  Other? other;
  String? id;
  String? number;
  String? firstname;
  String? lastname;
  Companyname? companyname;
  String? designation;
  String? email;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Recruiter({
    this.other,
    this.id,
    this.number,
    this.firstname,
    this.lastname,
    this.companyname,
    this.designation,
    this.email,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Recruiter.fromJson(Map<String, dynamic> json) => Recruiter(
        other: json["other"] == null ? null : Other.fromJson(json["other"]),
        id: json["_id"],
        number: json["number"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        companyname: json["companyname"] == null
            ? null
            : Companyname.fromJson(json["companyname"]),
        designation: json["designation"],
        email: json["email"],
        image: json["image"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "other": other?.toJson(),
        "_id": id,
        "number": number,
        "firstname": firstname,
        "lastname": lastname,
        "companyname": companyname?.toJson(),
        "designation": designation,
        "email": email,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Companyname {
  Location? cLocation;
  String? id;
  String? userid;
  String? legalName;
  String? sortName;
  Industry? industry;
  String? cSize;
  String? cWebsite;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Companyname({
    this.cLocation,
    this.id,
    this.userid,
    this.legalName,
    this.sortName,
    this.industry,
    this.cSize,
    this.cWebsite,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Companyname.fromJson(Map<String, dynamic> json) => Companyname(
        cLocation: json["c_location"] == null
            ? null
            : Location.fromJson(json["c_location"]),
        id: json["_id"],
        userid: json["userid"],
        legalName: json["legal_name"],
        sortName: json["sort_name"],
        industry: json["industry"] == null
            ? null
            : Industry.fromJson(json["industry"]),
        cSize: json["c_size"],
        cWebsite: json["c_website"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "c_location": cLocation?.toJson(),
        "_id": id,
        "userid": userid,
        "legal_name": legalName,
        "sort_name": sortName,
        "industry": industry?.toJson(),
        "c_size": cSize,
        "c_website": cWebsite,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

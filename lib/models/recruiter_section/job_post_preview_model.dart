// // To parse this JSON data, do
// //
// //     final jobPreviewModel = jobPreviewModelFromJson(jsonString);

// import 'dart:convert';

// List<JobPreviewModel> jobPreviewModelFromJson(String str) =>
//     List<JobPreviewModel>.from(
//         json.decode(str).map((x) => JobPreviewModel.fromJson(x)));

// String jobPreviewModelToJson(List<JobPreviewModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class JobPreviewModel {
//   String? id;
//   Userid? userid;
//   String? jobTitle;
//   ExperticeArea? experticeArea;
//   JosPostLocation? jobPostLocation;
//   String? jobDescription;
//   Education? experience;
//   Education? education;
//   Salary? salary;
//   Company? company;
//   List<Skill>? skill;
//   Jobtype? jobtype;
//   bool? remote;
//   int? jobStatusType;
//   String? jobStatus;
//   DateTime? postdate;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;

//   JobPreviewModel({
//     this.id,
//     this.userid,
//     this.jobTitle,
//     this.experticeArea,
//     this.jobPostLocation,
//     this.jobDescription,
//     this.experience,
//     this.education,
//     this.salary,
//     this.company,
//     this.skill,
//     this.jobtype,
//     this.remote,
//     this.jobStatusType,
//     this.jobStatus,
//     this.postdate,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory JobPreviewModel.fromJson(Map<String, dynamic> json) =>
//       JobPreviewModel(
//         id: json["_id"],
//         userid: json["userid"] == null ? null : Userid.fromJson(json["userid"]),
//         jobTitle: json["job_title"],
//         experticeArea: json["expertice_area"] == null
//             ? null
//             : ExperticeArea.fromJson(json["expertice_area"]),
//         jobPostLocation: json["job_location"] == null
//             ? null
//             : JosPostLocation.fromJson(json["job_location"]),
//         jobDescription: json["job_description"],
//         experience: json["experience"] == null
//             ? null
//             : Education.fromJson(json["experience"]),
//         education: json["education"] == null
//             ? null
//             : Education.fromJson(json["education"]),
//         salary: json["salary"] == null ? null : Salary.fromJson(json["salary"]),
//         company:
//             json["company"] == null ? null : Company.fromJson(json["company"]),
//         skill: json["skill"] == null
//             ? []
//             : List<Skill>.from(json["skill"]!.map((x) => Skill.fromJson(x))),
//         jobtype:
//             json["jobtype"] == null ? null : Jobtype.fromJson(json["jobtype"]),
//         remote: json["remote"],
//         jobStatusType: json["job_status_type"],
//         jobStatus: json["job_status"],
//         postdate:
//             json["postdate"] == null ? null : DateTime.parse(json["postdate"]),
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userid": userid?.toJson(),
//         "job_title": jobTitle,
//         "expertice_area": experticeArea?.toJson(),
//         "job_location": jobPostLocation?.toJson(),
//         "job_description": jobDescription,
//         "experience": experience?.toJson(),
//         "education": education?.toJson(),
//         "salary": salary?.toJson(),
//         "company": company?.toJson(),
//         "skill": skill == null
//             ? []
//             : List<dynamic>.from(skill!.map((x) => x.toJson())),
//         "jobtype": jobtype?.toJson(),
//         "remote": remote,
//         "job_status_type": jobStatusType,
//         "job_status": jobStatus,
//         "postdate": postdate?.toIso8601String(),
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Company {
//   CLocation? cLocation;
//   String? id;
//   String? userid;
//   String? legalName;
//   String? sortName;
//   Industry? industry;
//   CSize? cSize;
//   String? cWebsite;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;

//   Company({
//     this.cLocation,
//     this.id,
//     this.userid,
//     this.legalName,
//     this.sortName,
//     this.industry,
//     this.cSize,
//     this.cWebsite,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Company.fromJson(Map<String, dynamic> json) => Company(
//         cLocation: json["c_location"] == null
//             ? null
//             : CLocation.fromJson(json["c_location"]),
//         id: json["_id"],
//         userid: json["userid"],
//         legalName: json["legal_name"],
//         sortName: json["sort_name"],
//         industry: json["industry"] == null
//             ? null
//             : Industry.fromJson(json["industry"]),
//         cSize: json["c_size"] == null ? null : CSize.fromJson(json["c_size"]),
//         cWebsite: json["c_website"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "c_location": cLocation?.toJson(),
//         "_id": id,
//         "userid": userid,
//         "legal_name": legalName,
//         "sort_name": sortName,
//         "industry": industry?.toJson(),
//         "c_size": cSize?.toJson(),
//         "c_website": cWebsite,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class CLocation {
//   double? lat;
//   double? lon;
//   String? formetAddress;
//   String? city;

//   CLocation({
//     this.lat,
//     this.lon,
//     this.formetAddress,
//     this.city,
//   });

//   factory CLocation.fromJson(Map<String, dynamic> json) => CLocation(
//         lat: json["lat"]?.toDouble(),
//         lon: json["lon"]?.toDouble(),
//         formetAddress: json["formet_address"],
//         city: json["city"],
//       );

//   Map<String, dynamic> toJson() => {
//         "lat": lat,
//         "lon": lon,
//         "formet_address": formetAddress,
//         "city": city,
//       };
// }

// class CSize {
//   String? id;
//   String? size;
//   int? v;

//   CSize({
//     this.id,
//     this.size,
//     this.v,
//   });

//   factory CSize.fromJson(Map<String, dynamic> json) => CSize(
//         id: json["_id"],
//         size: json["size"],
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "size": size,
//         "__v": v,
//       };
// }

// class Industry {
//   String? id;
//   String? industryname;
//   int? v;

//   Industry({
//     this.id,
//     this.industryname,
//     this.v,
//   });

//   factory Industry.fromJson(Map<String, dynamic> json) => Industry(
//         id: json["_id"],
//         industryname: json["industryname"],
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "industryname": industryname,
//         "__v": v,
//       };
// }

// class Education {
//   String? id;
//   String? name;
//   int? v;

//   Education({
//     this.id,
//     this.name,
//     this.v,
//   });

//   factory Education.fromJson(Map<String, dynamic> json) => Education(
//         id: json["_id"],
//         name: json["name"],
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "__v": v,
//       };
// }

// class ExperticeArea {
//   String? id;
//   String? industryid;
//   String? categoryid;
//   String? functionalname;
//   int? v;

//   ExperticeArea({
//     this.id,
//     this.industryid,
//     this.categoryid,
//     this.functionalname,
//     this.v,
//   });

//   factory ExperticeArea.fromJson(Map<String, dynamic> json) => ExperticeArea(
//         id: json["_id"],
//         industryid: json["industryid"],
//         categoryid: json["categoryid"],
//         functionalname: json["functionalname"],
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "industryid": industryid,
//         "categoryid": categoryid,
//         "functionalname": functionalname,
//         "__v": v,
//       };
// }
// class JosPostLocation {
//     double? lat;
//     double? lon;
//     String? formetAddress;
//     String? city;

//     JosPostLocation({
//         this.lat,
//         this.lon,
//         this.formetAddress,
//         this.city,
//     });

//     factory JosPostLocation.fromJson(Map<String, dynamic> json) => JosPostLocation(
//         lat: json["lat"].toDouble(),
//         lon: json["lon"].toDouble(),
//         formetAddress: json["formet_address"],
//         city: json["city"],
//     );

//     Map<String, dynamic> toJson() => {
//         "lat": lat,
//         "lon": lon,
//         "formet_address": formetAddress,
//         "city": city,
//     };
// }

// class Jobtype {
//   String? id;
//   String? worktype;
//   int? v;

//   Jobtype({
//     this.id,
//     this.worktype,
//     this.v,
//   });

//   factory Jobtype.fromJson(Map<String, dynamic> json) => Jobtype(
//         id: json["_id"],
//         worktype: json["worktype"],
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "worktype": worktype,
//         "__v": v,
//       };
// }

// class Salary {
//     MaxSalaryClass? minSalary;
//     MaxSalaryClass? maxSalary;

//     Salary({
//         this.minSalary,
//         this.maxSalary,
//     });

//     factory Salary.fromJson(Map<String, dynamic> json) => Salary(
//         minSalary: json["min_salary"] == null ? null : MaxSalaryClass.fromJson(json["min_salary"]),
//         maxSalary: json["max_salary"] == null ? null : MaxSalaryClass.fromJson(json["max_salary"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "min_salary": minSalary!.toJson(),
//         "max_salary": maxSalary!.toJson(),
//     };
// }

// class MaxSalaryClass {
//     String? id;
//     dynamic salary;
//     int? type;
//     String? simbol;
//     String? currency;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     int? v;

//     MaxSalaryClass({
//         this.id,
//         this.salary,
//         this.type,
//         this.simbol,
//         this.currency,
//         this.createdAt,
//         this.updatedAt,
//         this.v,
//     });

//     factory MaxSalaryClass.fromJson(Map<String, dynamic> json) => MaxSalaryClass(
//         id: json["_id"],
//         salary: json["salary"],
//         type: json["type"],
//         simbol: json["simbol"],
//         currency: json["currency"],
//         createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "salary": salary,
//         "type": type,
//         "simbol": simbol,
//         "currency": currency,
//         "createdAt": createdAt!.toIso8601String(),
//         "updatedAt": updatedAt!.toIso8601String(),
//         "__v": v,
//     };
// }


// class Skill {
//   String? id;
//   String? skill;
//   String? userid;
//   int? v;

//   Skill({
//     this.id,
//     this.skill,
//     this.userid,
//     this.v,
//   });

//   factory Skill.fromJson(Map<String, dynamic> json) => Skill(
//         id: json["_id"],
//         skill: json["skill"],
//         userid: json["userid"],
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "skill": skill,
//         "userid": userid,
//         "__v": v,
//       };
// }

// class Userid {
//   Other? other;
//   String? id;
//   String? number;
//   String? firstname;
//   String? lastname;
//   String? companyname;
//   String? designation;
//   String? email;
//   String? image;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;

//   Userid({
//     this.other,
//     this.id,
//     this.number,
//     this.firstname,
//     this.lastname,
//     this.companyname,
//     this.designation,
//     this.email,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Userid.fromJson(Map<String, dynamic> json) => Userid(
//         other: json["other"] == null ? null : Other.fromJson(json["other"]),
//         id: json["_id"],
//         number: json["number"],
//         firstname: json["firstname"],
//         lastname: json["lastname"],
//         companyname: json["companyname"],
//         designation: json["designation"],
//         email: json["email"],
//         image: json["image"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "other": other?.toJson(),
//         "_id": id,
//         "number": number,
//         "firstname": firstname,
//         "lastname": lastname,
//         "companyname": companyname,
//         "designation": designation,
//         "email": email,
//         "image": image,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Other {
//   Notification? notification;
//   bool? companyVerify;
//   bool? profileVerify;
//   bool? companyDocupload;
//   bool? profileDocupload;
//   DateTime? profileVerifyDate;
//   bool? premium;
//   int? totalChat;
//   int? savecandidate;
//   int? interview;
//   int? totalStep;
//   int? incomplete;
//   int? complete;
//   String? pushnotification;

//   Other({
//     this.notification,
//     this.companyVerify,
//     this.profileVerify,
//     this.companyDocupload,
//     this.profileDocupload,
//     this.profileVerifyDate,
//     this.premium,
//     this.totalChat,
//     this.savecandidate,
//     this.interview,
//     this.totalStep,
//     this.incomplete,
//     this.complete,
//     this.pushnotification,
//   });

//   factory Other.fromJson(Map<String, dynamic> json) => Other(
//         notification: json["notification"] == null
//             ? null
//             : Notification.fromJson(json["notification"]),
//         companyVerify: json["company_verify"],
//         profileVerify: json["profile_verify"],
//         companyDocupload: json["company_docupload"],
//         profileDocupload: json["profile_docupload"],
//         profileVerifyDate: json["profile_verify_date"] == null
//             ? null
//             : DateTime.parse(json["profile_verify_date"]),
//         premium: json["premium"],
//         totalChat: json["total_chat"],
//         savecandidate: json["savecandidate"],
//         interview: json["interview"],
//         totalStep: json["total_step"],
//         incomplete: json["incomplete"],
//         complete: json["complete"],
//         pushnotification: json["pushnotification"],
//       );

//   Map<String, dynamic> toJson() => {
//         "notification": notification?.toJson(),
//         "company_verify": companyVerify,
//         "profile_verify": profileVerify,
//         "company_docupload": companyDocupload,
//         "profile_docupload": profileDocupload,
//         "profile_verify_date": profileVerifyDate?.toIso8601String(),
//         "premium": premium,
//         "total_chat": totalChat,
//         "savecandidate": savecandidate,
//         "interview": interview,
//         "total_step": totalStep,
//         "incomplete": incomplete,
//         "complete": complete,
//         "pushnotification": pushnotification,
//       };
// }

// class Notification {
//   bool? pushNotification;
//   bool? whatsappNotification;
//   bool? smsNotification;
//   bool? jobRecommandation;

//   Notification({
//     this.pushNotification,
//     this.whatsappNotification,
//     this.smsNotification,
//     this.jobRecommandation,
//   });

//   factory Notification.fromJson(Map<String, dynamic> json) => Notification(
//         pushNotification: json["push_notification"],
//         whatsappNotification: json["whatsapp_notification"],
//         smsNotification: json["sms_notification"],
//         jobRecommandation: json["job_recommandation"],
//       );

//   Map<String, dynamic> toJson() => {
//         "push_notification": pushNotification,
//         "whatsapp_notification": whatsappNotification,
//         "sms_notification": smsNotification,
//         "job_recommandation": jobRecommandation,
//       };
// }



// To parse this JSON data, do
//
//     final jobPreviewModel = jobPreviewModelFromJson(jsonString);






import 'dart:convert';

List<JobPreviewModel?> jobPreviewModelFromJson(String str) => List<JobPreviewModel?>.from(json.decode(str).map((x) => x == null ? null : JobPreviewModel.fromJson(x)));

String jobPreviewModelToJson(List<JobPreviewModel?> data) => json.encode(List<dynamic>.from(data.map((x) => x?.toJson())));

class JobPreviewModel {
    SalaryClass? salary;
    Location? jobLocation;
    String? id;
    Userid? userid;
    String? jobTitle;
    ExperticeArea? experticeArea;
    String? jobDescription;
    Education? experience;
    Education? education;
    Company? company;
    List<String>? skill;
    Education? jobtype;
    bool? remote;
    int? jobStatusType;
    String? jobStatus;
    DateTime? postdate;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    JobPreviewModel({
        this.salary,
        this.jobLocation,
        this.id,
        this.userid,
        this.jobTitle,
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

    factory JobPreviewModel.fromJson(Map<String, dynamic> json) => JobPreviewModel(
        salary: json["salary"] == null ? null : SalaryClass.fromJson(json["salary"]),
        jobLocation: json["job_location"] == null ? null : Location.fromJson(json["job_location"]),
        id: json["_id"],
        userid: json["userid"] == null ? null : Userid.fromJson(json["userid"]),
        jobTitle: json["job_title"],
        experticeArea: json["expertice_area"] == null ? null : ExperticeArea.fromJson(json["expertice_area"]),
        jobDescription: json["job_description"],
        experience: json["experience"] == null ? null : Education.fromJson(json["experience"]),
        education: json["education"] == null ? null : Education.fromJson(json["education"]),
        company: json["company"] == null ? null : Company.fromJson(json["company"]),
                skill: json["skill"] == null
            ? []
            : List<String>.from(json["skill"].map((x) => x)),
        jobtype: json["jobtype"] == null ? null : Education.fromJson(json["jobtype"]),
        remote: json["remote"],
        jobStatusType: json["job_status_type"],
        jobStatus: json["job_status"],
        postdate: json["postdate"] == null ? null : DateTime.parse(json["postdate"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "salary": salary?.toJson(),
        "job_location": jobLocation?.toJson(),
        "_id": id,
        "userid": userid?.toJson(),
        "job_title": jobTitle,
        "expertice_area": experticeArea?.toJson(),
        "job_description": jobDescription,
        "experience": experience?.toJson(),
        "education": education?.toJson(),
        "company": company?.toJson(),
       "skill": skill == null
            ? []
            : List<dynamic>.from(skill!.map((x) => x)),
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
        cLocation: json["c_location"] == null ? null : Location.fromJson(json["c_location"]),
        id: json["_id"],
        userid: json["userid"],
        legalName: json["legal_name"],
        sortName: json["sort_name"],
        industry: json["industry"] == null ? null : Industry.fromJson(json["industry"]),
        cSize: json["c_size"] == null ? null : CSize.fromJson(json["c_size"]),
        cWebsite: json["c_website"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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

    Location({
        this.lat,
        this.lon,
        this.formetAddress,
        this.divisiondata,
        this.locationoptional,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        formetAddress: json["formet_address"],
        locationoptional: json["locationoptional"],
        divisiondata: json["divisiondata"] == null ? null : DivisionData.fromJson(json["divisiondata"]),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "formet_address": formetAddress,
        "locationoptional": locationoptional,
        "divisiondata": divisiondata!.toJson(),
    };
}

class CSize {
    String? id;
    String? size;
    int? v;

    CSize({
        this.id,
        this.size,
        this.v,
    });

    factory CSize.fromJson(Map<String, dynamic> json) => CSize(
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Education {
    String? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? worktype;

    Education({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.worktype,
    });

    factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["_id"],
        name: json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        worktype: json["worktype"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "worktype": worktype,
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

class SalaryClass {
    Salary? minSalary;
    Salary? maxSalary;

    SalaryClass({
        this.minSalary,
        this.maxSalary,
    });

    factory SalaryClass.fromJson(Map<String, dynamic> json) => SalaryClass(
        minSalary: json["min_salary"] == null ? null : Salary.fromJson(json["min_salary"]),
        maxSalary: json["max_salary"] == null ? null : Salary.fromJson(json["max_salary"]),
    );

    Map<String, dynamic> toJson() => {
        "min_salary": minSalary?.toJson(),
        "max_salary": maxSalary?.toJson(),
    };
}

class Salary {
    String? id;
    dynamic salary;
    int? type;
    String? simbol;
    String? currency;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Salary({
        this.id,
        this.salary,
        this.type,
        this.simbol,
        this.currency,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Salary.fromJson(Map<String, dynamic> json) => Salary(
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
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
    int? totalStep;
    int? incomplete;
    int? complete;
    bool? online;
    String? pushnotification;
    int? candidateView;
    int? offlinedate;

    Other({
        this.notification,
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
        this.totalStep,
        this.incomplete,
        this.complete,
        this.online,
        this.pushnotification,
        this.candidateView,
        this.offlinedate,
    });

    factory Other.fromJson(Map<String, dynamic> json) => Other(
        notification: json["notification"] == null ? null : Notification.fromJson(json["notification"]),
        latestjobid: json["latestjobid"],
        companyVerify: json["company_verify"],
        profileVerify: json["profile_verify"],
        profileVerifyType: json["profile_verify_type"],
        companyVerifyType: json["company_verify_type"],
        companyDocupload: json["company_docupload"],
        profileDocupload: json["profile_docupload"],
        profileVerifyDate: json["profile_verify_date"] == null ? null : DateTime.parse(json["profile_verify_date"]),
        premium: json["premium"],
        totalChat: json["total_chat"],
        savecandidate: json["savecandidate"],
        interview: json["interview"],
        totalStep: json["total_step"],
        incomplete: json["incomplete"],
        complete: json["complete"],
        online: json["online"],
        pushnotification: json["pushnotification"],
        candidateView: json["candidate_view"],
        offlinedate: json["offlinedate"],
    );

    Map<String, dynamic> toJson() => {
        "notification": notification?.toJson(),
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
        "total_step": totalStep,
        "incomplete": incomplete,
        "complete": complete,
        "online": online,
        "pushnotification": pushnotification,
        "candidate_view": candidateView,
        "offlinedate": offlinedate,
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



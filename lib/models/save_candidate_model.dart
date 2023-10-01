// To parse this JSON data, do
//
//     final savecandidate = savecandidateFromJson(jsonString);

import 'dart:convert';

List<Savecandidate> savecandidateFromJson(String str) => List<Savecandidate>.from(json.decode(str).map((x) => Savecandidate.fromJson(x)));

String savecandidateToJson(List<Savecandidate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Savecandidate {
    String? id;
    String? userid;
    String? candidateid;
    Candidatefullprofile? candidatefullprofile;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Savecandidate({
        this.id,
        this.userid,
        this.candidateid,
        this.candidatefullprofile,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Savecandidate.fromJson(Map<String, dynamic> json) => Savecandidate(
        id: json["_id"],
        userid: json["userid"],
        candidateid: json["candidateid"],
        candidatefullprofile: json["candidatefullprofile"] == null ? null : Candidatefullprofile.fromJson(json["candidatefullprofile"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid,
        "candidateid": candidateid,
        "candidatefullprofile": candidatefullprofile?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Candidatefullprofile {
    String? id;
    Userid? userid;
    List<Workexperience>? workexperience;
    List<Education>? education;
    List<String>? skill;
    List<About>? protfoliolink;
    List<CareerPreference>? careerPreference;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    About? about;

    Candidatefullprofile({
        this.id,
        this.userid,
        this.workexperience,
        this.education,
        this.skill,
        this.protfoliolink,
        this.careerPreference,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.about,
    });

    factory Candidatefullprofile.fromJson(Map<String, dynamic> json) => Candidatefullprofile(
        id: json["_id"],
        userid: json["userid"] == null ? null : Userid.fromJson(json["userid"]),
        workexperience: json["workexperience"] == null ? [] : List<Workexperience>.from(json["workexperience"]!.map((x) => Workexperience.fromJson(x))),
        education: json["education"] == null ? [] : List<Education>.from(json["education"]!.map((x) => Education.fromJson(x))),
        skill: json["skill"] == null ? [] : List<String>.from(json["skill"]!.map((x) => x)),
        protfoliolink: json["protfoliolink"] == null ? [] : List<About>.from(json["protfoliolink"]!.map((x) => About.fromJson(x))),
        careerPreference: json["careerPreference"] == null ? [] : List<CareerPreference>.from(json["careerPreference"]!.map((x) => CareerPreference.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        about: json["about"] == null ? null : About.fromJson(json["about"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid?.toJson(),
        "workexperience": workexperience == null ? [] : List<dynamic>.from(workexperience!.map((x) => x.toJson())),
        "education": education == null ? [] : List<dynamic>.from(education!.map((x) => x.toJson())),
        "skill": skill == null ? [] : List<String>.from(skill!.map((x) => x)),
        "protfoliolink": protfoliolink == null ? [] : List<dynamic>.from(protfoliolink!.map((x) => x.toJson())),
        "careerPreference": careerPreference == null ? [] : List<dynamic>.from(careerPreference!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "about": about?.toJson(),
    };
}

class About {
    String? id;
    String? about;
    String? userid;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? protfoliolink;

    About({
        this.id,
        this.about,
        this.userid,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.protfoliolink,
    });

    factory About.fromJson(Map<String, dynamic> json) => About(
        id: json["_id"],
        about: json["about"],
        userid: json["userid"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        protfoliolink: json["protfoliolink"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "about": about,
        "userid": userid,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "protfoliolink": protfoliolink,
    };
}

class CareerPreference {
    String? id;
    String? userid;
    List<Category>? category;
    Area? functionalarea;
    Division? division;
    Jobtype? jobtype;
    Salaray? salaray;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    CareerPreference({
        this.id,
        this.userid,
        this.category,
        this.functionalarea,
        this.division,
        this.jobtype,
        this.salaray,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory CareerPreference.fromJson(Map<String, dynamic> json) => CareerPreference(
        id: json["_id"],
        userid: json["userid"],
        category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
        functionalarea: json["functionalarea"] == null ? null : Area.fromJson(json["functionalarea"]),
        division: json["division"] == null ? null : Division.fromJson(json["division"]),
        jobtype: json["jobtype"] == null ? null : Jobtype.fromJson(json["jobtype"]),
        salaray: json["salaray"] == null ? null : Salaray.fromJson(json["salaray"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid,
        "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
        "functionalarea": functionalarea?.toJson(),
        "division": division?.toJson(),
        "jobtype": jobtype?.toJson(),
        "salaray": salaray?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Category {
    String? id;
    String? industryid;
    String? categoryname;
    int? v;

    Category({
        this.id,
        this.industryid,
        this.categoryname,
        this.v,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        industryid: json["industryid"],
        categoryname: json["categoryname"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryid": industryid,
        "categoryname": categoryname,
        "__v": v,
    };
}

class Division {
    String? id;
    String? divisionname;
    Subject? cityid;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Division({
        this.id,
        this.divisionname,
        this.cityid,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Division.fromJson(Map<String, dynamic> json) => Division(
        id: json["_id"],
        divisionname: json["divisionname"],
        cityid: json["cityid"] == null ? null : Subject.fromJson(json["cityid"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "divisionname": divisionname,
        "cityid": cityid?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Subject {
    String? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    List<String>? digree;

    Subject({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.digree,
    });

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["_id"],
        name: json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        digree: json["digree"] == null ? [] : List<String>.from(json["digree"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "digree": digree == null ? [] : List<dynamic>.from(digree!.map((x) => x)),
    };
}

class Area {
    String? id;
    String? industryid;
    String? categoryid;
    String? functionalname;
    int? v;

    Area({
        this.id,
        this.industryid,
        this.categoryid,
        this.functionalname,
        this.v,
    });

    factory Area.fromJson(Map<String, dynamic> json) => Area(
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
class Salaray {
    MaxSalaryClass? minSalary;
    MaxSalaryClass? maxSalary;

    Salaray({
        this.minSalary,
        this.maxSalary,
    });

    factory Salaray.fromJson(Map<String, dynamic> json) => Salaray(
        minSalary: json["min_salary"] == null ? null : MaxSalaryClass.fromJson(json["min_salary"]),
        maxSalary: json["max_salary"] == null ? null : MaxSalaryClass.fromJson(json["max_salary"]),
    );

    Map<String, dynamic> toJson() => {
        "min_salary": minSalary!.toJson(),
        "max_salary": maxSalary!.toJson(),
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
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

class Education {
    String? id;
    String? institutename;
    Experiencedlevel? digree;
    Subject? subject;
    int? type;
    String? grade;
    String? gradetype;
    String? division;
    DateTime? startdate;
    DateTime? enddate;
    String? otheractivity;
    String? userid;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Education({
        this.id,
        this.institutename,
        this.digree,
        this.subject,
        this.type,
        this.grade,
        this.gradetype,
        this.division,
        this.startdate,
        this.enddate,
        this.otheractivity,
        this.userid,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["_id"],
        institutename: json["institutename"],
        digree: json["digree"] == null ? null : Experiencedlevel.fromJson(json["digree"]),
        subject: json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        type: json["type"],
        grade: json["grade"],
        gradetype: json["gradetype"],
        division: json["division"],
        startdate: json["startdate"] == null ? null : DateTime.parse(json["startdate"]),
        enddate: json["enddate"] == null ? null : DateTime.parse(json["enddate"]),
        otheractivity: json["otheractivity"],
        userid: json["userid"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "institutename": institutename,
        "digree": digree?.toJson(),
        "subject": subject?.toJson(),
        "type": type,
        "grade": grade,
        "gradetype": gradetype,
        "division": division,
        "startdate": startdate?.toIso8601String(),
        "enddate": enddate?.toIso8601String(),
        "otheractivity": otheractivity,
        "userid": userid,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Experiencedlevel {
    String? id;
    String? name;
    Experiencedlevel? education;
    int? v;

    Experiencedlevel({
        this.id,
        this.name,
        this.education,
        this.v,
    });

    factory Experiencedlevel.fromJson(Map<String, dynamic> json) => Experiencedlevel(
        id: json["_id"],
        name: json["name"],
        education: json["education"] == null ? null : Experiencedlevel.fromJson(json["education"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "education": education?.toJson(),
        "__v": v,
    };
}

class Userid {
    Other? other;
    String? id;
    String? number;
    String? secoundnumber;
    String? fastname;
    String? lastname;
    String? gender;
    Experiencedlevel? experiencedlevel;
    DateTime? startedworking;
    DateTime? deatofbirth;
    String? email;
    String? image;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Userid({
        this.other,
        this.id,
        this.number,
        this.secoundnumber,
        this.fastname,
        this.lastname,
        this.gender,
        this.experiencedlevel,
        this.startedworking,
        this.deatofbirth,
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
        secoundnumber: json["secoundnumber"],
        fastname: json["fastname"],
        lastname: json["lastname"],
        gender: json["gender"],
        experiencedlevel: json["experiencedlevel"] == null ? null : Experiencedlevel.fromJson(json["experiencedlevel"]),
        startedworking: json["startedworking"] == null ? null : DateTime.parse(json["startedworking"]),
        deatofbirth: json["deatofbirth"] == null ? null : DateTime.parse(json["deatofbirth"]),
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
        "secoundnumber": secoundnumber,
        "fastname": fastname,
        "lastname": lastname,
        "gender": gender,
        "experiencedlevel": experiencedlevel?.toJson(),
        "startedworking": startedworking?.toIso8601String(),
        "deatofbirth": deatofbirth?.toIso8601String(),
        "email": email,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Other {
    Notification? notification;
    int? viewjob;
    int? cvsend;
    int? totalchat;
    int? savejob;
    int? carearpre;
    int? totalStep;
    int? incomplete;
    int? complete;
    dynamic jobHunting;
    dynamic moreStatus;
    bool? jobRightNow;
    String? pushnotification;
    bool? online;
    int? offlinedate;
    String? fullProfile;
    String? lastfunctionalarea;

    Other({
        this.notification,
        this.viewjob,
        this.cvsend,
        this.totalchat,
        this.savejob,
        this.carearpre,
        this.totalStep,
        this.incomplete,
        this.complete,
        this.jobHunting,
        this.moreStatus,
        this.jobRightNow,
        this.pushnotification,
        this.online,
        this.offlinedate,
        this.fullProfile,
        this.lastfunctionalarea,
    });

    factory Other.fromJson(Map<String, dynamic> json) => Other(
        notification: json["notification"] == null ? null : Notification.fromJson(json["notification"]),
        viewjob: json["viewjob"],
        cvsend: json["cvsend"],
        totalchat: json["totalchat"],
        savejob: json["savejob"],
        carearpre: json["carearpre"],
        totalStep: json["total_step"],
        incomplete: json["incomplete"],
        complete: json["complete"],
        jobHunting: json["job_hunting"],
        moreStatus: json["more_status"],
        jobRightNow: json["job_right_now"],
        pushnotification: json["pushnotification"],
        online: json["online"],
        offlinedate: json["offlinedate"],
        fullProfile: json["full_profile"],
        lastfunctionalarea: json["lastfunctionalarea"],
    );

    Map<String, dynamic> toJson() => {
        "notification": notification?.toJson(),
        "viewjob": viewjob,
        "cvsend": cvsend,
        "totalchat": totalchat,
        "savejob": savejob,
        "carearpre": carearpre,
        "total_step": totalStep,
        "incomplete": incomplete,
        "complete": complete,
        "job_hunting": jobHunting,
        "more_status": moreStatus,
        "job_right_now": jobRightNow,
        "pushnotification": pushnotification,
        "online": online,
        "offlinedate": offlinedate,
        "full_profile": fullProfile,
        "lastfunctionalarea": lastfunctionalarea,
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

class Workexperience {
    String? id;
    String? companyname;
    Category? category;
    DateTime? startdate;
    DateTime? enddate;
    Area? expertisearea;
    String? designation;
    String? department;
    String? dutiesandresponsibilities;
    String? careermilestones;
    bool? workintern;
    bool? hidedetails;
    String? userid;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Workexperience({
        this.id,
        this.companyname,
        this.category,
        this.startdate,
        this.enddate,
        this.expertisearea,
        this.designation,
        this.department,
        this.dutiesandresponsibilities,
        this.careermilestones,
        this.workintern,
        this.hidedetails,
        this.userid,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Workexperience.fromJson(Map<String, dynamic> json) => Workexperience(
        id: json["_id"],
        companyname: json["companyname"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        startdate: json["startdate"] == null ? null : DateTime.parse(json["startdate"]),
        enddate: json["enddate"] == null ? null : DateTime.parse(json["enddate"]),
        expertisearea: json["expertisearea"] == null ? null : Area.fromJson(json["expertisearea"]),
        designation: json["designation"],
        department: json["department"],
        dutiesandresponsibilities: json["dutiesandresponsibilities"],
        careermilestones: json["careermilestones"],
        workintern: json["workintern"],
        hidedetails: json["hidedetails"],
        userid: json["userid"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "companyname": companyname,
        "category": category?.toJson(),
        "startdate": startdate?.toIso8601String(),
        "enddate": enddate?.toIso8601String(),
        "expertisearea": expertisearea?.toJson(),
        "designation": designation,
        "department": department,
        "dutiesandresponsibilities": dutiesandresponsibilities,
        "careermilestones": careermilestones,
        "workintern": workintern,
        "hidedetails": hidedetails,
        "userid": userid,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

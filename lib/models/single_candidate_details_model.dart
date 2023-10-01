

import 'dart:convert';

SingleCandidateDetailsModel singleCandidateDetailsModelFromJson(String str) => SingleCandidateDetailsModel.fromJson(json.decode(str));

String singleCandidateDetailsModelToJson(SingleCandidateDetailsModel data) => json.encode(data.toJson());

class SingleCandidateDetailsModel {
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

    SingleCandidateDetailsModel({
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

    factory SingleCandidateDetailsModel.fromJson(Map<String, dynamic> json) => SingleCandidateDetailsModel(
        id: json["_id"],
        userid: json["userid"] == null ? null : Userid.fromJson(json["userid"]),
        workexperience: json["workexperience"] == null ? [] :  List<Workexperience>.from(json["workexperience"].map((x) => Workexperience.fromJson(x))),
        education: json["education"] == null ? [] : List<Education>.from(json["education"].map((x) => Education.fromJson(x))),
        skill: json["skill"] == null ? [] : List<String>.from(json["skill"].map((x) => x)),
        protfoliolink: json["protfoliolink"] == null ? [] : List<About>.from(json["protfoliolink"].map((x) => About.fromJson(x))),
        careerPreference: json["careerPreference"] == null ? [] : List<CareerPreference>.from(json["careerPreference"].map((x) => CareerPreference.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        about: json["about"] == null ? null : About.fromJson(json["about"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid!.toJson(),
        "workexperience": List<dynamic>.from(workexperience!.map((x) => x.toJson())),
        "education": List<dynamic>.from(education!.map((x) => x.toJson())),
        "skill": List<String>.from(skill!.map((x) => x)),
        "protfoliolink": List<dynamic>.from(protfoliolink!.map((x) => x.toJson())),
        "careerPreference": List<dynamic>.from(careerPreference!.map((x) => x.toJson())),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "about": about!.toJson(),
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
    String? skill;

    About({
        this.id,
        this.about,
        this.userid,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.protfoliolink,
        this.skill,
    });

    factory About.fromJson(Map<String, dynamic> json) => About(
        id: json["_id"],
        about: json["about"],
        userid: json["userid"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        protfoliolink: json["protfoliolink"],
        skill: json["skill"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "about": about,
        "userid": userid,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "protfoliolink": protfoliolink,
        "skill": skill,
    };
}

class CareerPreference {
    Salaray? salaray;
    String? id;
    String? userid;
    List<Category>? category;
    Area? functionalarea;
    Division? division;
    Jobtype? jobtype;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    CareerPreference({
        this.salaray,
        this.id,
        this.userid,
        this.category,
        this.functionalarea,
        this.division,
        this.jobtype,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory CareerPreference.fromJson(Map<String, dynamic> json) => CareerPreference(
        salaray: json["salaray"] == null ? null : Salaray.fromJson(json["salaray"]),
        id: json["_id"],
        userid: json["userid"],
        category: json["category"] == null ? [] : List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
        functionalarea: json["functionalarea"] == null ? null : Area.fromJson(json["functionalarea"]),
        division: json["division"] == null ? null : Division.fromJson(json["division"]),
        jobtype: json["jobtype"] == null ? null : Jobtype.fromJson(json["jobtype"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "salaray": salaray!.toJson(),
        "_id": id,
        "userid": userid,
        "category": List<dynamic>.from(category!.map((x) => x.toJson())),
        "functionalarea": functionalarea!.toJson(),
        "division": division!.toJson(),
        "jobtype": jobtype!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

class Category {
    String? id;
    Industryid? industryid;
    String? categoryname;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Category({
        this.id,
        this.industryid,
        this.categoryname,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        industryid: industryidValues.map[json["industryid"]],
        categoryname: json["categoryname"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryid": industryidValues.reverse[industryid],
        "categoryname": categoryname,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

enum Industryid {
    THE_64_B24606_A563_D62_E10_FBFB2_E
}

final industryidValues = EnumValues({
    "64b24606a563d62e10fbfb2e": Industryid.THE_64_B24606_A563_D62_E10_FBFB2_E
});

class Division {
    String? id;
    String? divisionname;
    Experiencedlevel? cityid;
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
        cityid: json["cityid"] == null ? null : Experiencedlevel.fromJson(json["cityid"]),
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

class Experiencedlevel {
    String? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    Experiencedlevel? education;
    List<String>? digree;

    Experiencedlevel({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.education,
        this.digree,
    });

    factory Experiencedlevel.fromJson(Map<String, dynamic> json) => Experiencedlevel(
        id: json["_id"],
        name: json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        education: json["education"] == null ? null : Experiencedlevel.fromJson(json["education"]),
        digree: json["digree"] == null ? [] : List<String>.from(json["digree"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "education": education!.toJson(),
        "digree": List<dynamic>.from(digree!.map((x) => x)),
    };
}

class Area {
    String? id;
    String? industryid;
    String? categoryid;
    String? functionalname;
    int? v;
    DateTime? updatedAt;

    Area({
        this.id,
        this.industryid,
        this.categoryid,
        this.functionalname,
        this.v,
        this.updatedAt,
    });

    factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["_id"],
        industryid: json["industryid"],
        categoryid: json["categoryid"],
        functionalname: json["functionalname"],
        v: json["__v"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryid": industryid,
        "categoryid": categoryid,
        "functionalname": functionalname,
        "__v": v,
        "updatedAt": updatedAt!.toIso8601String(),
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
    Salary? minSalary;
    Salary? maxSalary;

    Salaray({
        this.minSalary,
        this.maxSalary,
    });

    factory Salaray.fromJson(Map<String, dynamic> json) => Salaray(
        minSalary: json["min_salary"] == null ? null : Salary.fromJson(json["min_salary"]),
        maxSalary: json["max_salary"] == null ? null : Salary.fromJson(json["max_salary"]),
    );

    Map<String, dynamic> toJson() => {
        "min_salary": minSalary!.toJson(),
        "max_salary": maxSalary!.toJson(),
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
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

class Education {
    String? id;
    String? institutename;
    Experiencedlevel? digree;
    Experiencedlevel? subject;
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
        subject: json["subject"] == null ? null : Experiencedlevel.fromJson(json["subject"]),
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
        "digree": digree!.toJson(),
        "subject": subject!.toJson(),
        "type": type,
        "grade": grade,
        "gradetype": gradetype,
        "division": division,
        "startdate": startdate!.toIso8601String(),
        "enddate": enddate!.toIso8601String(),
        "otheractivity": otheractivity,
        "userid": userid,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
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
        "other": other!.toJson(),
        "_id": id,
        "number": number,
        "secoundnumber": secoundnumber,
        "fastname": fastname,
        "lastname": lastname,
        "gender": gender,
        "experiencedlevel": experiencedlevel!.toJson(),
        "startedworking": startedworking!.toIso8601String(),
        "deatofbirth": deatofbirth!.toIso8601String(),
        "email": email,
        "image": image,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
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
    bool? online;
    String? fullProfile;
    String? jobHunting;
    String? moreStatus;
    bool? jobRightNow;
    String? pushnotification;
    int? offlinedate;
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
        this.online,
        this.fullProfile,
        this.jobHunting,
        this.moreStatus,
        this.jobRightNow,
        this.pushnotification,
        this.offlinedate,
        this.lastfunctionalarea,
    });

    factory Other.fromJson(Map<String, dynamic> json) => Other(
        notification: Notification.fromJson(json["notification"]),
        viewjob: json["viewjob"],
        cvsend: json["cvsend"],
        totalchat: json["totalchat"],
        savejob: json["savejob"],
        carearpre: json["carearpre"],
        totalStep: json["total_step"],
        incomplete: json["incomplete"],
        complete: json["complete"],
        online: json["online"],
        fullProfile: json["full_profile"],
        jobHunting: json["job_hunting"],
        moreStatus: json["more_status"],
        jobRightNow: json["job_right_now"],
        pushnotification: json["pushnotification"],
        offlinedate: json["offlinedate"],
        lastfunctionalarea: json["lastfunctionalarea"],
    );

    Map<String, dynamic> toJson() => {
        "notification": notification!.toJson(),
        "viewjob": viewjob,
        "cvsend": cvsend,
        "totalchat": totalchat,
        "savejob": savejob,
        "carearpre": carearpre,
        "total_step": totalStep,
        "incomplete": incomplete,
        "complete": complete,
        "online": online,
        "full_profile": fullProfile,
        "job_hunting": jobHunting,
        "more_status": moreStatus,
        "job_right_now": jobRightNow,
        "pushnotification": pushnotification,
        "offlinedate": offlinedate,
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
        "category": category!.toJson(),
        "startdate": startdate!.toIso8601String(),
        "enddate": enddate!.toIso8601String(),
        "expertisearea": expertisearea!.toJson(),
        "designation": designation,
        "department": department,
        "dutiesandresponsibilities": dutiesandresponsibilities,
        "careermilestones": careermilestones,
        "workintern": workintern,
        "hidedetails": hidedetails,
        "userid": userid,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

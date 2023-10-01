// To parse this JSON data, do
//
//     final candidateProfileModel = candidateProfileModelFromJson(jsonString);

import 'dart:convert';

CandidateProfileModel candidateProfileModelFromJson(String str) => CandidateProfileModel.fromJson(json.decode(str));

String candidateProfileModelToJson(CandidateProfileModel data) => json.encode(data.toJson());

class CandidateProfileModel {
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

    CandidateProfileModel({
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

    factory CandidateProfileModel.fromJson(Map<String, dynamic> json) => CandidateProfileModel(
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

class Experiencedlevel {
    String? id;
    String? name;
    int? v;

    Experiencedlevel({
        this.id,
        this.name,
        this.v,
    });

    factory Experiencedlevel.fromJson(Map<String, dynamic> json) => Experiencedlevel(
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

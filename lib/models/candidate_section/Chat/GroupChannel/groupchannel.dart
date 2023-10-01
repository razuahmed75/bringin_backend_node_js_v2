// To parse this JSON data, do
//
//     final groupchannel = groupchannelFromJson(jsonString);

import 'dart:convert';

Groupchannel groupchannelFromJson(String str) => Groupchannel.fromJson(json.decode(str));

String groupchannelToJson(Groupchannel data) => json.encode(data.toJson());

class Groupchannel {
    DateTime? date;
    Lastmessage? lastmessage;
    Map<String, bool>? block;
    bool? seen;
    List<Userinfo>? userinfo;
    String? channelid;
    List<int>? users;

    Groupchannel({
        this.date,
        this.lastmessage,
        this.block,
        this.seen,
        this.userinfo,
        this.channelid,
        this.users,
    });

    factory Groupchannel.fromJson(Map<String, dynamic> json) => Groupchannel(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        lastmessage: json["lastmessage"] == null ? null : Lastmessage.fromJson(json["lastmessage"]),
        block: Map.from(json["block"]!).map((k, v) => MapEntry<String, bool>(k, v)),
        seen: json["seen"],
        userinfo: json["userinfo"] == null ? [] : List<Userinfo>.from(json["userinfo"]!.map((x) => Userinfo.fromJson(x))),
        channelid: json["channelid"],
        users: json["users"] == null ? [] : List<int>.from(json["users"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "lastmessage": lastmessage?.toJson(),
        "block": Map.from(block!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "seen": seen,
        "userinfo": userinfo == null ? [] : List<dynamic>.from(userinfo!.map((x) => x.toJson())),
        "channelid": channelid,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x)),
    };
}

class Lastmessage {
    DateTime? createdAt;
    List<Media>? medias;
    List<dynamic>? quickReplies;
    LastmessageCustomProperties? customProperties;
    List<dynamic>? mentions;
    dynamic replyTo;
    String? text;
    User? user;
    String? status;

    Lastmessage({
        this.createdAt,
        this.medias,
        this.quickReplies,
        this.customProperties,
        this.mentions,
        this.replyTo,
        this.text,
        this.user,
        this.status,
    });

    factory Lastmessage.fromJson(Map<String, dynamic> json) => Lastmessage(
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        medias: json["medias"] == null ? [] : List<Media>.from(json["medias"]!.map((x) => Media.fromJson(x))),
        quickReplies: json["quickReplies"] == null ? [] : List<dynamic>.from(json["quickReplies"]!.map((x) => x)),
        customProperties: json["customProperties"] == null ? null : LastmessageCustomProperties.fromJson(json["customProperties"]),
        mentions: json["mentions"] == null ? [] : List<dynamic>.from(json["mentions"]!.map((x) => x)),
        replyTo: json["replyTo"],
        text: json["text"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "medias": medias == null ? [] : List<dynamic>.from(medias!.map((x) => x.toJson())),
        "quickReplies": quickReplies == null ? [] : List<dynamic>.from(quickReplies!.map((x) => x)),
        "customProperties": customProperties?.toJson(),
        "mentions": mentions == null ? [] : List<dynamic>.from(mentions!.map((x) => x)),
        "replyTo": replyTo,
        "text": text,
        "user": user?.toJson(),
        "status": status,
    };
}

class LastmessageCustomProperties {
    int? type;
    bool? seen;

    LastmessageCustomProperties({
        this.type,
        this.seen,
    });

    factory LastmessageCustomProperties.fromJson(Map<String, dynamic> json) => LastmessageCustomProperties(
        type: json["type"],
        seen: json["seen"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "seen": seen,
    };
}

class Media {
    String? fileName;
    dynamic customProperties;
    String? type;
    DateTime? uploadedDate;
    String? url;
    bool? isUploading;

    Media({
        this.fileName,
        this.customProperties,
        this.type,
        this.uploadedDate,
        this.url,
        this.isUploading,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        fileName: json["fileName"],
        customProperties: json["customProperties"],
        type: json["type"],
        uploadedDate: json["uploadedDate"] == null ? null : DateTime.parse(json["uploadedDate"]),
        url: json["url"],
        isUploading: json["isUploading"],
    );

    Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "customProperties": customProperties,
        "type": type,
        "uploadedDate": uploadedDate?.toIso8601String(),
        "url": url,
        "isUploading": isUploading,
    };
}

class User {
    String? firstName;
    String? lastName;
    UserCustomProperties? customProperties;
    String? profileImage;
    String? id;

    User({
        this.firstName,
        this.lastName,
        this.customProperties,
        this.profileImage,
        this.id,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        customProperties: json["customProperties"] == null ? null : UserCustomProperties.fromJson(json["customProperties"]),
        profileImage: json["profileImage"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "customProperties": customProperties?.toJson(),
        "profileImage": profileImage,
        "id": id,
    };
}

class UserCustomProperties {
    String? phone;
    String? email;

    UserCustomProperties({
        this.phone,
        this.email,
    });

    factory UserCustomProperties.fromJson(Map<String, dynamic> json) => UserCustomProperties(
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "email": email,
    };
}

class Userinfo {
    String? firstname;
    String? gender;
    String? lastName;
    String? photo;
    String? recruiterId;
    String? experience;
    DateTime? startedWorking;
    String? lastname;
    String? phone;
    DateTime? dob;
    String? companyName;
    int? id;
    String? designation;
    String? email;
    dynamic status;

    Userinfo({
        this.firstname,
        this.gender,
        this.lastName,
        this.photo,
        this.recruiterId,
        this.experience,
        this.startedWorking,
        this.lastname,
        this.phone,
        this.dob,
        this.companyName,
        this.id,
        this.designation,
        this.email,
        this.status,
    });

    factory Userinfo.fromJson(Map<String, dynamic> json) => Userinfo(
        firstname: json["firstname"],
        gender: json["gender"],
        lastName: json["last_name"],
        photo: json["photo"],
        recruiterId: json["recruiter_id"],
        experience: json["experience"],
        startedWorking: json["started_working"] == null ? null : DateTime.parse(json["started_working"]),
        lastname: json["lastname"],
        phone: json["phone"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        companyName: json["company_name"],
        id: json["id"],
        designation: json["designation"],
        email: json["email"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "gender": gender,
        "last_name": lastName,
        "photo": photo,
        "recruiter_id": recruiterId,
        "experience": experience,
        "started_working": startedWorking?.toIso8601String(),
        "lastname": lastname,
        "phone": phone,
        "dob": dob?.toIso8601String(),
        "company_name": companyName,
        "id": id,
        "designation": designation,
        "email": email,
        "status": status,
    };
}

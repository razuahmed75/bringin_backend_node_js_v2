// To parse this JSON data, do
//
//     final bringAssestesmsg = bringAssestesmsgFromJson(jsonString);

import 'dart:convert';

List<BringAssestesmsg> bringAssestesmsgFromJson(String str) => List<BringAssestesmsg>.from(json.decode(str).map((x) => BringAssestesmsg.fromJson(x)));

String bringAssestesmsgToJson(List<BringAssestesmsg> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BringAssestesmsg {
    String? id;
    String? channel;
    Message? message;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    BringAssestesmsg({
        this.id,
        this.channel,
        this.message,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory BringAssestesmsg.fromJson(Map<String, dynamic> json) => BringAssestesmsg(
        id: json["_id"],
        channel: json["channel"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "channel": channel,
        "message": message?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Message {
    User? user;
    int? createdAt;
    String? text;
    dynamic medias;
    dynamic quickReplies;
    MessageCustomProperties? customProperties;
    dynamic mentions;
    dynamic status;
    dynamic replyTo;

    Message({
        this.user,
        this.createdAt,
        this.text,
        this.medias,
        this.quickReplies,
        this.customProperties,
        this.mentions,
        this.status,
        this.replyTo,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        createdAt: json["createdAt"],
        text: json["text"],
        medias: json["medias"],
        quickReplies: json["quickReplies"],
        customProperties: json["customProperties"] == null ? null : MessageCustomProperties.fromJson(json["customProperties"]),
        mentions: json["mentions"],
        status: json["status"],
        replyTo: json["replyTo"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "createdAt": createdAt,
        "text": text,
        "medias": medias,
        "quickReplies": quickReplies,
        "customProperties": customProperties?.toJson(),
        "mentions": mentions,
        "status": status,
        "replyTo": replyTo,
    };
}

class MessageCustomProperties {
    String? dsvsdv;

    MessageCustomProperties({
        this.dsvsdv,
    });

    factory MessageCustomProperties.fromJson(Map<String, dynamic> json) => MessageCustomProperties(
        dsvsdv: json["dsvsdv"],
    );

    Map<String, dynamic> toJson() => {
        "dsvsdv": dsvsdv,
    };
}

class User {
    int? id;
    String? profileImage;
    String? firstName;
    String? lastName;
    UserCustomProperties? customProperties;

    User({
        this.id,
        this.profileImage,
        this.firstName,
        this.lastName,
        this.customProperties,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        profileImage: json["profileImage"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        customProperties: json["customProperties"] == null ? null : UserCustomProperties.fromJson(json["customProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "profileImage": profileImage,
        "firstName": firstName,
        "lastName": lastName,
        "customProperties": customProperties?.toJson(),
    };
}

class UserCustomProperties {
    String? sdvsd;

    UserCustomProperties({
        this.sdvsd,
    });

    factory UserCustomProperties.fromJson(Map<String, dynamic> json) => UserCustomProperties(
        sdvsd: json["sdvsd"],
    );

    Map<String, dynamic> toJson() => {
        "sdvsd": sdvsd,
    };
}

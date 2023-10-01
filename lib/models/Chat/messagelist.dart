// To parse this JSON data, do
//
//     final messagelist = messagelistFromJson(jsonString);

import 'dart:convert';

List<Messagelist> messagelistFromJson(String str) => List<Messagelist>.from(json.decode(str).map((x) => Messagelist.fromJson(x)));

String messagelistToJson(List<Messagelist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Messagelist {
    String? id;
    String? channel;
    Message? message;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Messagelist({
        this.id,
        this.channel,
        this.message,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Messagelist.fromJson(Map<String, dynamic> json) => Messagelist(
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
    DateTime? createdAt;
    String? text;
    dynamic medias;
    dynamic quickReplies;
    dynamic customProperties;
    dynamic mentions;
    String? status;
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
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        text: json["text"],
        medias: json["medias"],
        quickReplies: json["quickReplies"],
        customProperties: json["customProperties"],
        mentions: json["mentions"],
        status: json["status"],
        replyTo: json["replyTo"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "text": text,
        "medias": medias,
        "quickReplies": quickReplies,
        "customProperties": customProperties,
        "mentions": mentions,
        "status": status,
        "replyTo": replyTo,
    };
}

class User {
    String? id;
    dynamic profileImage;
    dynamic firstName;
    dynamic lastName;
    dynamic customProperties;

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
        customProperties: json["customProperties"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "profileImage": profileImage,
        "firstName": firstName,
        "lastName": lastName,
        "customProperties": customProperties,
    };
}

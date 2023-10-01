// To parse this JSON data, do
//
//     final channelInfo = channelInfoFromJson(jsonString);

import 'dart:convert';

import '../candidate_section/CandidateList/candidatelist_model.dart';

List<ChannelInfo> channelInfoFromJson(String str) => List<ChannelInfo>.from(
    json.decode(str).map((x) => ChannelInfo.fromJson(x)));

String channelInfoToJson(List<ChannelInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChannelInfo {
  DateTime? recruitermsgdate;
  String? id;
  int? type;
  bool? recruiterReject;
  int? greating;
  Seekerid? seekerid;
  Recruiterid? recruiterid;
  NotInterest? notInterest;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  Jobid? jobid;
  Candidatelist? candidateFullprofile;
  Lastmessage? lastmessage;
  bool? recruiterblock;
  bool? outbound;
  bool? seekerblock;
  int? recruiterUnseen;
  int? seekerUnseen;
  WhoViewMe? whoViewMe;
  BringAssis? bringAssis;

  ChannelInfo({
    this.recruitermsgdate,
    this.whoViewMe,
    this.greating,
    this.recruiterReject,
    this.id,
    this.type,
    this.seekerid,
    this.notInterest,
    this.recruiterid,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lastmessage,
    this.jobid,
    this.outbound,
    this.candidateFullprofile,
    this.recruiterblock,
    this.seekerblock,
    this.recruiterUnseen,
    this.seekerUnseen,
    this.bringAssis,
  });

  factory ChannelInfo.fromJson(Map<String, dynamic> json) => ChannelInfo(
        whoViewMe: json["who_view_me"] == null
            ? null
            : WhoViewMe.fromJson(json["who_view_me"]),
        recruitermsgdate: json["recruitermsgdate"] == null
            ? null
            : DateTime.parse(json["recruitermsgdate"]),
        id: json["_id"],
        recruiterReject: json["recruiter_reject"],
        notInterest: json["not_interest"] == null
            ? null
            : NotInterest.fromJson(json["not_interest"]),
        type: json["type"],
        greating: json["greating"],
        seekerid: json["seekerid"] == null
            ? null
            : Seekerid.fromJson(json["seekerid"]),
        recruiterid: json["recruiterid"] == null
            ? null
            : Recruiterid.fromJson(json["recruiterid"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        lastmessage: json["lastmessage"] == null
            ? null
            : Lastmessage.fromJson(json["lastmessage"]),
        jobid: json["jobid"] == null ? null : Jobid.fromJson(json["jobid"]),
        recruiterblock: json["recruiterblock"],
        outbound: json["outbound"],
        candidateFullprofile: json["candidate_fullprofile"] == null
            ? null
            : Candidatelist.fromJson(json["candidate_fullprofile"]),
        seekerblock: json["seekerblock"],
        recruiterUnseen: json["recruiter_unseen"],
        seekerUnseen: json["seeker_unseen"],
        bringAssis: json["bring_assis"] == null
            ? null
            : BringAssis.fromJson(json["bring_assis"]),
      );

  Map<String, dynamic> toJson() => {
        "recruitermsgdate": recruitermsgdate?.toIso8601String(),
        "who_view_me": whoViewMe?.toJson(),
        "_id": id,
        "recruiter_reject": recruiterReject,
        "not_interest": notInterest?.toJson(),
        "type": type,
        "greating": greating,
        "seekerid": seekerid?.toJson(),
        "recruiterid": recruiterid?.toJson(),
        "date": date?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "jobid": jobid?.toJson(),
        "lastmessage": lastmessage?.toJson(),
        "recruiterblock": recruiterblock,
        "outbound": outbound,
        "seekerblock": seekerblock,
        "candidate_fullprofile": candidateFullprofile?.toJson(),
        "recruiter_unseen": recruiterUnseen,
        "seeker_unseen": seekerUnseen,
        "bring_assis": bringAssis?.toJson(),
      };
}

class Lastmessage {
  String? id;
  String? channel;
  Message? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Lastmessage({
    this.id,
    this.channel,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Lastmessage.fromJson(Map<String, dynamic> json) => Lastmessage(
        id: json["_id"],
        channel: json["channel"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
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
  List<Media>? medias;
  dynamic quickReplies;
  MessageCustomProperties? customProperties;
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
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        text: json["text"],
        medias: json["medias"] == null
            ? []
            : List<Media>.from(json["medias"]!.map((x) => Media.fromJson(x))),
        quickReplies: json["quickReplies"],
        customProperties: json["customProperties"] == null
            ? null
            : MessageCustomProperties.fromJson(json["customProperties"]),
        mentions: json["mentions"],
        status: json["status"],
        replyTo: json["replyTo"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "text": text,
        "medias": medias == null
            ? []
            : List<dynamic>.from(medias!.map((x) => x.toJson())),
        "quickReplies": quickReplies,
        "customProperties": customProperties?.toJson(),
        "mentions": mentions,
        "status": status,
        "replyTo": replyTo,
      };
}

class MessageCustomProperties {
  int? type;
  bool? seen;
  bool? reaply;
  dynamic reaplymsg;
  String? messageid;

  MessageCustomProperties({
    this.type,
    this.seen,
    this.reaply,
    this.reaplymsg,
    this.messageid,
  });

  factory MessageCustomProperties.fromJson(Map<String, dynamic> json) =>
      MessageCustomProperties(
        type: json["type"],
        seen: json["seen"],
        reaply: json["reaply"],
        reaplymsg: json["reaplymsg"],
        messageid: json["messageid"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "seen": seen,
        "reaply": reaply,
        "reaplymsg": reaplymsg,
        "messageid": messageid,
      };
}

class Media {
  String? url;
  String? type;
  String? fileName;
  bool? isUploading;
  DateTime? uploadedDate;
  MediaCustomProperties? customProperties;

  Media({
    this.url,
    this.type,
    this.fileName,
    this.isUploading,
    this.uploadedDate,
    this.customProperties,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        url: json["url"],
        type: json["type"],
        fileName: json["fileName"],
        isUploading: json["isUploading"],
        uploadedDate: json["uploadedDate"] == null
            ? null
            : DateTime.parse(json["uploadedDate"]),
        customProperties: json["customProperties"] == null
            ? null
            : MediaCustomProperties.fromJson(json["customProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
        "fileName": fileName,
        "isUploading": isUploading,
        "uploadedDate": uploadedDate?.toIso8601String(),
        "customProperties": customProperties?.toJson(),
      };
}

class MediaCustomProperties {
  String? data;

  MediaCustomProperties({
    this.data,
  });

  factory MediaCustomProperties.fromJson(Map<String, dynamic> json) =>
      MediaCustomProperties(
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}

class User {
  String? id;
  String? profileImage;
  String? firstName;
  String? lastName;
  MediaCustomProperties? customProperties;

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
        customProperties: json["customProperties"] == null
            ? null
            : MediaCustomProperties.fromJson(json["customProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profileImage": profileImage,
        "firstName": firstName,
        "lastName": lastName,
        "customProperties": customProperties?.toJson(),
      };
}

class Recruiterid {
  Other? other;
  String? id;
  String? number;
  String? firstname;
  String? lastname;
  Companyname? companyname;
  String? designation;
  String? email;
  String? image;

  Recruiterid({
    this.other,
    this.id,
    this.number,
    this.firstname,
    this.lastname,
    this.companyname,
    this.designation,
    this.email,
    this.image,
  });

  factory Recruiterid.fromJson(Map<String, dynamic> json) => Recruiterid(
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

class Seekerid {
  Other? other;
  String? id;
  String? number;
  String? secoundnumber;
  String? fastname;
  String? lastname;
  String? email;
  String? image;

  Seekerid({
    this.other,
    this.id,
    this.number,
    this.secoundnumber,
    this.fastname,
    this.lastname,
    this.email,
    this.image,
  });

  factory Seekerid.fromJson(Map<String, dynamic> json) => Seekerid(
        other: json["other"] == null ? null : Other.fromJson(json["other"]),
        id: json["_id"],
        number: json["number"],
        secoundnumber: json["secoundnumber"],
        fastname: json["fastname"],
        lastname: json["lastname"],
        email: json["email"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "other": other?.toJson(),
        "_id": id,
        "number": number,
        "secoundnumber": secoundnumber,
        "fastname": fastname,
        "lastname": lastname,
        "email": email,
        "image": image,
      };
}

class Other {
  int? offlinedate;
  bool? premium;
  bool? online;
  String? pushnotification;
  Lastfunctionalarea? lastfunctionalarea;
  int? totaljob;

  Other({
    this.offlinedate,
    this.premium,
    this.online,
    this.pushnotification,
    this.lastfunctionalarea,
    this.totaljob,
  });

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        offlinedate: json["offlinedate"],
        premium: json["premium"],
        online: json["online"],
        totaljob: json['totaljob'] == null ? 0 : json['totaljob'],
        pushnotification: json["pushnotification"],
        lastfunctionalarea: json["lastfunctionalarea"] == null
            ? null
            : Lastfunctionalarea.fromJson(json["lastfunctionalarea"]),
      );

  Map<String, dynamic> toJson() => {
        "offlinedate": offlinedate,
        "premium": premium,
        "online": online,
        "pushnotification": pushnotification,
        "lastfunctionalarea": lastfunctionalarea?.toJson(),
        "totaljob": totaljob
      };
}

class Lastfunctionalarea {
  String? id;
  String? industryid;
  String? categoryid;
  String? functionalname;
  int? v;
  DateTime? updatedAt;

  Lastfunctionalarea({
    this.id,
    this.industryid,
    this.categoryid,
    this.functionalname,
    this.v,
    this.updatedAt,
  });

  factory Lastfunctionalarea.fromJson(Map<String, dynamic> json) =>
      Lastfunctionalarea(
        id: json["_id"],
        industryid: json["industryid"],
        categoryid: json["categoryid"],
        functionalname: json["functionalname"],
        v: json["__v"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "industryid": industryid,
        "categoryid": categoryid,
        "functionalname": functionalname,
        "__v": v,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class BringAssis {
  String? title;
  String? message1;
  String? message2;
  Bringlastmessage? bringlastmessage;

  BringAssis({
    this.title,
    this.message1,
    this.message2,
    this.bringlastmessage,
  });

  factory BringAssis.fromJson(Map<String, dynamic> json) => BringAssis(
        title: json["title"],
        message1: json["message1"],
        message2: json["message2"],
        bringlastmessage: json["bringlastmessage"] == null
            ? null
            : Bringlastmessage.fromJson(json["bringlastmessage"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message1": message1,
        "message2": message2,
        "bringlastmessage": bringlastmessage?.toJson(),
      };
}

class Bringlastmessage {
  String? id;
  String? channel;
  BringlastmessageMessage? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Bringlastmessage({
    this.id,
    this.channel,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Bringlastmessage.fromJson(Map<String, dynamic> json) =>
      Bringlastmessage(
        id: json["_id"],
        channel: json["channel"],
        message: json["message"] == null
            ? null
            : BringlastmessageMessage.fromJson(json["message"]),
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
        "channel": channel,
        "message": message?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class BringlastmessageMessage {
  int? createdAt;
  String? text;

  BringlastmessageMessage({
    this.createdAt,
    this.text,
  });

  factory BringlastmessageMessage.fromJson(Map<String, dynamic> json) =>
      BringlastmessageMessage(
        createdAt: json["createdAt"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "text": text,
      };
}

class WhoViewMe {
  String? title;
  int? totalview;
  int? newview;
  Seekerviewid? seekerviewid;
  Recruiterview? recruiterview;

  WhoViewMe({
    this.title,
    this.totalview,
    this.newview,
    this.seekerviewid,
    this.recruiterview,
  });

  factory WhoViewMe.fromJson(Map<String, dynamic> json) => WhoViewMe(
        title: json["title"],
        totalview: json["totalview"],
        newview: json["newview"],
        seekerviewid: json["seekerviewid"] == null
            ? null
            : Seekerviewid.fromJson(json["seekerviewid"]),
        recruiterview: json["recruiterview"] == null
            ? null
            : Recruiterview.fromJson(json["recruiterview"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "totalview": totalview,
        "newview": newview,
        "seekerviewid": seekerviewid == null ? null : seekerviewid!.toJson(),
        "recruiterview": recruiterview == null ? null : recruiterview!.toJson(),
      };
}

class Seekerviewid {
  SeekerviewidOther? other;
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

  Seekerviewid({
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

  factory Seekerviewid.fromJson(Map<String, dynamic> json) => Seekerviewid(
        other: json["other"] == null
            ? null
            : SeekerviewidOther.fromJson(json["other"]),
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

class SeekerviewidOther {
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

  SeekerviewidOther({
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

  factory SeekerviewidOther.fromJson(Map<String, dynamic> json) =>
      SeekerviewidOther(
        notification: json["notification"] == null
            ? null
            : Notification.fromJson(json["notification"]),
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

class Recruiterview {
  String? id;
  String? fastname;
  String? lastname;

  Recruiterview({
    this.id,
    this.fastname,
    this.lastname,
  });

  factory Recruiterview.fromJson(Map<String, dynamic> json) => Recruiterview(
        id: json["_id"],
        fastname: json["fastname"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fastname": fastname,
        "lastname": lastname,
      };
}

class NotInterest {
  int? person;
  String? title;

  NotInterest({
    this.person,
    this.title,
  });

  factory NotInterest.fromJson(Map<String, dynamic> json) => NotInterest(
        person: json["person"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "person": person,
        "title": title,
      };
}

class Jobid {
  Salary? salary;
  Location? jobLocation;
  String? id;
  String? jobTitle;
  String? companyname;
  Area? experticeArea;
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

  Jobid({
    this.salary,
    this.jobLocation,
    this.id,
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

  factory Jobid.fromJson(Map<String, dynamic> json) => Jobid(
        salary: json["salary"] == null ? null : Salary.fromJson(json["salary"]),
        jobLocation: json["job_location"] == null
            ? null
            : Location.fromJson(json["job_location"]),
        id: json["_id"],
        jobTitle: json["job_title"],
        companyname: json["companyname"],
        experticeArea: json["expertice_area"] == null
            ? null
            : Area.fromJson(json["expertice_area"]),
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
            : List<String>.from(json["skill"]!.map((x) => x)),
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
        "job_title": jobTitle,
        "companyname": companyname,
        "expertice_area": experticeArea?.toJson(),
        "job_description": jobDescription,
        "experience": experience?.toJson(),
        "education": education?.toJson(),
        "company": company?.toJson(),
        "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x)),
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
  Divisiondata? divisiondata;
  double? lat;
  double? lon;
  String? formetAddress;
  String? city;
  String? division;

  Location({
    this.divisiondata,
    this.lat,
    this.lon,
    this.formetAddress,
    this.city,
    this.division,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        divisiondata: json["divisiondata"] == null
            ? null
            : Divisiondata.fromJson(json["divisiondata"]),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        formetAddress: json["formet_address"],
        city: json["city"],
        division: json["division"],
      );

  Map<String, dynamic> toJson() => {
        "divisiondata": divisiondata?.toJson(),
        "lat": lat,
        "lon": lon,
        "formet_address": formetAddress,
        "city": city,
        "division": division,
      };
}

class Divisiondata {
  String? id;
  String? divisionname;
  Cityid? cityid;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Divisiondata({
    this.id,
    this.divisionname,
    this.cityid,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Divisiondata.fromJson(Map<String, dynamic> json) => Divisiondata(
        id: json["_id"],
        divisionname: json["divisionname"],
        cityid: json["cityid"] == null ? null : Cityid.fromJson(json["cityid"]),
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
        "divisionname": divisionname,
        "cityid": cityid?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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
  int? v;
  DateTime? updatedAt;

  CSize({
    this.id,
    this.size,
    this.v,
    this.updatedAt,
  });

  factory CSize.fromJson(Map<String, dynamic> json) => CSize(
        id: json["_id"],
        size: json["size"],
        v: json["__v"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "size": size,
        "__v": v,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Education {
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Education({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["_id"],
        name: json["name"],
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Experience {
  String? id;
  String? name;
  int? v;

  Experience({
    this.id,
    this.name,
    this.v,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
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

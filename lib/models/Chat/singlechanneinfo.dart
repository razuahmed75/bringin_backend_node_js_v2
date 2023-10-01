// To parse this JSON data, do
//
//     final channelInfo = channelInfoFromJson(jsonString);

import 'dart:convert';

ChannelInfo channelInfoFromJson(String str) => ChannelInfo.fromJson(json.decode(str));

String channelInfoToJson(ChannelInfo data) => json.encode(data.toJson());

class ChannelInfo {
    String? id;
    Seekerid? seekerid;
    Recruiterid? recruiterid;
    DateTime? date;
    dynamic recruitermsgdate;
    bool? seekerblock;
    bool? recruiterblock;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    ChannelInfo({
        this.id,
        this.seekerid,
        this.recruiterid,
        this.date,
        this.recruitermsgdate,
        this.seekerblock,
        this.recruiterblock,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory ChannelInfo.fromJson(Map<String, dynamic> json) => ChannelInfo(
        id: json["_id"],
        seekerid: json["seekerid"] == null ? null : Seekerid.fromJson(json["seekerid"]),
        recruiterid: json["recruiterid"] == null ? null : Recruiterid.fromJson(json["recruiterid"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        recruitermsgdate: json["recruitermsgdate"],
        seekerblock: json["seekerblock"],
        recruiterblock: json["recruiterblock"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "seekerid": seekerid?.toJson(),
        "recruiterid": recruiterid?.toJson(),
        "date": date?.toIso8601String(),
        "recruitermsgdate": recruitermsgdate,
        "seekerblock": seekerblock,
        "recruiterblock": recruiterblock,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Recruiterid {
    String? id;
    String? number;
    String? firstname;
    String? lastname;
    Companyname? companyname;
    String? designation;
    String? email;
    String? image;
    bool? companyVerify;
    bool? profileVerify;
    bool? companyDocupload;
    bool? profileDocupload;
    bool? premium;
    DateTime? profileVerifyDate;
    int? v;

    Recruiterid({
        this.id,
        this.number,
        this.firstname,
        this.lastname,
        this.companyname,
        this.designation,
        this.email,
        this.image,
        this.companyVerify,
        this.profileVerify,
        this.companyDocupload,
        this.profileDocupload,
        this.premium,
        this.profileVerifyDate,
        this.v,
    });

    factory Recruiterid.fromJson(Map<String, dynamic> json) => Recruiterid(
        id: json["_id"],
        number: json["number"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        companyname: json["companyname"] == null ? null : Companyname.fromJson(json["companyname"]),
        designation: json["designation"],
        email: json["email"],
        image: json["image"],
        companyVerify: json["company_verify"],
        profileVerify: json["profile_verify"],
        companyDocupload: json["company_docupload"],
        profileDocupload: json["profile_docupload"],
        premium: json["premium"],
        profileVerifyDate: json["profile_verify_date"] == null ? null : DateTime.parse(json["profile_verify_date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "number": number,
        "firstname": firstname,
        "lastname": lastname,
        "companyname": companyname?.toJson(),
        "designation": designation,
        "email": email,
        "image": image,
        "company_verify": companyVerify,
        "profile_verify": profileVerify,
        "company_docupload": companyDocupload,
        "profile_docupload": profileDocupload,
        "premium": premium,
        "profile_verify_date": profileVerifyDate?.toIso8601String(),
        "__v": v,
    };
}

class Companyname {
    CLocation? cLocation;
    String? id;
    String? userid;
    String? legalName;
    String? sortName;
    Industry? industry;
    String? cSize;
    String? cWebsite;
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
        this.v,
    });

    factory Companyname.fromJson(Map<String, dynamic> json) => Companyname(
        cLocation: json["c_location"] == null ? null : CLocation.fromJson(json["c_location"]),
        id: json["_id"],
        userid: json["userid"],
        legalName: json["legal_name"],
        sortName: json["sort_name"],
        industry: json["industry"] == null ? null : Industry.fromJson(json["industry"]),
        cSize: json["c_size"],
        cWebsite: json["c_website"],
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
        "__v": v,
    };
}

class CLocation {
    int? lat;
    int? lon;
    String? formetAddress;
    String? city;

    CLocation({
        this.lat,
        this.lon,
        this.formetAddress,
        this.city,
    });

    factory CLocation.fromJson(Map<String, dynamic> json) => CLocation(
        lat: json["lat"],
        lon: json["lon"],
        formetAddress: json["formet_address"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "formet_address": formetAddress,
        "city": city,
    };
}

class Industry {
    String? id;
    String? industryname;
    List<String>? category;
    int? v;

    Industry({
        this.id,
        this.industryname,
        this.category,
        this.v,
    });

    factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        id: json["_id"],
        industryname: json["industryname"],
        category: json["category"] == null ? [] : List<String>.from(json["category"]!.map((x) => x)),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "industryname": industryname,
        "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
        "__v": v,
    };
}

class Seekerid {
    String? id;
    String? number;
    String? fastname;
    String? lastname;
    String? gender;
    String? experiencedlevel;
    DateTime? startedworking;
    DateTime? deatofbirth;
    String? email;
    String? image;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    int? cvsend;
    int? savejob;
    int? totalchat;
    int? viewjob;
    int? carearpre;

    Seekerid({
        this.id,
        this.number,
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
        this.cvsend,
        this.savejob,
        this.totalchat,
        this.viewjob,
        this.carearpre,
    });

    factory Seekerid.fromJson(Map<String, dynamic> json) => Seekerid(
        id: json["_id"],
        number: json["number"],
        fastname: json["fastname"],
        lastname: json["lastname"],
        gender: json["gender"],
        experiencedlevel: json["experiencedlevel"],
        startedworking: json["startedworking"] == null ? null : DateTime.parse(json["startedworking"]),
        deatofbirth: json["deatofbirth"] == null ? null : DateTime.parse(json["deatofbirth"]),
        email: json["email"],
        image: json["image"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        cvsend: json["cvsend"],
        savejob: json["savejob"],
        totalchat: json["totalchat"],
        viewjob: json["viewjob"],
        carearpre: json["carearpre"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "number": number,
        "fastname": fastname,
        "lastname": lastname,
        "gender": gender,
        "experiencedlevel": experiencedlevel,
        "startedworking": startedworking?.toIso8601String(),
        "deatofbirth": deatofbirth?.toIso8601String(),
        "email": email,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "cvsend": cvsend,
        "savejob": savejob,
        "totalchat": totalchat,
        "viewjob": viewjob,
        "carearpre": carearpre,
    };
}

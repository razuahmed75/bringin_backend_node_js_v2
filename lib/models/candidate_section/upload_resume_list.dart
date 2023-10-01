class Uploadresumelist {
  String? sId;
  Resume? resume;
  String? userid;
  String? uploadtime;
  int? iV;

  Uploadresumelist(
      {this.sId, this.resume, this.userid, this.uploadtime, this.iV});

  Uploadresumelist.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    resume =
        json['resume'] != null ? new Resume.fromJson(json['resume']) : null;
    userid = json['userid'];
    uploadtime = json['uploadtime'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.resume != null) {
      data['resume'] = this.resume!.toJson();
    }
    data['userid'] = this.userid;
    data['uploadtime'] = this.uploadtime;
    data['__v'] = this.iV;
    return data;
  }
}

class Resume {
  String? fieldname;
  String? originalname;
  String? encoding;
  String? mimetype;
  String? destination;
  String? filename;
  String? path;
  int? size;

  Resume(
      {this.fieldname,
      this.originalname,
      this.encoding,
      this.mimetype,
      this.destination,
      this.filename,
      this.path,
      this.size});

  Resume.fromJson(Map<String, dynamic> json) {
    fieldname = json['fieldname'];
    originalname = json['originalname'];
    encoding = json['encoding'];
    mimetype = json['mimetype'];
    destination = json['destination'];
    filename = json['filename'];
    path = json['path'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldname'] = this.fieldname;
    data['originalname'] = this.originalname;
    data['encoding'] = this.encoding;
    data['mimetype'] = this.mimetype;
    data['destination'] = this.destination;
    data['filename'] = this.filename;
    data['path'] = this.path;
    data['size'] = this.size;
    return data;
  }
}

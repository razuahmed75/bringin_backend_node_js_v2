class JobTypeModel {
  String? sId;
  String? worktype;
  int? iV;

  JobTypeModel({this.sId, this.worktype, this.iV});

  JobTypeModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    worktype = json['worktype'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['worktype'] = this.worktype;
    data['__v'] = this.iV;
    return data;
  }
}

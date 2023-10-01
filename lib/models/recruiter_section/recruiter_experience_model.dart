class RecruiterExperienceModel {
  String? sId;
  String? name;
  int? iV;

  RecruiterExperienceModel({this.sId, this.name, this.iV});

  RecruiterExperienceModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['__v'] = this.iV;
    return data;
  }
}

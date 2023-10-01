class SkillUpdateModel {
  List<String>? skill;

  SkillUpdateModel({this.skill});

  SkillUpdateModel.fromJson(Map<String, dynamic> json) {
    skill = json['skill'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skill'] = this.skill;
    return data;
  }
}

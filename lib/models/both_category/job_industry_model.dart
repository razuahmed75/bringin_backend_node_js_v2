class JobIndustryModel {
  List<Category>? category;
  List<Industry>? industry;

  JobIndustryModel({this.category, this.industry});

  JobIndustryModel.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['industry'] != null) {
      industry = <Industry>[];
      json['industry'].forEach((v) {
        industry!.add(new Industry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.industry != null) {
      data['industry'] = this.industry!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? sId;
  String? industryid;
  String? categoryname;
  int? iV;

  Category({this.sId, this.industryid, this.categoryname, this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    industryid = json['industryid'];
    categoryname = json['categoryname'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['industryid'] = this.industryid;
    data['categoryname'] = this.categoryname;
    data['__v'] = this.iV;
    return data;
  }
}

class Industry {
  String? sId;
  String? industryname;
  int? iV;
  List<Category>? category;

  Industry({this.sId, this.industryname, this.iV, this.category});

  Industry.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    industryname = json['industryname'];
    iV = json['__v'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['industryname'] = this.industryname;
    data['__v'] = this.iV;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

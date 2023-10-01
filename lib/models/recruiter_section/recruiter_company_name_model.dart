class RecruiterCompanyListModel {
  CLocation? cLocation;
  String? sId;
  String? userid;
  String? legalName;
  String? sortName;
  Industry? industry;
  CSize? cSize;
  String? cWebsite;
  int? iV;

  RecruiterCompanyListModel(
      {this.cLocation,
      this.sId,
      this.userid,
      this.legalName,
      this.sortName,
      this.industry,
      this.cSize,
      this.cWebsite,
      this.iV});

  RecruiterCompanyListModel.fromJson(Map<String, dynamic> json) {
    cLocation = json['c_location'] != null
        ? new CLocation.fromJson(json['c_location'])
        : null;
    sId = json['_id'];
    userid = json['userid'];
    legalName = json['legal_name'];
    sortName = json['sort_name'];
    industry = json['industry'] != null
        ? new Industry.fromJson(json['industry'])
        : null;
    cSize = json['c_size'] != null ? new CSize.fromJson(json['c_size']) : null;
    cWebsite = json['c_website'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cLocation != null) {
      data['c_location'] = this.cLocation!.toJson();
    }
    data['_id'] = this.sId;
    data['userid'] = this.userid;
    data['legal_name'] = this.legalName;
    data['sort_name'] = this.sortName;
    if (this.industry != null) {
      data['industry'] = this.industry!.toJson();
    }
    if (this.cSize != null) {
      data['c_size'] = this.cSize!.toJson();
    }
    data['c_website'] = this.cWebsite;
    data['__v'] = this.iV;
    return data;
  }
}

class CLocation {
  dynamic lat;
  dynamic lon;
  String? formetAddress;
  String? city;
  String? division;

  CLocation({this.lat, this.lon, this.formetAddress, this.city, this.division});

  CLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    formetAddress = json['formet_address'];
    city = json['city'];
    division = json['division'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['formet_address'] = this.formetAddress;
    data['city'] = this.city;
    data['division'] = this.division;
    return data;
  }
}

class Industry {
  String? sId;
  String? industryname;
  int? iV;
  // List<String>? category;

  Industry({this.sId, this.industryname, this.iV});

  Industry.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    industryname = json['industryname'];
    iV = json['__v'];
    // category = json['category'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['industryname'] = this.industryname;
    data['__v'] = this.iV;
    // data['category'] = this.category;
    return data;
  }
}

class CSize {
  String? sId;
  String? size;
  int? iV;

  CSize({this.sId, this.size, this.iV});

  CSize.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    size = json['size'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['size'] = this.size;
    data['__v'] = this.iV;
    return data;
  }
}

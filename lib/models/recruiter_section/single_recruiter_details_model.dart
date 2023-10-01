class SingleRecruiterDetailsModel {
  Recruiter? recruiter;
  List<Joblist>? joblist;

  SingleRecruiterDetailsModel({this.recruiter, this.joblist});

  SingleRecruiterDetailsModel.fromJson(Map<String, dynamic> json) {
    recruiter = json['recruiter'] != null
        ? new Recruiter.fromJson(json['recruiter'])
        : null;
    if (json['joblist'] != null) {
      joblist = <Joblist>[];
      json['joblist'].forEach((v) {
        joblist!.add(new Joblist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recruiter != null) {
      data['recruiter'] = this.recruiter!.toJson();
    }
    if (this.joblist != null) {
      data['joblist'] = this.joblist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recruiter {
  Other? other;
  String? sId;
  String? number;
  String? firstname;
  String? lastname;
  Companyname? companyname;
  String? designation;
  String? email;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Recruiter(
      {this.other,
      this.sId,
      this.number,
      this.firstname,
      this.lastname,
      this.companyname,
      this.designation,
      this.email,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Recruiter.fromJson(Map<String, dynamic> json) {
    other = json['other'] != null ? new Other.fromJson(json['other']) : null;
    sId = json['_id'];
    number = json['number'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    companyname = json['companyname'] != null
        ? new Companyname.fromJson(json['companyname'])
        : null;
    designation = json['designation'];
    email = json['email'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.other != null) {
      data['other'] = this.other!.toJson();
    }
    data['_id'] = this.sId;
    data['number'] = this.number;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    if (this.companyname != null) {
      data['companyname'] = this.companyname!.toJson();
    }
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Other {
  Notification? notification;
  int? totaljob;
  Package? package;
  String? latestjobid;
  bool? companyVerify;
  bool? profileVerify;
  int? profileVerifyType;
  int? companyVerifyType;
  bool? companyDocupload;
  bool? profileDocupload;
  String? profileVerifyDate;
  bool? premium;
  int? totalChat;
  int? savecandidate;
  int? interview;
  int? candidateView;
  int? totalStep;
  int? incomplete;
  int? complete;
  bool? online;
  int? offlinedate;
  String? pushnotification;

  Other(
      {this.notification,
      this.totaljob,
      this.package,
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
      this.candidateView,
      this.totalStep,
      this.incomplete,
      this.complete,
      this.online,
      this.offlinedate,
      this.pushnotification});

  Other.fromJson(Map<String, dynamic> json) {
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
    totaljob = json['totaljob'];
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
    latestjobid = json['latestjobid'];
    companyVerify = json['company_verify'];
    profileVerify = json['profile_verify'];
    profileVerifyType = json['profile_verify_type'];
    companyVerifyType = json['company_verify_type'];
    companyDocupload = json['company_docupload'];
    profileDocupload = json['profile_docupload'];
    profileVerifyDate = json['profile_verify_date'];
    premium = json['premium'];
    totalChat = json['total_chat'];
    savecandidate = json['savecandidate'];
    interview = json['interview'];
    candidateView = json['candidate_view'];
    totalStep = json['total_step'];
    incomplete = json['incomplete'];
    complete = json['complete'];
    online = json['online'];
    offlinedate = json['offlinedate'];
    pushnotification = json['pushnotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    data['totaljob'] = this.totaljob;
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    data['latestjobid'] = this.latestjobid;
    data['company_verify'] = this.companyVerify;
    data['profile_verify'] = this.profileVerify;
    data['profile_verify_type'] = this.profileVerifyType;
    data['company_verify_type'] = this.companyVerifyType;
    data['company_docupload'] = this.companyDocupload;
    data['profile_docupload'] = this.profileDocupload;
    data['profile_verify_date'] = this.profileVerifyDate;
    data['premium'] = this.premium;
    data['total_chat'] = this.totalChat;
    data['savecandidate'] = this.savecandidate;
    data['interview'] = this.interview;
    data['candidate_view'] = this.candidateView;
    data['total_step'] = this.totalStep;
    data['incomplete'] = this.incomplete;
    data['complete'] = this.complete;
    data['online'] = this.online;
    data['offlinedate'] = this.offlinedate;
    data['pushnotification'] = this.pushnotification;
    return data;
  }
}

class Notification {
  bool? pushNotification;
  bool? whatsappNotification;
  bool? smsNotification;
  bool? jobRecommandation;

  Notification(
      {this.pushNotification,
      this.whatsappNotification,
      this.smsNotification,
      this.jobRecommandation});

  Notification.fromJson(Map<String, dynamic> json) {
    pushNotification = json['push_notification'];
    whatsappNotification = json['whatsapp_notification'];
    smsNotification = json['sms_notification'];
    jobRecommandation = json['job_recommandation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['push_notification'] = this.pushNotification;
    data['whatsapp_notification'] = this.whatsappNotification;
    data['sms_notification'] = this.smsNotification;
    data['job_recommandation'] = this.jobRecommandation;
    return data;
  }
}

class Package {
  String? sId;
  Packageid? packageid;
  String? recruiterid;
  int? starddate;
  int? enddate;
  int? activeType;
  bool? active;
  TransactionID? transactionID;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Package(
      {this.sId,
      this.packageid,
      this.recruiterid,
      this.starddate,
      this.enddate,
      this.activeType,
      this.active,
      this.transactionID,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Package.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    packageid = json['packageid'] != null
        ? new Packageid.fromJson(json['packageid'])
        : null;
    recruiterid = json['recruiterid'];
    starddate = json['starddate'];
    enddate = json['enddate'];
    activeType = json['active_type'];
    active = json['active'];
    transactionID = json['transactionID'] != null
        ? new TransactionID.fromJson(json['transactionID'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.packageid != null) {
      data['packageid'] = this.packageid!.toJson();
    }
    data['recruiterid'] = this.recruiterid;
    data['starddate'] = this.starddate;
    data['enddate'] = this.enddate;
    data['active_type'] = this.activeType;
    data['active'] = this.active;
    if (this.transactionID != null) {
      data['transactionID'] = this.transactionID!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Packageid {
  String? sId;
  String? name;
  String? suggestname;
  int? chat;
  int? amount;
  String? currency;
  int? durationTime;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Packageid(
      {this.sId,
      this.name,
      this.suggestname,
      this.chat,
      this.amount,
      this.currency,
      this.durationTime,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Packageid.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    suggestname = json['suggestname'];
    chat = json['chat'];
    amount = json['amount'];
    currency = json['currency'];
    durationTime = json['duration_time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['suggestname'] = this.suggestname;
    data['chat'] = this.chat;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['duration_time'] = this.durationTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class TransactionID {
  String? pgTxnid;
  String? merTxnid;
  String? riskTitle;
  String? riskLevel;
  String? cusName;
  String? cusEmail;
  String? cusPhone;
  String? desc;
  String? cusAdd1;
  String? cusAdd2;
  String? cusCity;
  String? cusState;
  String? cusPostcode;
  String? cusCountry;
  dynamic cusFax;
  dynamic shipName;
  dynamic shipAdd1;
  dynamic shipAdd2;
  dynamic shipCity;
  dynamic shipState;
  dynamic shipPostcode;
  dynamic shipCountry;
  String? merchantId;
  String? storeId;
  String? amount;
  String? amountBdt;
  String? payStatus;
  String? statusCode;
  String? statusTitle;
  String? cardnumber;
  String? approvalCode;
  String? paymentProcessor;
  String? bankTrxid;
  String? paymentType;
  String? errorCode;
  String? errorTitle;
  String? binCountry;
  String? binIssuer;
  String? binCardtype;
  String? binCardcategory;
  String? date;
  String? dateProcessed;
  String? amountCurrency;
  String? recAmount;
  String? processingRatio;
  String? processingCharge;
  String? ip;
  String? currency;
  String? currencyMerchant;
  String? convertionRate;
  String? optA;
  String? optB;
  String? optC;
  String? optD;
  String? verifyStatus;
  String? callType;
  String? emailSend;
  String? docRecived;
  String? checkoutStatus;

  TransactionID(
      {this.pgTxnid,
      this.merTxnid,
      this.riskTitle,
      this.riskLevel,
      this.cusName,
      this.cusEmail,
      this.cusPhone,
      this.desc,
      this.cusAdd1,
      this.cusAdd2,
      this.cusCity,
      this.cusState,
      this.cusPostcode,
      this.cusCountry,
      this.cusFax,
      this.shipName,
      this.shipAdd1,
      this.shipAdd2,
      this.shipCity,
      this.shipState,
      this.shipPostcode,
      this.shipCountry,
      this.merchantId,
      this.storeId,
      this.amount,
      this.amountBdt,
      this.payStatus,
      this.statusCode,
      this.statusTitle,
      this.cardnumber,
      this.approvalCode,
      this.paymentProcessor,
      this.bankTrxid,
      this.paymentType,
      this.errorCode,
      this.errorTitle,
      this.binCountry,
      this.binIssuer,
      this.binCardtype,
      this.binCardcategory,
      this.date,
      this.dateProcessed,
      this.amountCurrency,
      this.recAmount,
      this.processingRatio,
      this.processingCharge,
      this.ip,
      this.currency,
      this.currencyMerchant,
      this.convertionRate,
      this.optA,
      this.optB,
      this.optC,
      this.optD,
      this.verifyStatus,
      this.callType,
      this.emailSend,
      this.docRecived,
      this.checkoutStatus});

  TransactionID.fromJson(Map<String, dynamic> json) {
    pgTxnid = json['pg_txnid'];
    merTxnid = json['mer_txnid'];
    riskTitle = json['risk_title'];
    riskLevel = json['risk_level'];
    cusName = json['cus_name'];
    cusEmail = json['cus_email'];
    cusPhone = json['cus_phone'];
    desc = json['desc'];
    cusAdd1 = json['cus_add1'];
    cusAdd2 = json['cus_add2'];
    cusCity = json['cus_city'];
    cusState = json['cus_state'];
    cusPostcode = json['cus_postcode'];
    cusCountry = json['cus_country'];
    cusFax = json['cus_fax'];
    shipName = json['ship_name'];
    shipAdd1 = json['ship_add1'];
    shipAdd2 = json['ship_add2'];
    shipCity = json['ship_city'];
    shipState = json['ship_state'];
    shipPostcode = json['ship_postcode'];
    shipCountry = json['ship_country'];
    merchantId = json['merchant_id'];
    storeId = json['store_id'];
    amount = json['amount'];
    amountBdt = json['amount_bdt'];
    payStatus = json['pay_status'];
    statusCode = json['status_code'];
    statusTitle = json['status_title'];
    cardnumber = json['cardnumber'];
    approvalCode = json['approval_code'];
    paymentProcessor = json['payment_processor'];
    bankTrxid = json['bank_trxid'];
    paymentType = json['payment_type'];
    errorCode = json['error_code'];
    errorTitle = json['error_title'];
    binCountry = json['bin_country'];
    binIssuer = json['bin_issuer'];
    binCardtype = json['bin_cardtype'];
    binCardcategory = json['bin_cardcategory'];
    date = json['date'];
    dateProcessed = json['date_processed'];
    amountCurrency = json['amount_currency'];
    recAmount = json['rec_amount'];
    processingRatio = json['processing_ratio'];
    processingCharge = json['processing_charge'];
    ip = json['ip'];
    currency = json['currency'];
    currencyMerchant = json['currency_merchant'];
    convertionRate = json['convertion_rate'];
    optA = json['opt_a'];
    optB = json['opt_b'];
    optC = json['opt_c'];
    optD = json['opt_d'];
    verifyStatus = json['verify_status'];
    callType = json['call_type'];
    emailSend = json['email_send'];
    docRecived = json['doc_recived'];
    checkoutStatus = json['checkout_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pg_txnid'] = this.pgTxnid;
    data['mer_txnid'] = this.merTxnid;
    data['risk_title'] = this.riskTitle;
    data['risk_level'] = this.riskLevel;
    data['cus_name'] = this.cusName;
    data['cus_email'] = this.cusEmail;
    data['cus_phone'] = this.cusPhone;
    data['desc'] = this.desc;
    data['cus_add1'] = this.cusAdd1;
    data['cus_add2'] = this.cusAdd2;
    data['cus_city'] = this.cusCity;
    data['cus_state'] = this.cusState;
    data['cus_postcode'] = this.cusPostcode;
    data['cus_country'] = this.cusCountry;
    data['cus_fax'] = this.cusFax;
    data['ship_name'] = this.shipName;
    data['ship_add1'] = this.shipAdd1;
    data['ship_add2'] = this.shipAdd2;
    data['ship_city'] = this.shipCity;
    data['ship_state'] = this.shipState;
    data['ship_postcode'] = this.shipPostcode;
    data['ship_country'] = this.shipCountry;
    data['merchant_id'] = this.merchantId;
    data['store_id'] = this.storeId;
    data['amount'] = this.amount;
    data['amount_bdt'] = this.amountBdt;
    data['pay_status'] = this.payStatus;
    data['status_code'] = this.statusCode;
    data['status_title'] = this.statusTitle;
    data['cardnumber'] = this.cardnumber;
    data['approval_code'] = this.approvalCode;
    data['payment_processor'] = this.paymentProcessor;
    data['bank_trxid'] = this.bankTrxid;
    data['payment_type'] = this.paymentType;
    data['error_code'] = this.errorCode;
    data['error_title'] = this.errorTitle;
    data['bin_country'] = this.binCountry;
    data['bin_issuer'] = this.binIssuer;
    data['bin_cardtype'] = this.binCardtype;
    data['bin_cardcategory'] = this.binCardcategory;
    data['date'] = this.date;
    data['date_processed'] = this.dateProcessed;
    data['amount_currency'] = this.amountCurrency;
    data['rec_amount'] = this.recAmount;
    data['processing_ratio'] = this.processingRatio;
    data['processing_charge'] = this.processingCharge;
    data['ip'] = this.ip;
    data['currency'] = this.currency;
    data['currency_merchant'] = this.currencyMerchant;
    data['convertion_rate'] = this.convertionRate;
    data['opt_a'] = this.optA;
    data['opt_b'] = this.optB;
    data['opt_c'] = this.optC;
    data['opt_d'] = this.optD;
    data['verify_status'] = this.verifyStatus;
    data['call_type'] = this.callType;
    data['email_send'] = this.emailSend;
    data['doc_recived'] = this.docRecived;
    data['checkout_status'] = this.checkoutStatus;
    return data;
  }
}

class Companyname {
  CLocation? cLocation;
  String? sId;
  String? userid;
  String? legalName;
  String? sortName;
  Industry? industry;
  String? cSize;
  String? cWebsite;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Companyname(
      {this.cLocation,
      this.sId,
      this.userid,
      this.legalName,
      this.sortName,
      this.industry,
      this.cSize,
      this.cWebsite,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Companyname.fromJson(Map<String, dynamic> json) {
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
    cSize = json['c_size'];
    cWebsite = json['c_website'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['c_size'] = this.cSize;
    data['c_website'] = this.cWebsite;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CLocation {
  double? lat;
  double? lon;
  String? formetAddress;
  String? locationoptional;
  DivisionData? divisiondata;

  CLocation({this.lat, this.lon, this.formetAddress,this.divisiondata,this.locationoptional});

  CLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    formetAddress = json['formet_address'];
    locationoptional = json['locationoptional'];
    divisiondata = json['divisiondata'] == null ? null : DivisionData.fromJson(json['divisiondata']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['formet_address'] = this.formetAddress;
    data['locationoptional'] = this.locationoptional;
    if(this.divisiondata != null){
      data['divisiondata'] = this.divisiondata!.toJson();
    }
    return data;
  }
}

class Industry {
  String? sId;
  String? industryid;
  String? categoryname;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Industry(
      {this.sId,
      this.industryid,
      this.categoryname,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Industry.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    industryid = json['industryid'];
    categoryname = json['categoryname'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['industryid'] = this.industryid;
    data['categoryname'] = this.categoryname;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Joblist {
  Salary? salary;
  JobLocation? jobLocation;
  String? sId;
  Userid? userid;
  String? jobTitle;
  String? companyname;
  ExperticeArea? experticeArea;
  String? jobDescription;
  Experience? experience;
  Education? education;
  Company? company;
  List<String>? skill;
  Jobtype? jobtype;
  bool? remote;
  int? jobStatusType;
  String? jobStatus;
  String? postdate;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Joblist(
      {this.salary,
      this.jobLocation,
      this.sId,
      this.userid,
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
      this.iV});

  Joblist.fromJson(Map<String, dynamic> json) {
    salary =
        json['salary'] != null ? new Salary.fromJson(json['salary']) : null;
    jobLocation = json['job_location'] != null
        ? new JobLocation.fromJson(json['job_location'])
        : null;
    sId = json['_id'];
    userid =
        json['userid'] != null ? new Userid.fromJson(json['userid']) : null;
    jobTitle = json['job_title'];
    companyname = json['companyname'];
    experticeArea = json['expertice_area'] != null
        ? new ExperticeArea.fromJson(json['expertice_area'])
        : null;
    jobDescription = json['job_description'];
    experience = json['experience'] != null
        ? new Experience.fromJson(json['experience'])
        : null;
    education = json['education'] != null
        ? new Education.fromJson(json['education'])
        : null;
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    if (json['skill'] != null) {
      skill = <String>[];
      json['skill'].forEach((v) {
        skill!.add(v);
      });
    }
    jobtype =
        json['jobtype'] != null ? new Jobtype.fromJson(json['jobtype']) : null;
    remote = json['remote'];
    jobStatusType = json['job_status_type'];
    jobStatus = json['job_status'];
    postdate = json['postdate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.salary != null) {
      data['salary'] = this.salary!.toJson();
    }
    if (this.jobLocation != null) {
      data['job_location'] = this.jobLocation!.toJson();
    }
    data['_id'] = this.sId;
    if (this.userid != null) {
      data['userid'] = this.userid!.toJson();
    }
    data['job_title'] = this.jobTitle;
    data['companyname'] = this.companyname;
    if (this.experticeArea != null) {
      data['expertice_area'] = this.experticeArea!.toJson();
    }
    data['job_description'] = this.jobDescription;
    if (this.experience != null) {
      data['experience'] = this.experience!.toJson();
    }
    if (this.education != null) {
      data['education'] = this.education!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.skill != null) {
      data['skill'] = this.skill!.map((v) => v).toList();
    }
    if (this.jobtype != null) {
      data['jobtype'] = this.jobtype!.toJson();
    }
    data['remote'] = this.remote;
    data['job_status_type'] = this.jobStatusType;
    data['job_status'] = this.jobStatus;
    data['postdate'] = this.postdate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Salary {
  MinSalary? minSalary;
  MinSalary? maxSalary;

  Salary({this.minSalary, this.maxSalary});

  Salary.fromJson(Map<String, dynamic> json) {
    minSalary = json['min_salary'] != null
        ? new MinSalary.fromJson(json['min_salary'])
        : null;
    maxSalary = json['max_salary'] != null
        ? new MinSalary.fromJson(json['max_salary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.minSalary != null) {
      data['min_salary'] = this.minSalary!.toJson();
    }
    if (this.maxSalary != null) {
      data['max_salary'] = this.maxSalary!.toJson();
    }
    return data;
  }
}

class MinSalary {
  String? sId;
  dynamic salary;
  int? type;
  String? simbol;
  String? currency;
  String? createdAt;
  String? updatedAt;
  int? iV;

  MinSalary(
      {this.sId,
      this.salary,
      this.type,
      this.simbol,
      this.currency,
      this.createdAt,
      this.updatedAt,
      this.iV});

  MinSalary.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    salary = json['salary'];
    type = json['type'];
    simbol = json['simbol'];
    currency = json['currency'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['salary'] = this.salary;
    data['type'] = this.type;
    data['simbol'] = this.simbol;
    data['currency'] = this.currency;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class JobLocation {
  double? lat;
  double? lon;
  String? formetAddress;
  String? locationoptional;
  DivisionData? divisiondata;

  JobLocation({this.lat, this.lon, this.formetAddress,this.divisiondata,this.locationoptional});

  JobLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] == 0 ? 0.0 : json['lat'];
    lon = json['lon'] == 0 ? 0.0 : json['lon'];
    formetAddress = json['formet_address'];
    locationoptional = json['locationoptional'];
    divisiondata = json['divisiondata'] == null ? null : DivisionData.fromJson(json['divisiondata']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['formet_address'] = this.formetAddress;
    data['locationoptional'] = this.locationoptional;
    if(this.divisiondata != null){
      data['divisiondata'] = this.divisiondata!.toJson();
    }
    return data;
  }
}
class DivisionData {
    String? id;
    String? divisionname;
    Cityid? cityid;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    DivisionData({
        this.id,
        this.divisionname,
        this.cityid,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory DivisionData.fromJson(Map<String, dynamic> json) => DivisionData(
        id: json["_id"],
        divisionname: json["divisionname"],
        cityid: json["cityid"] == null ? null : Cityid.fromJson(json["cityid"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "divisionname": divisionname,
        "cityid": cityid!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
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

class Userid {
  Others? other;
  String? sId;
  String? number;
  String? firstname;
  String? lastname;
  String? companyname;
  String? designation;
  String? email;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Userid(
      {this.other,
      this.sId,
      this.number,
      this.firstname,
      this.lastname,
      this.companyname,
      this.designation,
      this.email,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Userid.fromJson(Map<String, dynamic> json) {
    other = json['other'] != null ? new Others.fromJson(json['other']) : null;
    sId = json['_id'];
    number = json['number'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    companyname = json['companyname'];
    designation = json['designation'];
    email = json['email'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.other != null) {
      data['other'] = this.other!.toJson();
    }
    data['_id'] = this.sId;
    data['number'] = this.number;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['companyname'] = this.companyname;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Others {
  Notification? notification;
  int? totaljob;
  String? package;
  String? latestjobid;
  bool? companyVerify;
  bool? profileVerify;
  int? profileVerifyType;
  int? companyVerifyType;
  bool? companyDocupload;
  bool? profileDocupload;
  String? profileVerifyDate;
  bool? premium;
  int? totalChat;
  int? savecandidate;
  int? interview;
  int? candidateView;
  int? totalStep;
  int? incomplete;
  int? complete;
  bool? online;
  int? offlinedate;
  String? pushnotification;

  Others(
      {this.notification,
      this.totaljob,
      this.package,
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
      this.candidateView,
      this.totalStep,
      this.incomplete,
      this.complete,
      this.online,
      this.offlinedate,
      this.pushnotification});

  Others.fromJson(Map<String, dynamic> json) {
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
    totaljob = json['totaljob'];
    package = json['package'];
    latestjobid = json['latestjobid'];
    companyVerify = json['company_verify'];
    profileVerify = json['profile_verify'];
    profileVerifyType = json['profile_verify_type'];
    companyVerifyType = json['company_verify_type'];
    companyDocupload = json['company_docupload'];
    profileDocupload = json['profile_docupload'];
    profileVerifyDate = json['profile_verify_date'];
    premium = json['premium'];
    totalChat = json['total_chat'];
    savecandidate = json['savecandidate'];
    interview = json['interview'];
    candidateView = json['candidate_view'];
    totalStep = json['total_step'];
    incomplete = json['incomplete'];
    complete = json['complete'];
    online = json['online'];
    offlinedate = json['offlinedate'];
    pushnotification = json['pushnotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    data['totaljob'] = this.totaljob;
    data['package'] = this.package;
    data['latestjobid'] = this.latestjobid;
    data['company_verify'] = this.companyVerify;
    data['profile_verify'] = this.profileVerify;
    data['profile_verify_type'] = this.profileVerifyType;
    data['company_verify_type'] = this.companyVerifyType;
    data['company_docupload'] = this.companyDocupload;
    data['profile_docupload'] = this.profileDocupload;
    data['profile_verify_date'] = this.profileVerifyDate;
    data['premium'] = this.premium;
    data['total_chat'] = this.totalChat;
    data['savecandidate'] = this.savecandidate;
    data['interview'] = this.interview;
    data['candidate_view'] = this.candidateView;
    data['total_step'] = this.totalStep;
    data['incomplete'] = this.incomplete;
    data['complete'] = this.complete;
    data['online'] = this.online;
    data['offlinedate'] = this.offlinedate;
    data['pushnotification'] = this.pushnotification;
    return data;
  }
}

class ExperticeArea {
  String? sId;
  String? industryid;
  String? categoryid;
  String? functionalname;
  int? iV;

  ExperticeArea(
      {this.sId,
      this.industryid,
      this.categoryid,
      this.functionalname,
      this.iV});

  ExperticeArea.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    industryid = json['industryid'];
    categoryid = json['categoryid'];
    functionalname = json['functionalname'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['industryid'] = this.industryid;
    data['categoryid'] = this.categoryid;
    data['functionalname'] = this.functionalname;
    data['__v'] = this.iV;
    return data;
  }
}

class Experience {
  String? sId;
  String? name;
  int? iV;
  String? updatedAt;

  Experience({this.sId, this.name, this.iV, this.updatedAt});

  Experience.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['__v'] = this.iV;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Education {
  String? sId;
  String? name;
  List<String>? digree;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Education(
      {this.sId,
      this.name,
      this.digree,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Education.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    digree = json['digree'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['digree'] = this.digree;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Company {
  CLocation? cLocation;
  String? sId;
  String? userid;
  String? legalName;
  String? sortName;
  Industry? industry;
  CSize? cSize;
  String? cWebsite;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Company(
      {this.cLocation,
      this.sId,
      this.userid,
      this.legalName,
      this.sortName,
      this.industry,
      this.cSize,
      this.cWebsite,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Company.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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


class Jobtype {
  String? sId;
  String? worktype;
  int? iV;

  Jobtype({this.sId, this.worktype, this.iV});

  Jobtype.fromJson(Map<String, dynamic> json) {
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

class PaymentHistoryModel {
  String? sId;
  Packageid? packageid;
  Recruiterid? recruiterid;
  DateTime? starddate;
  DateTime? enddate;
  int? activeType;
  bool? active;
  TransactionID? transactionID;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PaymentHistoryModel(
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

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    packageid = json['packageid'] != null
        ? new Packageid.fromJson(json['packageid'])
        : null;
    recruiterid = json['recruiterid'] != null
        ? new Recruiterid.fromJson(json['recruiterid'])
        : null;
    starddate = DateTime.parse(json["starddate"]);
    enddate = DateTime.parse(json["enddate"]);
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
    if (this.recruiterid != null) {
      data['recruiterid'] = this.recruiterid!.toJson();
    }
    data['starddate'] = this.starddate?.toIso8601String();
    data['enddate'] = this.enddate?.toIso8601String();
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

class Recruiterid {
  Other? other;
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

  Recruiterid(
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

  Recruiterid.fromJson(Map<String, dynamic> json) {
    other = json['other'] != null ? new Other.fromJson(json['other']) : null;
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

class Other {
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

class TransactionID {
  String? pgTxnid;
  String? merTxnid;
  String? riskTitle;
  String? riskLevel;
  String? cusName;
  String? cusEmail;
  String? cusPhone;
  dynamic desc;
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

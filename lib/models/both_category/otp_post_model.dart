class OtpPostModel {
  String? number;
  String? otp;
  String? isrecruiter;

  OtpPostModel({this.number, this.otp, this.isrecruiter});

  OtpPostModel.fromJson(Map<String, String> json) {
    number = json['number'];
    otp = json['otp'];
    isrecruiter = json['isrecruiter'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['number'] = this.number!;
    data['otp'] = this.otp!;
    data['isrecruiter'] = this.isrecruiter!;
    return data;
  }
}

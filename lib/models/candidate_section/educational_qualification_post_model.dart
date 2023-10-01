
class EducationQualificationPostModel {
    String? institutename;
    String? digree;
    String? subject;
    int? type;
    String? grade;
    String? gradetype;
    String? startdate;
    String? enddate;
    String? otheractivity;

    EducationQualificationPostModel({
        this.institutename,
        this.digree,
        this.subject,
        this.type,
        this.grade,
        this.gradetype,
        this.startdate,
        this.enddate,
        this.otheractivity,
    });

    factory EducationQualificationPostModel.fromJson(Map<String, dynamic> json) => EducationQualificationPostModel(
        institutename: json["institutename"],
        digree: json["digree"],
        subject: json["subject"],
        type: json["type"],
        grade: json["grade"],
        gradetype: json["gradetype"],
        startdate: json["startdate"],
        enddate: json["enddate"],
        otheractivity: json["otheractivity"],
    );

    Map<String, dynamic> toJson() => {
        "institutename": institutename,
        "digree": digree,
        "subject": subject,
        "type": type,
        "grade": grade,
        "gradetype": gradetype,
        "startdate": startdate,
        "enddate": enddate,
        "otheractivity": otheractivity,
    };
}

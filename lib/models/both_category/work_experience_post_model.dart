
class WorkExperiencePostModel {
    String? companyname;
    String? category;
    String? startdate;
    String? enddate;
    String? expertisearea;
    String? designation;
    String? department;
    String? dutiesandresponsibilities;
    String? careermilestones;
    bool? workintern;
    bool? hidedetails;

    WorkExperiencePostModel({
        this.companyname,
        this.category,
        this.startdate,
        this.enddate,
        this.expertisearea,
        this.designation,
        this.department,
        this.dutiesandresponsibilities,
        this.careermilestones,
        this.workintern,
        this.hidedetails,
    });

    factory WorkExperiencePostModel.fromJson(Map<String, dynamic> json) => WorkExperiencePostModel(
        companyname: json["companyname"],
        category: json["category"],
        startdate: json["startdate"],
        enddate: json["enddate"],
        expertisearea: json["expertisearea"],
        designation: json["designation"],
        department: json["department"],
        dutiesandresponsibilities: json["dutiesandresponsibilities"],
        careermilestones: json["careermilestones"],
        workintern: json["workintern"],
        hidedetails: json["hidedetails"],
    );

    Map<String, dynamic> toJson() => {
        "companyname": companyname,
        "category": category,
        "startdate": startdate,
        "enddate": enddate,
        "expertisearea": expertisearea,
        "designation": designation,
        "department": department,
        "dutiesandresponsibilities": dutiesandresponsibilities,
        "careermilestones": careermilestones,
        "workintern": workintern,
        "hidedetails": hidedetails,
    };
}

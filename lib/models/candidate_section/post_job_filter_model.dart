
class PostJobFilterModel {
    List<bool>? workplace;
    List<String>? education;
    List<String>? salary;
    List<String>? experience;
    List<String>? industry;
    List<String>? companysize;

    PostJobFilterModel({
        this.workplace,
        this.education,
        this.salary,
        this.experience,
        this.industry,
        this.companysize,
    });

    factory PostJobFilterModel.fromJson(Map<String, dynamic> json) => PostJobFilterModel(
        workplace: List<bool>.from(json["workplace"].map((x) => x)),
        education: List<String>.from(json["education"].map((x) => x)),
        salary: List<String>.from(json["salary"].map((x) => x)),
        experience: List<String>.from(json["experience"].map((x) => x)),
        industry: List<String>.from(json["industry"].map((x) => x)),
        companysize: List<String>.from(json["companysize"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "workplace": List<dynamic>.from(workplace!.map((x) => x)),
        "education": List<dynamic>.from(education!.map((x) => x)),
        "salary": List<dynamic>.from(salary!.map((x) => x)),
        "experience": List<dynamic>.from(experience!.map((x) => x)),
        "industry": List<dynamic>.from(industry!.map((x) => x)),
        "companysize": List<dynamic>.from(companysize!.map((x) => x)),
    };
}

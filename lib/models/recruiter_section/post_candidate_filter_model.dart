
class PostCandidateFilterModel {
    List<bool>? workplace;
    List<String>? education;
    List<String>? salary;
    List<String>? experience;
    List<String>? industry;

    PostCandidateFilterModel({
        this.workplace,
        this.education,
        this.salary,
        this.experience,
        this.industry,
    });

    factory PostCandidateFilterModel.fromJson(Map<String, dynamic> json) => PostCandidateFilterModel(
        workplace: List<bool>.from(json["workplace"].map((x) => x)),
        education: List<String>.from(json["education"].map((x) => x)),
        salary: List<String>.from(json["salary"].map((x) => x)),
        experience: List<String>.from(json["experience"].map((x) => x)),
        industry: List<String>.from(json["industry"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "workplace": List<dynamic>.from(workplace!.map((x) => x)),
        "education": List<dynamic>.from(education!.map((x) => x)),
        "salary": List<dynamic>.from(salary!.map((x) => x)),
        "experience": List<dynamic>.from(experience!.map((x) => x)),
        "industry": List<dynamic>.from(industry!.map((x) => x)),
    };
}

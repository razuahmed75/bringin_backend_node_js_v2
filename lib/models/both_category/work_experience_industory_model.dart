// To parse this JSON data, do
//
//     final workExperienceIndustryModel = workExperienceIndustryModelFromJson(jsonString);


class WorkExperienceIndustryModel {
    int? id;
    String? name;
    String? parentIndustryName;
    String? featured;
    dynamic createdAt;
    dynamic updatedAt;

    WorkExperienceIndustryModel({
        this.id,
        this.name,
        this.parentIndustryName,
        this.featured,
        this.createdAt,
        this.updatedAt,
    });

    factory WorkExperienceIndustryModel.fromJson(Map<String, dynamic> json) => WorkExperienceIndustryModel(
        id: json["id"],
        name: json["name"],
        parentIndustryName: json["parent_industry_name"],
        featured: json["featured"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_industry_name": parentIndustryName,
        "featured": featured,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

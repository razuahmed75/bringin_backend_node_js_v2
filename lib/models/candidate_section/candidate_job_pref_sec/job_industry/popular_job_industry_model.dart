class PopularIndustryModel {
    int? id;
    String? name;
    dynamic slug;
    String? parentIndustryId;
    String? featured;
    dynamic createdAt;
    dynamic updatedAt;
    String? usersCount;

    PopularIndustryModel({
        this.id,
        this.name,
        this.slug,
        this.parentIndustryId,
        this.featured,
        this.createdAt,
        this.updatedAt,
        this.usersCount,
    });

    factory PopularIndustryModel.fromJson(Map<String, dynamic> json) => PopularIndustryModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        parentIndustryId: json["parent_industry_id"],
        featured: json["featured"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        usersCount: json["users_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "parent_industry_id": parentIndustryId,
        "featured": featured,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "users_count": usersCount,
    };
}

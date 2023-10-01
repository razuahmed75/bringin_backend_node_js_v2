
class AllindustryModel {
    int? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Category>? categories;

    AllindustryModel({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.categories,
    });

    factory AllindustryModel.fromJson(Map<String, dynamic> json) => AllindustryModel(
        id: json["id"],
        name: json["name"],
        createdAt:  DateTime.now() ,
        updatedAt:  DateTime.now() ,
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    };
}

class Category {
    int? id;
    String? name;
    dynamic slug;
    String? parentIndustryId;
    String? featured;
    dynamic createdAt;
    dynamic updatedAt;

    Category({
        this.id,
        this.name,
        this.slug,
        this.parentIndustryId,
        this.featured,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        parentIndustryId: json["parent_industry_id"],
        featured: json["featured"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "parent_industry_id": parentIndustryId,
        "featured": featured,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class CompanyNameModel {
    int? id;
    String? name;

    CompanyNameModel({
        this.id,
        this.name,
    });

    factory CompanyNameModel.fromJson(Map<String, dynamic> json) => CompanyNameModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

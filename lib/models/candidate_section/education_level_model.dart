
import 'dart:convert';

List<EducationLevelModel> educationLevelModelFromJson(String str) => List<EducationLevelModel>.from(json.decode(str).map((x) => EducationLevelModel.fromJson(x)));

String educationLevelModelToJson(List<EducationLevelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EducationLevelModel {
    String? id;
    String? name;
    int? v;
    List<EducationLevelModel>? digree;
    Education? education;

    EducationLevelModel({
        this.id,
        this.name,
        this.v,
        this.digree,
        this.education,
    });

    factory EducationLevelModel.fromJson(Map<String, dynamic> json) => EducationLevelModel(
        id: json["_id"],
        name: json["name"],
        v: json["__v"],
        digree: json["digree"] == null ? null : List<EducationLevelModel>.from(json["digree"].map((x) => EducationLevelModel.fromJson(x))),
        education: educationValues.map[json["education"]],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
        "digree": List<dynamic>.from(digree!.map((x) => x.toJson())),
        "education": educationValues.reverse[education],
    };
}

enum Education { THE_648_FE8462_B1_BEFEC7_CBF6_C0_F, THE_648_FE8512_B1_BEFEC7_CBF6_C14, THE_648_FE85_A2_B1_BEFEC7_CBF6_C17, THE_648_FE8632_B1_BEFEC7_CBF6_C1_A, THE_648_FE86_D2_B1_BEFEC7_CBF6_C1_D }

final educationValues = EnumValues({
    "648fe8462b1befec7cbf6c0f": Education.THE_648_FE8462_B1_BEFEC7_CBF6_C0_F,
    "648fe8512b1befec7cbf6c14": Education.THE_648_FE8512_B1_BEFEC7_CBF6_C14,
    "648fe85a2b1befec7cbf6c17": Education.THE_648_FE85_A2_B1_BEFEC7_CBF6_C17,
    "648fe8632b1befec7cbf6c1a": Education.THE_648_FE8632_B1_BEFEC7_CBF6_C1_A,
    "648fe86d2b1befec7cbf6c1d": Education.THE_648_FE86_D2_B1_BEFEC7_CBF6_C1_D
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

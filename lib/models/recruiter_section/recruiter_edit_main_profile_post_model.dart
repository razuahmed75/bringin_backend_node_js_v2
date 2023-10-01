
class RecruiterEditMainProfilePostModel {
    String? firstname;
    String? lastname;
    String? designation;
    String? email;

    RecruiterEditMainProfilePostModel({
         this.firstname,
         this.lastname,
         this.designation,
         this.email,
    });

    factory RecruiterEditMainProfilePostModel.fromJson(Map<String, String> json) => RecruiterEditMainProfilePostModel(
        firstname: json["firstname"],
        lastname: json["lastname"],
        designation: json["designation"],
        email: json["email"],
    );

    Map<String, String> toJson() => {
        "firstname": firstname!,
        "lastname": lastname!,
        "designation": designation!,
        "email": email!,
    };
}

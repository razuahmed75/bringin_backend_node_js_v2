
class EmployeeSizeModel {
    int? status;
    List<EmployeeSize>? employeeSize;

    EmployeeSizeModel({
        this.status,
        this.employeeSize,
    });

    factory EmployeeSizeModel.fromJson(Map<String, dynamic> json) => EmployeeSizeModel(
        status: json["status"],
        employeeSize: List<EmployeeSize>.from(json["employee_size"].map((x) => EmployeeSize.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "employee_size": List<dynamic>.from(employeeSize!.map((x) => x.toJson())),
    };
}

class EmployeeSize {
    int? id;
    String? size;
    DateTime? createdAt;
    String? updatedAt;

    EmployeeSize({
        this.id,
        this.size,
        this.createdAt,
        this.updatedAt,
    });

    factory EmployeeSize.fromJson(Map<String, dynamic> json) => EmployeeSize(
        id: json["id"],
        size: json["size"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "size": size,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt,
    };
}

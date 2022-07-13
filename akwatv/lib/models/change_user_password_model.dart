// To parse this JSON data, do
//
//     final changeUserPassword = changeUserPasswordFromJson(jsonString);

import 'dart:convert';

ChangeUserPassword changeUserPasswordFromJson(String str) => ChangeUserPassword.fromJson(json.decode(str));

String changeUserPasswordToJson(ChangeUserPassword data) => json.encode(data.toJson());

class ChangeUserPassword {
    ChangeUserPassword({
        this.data,
        this.errors,
        this.message,
    });

    final Data? data;
    final Data? errors;
    final dynamic message;

    factory ChangeUserPassword.fromJson(Map<String, dynamic> json) => ChangeUserPassword(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errors: json["errors"] == null ? null : Data.fromJson(json["errors"]),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "errors": errors == null ? null : errors!.toJson(),
        "message": message == null ? null : message,
    };
}

class Data {
    Data();

    factory Data.fromJson(Map<String, dynamic> json) => Data(
    );

    Map<String, dynamic> toJson() => {
    };
}

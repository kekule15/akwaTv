// To parse this JSON data, do
//
//     final forgotPassWordModel = forgotPassWordModelFromJson(jsonString);

import 'dart:convert';

ForgotPassWordModel forgotPassWordModelFromJson(String str) => ForgotPassWordModel.fromJson(json.decode(str));

String forgotPassWordModelToJson(ForgotPassWordModel data) => json.encode(data.toJson());

class ForgotPassWordModel {
    ForgotPassWordModel({
        this.data,
        this.errors,
        this.message,
    });

    final Data? data;
    final Data? errors;
    final String? message;

    factory ForgotPassWordModel.fromJson(Map<String, dynamic> json) => ForgotPassWordModel(
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

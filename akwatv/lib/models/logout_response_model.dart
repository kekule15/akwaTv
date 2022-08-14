// To parse this JSON data, do
//
//     final logoutResponseModel = logoutResponseModelFromJson(jsonString);

import 'dart:convert';

LogoutResponseModel logoutResponseModelFromJson(String str) => LogoutResponseModel.fromJson(json.decode(str));

String logoutResponseModelToJson(LogoutResponseModel data) => json.encode(data.toJson());

class LogoutResponseModel {
    LogoutResponseModel({
        this.data,
        this.errors,
        this.message,
        this.level,
    });

    final Data? data;
    final Data? errors;
    final String? message;
    final String? level;

    factory LogoutResponseModel.fromJson(Map<String, dynamic> json) => LogoutResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errors: json["errors"] == null ? null : Data.fromJson(json["errors"]),
        message: json["message"] == null ? null : json["message"],
        level: json["level"] == null ? null : json["level"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "errors": errors == null ? null : errors!.toJson(),
        "message": message == null ? null : message,
        "level": level == null ? null : level,
    };
}

class Data {
    Data();

    factory Data.fromJson(Map<String, dynamic> json) => Data(
    );

    Map<String, dynamic> toJson() => {
    };
}

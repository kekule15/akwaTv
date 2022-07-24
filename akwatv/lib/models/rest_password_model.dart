// To parse this JSON data, do
//
//     final resetPassWordModel = resetPassWordModelFromJson(jsonString);

import 'dart:convert';

ResetPassWordModel resetPassWordModelFromJson(String str) => ResetPassWordModel.fromJson(json.decode(str));

String resetPassWordModelToJson(ResetPassWordModel data) => json.encode(data.toJson());

class ResetPassWordModel {
    ResetPassWordModel({
        this.data,
        this.errors,
        this.message,
    });

    final Data? data;
    final Data? errors;
    final String? message;

    factory ResetPassWordModel.fromJson(Map<String, dynamic> json) => ResetPassWordModel(
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

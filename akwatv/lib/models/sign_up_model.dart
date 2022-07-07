// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    SignUpModel({
        this.data,
        this.errors,
        this.message,
    });

    final Data? data;
    final Data? errors;
    final dynamic message;

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        data: Data.fromJson(json["data"]),
        errors: Data.fromJson(json["errors"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "errors": errors!.toJson(),
        "message": message,
    };
}

class Data {
    Data();

    factory Data.fromJson(Map<String, dynamic> json) => Data(
    );

    Map<String, dynamic> toJson() => {
    };
}

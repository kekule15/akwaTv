// To parse this JSON data, do
//
//     final likeVideoResponseModel = likeVideoResponseModelFromJson(jsonString);

import 'dart:convert';

LikeVideoResponseModel likeVideoResponseModelFromJson(String str) => LikeVideoResponseModel.fromJson(json.decode(str));

String likeVideoResponseModelToJson(LikeVideoResponseModel data) => json.encode(data.toJson());

class LikeVideoResponseModel {
    LikeVideoResponseModel({
        this.data,
        this.errors,
        this.message,
    });

    final bool? data;
    final Errors? errors;
    final String? message;

    factory LikeVideoResponseModel.fromJson(Map<String, dynamic> json) => LikeVideoResponseModel(
        data: json["data"] == null ? null : json["data"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data,
        "errors": errors == null ? null : errors!.toJson(),
        "message": message == null ? null : message,
    };
}

class Errors {
    Errors();

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    );

    Map<String, dynamic> toJson() => {
    };
}

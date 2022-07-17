// To parse this JSON data, do
//
//     final getWatchListModel = getWatchListModelFromJson(jsonString);

import 'dart:convert';

GetWatchListModel getWatchListModelFromJson(String str) => GetWatchListModel.fromJson(json.decode(str));

String getWatchListModelToJson(GetWatchListModel data) => json.encode(data.toJson());

class GetWatchListModel {
    GetWatchListModel({
        this.data,
        this.errors,
        this.message,
    });

    final List<String>? data;
    final Errors? errors;
    final String? message;

    factory GetWatchListModel.fromJson(Map<String, dynamic> json) => GetWatchListModel(
        data: json["data"] == null ? null : List<String>.from(json["data"].map((x) => x)),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
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

// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    CategoryModel({
        this.data,
        this.errors,
        this.message,
    });

    final List<Items>? data;
    final Errors? errors;
    final String? message;

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        data: json["data"] == null ? null : List<Items>.from(json["data"].map((x) => Items.fromJson(x))),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors": errors == null ? null : errors!.toJson(),
        "message": message == null ? null : message,
    };
}

class Items {
    Items({
        this.id,
        this.title,
        this.type,
        this.genre,
        this.content,
        this.timestamps,
        this.v,
    });

    final String? id;
    final String? title;
    final String? type;
    final String? genre;
    final List<String>? content;
    final DateTime? timestamps;
    final int? v;

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
        genre: json["genre"] == null ? null : json["genre"],
        content: json["content"] == null ? null : List<String>.from(json["content"].map((x) => x)),
        timestamps: json["timestamps"] == null ? null : DateTime.parse(json["timestamps"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "type": type == null ? null : type,
        "genre": genre == null ? null : genre,
        "content": content == null ? null : List<dynamic>.from(content!.map((x) => x)),
        "timestamps": timestamps == null ? null : timestamps!.toIso8601String(),
        "__v": v == null ? null : v,
    };
}

class Errors {
    Errors();

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    );

    Map<String, dynamic> toJson() => {
    };
}

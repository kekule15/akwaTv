// To parse this JSON data, do
//
//     final searchResponseModel = searchResponseModelFromJson(jsonString);

import 'dart:convert';

SearchResponseModel searchResponseModelFromJson(String str) => SearchResponseModel.fromJson(json.decode(str));

String searchResponseModelToJson(SearchResponseModel data) => json.encode(data.toJson());

class SearchResponseModel {
    SearchResponseModel({
        this.data,
        this.errors,
        this.message,
    });

    final List<Datum>? data;
    final Errors? errors;
    final String? message;

    factory SearchResponseModel.fromJson(Map<String, dynamic> json) => SearchResponseModel(
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors": errors == null ? null : errors!.toJson(),
        "message": message == null ? null : message,
    };
}

class Datum {
    Datum({
        this.id,
        this.title,
        this.desc,
        this.img,
        this.imgTitle,
        this.imgSmall,
        this.trailer,
        this.video,
        this.movieRating,
        this.likes,
        this.dislikes,
        this.year,
        this.ageLimit,
        this.genre,
        this.isSeries,
        this.timestamps,
        this.v,
    });

    final String? id;
    final String? title;
    final String? desc;
    final String? img;
    final String? imgTitle;
    final String? imgSmall;
    final String? trailer;
    final String? video;
    final int? movieRating;
    final int? likes;
    final int? dislikes;
    final String? year;
    final int? ageLimit;
    final String? genre;
    final bool? isSeries;
    final DateTime? timestamps;
    final int? v;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        desc: json["desc"] == null ? null : json["desc"],
        img: json["img"] == null ? null : json["img"],
        imgTitle: json["imgTitle"] == null ? null : json["imgTitle"],
        imgSmall: json["imgSmall"] == null ? null : json["imgSmall"],
        trailer: json["trailer"] == null ? null : json["trailer"],
        video: json["video"] == null ? null : json["video"],
        movieRating: json["movieRating"] == null ? null : json["movieRating"],
        likes: json["likes"] == null ? null : json["likes"],
        dislikes: json["dislikes"] == null ? null : json["dislikes"],
        year: json["year"] == null ? null : json["year"],
        ageLimit: json["ageLimit"] == null ? null : json["ageLimit"],
        genre: json["genre"] == null ? null : json["genre"],
        isSeries: json["isSeries"] == null ? null : json["isSeries"],
        timestamps: json["timestamps"] == null ? null : DateTime.parse(json["timestamps"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "desc": desc == null ? null : desc,
        "img": img == null ? null : img,
        "imgTitle": imgTitle == null ? null : imgTitle,
        "imgSmall": imgSmall == null ? null : imgSmall,
        "trailer": trailer == null ? null : trailer,
        "video": video == null ? null : video,
        "movieRating": movieRating == null ? null : movieRating,
        "likes": likes == null ? null : likes,
        "dislikes": dislikes == null ? null : dislikes,
        "year": year == null ? null : year,
        "ageLimit": ageLimit == null ? null : ageLimit,
        "genre": genre == null ? null : genre,
        "isSeries": isSeries == null ? null : isSeries,
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

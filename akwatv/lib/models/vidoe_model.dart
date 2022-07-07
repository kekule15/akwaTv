// To parse this JSON data, do
//
//     final homeVideoModel = homeVideoModelFromJson(jsonString);

import 'dart:convert';

HomeVideoModel homeVideoModelFromJson(String str) => HomeVideoModel.fromJson(json.decode(str));

String homeVideoModelToJson(HomeVideoModel data) => json.encode(data.toJson());

class HomeVideoModel {
    HomeVideoModel({
        this.data,
        this.errors,
        this.message,
    });

    final List<Datum>? data;
    final Errors? errors;
    final String? message;

    factory HomeVideoModel.fromJson(Map<String, dynamic> json) => HomeVideoModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errors: Errors.fromJson(json["errors"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors": errors!.toJson(),
        "message": message,
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
    final dynamic movieRating;
    final dynamic likes;
    final dynamic dislikes;
    final String? year;
    final dynamic ageLimit;
    final String? genre;
    final bool? isSeries;
    final DateTime? timestamps;
    final int? v;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        title: json["title"],
        desc: json["desc"],
        img: json["img"],
        imgTitle: json["imgTitle"],
        imgSmall: json["imgSmall"],
        trailer: json["trailer"],
        video: json["video"],
        movieRating: json["movieRating"],
        likes: json["likes"],
        dislikes: json["dislikes"],
        year: json["year"],
        ageLimit: json["ageLimit"],
        genre: json["genre"],
        isSeries: json["isSeries"],
        timestamps: DateTime.parse(json["timestamps"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "desc": desc,
        "img": img,
        "imgTitle": imgTitle,
        "imgSmall": imgSmall,
        "trailer": trailer,
        "video": video,
        "movieRating": movieRating,
        "likes": likes,
        "dislikes": dislikes,
        "year": year,
        "ageLimit": ageLimit,
        "genre": genre,
        "isSeries": isSeries,
        "timestamps": timestamps!.toIso8601String(),
        "__v": v,
    };
}

class Errors {
    Errors();

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    );

    Map<String, dynamic> toJson() => {
    };
}

// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    onlineMp3: List<OnlineMp3>.from(json["ONLINE_MP3"].map((x) => OnlineMp3.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ONLINE_MP3": List<dynamic>.from(onlineMp3.map((x) => x.toJson())),
  };
}

class OnlineMp3 {
  OnlineMp3({
    required this.totalData,
    required this.id,
    required this.catId,
    required this.mp3Type,
    required this.mp3Title,
    required this.mp3Url,
    required this.mp3ThumbnailB,
    required this.mp3ThumbnailS,
    required this.mp3Duration,
    required this.mp3Artist,
    required this.mp3Description,
    required this.totalRate,
    required this.rateAvg,
    required this.totalViews,
    required this.totalDownload,
    required this.cid,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryImageThumb,
  });

  final String totalData;
  final String id;
  final String catId;
  final String mp3Type;
  final String mp3Title;
  final String mp3Url;
  final String mp3ThumbnailB;
  final String mp3ThumbnailS;
  final String mp3Duration;
  final String mp3Artist;
  final String mp3Description;
  final String totalRate;
  final String rateAvg;
  final String totalViews;
  final String totalDownload;
  final String cid;
  final String categoryName;
  final String categoryImage;
  final String categoryImageThumb;

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
    totalData: json["total_data"],
    id: json["id"],
    catId: json["cat_id"],
    mp3Type: json["mp3_type"],
    mp3Title: json["mp3_title"],
    mp3Url: json["mp3_url"],
    mp3ThumbnailB: json["mp3_thumbnail_b"],
    mp3ThumbnailS: json["mp3_thumbnail_s"],
    mp3Duration: json["mp3_duration"],
    mp3Artist: json["mp3_artist"],
    mp3Description: json["mp3_description"],
    totalRate: json["total_rate"],
    rateAvg: json["rate_avg"],
    totalViews: json["total_views"],
    totalDownload: json["total_download"],
    cid: json["cid"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
    categoryImageThumb: json["category_image_thumb"],
  );

  Map<String, dynamic> toJson() => {
    "total_data": totalData,
    "id": id,
    "cat_id": catId,
    "mp3_type": mp3Type,
    "mp3_title": mp3Title,
    "mp3_url": mp3Url,
    "mp3_thumbnail_b": mp3ThumbnailB,
    "mp3_thumbnail_s": mp3ThumbnailS,
    "mp3_duration": mp3Duration,
    "mp3_artist": mp3Artist,
    "mp3_description": mp3Description,
    "total_rate": totalRate,
    "rate_avg": rateAvg,
    "total_views": totalViews,
    "total_download": totalDownload,
    "cid": cid,
    "category_name": categoryName,
    "category_image": categoryImage,
    "category_image_thumb": categoryImageThumb,
  };
}

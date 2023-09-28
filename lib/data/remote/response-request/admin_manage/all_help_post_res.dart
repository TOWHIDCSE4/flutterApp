import '../../../../model/category_help_post.dart';

class AllHelpPostRes {
  AllHelpPostRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Data? data;

  factory AllHelpPostRes.fromJson(Map<String, dynamic> json) => AllHelpPostRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<HelpPostData>? data;

  dynamic nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? null
            : List<HelpPostData>.from(
                json["data"].map((x) => HelpPostData.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class HelpPostData {
  HelpPostData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.helpPost,
    this.categoryHelpPost,
  });

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  HelpPost? helpPost;
  CategoryHelpPost? categoryHelpPost;

  factory HelpPostData.fromJson(Map<String, dynamic> json) => HelpPostData(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        helpPost: json["HelpPost"] == null
            ? null
            : HelpPost.fromJson(json["HelpPost"]),
        categoryHelpPost: json["CategoryHelpPost"] == null
            ? null
            : CategoryHelpPost.fromJson(json["CategoryHelpPost"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "HelpPost": helpPost == null ? null : helpPost?.toJson(),
        "CategoryHelpPost":
            categoryHelpPost == null ? null : categoryHelpPost?.toJson(),
      };
}

// class CategoryHelpPost1 {
//   CategoryHelpPost1({
//     this.id,
//     this.isShow,
//     this.imageUrl,
//     this.title,
//     this.description,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int? id;
//   bool? isShow;
//   String? imageUrl;
//   String? title;
//   String? description;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   factory CategoryHelpPost1.fromJson(Map<String, dynamic> json) =>
//       CategoryHelpPost1(
//         id: json["id"] == null ? null : json["id"],
//         isShow: json["is_show"] == null ? null : json["is_show"],
//         imageUrl: json["image_url"] == null ? null : json["image_url"],
//         title: json["title"] == null ? null : json["title"],
//         description: json["description"] == null ? null : json["description"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "is_show": isShow == null ? null : isShow,
//         "image_url": imageUrl == null ? null : imageUrl,
//         "title": title == null ? null : title,
//         "description": description == null ? null : description,
//         "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
//       };
// }

class HelpPost {
  HelpPost({
    this.id,
    this.title,
    this.imageUrl,
    this.summary,
    this.content,
    this.isShow,
    this.countView,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? imageUrl;
  String? summary;
  String? content;
  dynamic isShow;
  int? countView;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HelpPost.fromJson(Map<String, dynamic> json) => HelpPost(
        id: json["id"],
        title: json["title"],
        imageUrl: json["image_url"],
        summary: json["summary"],
        content: json["content"],
        isShow: json["is_show"],
        countView: json["count_view"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image_url": imageUrl,
        "summary": summary,
        "content": content,
        "is_show": isShow,
        "count_view": countView,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}

class HelpPostRequest {
  HelpPostRequest(
      {this.categoryHelpPostId,
      this.title,
      this.imageUrl,
      this.published,
      this.summary,
      this.content,
      this.isShow});

  int? categoryHelpPostId;
  String? title;
  String? imageUrl;
  bool? published;
  String? summary;
  String? content;
  bool? isShow;

  // factory HelpPostRequest.fromJson(Map<String, dynamic> json) => HelpPostRequest(
  //     categoryHelpPostId: json["category_help_post_id"] == null ? null : json["category_help_post_id"],
  //     title: json["title"] == null ? null : json["title"],
  //     imageUrl: json["image_url"] == null ? null : json["image_url"],
  //     published: json["published"] == null ? null : json["published"],
  //     summary: json["summary"] == null ? null : json["summary"],
  //     content: json["content"] == null ? null : json["content"],
  // );

  Map<String, dynamic> toJson() => {
        "category_help_post_id":
            categoryHelpPostId,
        "title": title,
        "image_url": imageUrl,
        "published": published,
        "summary": summary,
        "content": content,
        "is_show": isShow,
      };
}

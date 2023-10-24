class CategoryHelpPost {
  CategoryHelpPost({
    this.id,
    this.isShow,
    this.imageUrl,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.helpPosts,
  });

  int? id;
  bool? isShow;
  String? imageUrl;
  String? title;
  dynamic description;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? helpPosts;

  factory CategoryHelpPost.fromJson(Map<String, dynamic> json) =>
      CategoryHelpPost(
        id: json["id"],
        isShow: json["is_show"],
        imageUrl: json["image_url"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        helpPosts: json["help_posts"] == null
            ? null
            : List<dynamic>.from(json["help_posts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_show": isShow,
        "image_url": imageUrl,
        "title": title,
        "description": description,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "help_posts": helpPosts == null
            ? null
            : List<dynamic>.from(helpPosts!.map((x) => x)),
      };
}

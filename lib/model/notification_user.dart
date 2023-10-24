class NotificationUser {
  NotificationUser({
    this.id,
    this.storeId,
    this.content,
    this.title,
    this.type,
    this.referencesValue,
    this.unread,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  String? content;
  String? title;
  String? type;
  String? referencesValue;
  bool? unread;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationUser.fromJson(Map<String, dynamic> json) =>
      NotificationUser(
        id: json["id"],
        storeId: json["store_id"],
        content: json["content"],
        title: json["title"],
        type: json["type"],
        referencesValue:
        json["references_value"],
        unread: json["unread"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
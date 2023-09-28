class AdminNotification {
  AdminNotification({
    this.title,
    this.content,
    this.role,
    this.type,
    this.referenceValue,
  });

  String? title;
  String? content;
  int? role;
  int? type;
  String? referenceValue;

  factory AdminNotification.fromJson(Map<String, dynamic> json) =>
      AdminNotification(
        title: json["title"],
        content: json["content"],
        role: json["role"],
        type: json["type"],
        referenceValue:
            json["reference_value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "role": role,
        "type": type,
        "reference_value": referenceValue,
      };
}

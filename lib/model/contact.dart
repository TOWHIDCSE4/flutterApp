class Contact {
  Contact(
      {this.id,
      this.facebook,
      this.zalo,
      this.email,
      this.phoneNumber,
      this.content,
      this.address,
      this.bankAccountNumber,
      this.createdAt,
      this.updatedAt,
      this.bankAccountName,
      this.bankName});

  int? id;
  String? facebook;
  dynamic zalo;
  String? email;
  String? phoneNumber;
  dynamic content;
  dynamic address;
  String? bankAccountNumber;
  String? bankAccountName;
  String? bankName;

  DateTime? createdAt;
  DateTime? updatedAt;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        facebook: json["facebook"],
        zalo: json["zalo"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        content: json["content"],
        address: json["address"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        bankAccountNumber: json['bank_account_number'],
        bankAccountName: json['bank_account_name'],
        bankName: json['bank_name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "facebook": facebook,
        "zalo": zalo,
        "email": email,
        "phone_number": phoneNumber,
        "content": content,
        "address": address,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "bank_account_number": bankAccountNumber,
        "bank_account_name": bankAccountName,
        "bank_name": bankName
      };
}

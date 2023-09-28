class Service {
  Service(
      {this.id,
      this.userId,
      this.serviceName,
      this.serviceIcon,
      this.serviceUnit,
      this.serviceCharge,
      this.typeUnit,
      this.note,
      this.total,
      this.quantity,
      this.quantityGetOld,
      this.oldQuantity,
      this.images,
      this.createdAt,
      this.updatedAt,
      this.uuid});

  int? id;
  int? userId;
  String? serviceName;
  String? serviceIcon;
  String? serviceUnit;
  double? serviceCharge;
  int? typeUnit;
  String? note;
  num? total;
  int? quantity;
  int? oldQuantity;
  int? quantityGetOld;
  List<String>? images;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? uuid;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        uuid: json['id'].toString(),
        userId: json["user_id"],
        serviceName: json["service_name"],
        serviceIcon: json["service_icon"],
        serviceUnit: json["service_unit"],
        typeUnit: json["type_unit"],
        serviceCharge: json["service_charge"] == null
            ? null
            : json["service_charge"].toDouble(),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        total: json["total"],
        quantity: json["quantity"],
        oldQuantity: json["old_quantity"],
        quantityGetOld: json["quantity"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "service_name": serviceName,
        "service_icon": serviceIcon,
        "service_unit": serviceUnit,
        "type_unit": typeUnit,
        "old_quantity": oldQuantity,
        "quantity": quantity,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "service_charge": serviceCharge,
        "note": note,
      };
}

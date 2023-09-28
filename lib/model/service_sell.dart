import 'category.dart';

class ServiceSell {
  ServiceSell({
    this.id,
    this.name,
    this.nameStrFilter,
    this.images,
    this.price,
    this.serviceSellIcon,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.categoryServiceSellId,this.category,this.sold
  });

  int? id;
  String? name;
  String? nameStrFilter;
  List<String>? images = [];
  String? serviceSellIcon;
  String? description;
  int? categoryServiceSellId;
  double? price;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Category? category;
  int? sold;

  factory ServiceSell.fromJson(Map<String, dynamic> json) => ServiceSell(
        id: json["id"],
        name: json["name"],
        serviceSellIcon: json["service_sell_icon"],
        description: json["description"],
        nameStrFilter:
            json["name_str_filter"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        price: json["price"] == null ? null : json["price"].toDouble(),
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        categoryServiceSellId:json["category_service_sell_id"],
        category : json["category_service_sell"] == null ? null : Category.fromJson(json["category_service_sell"]),
        sold: json['sold']
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_str_filter": nameStrFilter,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "price": price,
        "status": status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        'service_sell_icon': serviceSellIcon,
        "description": description,
        "category_service_sell_id" : categoryServiceSellId,
        "sold":sold
      };
}

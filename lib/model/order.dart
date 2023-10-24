import 'package:gohomy/model/service_sell.dart';

import 'category.dart';

class Order {
  Order({
    this.userId,
    this.orderCode,
    this.orderStatus,
    this.paymentStatus,
    this.totalShippingFee,
    this.totalBeforeDiscount,
    this.totalFinal,
    this.name,
    this.email,
    this.phoneNumber,
    this.provinceName,
    this.districtName,
    this.wardsName,
    this.province,
    this.district,
    this.wards,
    this.addressDetail,
    this.note,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.listCategory,
  });

  int? userId;
  String? orderCode;
  int? orderStatus;
  int? paymentStatus;
  double? totalShippingFee;
  double? totalBeforeDiscount;
  double? totalFinal;
  String? name;
  String? email;
  String? phoneNumber;
  String? provinceName;
  String? districtName;
  String? wardsName;
  int? province;
  int? district;
  int? wards;
  String? addressDetail;
  String? note;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  List<Category>? listCategory;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        userId: json["user_id"],
        orderCode: json["order_code"],
        orderStatus: json["order_status"],
        paymentStatus:
            json["payment_status"],
        totalShippingFee: json["total_shipping_fee"] == null
            ? null
            : json["total_shipping_fee"].toDouble(),
        totalBeforeDiscount: json["total_before_discount"] == null
            ? null
            : json["total_before_discount"].toDouble(),
        totalFinal:
            json["total_final"] == null ? null : json["total_final"].toDouble(),
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        provinceName:
            json["province_name"],
        districtName:
            json["district_name"],
        wardsName: json["wards_name"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        addressDetail:
            json["address_detail"],
        note: json["note"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        listCategory: json["list_category_service_sell"] == null
            ? null
            : List<Category>.from(json["list_category_service_sell"]
                .map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "order_code": orderCode,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "total_shipping_fee":
            totalShippingFee,
        "total_final": totalFinal,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "province_name": provinceName,
        "district_name": districtName,
        "wards_name": wardsName,
        "province": province,
        "district": district,
        "wards": wards,
        "address_detail": addressDetail,
        "note": note,
        "id": id,
      };
}

class ListServiceSell {
  ListServiceSell({
    this.id,
    this.userId,
    this.serviceSellId,
    this.quantity,
    this.itemPrice,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.serviceSell,this.categoryServiceSellId,this.orderServiceSellId,this.totalPrice,this.nameServiceSell
  });

  int? id;
  int? userId;
  int? categoryServiceSellId;
  int? orderServiceSellId;
  int? serviceSellId;
  int? quantity;
  double? itemPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? images;
  ServiceSell? serviceSell;
  double? totalPrice;
  String? nameServiceSell;

  factory ListServiceSell.fromJson(Map<String, dynamic> json) =>
      ListServiceSell(
        id: json["id"],
        userId: json["user_id"],
        serviceSellId:
            json["service_sell_id"],
        quantity: json["quantity"],
        itemPrice: json["item_price"] == null ? null : json["item_price"].toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        serviceSell: json["service_sell"] == null
            ? null
            : ServiceSell.fromJson(json["service_sell"]),
        nameServiceSell: json["name_service_sell"],
        totalPrice: json["total_price"] == null ? null : json["total_price"].toDouble(),
        categoryServiceSellId: json["category_service_sell_id"],
        orderServiceSellId: json["order_service_sell_id"]
      );
}

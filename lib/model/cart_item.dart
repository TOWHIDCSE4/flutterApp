import 'service_sell.dart';

class CartItem {
  CartItem({
    this.id,
    this.userId,
    this.serviceSellId,
    this.quantity,
    this.itemPrice,
    this.createdAt,
    this.updatedAt,
    this.serviceSell,
  });

  int? id;
  int? userId;
  int? serviceSellId;
  int? quantity;
  int? itemPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  ServiceSell? serviceSell;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        userId: json["user_id"],
        serviceSellId:
            json["service_sell_id"],
        quantity: json["quantity"],
        itemPrice: json["item_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        serviceSell: json["service_sell"] == null
            ? null
            : ServiceSell.fromJson(json["service_sell"]),
      );

  Map<String, dynamic> toJson() => {
        "cart_item_id": id,
        "service_sell_id": serviceSellId,
        "quantity": quantity,
      };
}

import 'cart_item.dart';

class Cart {
  Cart({
    this.totalBeforeDiscount,
    this.totalShippingFee,
    this.totalFinal,
    this.cartItems,
  });

  double? totalBeforeDiscount;
  double? totalShippingFee;
  double? totalFinal;
  List<CartItem>? cartItems;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    totalBeforeDiscount: json["total_before_discount"] == null
        ? null
        : json["total_before_discount"].toDouble(),
    totalShippingFee: json["total_shipping_fee"] == null
        ? null
        : json["total_shipping_fee"].toDouble(),
    totalFinal:
    json["total_final"] == null ? null : json["total_final"].toDouble(),
    cartItems: json["cart_items"] == null
        ? null
        : List<CartItem>.from(
        json["cart_items"].map((x) => CartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_before_discount":
    totalBeforeDiscount,
    "total_shipping_fee":
    totalShippingFee,
    "total_final": totalFinal,
    "cart_items": cartItems == null
        ? null
        : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
  };
}
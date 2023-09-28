class ChartOrder {
  ChartOrder({
    this.time,
    this.totalOrderCount,
    this.totalShippingFee,
    this.totalBeforeDiscount,
    this.totalFinal,
  });

  DateTime? time;
  int? totalOrderCount;
  double? totalShippingFee;
  double? totalBeforeDiscount;
  double? totalFinal;

  factory ChartOrder.fromJson(Map<String, dynamic> json) => ChartOrder(
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        totalOrderCount: json["total_order_count"],
        totalShippingFee: json["total_shipping_fee"] == null
            ? null
            : json["total_shipping_fee"].toDouble(),
        totalBeforeDiscount: json["total_before_discount"] == null
            ? null
            : json["total_before_discount"].toDouble(),
        totalFinal:
            json["total_final"] == null ? null : json["total_final"].toDouble(),
      );
}

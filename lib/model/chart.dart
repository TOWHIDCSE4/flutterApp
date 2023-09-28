class Chart {
  Chart({
    this.totalMoneyMotel,
    this.totalMoneyService,
    this.discount,
    this.totalFinal,
    this.datePayment,
    this.year,
    this.month,
  });

  double? totalMoneyMotel;
  double? totalMoneyService;
  double? discount;
  double? totalFinal;
  DateTime? datePayment;
  int? year;
  int? month;

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        totalMoneyMotel: json["total_money_motel"] == null
            ? null
            : json["total_money_motel"].toDouble(),
        totalMoneyService: json["total_money_service"] == null
            ? null
            : json["total_money_service"].toDouble(),
        discount: json["discount"] == null ? null : json["discount"].toDouble(),
        totalFinal:
            json["total_final"] == null ? null : json["total_final"].toDouble(),
        datePayment: json["date_payment"] == null
            ? null
            : DateTime.parse(json["date_payment"]),
        year: json["year"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "total_money_motel": totalMoneyMotel,
        "total_money_service":
            totalMoneyService,
        "discount": discount,
        "total_final": totalFinal,
        "date_payment": datePayment,
        "year": year,
        "month": month,
      };
}

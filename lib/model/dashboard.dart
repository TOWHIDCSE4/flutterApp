
class Dashboard {
  Dashboard({
    this.totalGoldenCoins,
    this.totalSilverCoins,
    this.totalDeposits,
    this.totalWithdraws,
  });
  String? totalGoldenCoins;
  String? totalSilverCoins;
  String? totalDeposits;
  String? totalWithdraws;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
    totalDeposits: json["total_deposit"],
    totalGoldenCoins: json["total_golden_coin"],
    totalSilverCoins: json["total_silver_coin"],
    totalWithdraws: json["total_withdraw"]
  );

  Map<String, dynamic> toJson() => {
    "total_deposit": totalDeposits,
    "total_golden_coin": totalGoldenCoins,
    "total_silver_coin": totalSilverCoins,
    "total_withdraw": totalWithdraws
  };
}

class Graph {
  Graph({
    this.month,
    this.value
});

  String? month;
  num? value;

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
    month: json.keys.first,
    value: json.values.first,
  );
}

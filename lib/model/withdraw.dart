
class Withdraw {
  Withdraw({
    this.id,
    this.userId,
    this.accountNumber,
    this.bankAccountHolderName,
    this.bankName,
    this.withdrawAmount,
    this.tradingCode,
    this.withdrawContent,
    this.withdrawDate,
    this.type,
    this.status
  });
  int? id;
  int? userId;
  String? accountNumber;
  String? bankAccountHolderName;
  String? bankName;
  num? withdrawAmount;
  String? tradingCode;
  String? withdrawContent;
  String? withdrawDate;
  int? type;
  String? status;

  factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
    id: json["id"],
    userId: json["user_id"],
    accountNumber: json["account_number"],
    bankAccountHolderName: json["bank_account_holder_name"],
    bankName: json["bank_name"],
    withdrawAmount: json["withdraw_money"],
    withdrawContent: json["withdraw_content"],
    tradingCode: json["withdraw_trading_code"],
    type: json["type"],
    withdrawDate: json["withdraw_date_time"],
    status: json["status"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "account_number": accountNumber,
    "bank_account_holder_name": bankAccountHolderName,
    "bank_name": bankName,
    "withdraw_money": withdrawAmount,
    "withdraw_content": withdrawContent,
    "withdraw_trading_code": tradingCode,
    "withdraw_date_time": withdrawDate,
    "type": type,
    "status": status
  };
}

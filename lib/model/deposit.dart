
class Deposit {
  Deposit({
    this.id,
    this.userId,
    this.accountNumber,
    this.bankAccountHolderName,
    this.bankName,
    this.depositAmount,
    this.tradingCode,
    this.depositContent,
    this.depositDate,
    this.type,
    this.qrCodeUrl,
});
  int? id;
  int? userId;
  String? accountNumber;
  String? bankAccountHolderName;
  String? bankName;
  int? depositAmount;
  String? tradingCode;
  String? depositContent;
  String? depositDate;
  int? type;
  String? qrCodeUrl;

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
    id: json["id"],
    userId: json["user_id"],
    accountNumber: json["account_number"],
    bankAccountHolderName: json["bank_account_holder_name"],
    bankName: json["bank_name"],
    depositAmount: json["deposit_money"],
    depositContent: json["deposit_content"],
    tradingCode: json["deposit_trading_code"],
    type: json["type"],
    qrCodeUrl: json["qr_code_url"],
    depositDate: json["deposit_date_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "account_number": accountNumber,
    "bank_account_holder_name": bankAccountHolderName,
    "bank_name": bankName,
    "deposit_money": depositAmount,
    "deposit_content": depositContent,
    "deposit_trading_code": tradingCode,
    "deposit_date_time": depositDate,
    "type": type,
    "qr_code_url": qrCodeUrl,
  };
}

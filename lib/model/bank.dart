
class BankInfo {

  BankInfo({
    this.id,
    this.userId,
    this.bankAccountHolderName,
    this.bankCode,
    this.bankAccountNumber
});

  int? id;
  int? userId;
  String? bankCode;
  String? bankAccountNumber;
  String? bankAccountHolderName;

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
    id: json["id"],
    userId: json["user_id"],
    bankAccountHolderName: json["bank_account_holder_name"],
    bankAccountNumber: json["bank_account_number"],
    bankCode: json["bank_code"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "bank_account_holder_name": bankAccountHolderName,
    "bank_account_number": bankAccountNumber,
    "bank_code": bankCode
  };
}
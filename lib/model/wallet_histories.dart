import 'package:gohomy/model/user.dart';

class WalletHistory {
  WalletHistory(
      {this.id,
      this.eWalletCollaboratorId,
      this.balanceOrigin,
      this.moneyChange,
      this.accountBalanceChanged,
      this.title,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.userReferral,
      this.takeOutMoney,
      this.typeMoneyfrom,
      this.userReferred});

  int? id;
  int? eWalletCollaboratorId;
  int? balanceOrigin;
  int? moneyChange;
  int? accountBalanceChanged;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? userReferral;
  User? userReferred;
  bool? takeOutMoney;
  int? typeMoneyfrom;
  factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
        id: json["id"],
        eWalletCollaboratorId: json["e_wallet_collaborator_id"],
        balanceOrigin:
            json["balance_origin"],
        moneyChange: json["money_change"],
        accountBalanceChanged: json["account_balance_changed"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userReferral: json['user_referral'] == null
            ? null
            : User.fromJson(json['user_referral']),
        takeOutMoney:
            json['take_out_money'],
        typeMoneyfrom:
            json['type_money_from'],
        userReferred: json['user_referred'] == null
            ? null
            : User.fromJson(json['user_referred']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "e_wallet_collaborator_id":
            eWalletCollaboratorId,
        "balance_origin": balanceOrigin,
        "money_change": moneyChange,
        "account_balance_changed":
            accountBalanceChanged,
        "title": title,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
        'type_money_from': typeMoneyfrom,
      };
}

import 'package:gohomy/model/service.dart';

import 'motel_room.dart';
import 'user.dart';

class Bill {
  Bill({
    this.id,
    this.contractId,
    this.status,
    this.content,
    this.datePayment,
    this.totalMoneyMotel,
    this.totalMoneyService,
    this.totalFinal,
    this.discount,
    this.serviceCloseId,
    this.depositMoney,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.motel,
    this.serviceClose,
    this.moService,
    this.note,
    this.typeBill,
    this.motelId,
    this.totalMoneyBeforePaidByDeposit,
    this.totalMoneyHasPaidByDeposit,
    this.hasUseDeposit,
    this.host,
  });

  int? id;
  int? contractId;
  int? status;
  int? motelId;
  String? content;
  DateTime? datePayment;
  double? totalMoneyMotel;
  double? totalMoneyService;
  double? totalFinal;
  double? discount;
  int? serviceCloseId;
  int? depositMoney;
  List<String>? images;
  MotelRoom? motel;
  ServiceClose? serviceClose;
  List<Service>? moService;
  String? note;
  int? typeBill;
  double? totalMoneyBeforePaidByDeposit;
  double? totalMoneyHasPaidByDeposit;
  dynamic? hasUseDeposit;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? host;

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"],
        motelId: json["motel_id"],
        contractId: json["contract_id"],
        status: json["status"],
        content: json["content"],
        datePayment: json["date_payment"] == null
            ? null
            : DateTime.parse(json["date_payment"]),
        totalMoneyMotel: json["total_money_motel"] == null
            ? null
            : json["total_money_motel"].toDouble(),
        totalMoneyService: json["total_money_service"] == null
            ? null
            : json["total_money_service"].toDouble(),
        totalFinal:
            json["total_final"] == null ? null : json["total_final"].toDouble(),
        discount: json["discount"] == null ? null : json["discount"].toDouble(),
        serviceCloseId:
            json["service_close_id"],
        depositMoney:
            json["deposit_money"],
        moService: json["mo_services"] == null
            ? null
            : List<Service>.from(json["mo_services"].map((x) => x)),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        motel: json["motel"] == null ? null : MotelRoom.fromJson(json["motel"]),
        serviceClose: json["service_close"] == null
            ? null
            : ServiceClose.fromJson(json["service_close"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        note: json['note'],
        totalMoneyBeforePaidByDeposit:
            json['total_money_before_paid_by_deposit'] == null
                ? null
                : json['total_money_before_paid_by_deposit'].toDouble(),
        totalMoneyHasPaidByDeposit:
            json['total_money_has_paid_by_deposit'] == null
                ? null
                : json['total_money_has_paid_by_deposit'].toDouble(),
        hasUseDeposit:
            json['has_use_deposit'],
        host: json['host'] == null ? null : User.fromJson(json['host']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "motel_id": motelId,
        "contract_id": contractId,
        "status": status,
        "date_payment":
            datePayment == null ? null : datePayment!.toIso8601String(),
        "total_money_motel": totalMoneyMotel,
        "total_money_service":
            totalMoneyService,
        "total_final": totalFinal,
        "discount": discount,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "service_close_id": serviceCloseId,
        "deposit_money": depositMoney,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "mo_services": moService == null
            ? null
            : List<dynamic>.from(moService!.map((x) => x.toJson())),
        "content": content,
        "note": note,
        "type_bill": typeBill,
        'total_money_before_paid_by_deposit':
            totalMoneyBeforePaidByDeposit,
        'total_money_has_paid_by_deposit': totalMoneyHasPaidByDeposit,
        'has_use_deposit': hasUseDeposit
      };
}

class ServiceClose {
  int? id;
  int? motelId;
  DateTime? closeDate;
  List<Service>? listServiceCloseItems;

  ServiceClose(
      {this.id, this.motelId, this.listServiceCloseItems, this.closeDate});
  factory ServiceClose.fromJson(Map<String, dynamic> json) => ServiceClose(
        id: json["id"],
        motelId: json["motel_id"],
        closeDate: json["close_date"] == null
            ? null
            : DateTime.parse(json["close_date"]),
        listServiceCloseItems: json["service_close_items"] == null
            ? null
            : List<Service>.from(
                json["service_close_items"].map((x) => Service.fromJson(x)),
              ),
      );
}

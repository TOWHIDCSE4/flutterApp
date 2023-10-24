import 'package:gohomy/model/furniture.dart';
import 'package:gohomy/model/service.dart';
import 'package:gohomy/model/tower.dart';
import 'package:gohomy/model/user.dart';
import 'motel_room.dart';
import 'renter.dart';

class Contract {
  Contract(
      {this.id,
      this.userId,
      this.rentalAgent,
      this.motelId,
      this.rentFrom,
      this.rentTo,
      this.startDate,
      this.paymentSpace,
      this.money,
      this.depositMoney,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.listRenter,
      this.motelRoom,
      this.images,
      this.moServices,
      this.moServicesReq,
      this.note,
      this.host,
      this.imagesDeposit,
      this.depositAmountPaid,
      this.furniture,this.tower,this.towerId,this.cmndBackImageUrl,this.cmndFrontImageUrl,this.cmndNumber});

  int? id;
  int? userId;
  String? rentalAgent;
  String? note;
  int? motelId;
  int? towerId;
  DateTime? rentFrom;
  DateTime? rentTo;
  DateTime? startDate;
  int? paymentSpace;
  double? money;
  double? depositMoney;
  List<String>? images = [];
  List<Service>? moServices;
  List<Service>? moServicesReq = [];
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Renter>? listRenter;
  MotelRoom? motelRoom;
  Tower? tower;
  User? host;
  dynamic depositAmountPaid;
  List<String>? imagesDeposit;
  List<Furniture>? furniture;
  String? cmndNumber;
  String? cmndFrontImageUrl;
  String? cmndBackImageUrl;

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        id: json["id"],
        userId: json["user_id"],
        rentalAgent: json["rental_agent"],
        note: json["note"],
        motelId: json["motel_id"],
        rentFrom: json["rent_from"] == null
            ? null
            : DateTime.parse(json["rent_from"]),
        rentTo:
            json["rent_to"] == null ? null : DateTime.parse(json["rent_to"]),
        startDate: json["pay_start"] == null
            ? null
            : DateTime.parse(json["pay_start"]),
        paymentSpace:
            json["payment_space"],
        money: json["money"] == null ? null : json["money"].toDouble(),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        moServices: json["mo_services"] == null
            ? null
            : List<Service>.from(
                json["mo_services"].map((x) => Service.fromJson(x))),
        depositMoney: json["deposit_money"] == null
            ? null
            : json["deposit_money"].toDouble(),
        status: json["status"],
        motelRoom:
            json["motel"] == null ? null : MotelRoom.fromJson(json["motel"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        listRenter: json["list_renter"] == null
            ? []
            : List<Renter>.from(
                json["list_renter"].map((x) => Renter.fromJson(x))),
        host: json['host'] == null ? null : User.fromJson(json['host']),
        depositAmountPaid: json['deposit_amount_paid'],
        imagesDeposit: json['images_deposit'] == null
            ? null
            : List<String>.from(json["images_deposit"].map((x) => x)),
        furniture: json["furniture"] == null
            ? null
            : List<Furniture>.from(
                json["furniture"].map((x) => Furniture.fromJson(x))),
          towerId : json['tower_id'],
          tower: json["tower"] == null ? null : Tower.fromJson(json["tower"]),
          cmndBackImageUrl: json['cmnd_back_image_url'],
          cmndFrontImageUrl: json['cmnd_front_image_url'],
          cmndNumber: json['cmnd_number']

      );

  Map<String, dynamic> toJson() => {
        "rental_agent": rentalAgent,
        "motel_id": motelId,
        "rent_from": rentFrom == null ? null : rentFrom!.toIso8601String(),
        "rent_to": rentTo == null ? null : rentTo!.toIso8601String(),
        "pay_start": startDate == null ? null : startDate!.toIso8601String(),
        "payment_space": paymentSpace,
        "money": money,
        "note": note,
        "deposit_money": depositMoney,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "status": status,
        "mo_services": moServicesReq == null
            ? null
            : List<dynamic>.from(moServicesReq!.map((x) => x.toJson())),
        "list_renter": listRenter == null
            ? null
            : List<dynamic>.from(listRenter!.map((x) => x.toJson())),
        "furniture": furniture == null
            ? null
            : List<dynamic>.from(furniture!.map((x) => x.toJson())),
        "tower_id" : towerId,
        "cmnd_number": cmndNumber,
        "cmnd_front_image_url" :cmndFrontImageUrl,
        "cmnd_back_image_url" :cmndBackImageUrl
      };
}

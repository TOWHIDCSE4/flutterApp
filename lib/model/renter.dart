import 'package:gohomy/model/bill.dart';
import 'package:gohomy/model/contract.dart';
import 'package:gohomy/model/motel_room.dart';
import 'package:gohomy/model/user.dart';

class Renter {
  Renter(
      {this.id,
      this.userId,
      this.name,
      this.phoneNumber,
      this.email,
      this.cmndNumber,
      this.cmndFrontImageUrl,
      this.cmndBackImageUrl,
      this.address,
      this.isRepresent,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.avatarImage,
      this.depositExpected,
      this.estimateRentalDate,
      this.estimateRentalPeriod,
      this.hasContract,
      this.nameMotelExpected,
      this.nameTowerExpected,
      this.priceExpected,
      this.motelName,this.listBill,this.listContract,this.motelId,this.towerId,this.motelRoom,this.contractActive});

  int? id;
  int? userId;
  String? name;
  String? phoneNumber;
  String? email;
  String? cmndNumber;
  String? cmndFrontImageUrl;
  String? cmndBackImageUrl;
  String? address;
  String? avatarImage;
  bool? isRepresent;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? nameTowerExpected;
  String? nameMotelExpected;
  double? priceExpected;
  double? depositExpected;
  String? estimateRentalPeriod;
  DateTime? estimateRentalDate;
  bool? hasContract;
  String? motelName;

  User? user;
  int? towerId;
  int? motelId;
  List<Bill>? listBill;
  List<Contract>? listContract;
  MotelRoom? motelRoom;
  Contract? contractActive;

  factory Renter.fromJson(Map<String, dynamic> json) => Renter(
      id: json["id"],
      userId: json["user_id"],
      name: json["name"],
      phoneNumber: json["phone_number"],
      isRepresent: json["is_represent"],
      email: json["email"],
      cmndNumber: json["cmnd_number"],
      cmndFrontImageUrl: json["cmnd_front_image_url"],
      cmndBackImageUrl: json["cmnd_back_image_url"],
      address: json["address"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      avatarImage: json['image_url'],
      user: json['user'] == null ? null : User.fromJson(json['user']),
      nameTowerExpected: json['name_tower_expected'],
      nameMotelExpected: json['name_motel_expected'],
      priceExpected: json['price_expected'] == null
          ? null
          : json['price_expected'].toDouble(),
      depositExpected: json['deposit_expected'] == null
          ? null
          : json['deposit_expected'].toDouble(),
      estimateRentalPeriod: json['estimate_rental_period'],
      estimateRentalDate: json['estimate_rental_date'] == null
          ? null
          : DateTime.parse(json["estimate_rental_date"]),
      hasContract: json['has_contract'],
      motelName: json['motel_name'],
      towerId: json['tower_id'],
      motelId: json['motel_id'],
      listBill: json['bill'] == null
          ? []
          : List<Bill>.from(json["bill"]!.map((x) => Bill.fromJson(x))),
      listContract: json['contract'] == null
          ? []
          : List<Contract>.from(
              json["contract"]!.map((x) => Contract.fromJson(x))),
      motelRoom: json['motel'] == null ? null : MotelRoom.fromJson(json['motel'],
      
      ),
      contractActive: json['contract_active'] == null ? null : Contract.fromJson(json['contract_active'])
      
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "is_represent": isRepresent,
        "phone_number": phoneNumber,
        "email": email,
        "cmnd_number": cmndNumber,
        "cmnd_front_image_url": cmndFrontImageUrl,
        "cmnd_back_image_url": cmndBackImageUrl,
        "address": address,
        "image_url": avatarImage,
        "name_tower_expected": nameTowerExpected,
        "name_motel_expected": nameMotelExpected,
        "price_expected": priceExpected,
        "deposit_expected": depositExpected,
        "estimate_rental_period": estimateRentalPeriod,
        "estimate_rental_date": estimateRentalDate?.toIso8601String(),
        "has_contract": hasContract,
        "motel_name": motelName,
        "tower_id":towerId,
        "motel_id":motelId,
        
      };
}

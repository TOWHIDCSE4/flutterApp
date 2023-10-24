import 'package:gohomy/model/furniture.dart';
import 'package:gohomy/model/service.dart';

import 'user.dart';

class MotelRoom {
  MotelRoom(
      {this.id,
      this.userId,
      this.type,
      this.status,
      this.accuracy,
      this.phoneNumber,
      this.title,
      this.description,
      this.motelName,
      this.capacity,
      this.sex,
      this.area,
      this.money,
      this.deposit,
      this.electricMoney,
      this.waterMoney,
      this.hasWifi,
      this.wifiMoney,
      this.hasPark,
      this.parkMoney,
      this.provinceName,
      this.districtName,
      this.wardsName,
      this.province,
      this.district,
      this.wards,
      this.moServicesReq,
      this.moServices,
      this.addressDetail,
      this.hasWc,
      this.hasWindow,
      this.hasSecurity,
      this.hasFreeMove,
      this.hasOwnOwner,
      this.hasAirConditioner,
      this.hasWaterHeater,
      this.hasKitchen,
      this.hasFridge,
      this.hasWashingMachine,
      this.hasMezzanine,
      this.hasBed,
      this.hasWardrobe,
      this.hasTivi,
      this.hasPet,
      this.hasBalcony,
      this.hourOpen,
      this.minuteOpen,
      this.hourClose,
      this.minuteClose,
      this.images,
      this.numberFloor,
      this.quantityVehicleParked,
      this.createdAt,
      this.updatedAt,
      this.hasCeilingFans,
      this.hasCurtain,
      this.hasDecorativeLights,
      this.hasFingerprint,
      this.hasKitchenStuff,
      this.hasMattress,
      this.hasMirror,
      this.hasPicture,
      this.hasPillow,
      this.hasShoesRacks,
      this.hasSofa,
      this.hasTable,
      this.host,
      this.hasTree,
      this.furniture,
      this.hasPost,
      this.hasContract,
      this.adminVerified,
      this.moneyCommissionAdmin,
      this.hasCollaborator,
      this.moneyCommissionUser,
      this.towerId,
      this.videoLink,
      this.towerName,
      this.isSupportManageMotel,
      this.isHidden});

  int? id;
  int? userId;
  int? towerId;
  int? type;
  int? status;
  int? accuracy;
  String? phoneNumber;
  String? title;
  String? description;
  String? motelName;
  int? capacity;
  int? sex = 0;
  int? area;
  double? money;
  double? deposit;
  double? electricMoney;
  double? waterMoney;
  bool? hasWifi;
  double? wifiMoney;
  bool? hasPark;
  double? parkMoney;
  String? provinceName;
  String? districtName;
  String? wardsName;
  int? province;
  int? district;
  int? wards;
  List<String>? images = [];

  List<Service>? moServices;
  List<Service>? moServicesReq = [];
  String? addressDetail;

  ///Tien nghi
  bool? hasWc;
  bool? hasMezzanine;
  bool? hasBalcony;
  bool? hasFingerprint; ////
  bool? hasOwnOwner;
  bool? hasPet;

  ////Noi that
  bool? hasAirConditioner;
  bool? hasWaterHeater;
  bool? hasKitchen;
  bool? hasWindow;
  bool? hasSecurity;
  bool? hasFreeMove;
  bool? hasFridge;
  bool? hasBed;
  bool? hasWashingMachine;
  bool? hasKitchenStuff; ////
  bool? hasTable; /////
  bool? hasDecorativeLights; /////
  bool? hasPicture; /////
  bool? hasTree; /////
  bool? hasPillow; ////
  bool? hasWardrobe;
  bool? hasMattress; ////
  bool? hasShoesRacks; ////
  bool? hasCurtain; ////
  bool? hasCeilingFans; ////
  bool? hasMirror; ////
  bool? hasSofa;

  ///
  bool? hasTivi;
  bool? hasPost;
  int? hourOpen;
  int? minuteOpen;
  int? hourClose;
  int? minuteClose;
  int? numberFloor;
  int? quantityVehicleParked;
  User? host;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Furniture>? furniture;
  bool? hasContract;
  bool? adminVerified;

  double? moneyCommissionAdmin;
  double? moneyCommissionUser;
  bool? hasCollaborator;
  String? videoLink;
  String? towerName;
  bool? isSupportManageMotel;
  bool? isHidden;

  factory MotelRoom.fromJson(Map<String, dynamic> json) => MotelRoom(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        status: json["status"],
        host: json["host"] == null ? null : User.fromJson(json["host"]),
        accuracy: json["accuracy"],
        phoneNumber: json["phone_number"],
        title: json["title"],
        description: json["description"],
        motelName: json["motel_name"],
        capacity: json["capacity"],
        moServices: json["mo_services"] == null
            ? null
            : List<Service>.from(
                json["mo_services"].map((x) => Service.fromJson(x))),
        sex: json["sex"],
        area: json["area"],
        money: json["money"] == null ? null : json["money"].toDouble(),
        deposit: json["deposit"] == null ? null : json["deposit"].toDouble(),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        electricMoney: json["electric_money"] == null
            ? null
            : json["electric_money"].toDouble(),
        waterMoney:
            json["water_money"] == null ? null : json["water_money"].toDouble(),
        hasWifi: json["has_wifi"],
        wifiMoney:
            json["wifi_money"] == null ? null : json["wifi_money"].toDouble(),
        hasPark: json["has_park"],
        parkMoney:
            json["park_money"] == null ? null : json["park_money"].toDouble(),
        provinceName: json["province_name"],
        districtName: json["district_name"],
        wardsName: json["wards_name"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        addressDetail: json["address_detail"],
        hasWc: json["has_wc"],
        hasWindow: json["has_window"],
        hasSecurity: json["has_security"],
        hasFreeMove: json["has_free_move"],
        hasOwnOwner: json["has_own_owner"],
        hasAirConditioner: json["has_air_conditioner"],
        hasWaterHeater: json["has_water_heater"],
        hasKitchen: json["has_kitchen"],
        hasFridge: json["has_fridge"],
        hasWashingMachine: json["has_washing_machine"],
        hasMezzanine: json["has_mezzanine"],
        hasBed: json["has_bed"],
        hasWardrobe: json["has_wardrobe"],
        hasTivi: json["has_tivi"],
        hasPet: json["has_pet"],
        hasBalcony: json["has_balcony"],
        hourOpen: json["hour_open"],
        minuteOpen: json["minute_open"],
        hourClose: json["hour_close"],
        minuteClose: json["minute_close"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        numberFloor: json['number_floor'],
        quantityVehicleParked: json['quantity_vehicle_parked'],
        hasFingerprint: json['has_finger_print'],
        hasKitchenStuff: json['has_kitchen_stuff'],
        hasCeilingFans: json['has_ceiling_fans'],
        hasCurtain: json['has_curtain'],
        hasDecorativeLights: json['has_decorative_lights'],
        hasMattress: json['has_mattress'],
        hasMirror: json['has_mirror'],
        hasPicture: json['has_picture'],
        hasPillow: json['has_pillow'],
        hasShoesRacks: json['has_shoes_rasks'],
        hasSofa: json['has_sofa'],
        hasTable: json['has_table'],
        hasTree: json['has_tree'],
        hasPost: json['has_post'],
        furniture: json["furniture"] == null
            ? null
            : List<Furniture>.from(
                json["furniture"].map((x) => Furniture.fromJson(x))),
        hasContract: json['has_contract'],
        adminVerified: json['admin_verified'],
        // moneyCommissionAdmin: json['money_commission_admin'] == null ? null : json['money_commission_admin'].toDouble(),
        // moneyCommissionUser: json['money_commission_user'] == null ? null : json['money_commission_user'].toDouble(),
        hasCollaborator: json['has_collaborator'],
        towerId: json['tower_id'],
        videoLink: json['video_link'],
        towerName: json['tower_name'],
        isSupportManageMotel: json["is_support_manage_motel"],
        isHidden: json["is_room_hidden"],
        moServicesReq: json["mo_services"] == null
            ? null
            : List<Service>.from(
                json["mo_services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "status": status,
        "accuracy": accuracy,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "phone_number": phoneNumber,
        "title": title,
        "description": description,
        "motel_name": motelName,
        "capacity": capacity,
        "sex": sex,
        "area": area,
        "money": money,
        "deposit": deposit,
        "electric_money": electricMoney,
        "water_money": waterMoney,
        "has_wifi": hasWifi,
        "wifi_money": wifiMoney,
        "has_park": hasPark,
        "park_money": parkMoney,
        "province_name": provinceName,
        "district_name": districtName,
        "wards_name": wardsName,
        "mo_services": moServicesReq == null
            ? null
            : List<dynamic>.from(moServicesReq!.map((x) => x.toJson())),
        "province": province,
        "district": district,
        "wards": wards,
        "address_detail": addressDetail,
        "has_wc": hasWc,
        "has_window": hasWindow,
        "has_security": hasSecurity,
        "has_free_move": hasFreeMove,
        "has_own_owner": hasOwnOwner,
        "has_air_conditioner": hasAirConditioner,
        "has_water_heater": hasWaterHeater,
        "has_kitchen": hasKitchen,
        "has_fridge": hasFridge,
        "has_washing_machine": hasWashingMachine,
        "has_mezzanine": hasMezzanine,
        "has_bed": hasBed,
        "has_wardrobe": hasWardrobe,
        "has_tivi": hasTivi,
        "has_pet": hasPet,
        "has_balcony": hasBalcony,
        "hour_open": hourOpen,
        "minute_open": minuteOpen,
        "hour_close": hourClose,
        "minute_close": minuteClose,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "number_floor": numberFloor,
        "quantity_vehicle_parked": quantityVehicleParked,
        'has_finger_print': hasFingerprint,
        'has_kitchen_stuff': hasKitchenStuff,
        'has_ceiling_fans': hasCeilingFans,
        'has_curtain': hasCurtain,
        'has_decorative_lights': hasDecorativeLights,
        'has_mattress': hasMattress,
        'has_mirror': hasMirror,
        'has_picture': hasPicture,
        'has_pillow': hasPillow,
        'has_shoes_rasks': hasShoesRacks,
        'has_sofa': hasSofa,
        'has_table': hasTable,
        'has_tree': hasTree,
        'has_post': hasPost,
        "furniture": furniture == null
            ? null
            : List<dynamic>.from(furniture!.map((x) => x.toJson())),
        "has_collaborator": hasCollaborator,
        // "money_commission_admin": moneyCommissionAdmin ?? null,
        // 'money_commission_user': moneyCommissionUser ?? null,
        "tower_id": towerId,
        "video_link": videoLink,
        "is_room_hidden": isHidden
      };
}

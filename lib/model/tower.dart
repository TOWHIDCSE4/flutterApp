import 'package:gohomy/model/service.dart';

import 'furniture.dart';
import 'motel_room.dart';

class Tower {
  Tower(
      {this.id,
      this.userId,
      this.type,
      this.status,
      this.accuracy,
      this.phoneNumber,
      this.description,
      this.towerName,
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
      this.hasFingerPrint,
      this.hasKitchenStuff,
      this.hasTable,
      this.hasDecorativeLights,
      this.hasPicture,
      this.hasTree,
      this.hasPillow,
      this.hasMattress,
      this.hasShoesRasks,
      this.hasCurtain,
      this.hasMirror,
      this.hasCeilingFans,
      this.images,
      this.adminVerified,
      this.hasPost,
      this.numberFloor,
      this.quantityVehicleParked,
      this.hasSofa,
      this.hasContract,
      this.furniture,
      this.percentCommission,
      this.percentCommissionCollaborator,
      this.moneyCommissionAdmin,
      this.moneyCommissionUser,
      this.createdAt,
      this.updatedAt,
      this.moServicesReq,
      this.listMotelRoom,this.videoLink,this.isSupportManageTower,this.totalEmptyMotel,this.totalMotel});

  int? id;
  int? userId;
  int? type;
  int? status;
  int? accuracy;
  String? phoneNumber;
  String? description;
  String? towerName;
  int? capacity;
  int? sex;
  int? area;
  double? money;
  double? deposit;
  int? electricMoney;
  int? waterMoney;
  bool? hasWifi;
  int? wifiMoney;
  bool? hasPark;
  int? parkMoney;
  String? provinceName;
  String? districtName;
  String? wardsName;
  int? province;
  int? district;
  int? wards;
  String? addressDetail;
  bool? hasWc;
  bool? hasWindow;
  bool? hasSecurity;
  bool? hasFreeMove;
  bool? hasOwnOwner;
  bool? hasAirConditioner;
  bool? hasWaterHeater;
  bool? hasKitchen;
  bool? hasFridge;
  bool? hasWashingMachine;
  bool? hasMezzanine;
  bool? hasBed;
  bool? hasWardrobe;
  bool? hasTivi;
  bool? hasPet;
  bool? hasBalcony;
  int? hourOpen;
  int? minuteOpen;
  int? hourClose;
  int? minuteClose;
  bool? hasFingerPrint;
  bool? hasKitchenStuff;
  bool? hasTable;
  bool? hasDecorativeLights;
  bool? hasPicture;
  bool? hasTree;
  bool? hasPillow;
  bool? hasMattress;
  bool? hasShoesRasks;
  bool? hasCurtain;
  bool? hasMirror;
  bool? hasCeilingFans;
  List<String>? images;
  bool? adminVerified;
  bool? hasPost;
  int? numberFloor;
  int? quantityVehicleParked;
  bool? hasSofa;
  bool? hasContract;
  List<Furniture>? furniture;
  int? percentCommission;
  int? percentCommissionCollaborator;
  int? moneyCommissionAdmin;
  int? moneyCommissionUser;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Service>? moServicesReq = [];
  List<MotelRoom>? listMotelRoom;
  String? videoLink;
  bool? isSupportManageTower;
  int? totalMotel;
  int? totalEmptyMotel;

  factory Tower.fromJson(Map<String, dynamic> json) => Tower(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        status: json["status"],
        accuracy: json["accuracy"],
        phoneNumber: json["phone_number"],
        description: json["description"],
        towerName: json["tower_name"],
        capacity: json["capacity"],
        sex: json["sex"],
        area: json["area"],
        money: json["money"] == null ? null : json['money'].toDouble(),
        deposit: json["deposit"] == null ? null : json["deposit"].toDouble(),
        electricMoney: json["electric_money"],
        waterMoney: json["water_money"],
        hasWifi: json["has_wifi"],
        wifiMoney: json["wifi_money"],
        hasPark: json["has_park"],
        parkMoney: json["park_money"],
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
        hasFingerPrint: json["has_finger_print"],
        hasKitchenStuff: json["has_kitchen_stuff"],
        hasTable: json["has_table"],
        hasDecorativeLights: json["has_decorative_lights"],
        hasPicture: json["has_picture"],
        hasTree: json["has_tree"],
        hasPillow: json["has_pillow"],
        hasMattress: json["has_mattress"],
        hasShoesRasks: json["has_shoes_rasks"],
        hasCurtain: json["has_curtain"],
        hasMirror: json["has_mirror"],
        hasCeilingFans: json["has_ceiling_fans"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        adminVerified: json["admin_verified"],
        hasPost: json["has_post"],
        numberFloor: json["number_floor"],
        quantityVehicleParked: json["quantity_vehicle_parked"],
        hasSofa: json["has_sofa"],
        hasContract: json["has_contract"],
        furniture: json["furniture"] == null
            ? []
            : List<Furniture>.from(
                json["furniture"]!.map((x) => Furniture.fromJson(x))),
        percentCommission: json["percent_commission"],
        percentCommissionCollaborator: json["percent_commission_collaborator"],
        moneyCommissionAdmin: json["money_commission_admin"],
        moneyCommissionUser: json["money_commission_user"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        moServicesReq: json['tower_service'] == null
            ? []
            : List<Service>.from(
                json["tower_service"]!.map((x) => Service.fromJson(x))),
        listMotelRoom: json["motel"] == null
            ? []
            : List<MotelRoom>.from(
                json["motel"]!.map((x) => MotelRoom.fromJson(x))),
        videoLink: json['video_link'],
        isSupportManageTower: json["is_support_manage_tower"],
        totalEmptyMotel: json["total_empty_motel"],
        totalMotel: json["total_motel"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "status": status,
        "accuracy": accuracy,
        "phone_number": phoneNumber,
        "description": description,
        "tower_name": towerName,
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
        "has_finger_print": hasFingerPrint,
        "has_kitchen_stuff": hasKitchenStuff,
        "has_table": hasTable,
        "has_decorative_lights": hasDecorativeLights,
        "has_picture": hasPicture,
        "has_tree": hasTree,
        "has_pillow": hasPillow,
        "has_mattress": hasMattress,
        "has_shoes_rasks": hasShoesRasks,
        "has_curtain": hasCurtain,
        "has_mirror": hasMirror,
        "has_ceiling_fans": hasCeilingFans,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "admin_verified": adminVerified,
        "has_post": hasPost,
        "number_floor": numberFloor,
        "quantity_vehicle_parked": quantityVehicleParked,
        "has_sofa": hasSofa,
        "has_contract": hasContract,
        "furniture": furniture == null
            ? []
            : List<dynamic>.from(furniture!.map((x) => x.toJson())),
        "percent_commission": percentCommission,
        "percent_commission_collaborator": percentCommissionCollaborator,
        "money_commission_admin": moneyCommissionAdmin,
        "money_commission_user": moneyCommissionUser,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "tower_service": moServicesReq == null
            ? null
            : List<dynamic>.from(moServicesReq!.map((x) => x.toJson())),
        "video_link" : videoLink,
        "motel" :listMotelRoom == null ? null :List<dynamic>.from(listMotelRoom!.map((x) => x.toJson())),
      };
}

import 'package:gohomy/model/service.dart';
import 'package:gohomy/model/user.dart';

import 'furniture.dart';

class PostRoommate {
  PostRoommate(
      {this.id,
      this.userId,
      this.motelId,
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
      this.numberTenantCurrent,
      this.numberFindTenant,
      this.floor,
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
      this.hasCeilingFans,
      this.hasMirror,
      this.unit,
      this.images,
      this.type,
      this.moServices,
      this.status,
      this.note,
      this.adminVerified,
      this.availableMotel,
      this.linkVideo,
      this.quantityVehicleParked,
      this.numberFloor,
      this.hasSofa,
      this.furniture,
      this.numberCalls,
      this.moneyCommissionUser,
      this.moneyCommissionAdmin,
      this.adminConfirmCommission,
      this.percentCommission,
      this.percentCommissionCollaborator,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.totalViews});

  int? id;
  int? userId;
  int? motelId;
  String? phoneNumber;
  String? title;
  String? description;
  String? motelName;
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
  int? numberTenantCurrent;
  int? numberFindTenant;
  int? floor;
  int? province;
  int? district;
  int? wards;
  String? addressDetail;
  bool? hasWc;
  bool? hasWindow;
  bool? hasSecurity;
  bool? hasFreeMove;
  bool? hasOwnOwner;
  int? totalViews;
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
  bool? hasCeilingFans;
  bool? hasMirror;
  dynamic unit;
  List<String>? images;
  int? type;
  List<Service>? moServices;
  int? status;
  String? note;
  bool? adminVerified;
  bool? availableMotel;
  String? linkVideo;
  int? quantityVehicleParked;
  int? numberFloor;
  bool? hasSofa;
  List<Furniture>? furniture;
  int? numberCalls;
  double? moneyCommissionUser;
  double? moneyCommissionAdmin;
  bool? adminConfirmCommission;
  double? percentCommission;
  double? percentCommissionCollaborator;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory PostRoommate.fromJson(Map<String, dynamic> json) => PostRoommate(
      id: json["id"],
      userId: json["user_id"],
      motelId: json["motel_id"],
      phoneNumber: json["phone_number"],
      title: json["title"],
      description: json["description"],
      motelName: json["motel_name"],
      capacity: json["capacity"],
      sex: json["sex"],
      area: json["area"],
      money: json["money"] == null ? null : json["money"].toDouble(),
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
      numberTenantCurrent: json["number_tenant_current"],
      numberFindTenant: json["number_find_tenant"],
      floor: json["floor"],
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
      hasCeilingFans: json["has_ceiling_fans"],
      hasMirror: json["has_mirror"],
      unit: json["unit"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      type: json["type"],
      moServices: json["mo_services"] == null
          ? []
          : List<Service>.from(
              json["mo_services"]!.map((x) => Service.fromJson(x))),
      status: json["status"],
      note: json["note"],
      adminVerified: json["admin_verified"],
      availableMotel: json["available_motel"],
      linkVideo: json["link_video"],
      quantityVehicleParked: json["quantity_vehicle_parked"],
      numberFloor: json["number_floor"],
      hasSofa: json["has_sofa"],
      furniture: json["furniture"] == null
          ? []
          : List<Furniture>.from(
              json["furniture"]!.map((x) => Furniture.fromJson(x))),
      numberCalls: json["number_calls"],
      moneyCommissionUser: json["money_commission_user"] == null
          ? null
          : json["money_commission_user"].toDouble(),
      moneyCommissionAdmin: json["money_commission_admin"] == null
          ? null
          : json["money_commission_admin"].toDouble(),
      adminConfirmCommission: json["admin_confirm_commission"],
      percentCommission: json["percent_commission"] == null
          ? null
          : json["percent_commission"].toDouble(),
      percentCommissionCollaborator:
          json["percent_commission_collaborator"] == null
              ? null
              : json["percent_commission_collaborator"].toDouble(),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      user: json['user'] == null ? null : User.fromJson(json['user']),
      totalViews: json['total_views']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "motel_id": motelId,
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
        "number_tenant_current": numberTenantCurrent,
        "number_find_tenant": numberFindTenant,
        "floor": floor,
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
        "has_ceiling_fans": hasCeilingFans,
        "has_mirror": hasMirror,
        "unit": unit,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "type": type,
        "mo_services": moServices == null
            ? []
            : List<dynamic>.from(moServices!.map((x) => x.toJson())),
        "status": status,
        "note": note,
        "admin_verified": adminVerified,
        "available_motel": availableMotel,
        "link_video": linkVideo,
        "quantity_vehicle_parked": quantityVehicleParked,
        "number_floor": numberFloor,
        "has_sofa": hasSofa,
        "furniture": furniture == null
            ? []
            : List<dynamic>.from(furniture!.map((x) => x.toJson())),
        "number_calls": numberCalls,
        "money_commission_user": moneyCommissionUser,
        "money_commission_admin": moneyCommissionAdmin,
        "admin_confirm_commission": adminConfirmCommission,
        "percent_commission": percentCommission,
        "percent_commission_collaborator": percentCommissionCollaborator,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

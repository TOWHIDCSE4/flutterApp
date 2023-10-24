import 'package:gohomy/model/service.dart';

import 'motel_room.dart';
import 'user.dart';

class MotelPost {
  MotelPost(
      {this.id,
      this.userId,
      this.motelId,
      this.phoneNumber,
      this.title,
      this.type,
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
      this.createdAt,
      this.updatedAt,
      this.isFavorite,
      this.images,
      this.moServices,
      this.moServicesReq,
      this.unit,
      this.user,
      this.status,
      this.availableMotel,
      this.adminVerified,
      this.totalPost,
      this.totalViews,
      this.hostRank,
      this.linkVideo,
      this.numberFloor,
      this.quantityVehicleParked,
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
      this.hasTree,
      this.host,
      this.numberCalls,
      this.moneyCommissionAdmin,
      this.hasCollaborator,
      this.moneyCommissionUser,
      this.percentCommission,
      this.percentCommissionCollaborator,
      this.listMotel,
      this.towerId,this.towerName});
  int? status;
  int? id;
  int? towerId;
  int? userId;
  int? motelId;
  String? phoneNumber;
  String? title;
  String? description;
  String? unit;
  String? motelName;
  int? capacity;
  int? type;
  int? sex;
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
  List<String>? images = [];
  List<Service>? moServices;
  List<Service>? moServicesReq = [];
  int? province;
  int? district;
  int? wards;
  String? addressDetail;
  String? linkVideo;
  User? host;

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

  int? hourOpen;
  int? minuteOpen;
  int? hourClose;
  int? minuteClose;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isFavorite;
  User? user;
  bool? availableMotel;
  bool? adminVerified;
  int? totalPost;
  int? totalViews;
  int? hostRank;
  int? numberFloor;
  int? quantityVehicleParked;
  int? numberCalls;
  double? moneyCommissionAdmin;
  bool? hasCollaborator;
  double? moneyCommissionUser;
  int? percentCommission;
  int? percentCommissionCollaborator;
  List<MotelRoom>? listMotel;
  String? towerName;

  factory MotelPost.fromJson(Map<String, dynamic> json) => MotelPost(
        id: json["id"],
        userId: json["user_id"],
        motelId: json["motel_id"],
        towerId: json['tower_id'],
        phoneNumber: json["phone_number"],
        title: json["title"],
        unit: json["unit"],
        description: json["description"],
        motelName: json["motel_name"],
        capacity: json["capacity"],
        sex: json["sex"],
        area: json["area"],
        type: json["type"],
        host: json["host"] == null ? null : User.fromJson(json["host"]),
        money: json["money"] == null ? null : json["money"].toDouble(),
        deposit: json["deposit"] == null ? null : json["deposit"].toDouble(),
        electricMoney: json["electric_money"] == null
            ? null
            : json["electric_money"].toDouble(),
        waterMoney:
            json["water_money"] == null ? null : json["water_money"].toDouble(),
        hasWifi: json["has_wifi"],
        moServices: json["mo_services"] == null
            ? null
            : List<Service>.from(
                json["mo_services"].map((x) => Service.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x ?? '')),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isFavorite: json["is_favorite"],
        status: json["status"],
        availableMotel: json['available_motel'],
        adminVerified: json['admin_verified'],
        totalPost: json['total_post'],
        totalViews: json['total_views'],
        hostRank: json['host_rank'],
        linkVideo: json['link_video'],
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
        numberCalls: json['number_calls'],
        moneyCommissionAdmin: json['money_commission_admin'] == null
            ? null
            : json['money_commission_admin'].toDouble(),
        hasCollaborator: json['has_collaborator'],
        moneyCommissionUser: json['money_commission_user'] == null
            ? null
            : json['money_commission_user'].toDouble(),
        percentCommission: json['percent_commission'],
        percentCommissionCollaborator: json['percent_commission_collaborator'],
        listMotel: json['motel'] == null
            ? []
            : List<MotelRoom>.from(
                json["motel"].map((x) => MotelRoom.fromJson(x))),
        towerName:json['tower_name'],
        moServicesReq: json["mo_services"] == null
            ? null
            : List<Service>.from(
                json["mo_services"].map((x) => Service.fromJson(x))),
        
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "motel_id": motelId,
        "phone_number": phoneNumber,
        "title": title,
        "description": description,
        "motel_name": motelName,
        "capacity": capacity,
        "link_video": linkVideo,
        "mo_services": moServicesReq == null
            ? null
            : List<dynamic>.from(moServicesReq!.map((x) => x.toJson())),
        "unit": unit,
        "type": type,
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
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "is_favorite": isFavorite,
        "status": status,
        'admin_verified': adminVerified,
        'available_motel': availableMotel,
        'host_rank': hostRank,
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
        
        "has_collaborator": hasCollaborator,
        "money_commission_admin": moneyCommissionAdmin,
        'money_commission_user': moneyCommissionUser,
        "percent_commission": percentCommission,
        "percent_commission_collaborator": percentCommissionCollaborator,
        "motel": listMotel == null
            ? []
            : List<dynamic>.from(listMotel!.map((x) => x.toJson())),
        "tower_id": towerId,
        "tower_name":towerName
      };
}

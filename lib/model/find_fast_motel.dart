import 'package:gohomy/model/user.dart';

class FindFastMotel {
  FindFastMotel(
      {this.name,
      this.id,
      this.note,
      this.provinceName,
      this.wardsName,
      this.province,
      this.district,
      this.wards,
      this.status,
      this.addressDetail,
      this.phoneNumber,
      this.districtName,
      this.user,
      this.updatedAt,
      this.createdAt,
      this.capacity,
      this.price,
      this.hasAirConditioner,
      this.hasBalcony,
      this.hasBed,
      this.hasCeilingFans,
      this.hasCurtain,
      this.hasDecorativeLights,
      this.hasFingerprint,
      this.hasFreeMove,
      this.hasFridge,
      this.hasKitchen,
      this.hasKitchenStuff,
      this.hasMattress,
      this.hasMezzanine,
      this.hasMirror,
      this.hasOwnOwner,
      this.hasPet,
      this.hasPicture,
      this.hasPillow,
      this.hasSecurity,
      this.hasShoesRacks,
      this.hasSofa,
      this.hasTable,
      this.hasTree,
      this.hasWardrobe,
      this.hasWashingMachine,
      this.hasWaterHeater,
      this.hasWc,
      this.hasWindow,
      this.hasTivi});

  String? name;
  int? id;
  String? note;
  String? provinceName;
  String? wardsName;
  int? province;
  int? district;
  int? wards;
  int? status;
  String? addressDetail;
  String? phoneNumber;
  String? districtName;
  User? user;
  DateTime? updatedAt;
  DateTime? createdAt;
  double? price;
  int? capacity;

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
  bool? hasTivi;

  factory FindFastMotel.fromJson(Map<String, dynamic> json) => FindFastMotel(
        name: json["name"],
        id: json["id"],
        note: json["note"],
        provinceName: json["province_name"],
        wardsName: json["wards_name"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        status: json["status"],
        addressDetail: json["address_detail"],
        phoneNumber: json["phone_number"],
        districtName: json["district_name"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        price: json['price'] == null ? null : json['price'].toDouble(),
        capacity: json['capacity'],
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
   
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "note": note,
        "province": province,
        "district": district,
        "wards": wards,
        "status": status,
        "address_detail": addressDetail,
        "phone_number": phoneNumber,
        "price": price,
        'capacity': capacity,
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

      };
}

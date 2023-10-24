class MotelPostReq {
  MotelPostReq(
      {this.motelId,
      this.listType,
      this.status,
      this.phoneNumber,
      this.title,
      this.description,
      this.roomNumber,
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
      this.sortBy,
      this.descending,
      this.fromMoney,
      this.maxMoney,
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
      this.hasTree});

  int? motelId;
  List<int>? listType = [];
  int? status;
  String? phoneNumber;
  String? title;
  String? description;
  String? sortBy;
  int? roomNumber;
  int? capacity;
  int? sex;
  int? area;
  int? money;
  int? deposit;
  int? electricMoney;
  int? waterMoney;
  bool? hasWifi;
  int? wifiMoney;
  bool? hasPark;
  bool? descending;
  int? parkMoney;
  int? province;
  int? district;
  int? wards;
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

  int? hourOpen;
  int? minuteOpen;
  int? hourClose;
  int? minuteClose;
  double? fromMoney;
  double? maxMoney;

  factory MotelPostReq.fromJson(Map<String, dynamic> json) => MotelPostReq(
        motelId: json["motel_id"],
        listType: json["type"],
        status: json["status"],
        phoneNumber: json["phone_number"],
        title: json["title"],
        description: json["description"],
        roomNumber: json["room_number"],
        capacity: json["capacity"],
        sex: json["sex"],
        area: json["area"],
        money: json["money"],
        deposit: json["deposit"],
        electricMoney:
            json["electric_money"],
        waterMoney: json["water_money"],
        hasWifi: json["has_wifi"],
        wifiMoney: json["wifi_money"],
        hasPark: json["has_park"],
        parkMoney: json["park_money"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        addressDetail:
            json["address_detail"],
        hasWc: json["has_wc"],
        hasWindow: json["has_window"],
        hasSecurity: json["has_security"],
        hasFreeMove:
            json["has_free_move"],
        hasOwnOwner:
            json["has_own_owner"],
        hasAirConditioner: json["has_air_conditioner"],
        hasWaterHeater:
            json["has_water_heater"],
        hasKitchen: json["has_kitchen"],
        hasFridge: json["has_fridge"],
        hasWashingMachine: json["has_washing_machine"],
        hasMezzanine:
            json["has_mezzanine"],
        hasBed: json["has_bed"],
        hasWardrobe: json["has_wardrobe"],
        hasTivi: json["has_tivi"],
        hasPet: json["has_pet"],
        hasBalcony: json["has_balcony"],
        hourOpen: json["hour_open"],
        minuteOpen: json["minute_open"],
        hourClose: json["hour_close"],
        minuteClose: json["minute_close"],
        hasFingerprint:
            json['has_finger_print'],
        hasKitchenStuff: json['has_kitchen_stuff'],
        hasCeilingFans:
            json['has_ceiling_fans'],
        hasCurtain: json['has_curtain'],
        hasDecorativeLights: json['has_decorative_lights'],
        hasMattress: json['has_mattress'],
        hasMirror: json['has_mirror'],
        hasPicture: json['has_picture'],
        hasPillow: json['has_pillow'],
        hasShoesRacks:
            json['has_shoes_rasks'],
        hasSofa: json['has_sofa'],
        hasTable: json['has_table'],
        hasTree: json['has_tree'],
      );

  Map<String, dynamic> toJson() => {
        "motel_id": motelId,
        "list_type": listType == null ? null : listType!,
        "status": status,
        "descending": descending,
        "phone_number": phoneNumber,
        "title": title,
        "sort_by": sortBy,
        "description": description,
        "room_number": roomNumber,
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
        "province": province,
        "district": district,
        "wards": wards,
        "address_detail": addressDetail,
        "has_wc": hasWc,
        "has_window": hasWindow,
        "has_security": hasSecurity,
        "has_free_move": hasFreeMove,
        "has_own_owner": hasOwnOwner,
        "has_air_conditioner":
            hasAirConditioner,
        "has_water_heater": hasWaterHeater,
        "has_kitchen": hasKitchen,
        "has_fridge": hasFridge,
        "has_washing_machine":
            hasWashingMachine,
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
        'has_finger_print': hasFingerprint,
        'has_kitchen_stuff': hasKitchenStuff,
        'has_ceiling_fans': hasCeilingFans,
        'has_curtain': hasCurtain,
        'has_decorative_lights':
            hasDecorativeLights,
        'has_mattress': hasMattress,
        'has_mirror': hasMirror,
        'has_picture': hasPicture,
        'has_pillow': hasPillow,
        'has_shoes_rasks': hasShoesRacks,
        'has_sofa': hasSofa,
        'has_table': hasTable,
        'has_tree': hasTree
      };
}

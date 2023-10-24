// To parse this JSON data, do
//
//     final infoOrderReq = infoOrderReqFromJson(jsonString);

import 'dart:convert';

InfoOrderReq infoOrderReqFromJson(String str) =>
    InfoOrderReq.fromJson(json.decode(str));

String infoOrderReqToJson(InfoOrderReq data) => json.encode(data.toJson());

class InfoOrderReq {
  InfoOrderReq({
    this.name,
    this.phoneNumber,
    this.province,
    this.district,
    this.wards,
    this.email,
    this.addressDetail,
    this.note,
     this.serviceSellId,
    this.quantity,
  });

  String? name;
  String? phoneNumber;
  int? province;
  int? district;
  int? wards;

  String? provinceName;
  String? districtName;
  String? wardsName;
  String? addressDetail;
  String? email;
  String? note;
  int? serviceSellId;
  int? quantity;

  factory InfoOrderReq.fromJson(Map<String, dynamic> json) => InfoOrderReq(
        name: json["name"],
        phoneNumber: json["phone_number"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        email: json["email"],
        addressDetail:
            json["address_detail"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "province": province,
        "district": district,
        "wards": wards,
        "address_detail": addressDetail,
        "note": note,
        "service_sell_id": serviceSellId,
        "quantity": quantity,
      };
}

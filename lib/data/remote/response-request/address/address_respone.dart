import 'dart:convert';

import 'package:gohomy/model/location_address.dart';

AddressResponse addressResponseFromJson(String str) =>
    AddressResponse.fromJson(json.decode(str));

String addressResponseToJson(AddressResponse data) =>
    json.encode(data.toJson());

class AddressResponse {
  AddressResponse({
    this.code,
    this.success,
    this.data,
    this.msgCode,
  });

  int? code;
  bool? success;
  List<LocationAddress>? data;
  String? msgCode;

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        code: json["code"],
        success: json["success"],
        data: List<LocationAddress>.from(
            json["data"].map((x) => LocationAddress.fromJson(x))),
        msgCode: json["msg_code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg_code": msgCode,
      };
}

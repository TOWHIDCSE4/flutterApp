// To parse this JSON data, do
//
//     final locationFindReq = locationFindReqFromJson(jsonString);

import 'dart:convert';

LocationFindReq locationFindReqFromJson(String str) =>
    LocationFindReq.fromJson(json.decode(str));

String locationFindReqToJson(LocationFindReq data) =>
    json.encode(data.toJson());

class LocationFindReq {
  LocationFindReq({
    this.name,
    this.street,
    this.isoCountryCode,
    this.country,
    this.postalcode,
    this.administrativeArea,
    this.subadministrativeArea,
    this.locality,
    this.sublocality,
    this.thoroughfare,
    this.subthoroughfare,
  });

  String? name;
  String? street;
  String? isoCountryCode;
  String? country;
  String? postalcode;
  String? administrativeArea;
  String? subadministrativeArea;
  String? locality;
  String? sublocality;
  String? thoroughfare;
  String? subthoroughfare;

  factory LocationFindReq.fromJson(Map<String, dynamic> json) =>
      LocationFindReq(
        name: json["name"],
        street: json["street"],
        isoCountryCode:
            json["iso_country_code"],
        country: json["country"],
        postalcode: json["postalcode"],
        administrativeArea: json["administrative_area"],
        subadministrativeArea: json["subadministrative_area"],
        locality: json["locality"],
        sublocality: json["sublocality"],
        thoroughfare:
            json["thoroughfare"],
        subthoroughfare:
            json["subthoroughfare"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "street": street,
        "iso_country_code": isoCountryCode,
        "country": country,
        "postalcode": postalcode,
        "administrative_area":
            administrativeArea,
        "subadministrative_area":
            subadministrativeArea,
        "locality": locality,
        "sublocality": sublocality,
        "thoroughfare": thoroughfare,
        "subthoroughfare": subthoroughfare,
      };
}

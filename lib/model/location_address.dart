import 'dart:convert';

LocationAddress locationAddressFromJson(String str) =>
    LocationAddress.fromJson(json.decode(str));

String locationAddressToJson(LocationAddress data) =>
    json.encode(data.toJson());

class LocationAddress {
  LocationAddress({
    this.id,
    this.name,
    this.type,
  });

  int? id;
  String? name;
  String? type;

  factory LocationAddress.fromJson(Map<String, dynamic> json) =>
      LocationAddress(
        id: json["id"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
      };
}

class OrderNow {
  int? serviceSellId;
  int? quantity;
  String? name;
  String? phoneNumber;
  int? province;
  int? district;
  int? wards;
  String? addressDetail;
  String? note;

  OrderNow({
    this.serviceSellId,
    this.quantity,
    this.name,
    this.phoneNumber,
    this.province,
    this.district,
    this.wards,
    this.addressDetail,
    this.note,
  });

  factory OrderNow.fromJson(Map<String, dynamic> json) => OrderNow(
        serviceSellId: json["service_sell_id"],
        quantity: json["quantity"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        addressDetail: json["address_detail"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "service_sell_id": serviceSellId,
        "quantity": quantity,
        "name": name,
        "phone_number": phoneNumber,
        "province": province,
        "district": district,
        "wards": wards,
        "address_detail": addressDetail,
        "note": note,
      };
}

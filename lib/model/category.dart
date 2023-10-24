import 'package:gohomy/model/order.dart';

class Category {
    int? id;
    String? name;
    String? image;
    bool? isActive;
    List<ListServiceSell>? listServiceSell;

    Category({
        this.id,
        this.name,
        this.image,
        this.isActive,this.listServiceSell
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        isActive: json["is_active"],
        listServiceSell: json["list_service_sell"] == null ? [] : List<ListServiceSell>.from(json["list_service_sell"]!.map((x) => ListServiceSell.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "is_active": isActive,
    };
}
class Furniture {
  Furniture({
    this.name,
    this.quantity,
    this.images,
  });

  String? name;
  int? quantity;
  List<dynamic>? images;

  factory Furniture.fromJson(Map<String, dynamic> json) => Furniture(
        name: json["name"],
        quantity: json["quantity"],
        images: json["images"] == null
            ? null
            : List<dynamic>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
      };
}

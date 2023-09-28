import 'package:gohomy/model/banners.dart';
import 'package:gohomy/model/post_find_room.dart';
import 'package:gohomy/model/post_roommate.dart';

import 'admin_discover.dart';
import 'category.dart';
import 'motel_post.dart';


class HomeApp {
  HomeApp(
      {this.layouts,
      this.listBanners,
      this.adminContact,
      this.adminDiscover,
      this.listCategoryServiceSell,
      this.listPostFindRoom,
      this.listPostRoommate});

  List<Layout>? layouts;
  List<Banners>? listBanners;
  AdminContact? adminContact;
  List<AdminDiscover>? adminDiscover;
  List<Category>? listCategoryServiceSell;
  List<PostFindRoom>? listPostFindRoom;
  List<PostRoommate>? listPostRoommate;

  factory HomeApp.fromJson(Map<String, dynamic> json) => HomeApp(
        layouts: json["layouts"] == null
            ? null
            : List<Layout>.from(json["layouts"].map((x) => Layout.fromJson(x))),
        listBanners: json['banners'] == null
            ? null
            : List<Banners>.from(
                json['banners'].map((x) => Banners.fromJson(x)),
              ),
        adminContact: json["admin_contacts"] == null
            ? null
            : AdminContact.fromJson(json["admin_contacts"]),
        adminDiscover: json["admin_discovers"] == null
            ? null
            : List<AdminDiscover>.from(
                json["admin_discovers"].map((x) => AdminDiscover.fromJson(x))),
        listCategoryServiceSell: json["list_category_service_sell"] == null
            ? null
            : List<Category>.from(
                json["list_category_service_sell"].map((x) => Category.fromJson(x))),
        listPostFindRoom: json['mo_post_find_motels'] == null
            ? []
            : List<PostFindRoom>.from(json["mo_post_find_motels"]
                .map((x) => PostFindRoom.fromJson(x))),
        listPostRoommate: json['mo_post_find_roommates'] == null
            ? []
            : List<PostRoommate>.from(json["mo_post_find_roommates"]
                .map((x) => PostRoommate.fromJson(x))),
      );
}

class AdminContact {
  AdminContact({
    this.id,
    this.facebook,
    this.zalo,
    this.email,
    this.phoneNumber,
    this.content,
    this.address,
    this.bankAccountNumber,
    this.bankAccountName,
    this.bankName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? facebook;
  String? zalo;
  String? email;
  String? phoneNumber;
  String? content;
  String? address;
  String? bankAccountNumber;
  String? bankName;
  String? bankAccountName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AdminContact.fromJson(Map<String, dynamic> json) => AdminContact(
        id: json["id"],
        facebook: json["facebook"],
        zalo: json["zalo"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        content: json["content"],
        address: json["address"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        bankAccountName: json['bank_account_name'],
        bankAccountNumber: json['bank_account_number'],
        bankName: json['bank_name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "facebook": facebook,
        "zalo": zalo,
        "email": email,
        "phone_number": phoneNumber,
        "content": content,
        "address": address,
        "bank_account_name": bankAccountName,
        "bank_account_number": bankAccountNumber,
        "bank_name": bankName
      };
}

class Layout {
  Layout({
    this.title,
    this.type,
    this.list,
  });

  String? title;
  String? type;
  List<MotelPost>? list;

  factory Layout.fromJson(Map<String, dynamic> json) => Layout(
        title: json["title"],
        type: json["type"],
        list: json["list"] == []
            ? null
            : List<MotelPost>.from(
                json["list"].map((x) => MotelPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "type": type,
        "list": list == null
            ? null
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

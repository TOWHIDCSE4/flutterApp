import 'package:gohomy/model/user.dart';

import 'bill.dart';
import 'contract.dart';
import 'motel_post.dart';

class PotentialUser {
  PotentialUser(
      {this.id,
      this.userGuestId,
      this.userHostId,
      this.title,
      this.typeFrom,
      this.status,
      this.valueReference,
      this.timeInteract,
      this.createdAt,
      this.updatedAt,
      this.historyUserPotential,
      this.listPostFavorite,
      this.userGuest,
      this.isHasContract,
      this.listBill,
      this.listContract,
      this.nameMotel,
      this.nameTower});

  int? id;
  int? userGuestId;
  int? userHostId;
  String? title;
  int? typeFrom;
  int? status;
  int? valueReference;
  DateTime? timeInteract;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<HistoryUserPotential>? historyUserPotential;
  List<ListPostFavorite>? listPostFavorite;
  User? userGuest;
  String? nameMotel;
  String? nameTower;
  List<Bill>? listBill;
  bool? isHasContract;
  List<Contract>? listContract;

  factory PotentialUser.fromJson(Map<String, dynamic> json) => PotentialUser(
      id: json["id"],
      userGuestId: json["user_guest_id"],
      userHostId: json["user_host_id"],
      title: json["title"],
      typeFrom: json["type_from"],
      status: json["status"],
      valueReference: json["value_reference"],
      timeInteract: json["time_interact"] == null
          ? null
          : DateTime.parse(json["time_interact"]),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      historyUserPotential: json["history_user_potential"] == null
          ? []
          : List<HistoryUserPotential>.from(json["history_user_potential"]!
              .map((x) => HistoryUserPotential.fromJson(x))),
      listPostFavorite: json["list_post_favorite"] == null
          ? []
          : List<ListPostFavorite>.from(json["list_post_favorite"]!
              .map((x) => ListPostFavorite.fromJson(x))),
      userGuest:
          json["user_guest"] == null ? null : User.fromJson(json["user_guest"]),
      nameMotel: json['name_motel'],
      nameTower: json['name_tower'],
      listBill: json['bill'] == null
          ? []
          : List<Bill>.from(json["bill"]!.map((x) => Bill.fromJson(x))),
      listContract: json['contract'] == null
          ? []
          : List<Contract>.from(
              json["contract"]!.map((x) => Contract.fromJson(x))),
      isHasContract: json['is_has_contract']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_guest_id": userGuestId,
        "user_host_id": userHostId,
        "title": title,
        "type_from": typeFrom,
        "status": status,
        "value_reference": valueReference,
        "time_interact": timeInteract?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "history_user_potential": historyUserPotential == null
            ? []
            : List<dynamic>.from(historyUserPotential!.map((x) => x.toJson())),
        "list_post_favorite": listPostFavorite == null
            ? []
            : List<dynamic>.from(listPostFavorite!.map((x) => x.toJson())),
        "user_guest": userGuest?.toJson(),
      };
}

class ListPostFavorite {
  ListPostFavorite({
    this.id,
    this.userId,
    this.moPostId,
    this.createdAt,
    this.updatedAt,
    this.moPost,
  });

  int? id;
  int? userId;
  int? moPostId;
  DateTime? createdAt;
  DateTime? updatedAt;
  MotelPost? moPost;

  factory ListPostFavorite.fromJson(Map<String, dynamic> json) =>
      ListPostFavorite(
        id: json["id"],
        userId: json["user_id"],
        moPostId: json["mo_post_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        moPost: json["mo_post"] == null
            ? null
            : MotelPost.fromJson(json["mo_post"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "mo_post_id": moPostId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "mo_post": moPost?.toJson(),
      };
}

class HistoryUserPotential {
  HistoryUserPotential({
    this.id,
    this.userGuestId,
    this.userHostId,
    this.title,
    this.typeFrom,
    this.valueReference,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userGuestId;
  int? userHostId;
  String? title;
  int? typeFrom;
  int? valueReference;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HistoryUserPotential.fromJson(Map<String, dynamic> json) =>
      HistoryUserPotential(
        id: json["id"],
        userGuestId: json["user_guest_id"],
        userHostId: json["user_host_id"],
        title: json["title"],
        typeFrom: json["type_from"],
        valueReference: json["value_reference"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_guest_id": userGuestId,
        "user_host_id": userHostId,
        "title": title,
        "type_from": typeFrom,
        "value_reference": valueReference,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

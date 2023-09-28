import 'badge.dart';
import 'decentralization.dart';

class User {
  User(
      {this.id,
      this.areaCode,
      this.phoneNumber,
      this.phoneVerifiedAt,
      this.email,
      this.emailVerifiedAt,
      this.name,
      this.dateOfBirth,
      this.avatarImage,
      this.sex,
      this.status,
      this.isHost,
      this.permission,
      this.createdAt,
      this.updatedAt,
      this.isAdmin,
      this.hasPost,
      this.ranked,
      this.rankName,
      this.totalPost,
      this.listMotelRented,
      this.accountRank,
      this.accountRankName,
      this.hostRank,
      this.hostRankName,
      this.avgMinutesResolvedProblem,
      this.decentralization,
      this.referralCode,
      this.hasReferralCode,
      this.eWalletCollaborator,
      this.selfReferralCode,
      this.balanceAccount,
      this.bankAccountName,
      this.bankAccountNumber,
      this.bankName,
      this.cmndBackImageUrl,
      this.cmndFrontImageUrl,
      this.cmndNumber,
      this.totalPostRoommate,
      this.totalPostFindMotel,
      this.goldenCoins,
      this.silverCoins});

  int? id;
  String? areaCode;
  String? phoneNumber;
  String? phoneVerifiedAt;
  String? email;
  String? emailVerifiedAt;
  String? name;
  DateTime? dateOfBirth;
  String? avatarImage;
  int? sex;
  int? status;
  bool? isHost;
  int? permission;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isAdmin;
  int? ranked;
  int? totalPost;
  String? rankName;
  bool? hasPost;
  int? hostRank;
  int? accountRank;
  String? hostRankName;
  String? accountRankName;
  List<MotelRented>? listMotelRented;
  int? avgMinutesResolvedProblem;
  Decentralization? decentralization;
  String? referralCode;
  bool? hasReferralCode;
  String? selfReferralCode;
  EWalletCollaborator? eWalletCollaborator;
  double? balanceAccount;
  String? cmndNumber;
  String? cmndFrontImageUrl;
  String? cmndBackImageUrl;
  String? bankAccountNumber;
  String? bankAccountName;
  String? bankName;
  int? totalPostRoommate;
  int? totalPostFindMotel;
  num? goldenCoins;
  num? silverCoins;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      areaCode: json["area_code"],
      phoneNumber: json["phone_number"],
      phoneVerifiedAt: json["phone_verified_at"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      name: json["name"],
      dateOfBirth: json["date_of_birth"] == null
          ? null
          : DateTime.parse(json["date_of_birth"]),
      avatarImage: json["avatar_image"],
      sex: json["sex"],
      totalPost: json["total_post"],
      status: json["status"],
      isHost: json["is_host"],
      permission: json["permission"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      isAdmin: json["is_admin"],
      ranked: json["ranked"],
      rankName: json["rank_name"],
      //hasPost: json["has_post"] == null ? null : json["has_post"]
      listMotelRented: json["list_motel_rented"] == null
          ? null
          : List<MotelRented>.from(
              json["list_motel_rented"].map((x) => MotelRented.fromJson(x))),
      accountRank: json['account_rank'],
      hostRank: json['host_rank'],
      hasPost: json['has_post'],
      accountRankName: json['account_rank_name'],
      hostRankName: json['host_rank_name'],
      avgMinutesResolvedProblem: json['avg_minutes_resolved_problem'],
      decentralization: json['system_permission'] == null
          ? null
          : Decentralization.fromJson(json['system_permission']),
      referralCode: json['referral_code'],
      hasReferralCode: json['has_referral_code'],
      eWalletCollaborator: json['e_wallet_collaborator'] == null
          ? null
          : EWalletCollaborator.fromJson(json['e_wallet_collaborator']),
      selfReferralCode: json['self_referral_code'],
      balanceAccount: json['balance_account'] == null
          ? null
          : json['balance_account'].toDouble(),
      cmndNumber: json['cmnd_number'],
      cmndBackImageUrl: json['cmnd_back_image_url'],
      cmndFrontImageUrl: json['cmnd_front_image_url'],
      bankAccountName: json['bank_account_name'],
      bankAccountNumber: json['bank_account_number'],
      bankName: json['bank_name'],
      totalPostFindMotel: json['total_post_find_motel'],
      totalPostRoommate: json['total_post_roommate'],
      goldenCoins: json["golden_coin"],
      silverCoins: json["silver_coin"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "area_code": areaCode,
        "phone_number": phoneNumber,
        "has_post": hasPost,
        "phone_verified_at": phoneVerifiedAt,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "name": name,
        "date_of_birth":
            dateOfBirth == null ? null : dateOfBirth!.toIso8601String(),
        "avatar_image": avatarImage,
        "sex": sex,
        "status": status,
        "is_host": isHost,
        "permission": permission,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "is_admin": isAdmin,
        "rank": ranked,
        "rank_name": rankName,
        'account_rank': accountRank,
        'host_rank': hostRank,
        'account_rank_name': accountRankName,
        'host_rank_name': hostRankName,
        'referral_code': referralCode,
        'has_referral_code': hasReferralCode,
        'balance_account': balanceAccount,
        "cmnd_number": cmndNumber,
        "cmnd_front_image_url": cmndFrontImageUrl,
        "cmnd_back_image_url": cmndBackImageUrl,
        "bank_account_number": bankAccountNumber,
        "bank_account_name": bankAccountName,
        "bank_name": bankName,
        'total_post_find_motel': totalPostFindMotel,
        "total_post_roommate": totalPostRoommate,
        "golden_coin": goldenCoins,
        "silver_coin": silverCoins
      };
}

class MotelRented {
  MotelRented(
      {this.motelName,
      this.provinceName,
      this.districtName,
      this.wardsName,
      this.addressDetail,
      this.district,
      this.province,
      this.wards});

  String? motelName;
  String? provinceName;
  String? districtName;
  String? wardsName;
  String? addressDetail;
  int? province;
  int? wards;
  int? district;

  factory MotelRented.fromJson(Map<String, dynamic> json) => MotelRented(
        motelName: json["motel_name"],
        provinceName: json["province_name"],
        districtName: json["district_name"],
        wardsName: json["wards_name"],
        addressDetail: json["address_detail"],
        province: json['province'],
        wards: json['wards'],
        district: json['district'],
      );
}

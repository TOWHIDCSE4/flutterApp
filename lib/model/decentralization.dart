class Decentralization {
  Decentralization(
      {this.viewBadge,
      this.manageMotel,
      this.manageUser,
      this.manageMoPost,
      this.manageContract,
      this.manageBill,
      this.manageMessage,
      this.manageReportProblem,
      this.manageService,
      this.manageOrderServiceSell,
      this.manageNotification,
      this.settingBanner,
      this.settingContact,
      this.settingHelp,
      this.manageMotelConsult,
      this.manageReportStatistic,
      this.createdAt,
      this.updatedAt,
      this.id,
      this.allAccess,
      this.manageServiceSell,
      this.settingCategoryHelp,
      this.name,
      this.description,
      this.ableDecentralization,
      this.unableAccess,
      this.ableRemove,
      this.manageRenter,
      this.manageCollaborator});

  bool? viewBadge;
  bool? manageMotel;
  bool? manageUser;
  bool? manageMoPost;
  bool? manageContract;
  bool? manageBill;
  bool? manageMessage;
  bool? manageReportProblem;
  bool? manageService;
  bool? manageOrderServiceSell;
  bool? manageNotification;
  bool? settingBanner;
  bool? settingContact;
  bool? settingHelp;
  bool? manageMotelConsult;
  bool? manageReportStatistic;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? id;
  bool? allAccess;
  bool? manageServiceSell;
  bool? settingCategoryHelp;
  bool? ableDecentralization;
  bool? unableAccess;
  bool? ableRemove;
  bool? manageRenter;
  String? name;
  String? description;
  bool? manageCollaborator;

  factory Decentralization.fromJson(Map<String, dynamic> json) =>
      Decentralization(
          viewBadge: json["view_badge"],
          manageMotel:
              json["manage_motel"],
          manageUser: json["manage_user"],
          manageMoPost:
              json["manage_mo_post"],
          manageContract:
              json["manage_contract"],
          manageBill: json["manage_bill"],
          manageMessage:
              json["manage_message"],
          manageReportProblem: json["manage_report_problem"],
          manageService:
              json["manage_service"],
          manageOrderServiceSell: json["manage_order_service_sell"],
          manageNotification: json["manage_notification"],
          settingBanner:
              json["setting_banner"],
          settingContact:
              json["setting_contact"],
          settingHelp:
              json["setting_help"],
          manageMotelConsult: json["manage_motel_consult"],
          manageReportStatistic: json["manage_report_statistic"],
          createdAt: json["created_at"] == null
              ? null
              : DateTime.parse(json["created_at"]),
          updatedAt: json["updated_at"] == null
              ? null
              : DateTime.parse(json["updated_at"]),
          id: json["id"],
          allAccess: json["all_access"],
          manageServiceSell: json["manage_service_sell"],
          settingCategoryHelp: json["setting_category_help"],
          name: json["name"],
          description: json["description"],
          ableDecentralization: json['able_decentralization'],
          unableAccess:
              json['unable_access'],
          ableRemove: json['able_remove'],
          manageRenter: json['manage_renter'],
          manageCollaborator: json['manage_collaborator']);

  Map<String, dynamic> toJson() => {
        "view_badge": viewBadge,
        "manage_motel": manageMotel,
        "manage_user": manageUser,
        "manage_mo_post": manageMoPost,
        "manage_contract": manageContract,
        "manage_bill": manageBill,
        "manage_message": manageMessage,
        "manage_report_problem":
            manageReportProblem,
        "manage_service": manageService,
        "manage_order_service_sell":
            manageOrderServiceSell,
        "manage_notification":
            manageNotification,
        "setting_banner": settingBanner,
        "setting_contact": settingContact,
        "setting_help": settingHelp,
        "manage_motel_consult":
            manageMotelConsult,
        "manage_report_statistic":
            manageReportStatistic,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "id": id,
        "all_access": allAccess,
        "manage_service_sell":
            manageServiceSell,
        "setting_category_help":
            settingCategoryHelp,
        "name": name,
        "description": description,
        "able_decentralization": ableDecentralization,
        "unable_access": unableAccess,
        "able_remove": ableRemove,
        "manage_renter": manageRenter,
        'manage_collaborator': manageCollaborator,
      };
}

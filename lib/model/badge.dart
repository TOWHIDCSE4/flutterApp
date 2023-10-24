import 'package:gohomy/model/user.dart';

class Badge {
  Badge({
    this.totalUser,
    this.totalCart,
    this.totalRenter,
    this.totalQuantityContractRented,
    this.totalQuantityBillsNeedPaid,
    this.totalMoneyBillsNeedPaid,
    this.totalUserChat,
    this.totalMoneyNeedPayment,
    this.totalMotelManage,
    this.totalMotelRentedManage,
    this.totalMotelFavoriteManage,
    this.totalMotelAvailableManage,
    this.totalRenterRentedManage,
    this.totalContractActiveManage,
    this.totalContractPendingManage,
    this.totalContractExpiredManage,
    this.totalMoneyBillsNeedCollectManage,
    this.totalQuantityBillManage,
    this.totalProblemDoneManage,
    this.totalProblemNotDoneManage,
    this.totalContractAdmin,
    this.totalContractActiveAdmin,
    this.totalContractPendingAdmin,
    this.totalContractExpiredAdmin,
    this.totalRenterHasMotelAdmin,
    this.totalRenterHasNotMotelAdmin,
    this.totalRenterUnconfirmedMotelAdmin,
    this.totalProblemDoneAdmin,
    this.totalProblemNotDoneAdmin,
    this.totalMotelBillToCollect,
    this.totalQuantityContractPending,
    this.totalQuantityProblem,
    this.totalQuantityProblemDone,
    this.totalQuantityProblemNotDone,
    this.user,
    this.notificationUnread,
    this.totalHostAccountAdmin,
    this.totalMoPostAdmin,
    this.totalMotelAdmin,
    this.totalOrderAdmin,
    this.chatUnread,
    this.totalQuantityBillsAdmin,
    this.totalQuantityPendingPaymentBillsAdmin,
    this.totalQuantityPendingPaymentBillsManage,
    this.totalQuantityWaitConfirmBillsAdmin,
    this.totalQuantityWaitConfirmBillsManage,
    this.totalFindFastMotelNotResolveAdmin,
    this.totalReservationMotelNotConsultAdmin,
    this.totalReservationMotelConsulted,
    this.totalReservationMotelNotConsult,
    this.totalQuantityOrderCancelAdmin,
    this.totalQuantityOrderCompletedAdmin,
    this.totalQuantityOrderProgressingAdmin,
    this.totalQuantityReportViolationPostCompletedAdmin,
    this.totalQuantityReportViolationPostProgressingAdmin,
  });

  int? totalUser;
  int? totalCart;
  int? totalRenter;
  int? totalQuantityContractRented;
  int? totalQuantityBillsNeedPaid;
  int? totalMoneyBillsNeedPaid;
  int? totalUserChat;
  int? totalMoneyNeedPayment;
  int? totalMotelManage;
  int? totalMotelRentedManage;
  int? totalMotelFavoriteManage;
  int? totalMotelAvailableManage;
  int? totalRenterRentedManage;
  int? totalContractActiveManage;
  int? totalContractPendingManage;
  int? totalContractExpiredManage;
  int? totalMoneyBillsNeedCollectManage;
  int? totalQuantityBillManage;
  int? totalProblemDoneManage;
  int? totalProblemNotDoneManage;
  int? totalContractAdmin;
  int? totalContractActiveAdmin;
  int? totalContractPendingAdmin;
  int? totalContractExpiredAdmin;
  int? totalRenterHasMotelAdmin;
  int? totalRenterHasNotMotelAdmin;
  int? totalRenterUnconfirmedMotelAdmin;
  int? totalProblemDoneAdmin;
  int? totalProblemNotDoneAdmin;
  int? totalMotelBillToCollect;
  int? totalQuantityContractPending;
  int? totalQuantityProblem;
  int? totalQuantityProblemDone;
  int? totalQuantityProblemNotDone;
  User? user;
  int? notificationUnread;
  int? totalHostAccountAdmin;
  int? totalOrderAdmin;
  int? totalMoPostAdmin;
  int? totalMotelAdmin;
  int? chatUnread;
  int? totalQuantityWaitConfirmBillsManage;
  int? totalQuantityPendingPaymentBillsManage;
  int? totalQuantityBillsAdmin;
  int? totalQuantityWaitConfirmBillsAdmin;
  int? totalQuantityPendingPaymentBillsAdmin;
  int? totalReservationMotelNotConsultAdmin;
  int? totalFindFastMotelNotResolveAdmin;
  int? totalReservationMotelConsulted;
  int? totalReservationMotelNotConsult;

  int? totalQuantityOrderProgressingAdmin;
  int? totalQuantityOrderCancelAdmin;
  int? totalQuantityOrderCompletedAdmin;
  int? totalQuantityReportViolationPostCompletedAdmin;
  int? totalQuantityReportViolationPostProgressingAdmin;

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
        totalUser: json["total_user"],
        totalCart: json["total_cart"],
        totalRenter: json["total_renter"],
        totalQuantityContractRented:
            json["total_quantity_contract_rented"],
        totalQuantityBillsNeedPaid:
            json["total_quantity_bills_need_paid"],
        totalMoneyBillsNeedPaid: json["total_money_bills_need_paid"],
        totalUserChat:
            json["total_user_chat"],
        totalMoneyNeedPayment: json["total_money_need_payment"],
        totalMotelManage: json["total_motel_manage"],
        totalMotelRentedManage: json["total_motel_rented_manage"],
        totalMotelFavoriteManage: json["total_motel_favorite_manage"],
        totalMotelAvailableManage: json["total_motel_available_manage"],
        totalRenterRentedManage: json["total_renter_rented_manage"],
        totalContractActiveManage: json["total_contract_active_manage"],
        totalContractPendingManage:
            json["total_contract_pending_manage"],
        totalContractExpiredManage:
            json["total_contract_expired_manage"],
        totalMoneyBillsNeedCollectManage:
            json["total_money_bills_need_collect_manage"],
        totalQuantityBillManage: json["total_quantity_bills_manage"],
        totalProblemDoneManage: json["total_problem_done_manage"],
        totalProblemNotDoneManage: json["total_problem_not_done_manage"],
        totalContractAdmin: json["total_contract_admin"],
        totalContractActiveAdmin: json["total_contract_active_admin"],
        totalContractPendingAdmin: json["total_contract_pending_admin"],
        totalContractExpiredAdmin: json["total_contract_expired_admin"],
        totalRenterHasMotelAdmin: json["total_renter_has_motel_admin"],
        totalRenterHasNotMotelAdmin:
            json["total_renter_has_not_motel_admin"],
        totalRenterUnconfirmedMotelAdmin:
            json["total_renter_unconfirmed_motel_admin"],
        totalProblemDoneAdmin: json["total_problem_done_admin"],
        totalProblemNotDoneAdmin: json["total_problem_not_done_admin"],
        totalMotelBillToCollect: json["total_motel_bill_to_collect"],
        user: json["current_user"] == null
            ? null
            : User.fromJson(json["current_user"]),
        totalQuantityContractPending:
            json['total_quantity_contract_pending'],
        totalQuantityProblem: json['total_quantity_problem'],
        totalQuantityProblemDone: json['total_quantity_problem_done'],
        totalQuantityProblemNotDone:
            json['total_quantity_problem_not_done'],
        notificationUnread: json['notification_unread'],
        totalHostAccountAdmin: json['total_host_account_admin'],
        totalMoPostAdmin: json['total_mo_post_admin'],
        totalMotelAdmin: json['total_motel_admin'],
        totalOrderAdmin: json['total_order_admin'],
        chatUnread: json['chat_unread'],
        totalQuantityBillsAdmin: json['total_quantity_bills_admin'],
        totalQuantityPendingPaymentBillsAdmin:
            json['total_quantity_pending_payment_bills_admin'],
        totalQuantityPendingPaymentBillsManage:
            json['total_quantity_pending_payment_bills_manage'],
        totalQuantityWaitConfirmBillsAdmin:
            json['total_quantity_wait_confirm_bills_admin'],
        totalQuantityWaitConfirmBillsManage:
            json['total_quantity_wait_confirm_bills_manage'],
        totalFindFastMotelNotResolveAdmin:
            json['total_find_fast_motel_not_consult_admin'],
        totalReservationMotelNotConsultAdmin:
            json['total_reservation_motel_not_consult_admin'],
        totalReservationMotelConsulted:
            json['total_reservation_motel_consulted'],
        totalReservationMotelNotConsult:
            json['total_reservation_motel_not_consult'],
        totalQuantityOrderCancelAdmin:
            json['total_quantity_order_cancel_admin'],
        totalQuantityOrderCompletedAdmin:
            json['total_quantity_order_completed_admin'],
        totalQuantityOrderProgressingAdmin:
            json['total_quantity_order_progressing_admin'],
        totalQuantityReportViolationPostCompletedAdmin:
            json['total_quantity_report_violation_post_completed_admin'],
        totalQuantityReportViolationPostProgressingAdmin:
            json['total_quantity_report_violation_post_progressing_admin'],
      );

  Map<String, dynamic> toJson() => {
        "total_user": totalUser,
        "total_cart": totalCart,
        "total_renter": totalRenter,
        "total_quantity_contract_rented": totalQuantityContractRented,
        "total_quantity_bills_need_paid": totalQuantityBillsNeedPaid,
        "total_money_bills_need_paid":
            totalMoneyBillsNeedPaid,
        "total_user_chat": totalUserChat,
        "total_money_need_payment":
            totalMoneyNeedPayment,
        "total_motel_manage":
            totalMotelManage,
        "total_motel_rented_manage":
            totalMotelRentedManage,
        "total_motel_favorite_manage":
            totalMotelFavoriteManage,
        "total_motel_available_manage": totalMotelAvailableManage,
        "total_renter_rented_manage":
            totalRenterRentedManage,
        "total_contract_active_manage": totalContractActiveManage,
        "total_contract_pending_manage": totalContractPendingManage,
        "total_contract_expired_manage": totalContractExpiredManage,
        "total_money_bills_need_collect_manage":
            totalMoneyBillsNeedCollectManage,
        "total_quantity_bills_need_collect_manage":
            totalQuantityBillManage,
        "total_problem_done_manage":
            totalProblemDoneManage,
        "total_problem_not_done_manage": totalProblemNotDoneManage,
        "total_contract_admin":
            totalContractAdmin,
        "total_contract_active_admin":
            totalContractActiveAdmin,
        "total_contract_pending_admin": totalContractPendingAdmin,
        "total_contract_expired_admin": totalContractExpiredAdmin,
        "total_renter_has_motel_admin":
            totalRenterHasMotelAdmin,
        "total_renter_has_not_motel_admin": totalRenterHasNotMotelAdmin,
        "total_renter_unconfirmed_motel_admin":
            totalRenterUnconfirmedMotelAdmin,
        "total_problem_done_admin":
            totalProblemDoneAdmin,
        "total_problem_not_done_admin":
            totalProblemNotDoneAdmin,
        "total_motel_bill_to_collect":
            totalMotelBillToCollect,
        "current_user": user == null ? null : user?.toJson(),
      };
}

class EWalletCollaborator {
  EWalletCollaborator({this.accountBalance});
  double? accountBalance;

  factory EWalletCollaborator.fromJson(Map<String, dynamic> json) =>
      EWalletCollaborator(
          accountBalance: json['account_balance'] == null
              ? null
              : json['account_balance'].toDouble());
}

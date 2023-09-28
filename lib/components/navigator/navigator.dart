import 'package:gohomy/const/type_notifications.dart';
import 'package:gohomy/model/user.dart';
import 'package:gohomy/screen/chat/chat_list/chat_list_screen.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/find_room/room_information/room_information_screen.dart';
import 'package:gohomy/screen/owner/contract/add_contract/add_contract_screen.dart';
import 'package:gohomy/screen/profile/bill/bill_screen.dart';

import '../../model/notification_user.dart';
import 'package:get/get.dart';

import '../../screen/admin/admin_withdrawal_manage/admin_withdrawal_details/withdrawal_details_screen.dart';
import '../../screen/admin/commission_manage_admin/commission_detail_admin/commission_detail_admin_screen.dart';
import '../../screen/admin/commission_payment.dart/commission_payment_detail/commission_payment_detail_screen.dart';
import '../../screen/admin/find_fast_motel/find_fast_motel_detail/find_fast_motel_detail_screen.dart';
import '../../screen/admin/find_fast_motel/find_fast_motel_screen.dart';
import '../../screen/admin/motel_room_admin/tower/tower_screen.dart';
import '../../screen/admin/post/find_room_post/find_room_post_admin_detail/find_room_post_admin_detail_screen.dart';
import '../../screen/admin/post/post_details/post_details_screen.dart';
import '../../screen/admin/post/roommate_post/post_roommate_admin/post_roommate_admin_detail_screen.dart';
import '../../screen/admin/potential_user/potential_user_screen.dart';
import '../../screen/admin/report_post_violation/report_post_violation_screen.dart';
import '../../screen/admin/service_sell/orders/detail/order_admin_detail_screen.dart';

import '../../screen/chat/chat_detail/chat_detail_screen.dart';
import '../../screen/owner/commission/commission_detail/commisstion_detail_screen.dart';
import '../../screen/owner/post_management/list_post_management_screen.dart';
import '../../screen/owner/problem_owner/add_problem/add_problem_owner_screen.dart';
import '../../screen/owner/reservation_motel/reservation_motel_host_screen.dart';
import '../../screen/profile/bill/bill_details/bill_details_screen.dart';
import '../../screen/profile/contract/update_contract/contract_details_screen.dart';
import '../../screen/profile/e_wallet_histories/e_wallet_histories_screen.dart';
import '../../screen/profile/problem/add_problem/add_problem_screen.dart';
import '../../screen/profile/service_sell/orders/detail/order_detail_screen.dart';
import '../../screen/users_bill/user_bill_details/user_bill_details_screen.dart';

class NotificationNavigator {
  static void navigator(NotificationUser notificationUser) async {

    print('type ${notificationUser.type}');
    if (notificationUser.type == POST_APPROVED) {
      Get.to(() => ListPostManagementScreen(
            initTab: 1,
          ));
    }
    if (notificationUser.type == CONFIRM_CONTRACT) {
      Get.to(() => UpdateContractScreen(
          id: int.parse(notificationUser.referencesValue!)));
    }
    if (notificationUser.type == POST_CANCEL) {
      Get.to(() => ListPostManagementScreen(
            initTab: 2,
          ));
    }
    if (notificationUser.type == POST_APPROVED_AND_VERIFIED) {
      Get.to(() => RoomInformationScreen(
            roomPostId: int.parse(
              notificationUser.referencesValue!,
            ),
            isWatch: true,
          ));
    }
    if (notificationUser.type == NEW_CONTRACT) {
      Get.to(() => UpdateContractScreen(
          id: int.parse(notificationUser.referencesValue!)));
    }
    if (notificationUser.type == NEW_REPORT_PROBLEM) {
      Get.to(() => AddProblemOwnerScreen(
          problemId: int.parse(notificationUser.referencesValue!)));
    }
    if (notificationUser.type == REPORT_PROBLEM_DONE) {
      Get.to(() => AddProblemScreen(
          problemId: int.parse(notificationUser.referencesValue!)));
    }
    if (notificationUser.type == CONTRACT_HAS_CHANGED) {
      Get.to(() => UpdateContractScreen(
          id: int.parse(notificationUser.referencesValue!)));
    }
    if (notificationUser.type == NEW_BILL) {
      Get.to(() => UserBillDetailsScreen(
            billId: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == NEW_MO_POST) {
      Get.to(() => PostDetailsScreen(
            id: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == CONFIRM_CONTRACT_AND_DEPOSIT_PAID) {
      Get.to(() => AddContractScreen(
            contractId: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == UNCONFIRMED_CONTRACT_BY_HOST) {
      Get.to(() => UpdateContractScreen(
            id: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == TERMINATION_CONTRACT) {
      Get.to(() => UpdateContractScreen(
            id: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == CONTRACT_IS_ABOUT_TO_EXPIRE) {
      Get.to(() => UpdateContractScreen(
            id: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == CONTRACT_IS_ABOUT_TO_EXPIRE_MANAGE) {
      Get.to(() => AddContractScreen(
            contractId: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == CONTRACT_EXPIRED_MANAGE) {
      Get.to(() => AddContractScreen(
            contractId: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == CONTRACT_EXPIRED) {
      Get.to(() => UpdateContractScreen(
            id: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == BILL_HAS_PAID) {
      Get.to(() => BillDetails(
            billId: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == BILL_HAS_PAID_WAIT_HOST_CONFIRM) {
      Get.to(() => BillDetails(
            billId: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == BILL_CANCEL_BY_RENTER) {
      Get.to(() => BillDetails(
            billId: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == RENTER_CONFIRMED) {}
    if (notificationUser.type == BILL_NEED_PAID) {
      Get.to(() => UserBillDetailsScreen(
            billId: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == ORDER_SUCCESS) {
      Get.to(() => OrderHistoryDetailScreen(
          orderCode: notificationUser.referencesValue!));
    }
    if (notificationUser.type == NEW_MESSAGE) {
      Get.to(() => ChatDetailScreen(
            toUser: User(id: int.parse(notificationUser.referencesValue!)),
          ));
    }
    if (notificationUser.type == NEW_ORDER) {
      Get.to(() => OrderAdminHistoryDetailScreen(
          id: int.parse(notificationUser.referencesValue!)));
    }
    if (notificationUser.type == CANCEL_ORDER) {
      Get.to(() => OrderHistoryDetailScreen(
          orderCode: notificationUser.referencesValue!));
    }
    if (notificationUser.type == ORDER_SHIPPING) {
      Get.to(() => OrderHistoryDetailScreen(
          orderCode: notificationUser.referencesValue!));
    }

    if (notificationUser.type == NEW_REQUEST_WITHDRAWAL) {
      Get.to(() => WithdrawalDetailsScreen(
          id: int.parse(notificationUser.referencesValue!)));
    }
    if (notificationUser.type == APPROVED_REQUEST_WITHDRAWAL) {
      Get.to(() => const WalletHistoryScreen());
    }
    if (notificationUser.type == BALANCE_CHANGE) {
      Get.to(() => const WalletHistoryScreen());
    }
    if (notificationUser.type == NEW_RESERVATION) {
      Get.to(() => const ReservationMotelHostScreen());
    }
    if (notificationUser.type == NEW_FIND_FAST_MOTEL) {
      Get.to(() => FindFastMotelDetailScreen(
            idFindFast: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == NEW_REPORT_VIOLATION) {
      Get.to(() => const ReportPostViolationScreen());
    }
    if (notificationUser.type == PAYMENT_COLLABORATOR_MANAGE) {
      Get.to(() => CommissionDetailManageScreen(
            id: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == CONFIRMED_COMMISSION_COLLABORATOR_FOR_HOST) {
      Get.to(() => CommissionDetailManageScreen(
            id: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == CONFIRM_COMMISSION_PAYMENT_HOST_FOR_ADMIN) {
      Get.to(() => CommissionDetailAdminScreen(
            id: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == CONFIRM_COMMISSION_COLLABORATOR_FOR_ADMIN) {
      Get.to(() => CommissionPaymentDetailScreen(
            id: int.parse(notificationUser.referencesValue!),
          ));
    }

    if (notificationUser.type == NEW_MO_POST_FIND_MOTEL) {
      Get.to(() => FindRoomPostDetailAdminScreen(
            postFindRoomId: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == NEW_MO_POST_ROOMMATE) {
      Get.to(() => PostRoommateAdminDetailScreen(
            postRoommateId: int.parse(notificationUser.referencesValue!),
          ));
    }
    if (notificationUser.type == NEW_CUSTOMER_POTENTIAL) {
      Get.to(() => PotentialUserScreen());
    }
    if (notificationUser.type == ADD_ROLE_MANAGE_TOWER) {
      Get.to(() => TowerScreen());
    }
    if (notificationUser.type == EXTEND_BILL) {
      Get.to(() => BillScreen());
    }
    if (notificationUser.type == PAYMENT_DATE_MOTEL_IS_COMING) {}
    if (notificationUser.type == MATURITY_MOTEL) {}
    if (notificationUser.type == UNCONFIRMED_BILL_BY_HOST) {}
  }
}

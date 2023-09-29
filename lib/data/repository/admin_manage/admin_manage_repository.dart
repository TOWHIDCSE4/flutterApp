import 'package:gohomy/data/remote/response-request/account/all_user_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/admin_badges_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/admin_discover_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_admin_category_help_post_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_admin_discover_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_banner_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_decentralization_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_report_post_violation_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_services_sell_response.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/banner_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/category_help_post_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/help_post_data_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/help_post_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/report_violation_post_res.dart';
import 'package:gohomy/data/remote/response-request/manage/all_renter_res.dart';
import 'package:gohomy/data/remote/response-request/motel_room/all_motal_room_res.dart';
import 'package:gohomy/data/remote/response-request/room_post/find_fast_motel_res.dart';
import 'package:gohomy/data/remote/response-request/room_post/room_post_res.dart';
import 'package:gohomy/data/remote/response-request/success/success_response.dart';
import 'package:gohomy/data/remote/response-request/wallet/dashboard.dart';
import 'package:gohomy/model/admin_discover.dart';
import 'package:gohomy/model/admin_discover_item.dart';
import 'package:gohomy/model/category_help_post.dart';
import 'package:gohomy/model/decentralization.dart';
import 'package:intl/intl.dart';

import '../../../model/admin_notification.dart';
import '../../../model/category.dart';
import '../../../model/contact.dart';
import '../../../model/post_find_room.dart';
import '../../../model/post_roommate.dart';
import '../../../model/service_sell.dart';

import '../../../model/banners.dart';
import '../../../model/user.dart';
import '../../remote/response-request/account/user_res.dart';
import '../../remote/response-request/admin_manage/admin_config.dart';
import '../../remote/response-request/admin_manage/admin_contact_res.dart';
import '../../remote/response-request/admin_manage/admin_discover_item_res.dart';
import '../../remote/response-request/admin_manage/all_admin_discover_item_res.dart';
import '../../remote/response-request/admin_manage/all_help_post_res.dart';
import '../../remote/response-request/admin_manage/all_history_receive_commission_res.dart';
import '../../remote/response-request/admin_manage/decentralization_res.dart';
import '../../remote/response-request/admin_manage/service_sell_res.dart';
import '../../remote/response-request/customer_manage/all_post_find_room_res.dart';
import '../../remote/response-request/customer_manage/all_post_roommate_res.dart';
import '../../remote/response-request/customer_manage/post_find_room.dart';
import '../../remote/response-request/customer_manage/post_rommmate_res.dart';
import '../../remote/response-request/manage/all_commission_manage_res.dart';
import '../../remote/response-request/manage/all_contract_res.dart';
import '../../remote/response-request/manage/commission_manage_res.dart';
import '../../remote/response-request/motel_room/motal_room_res.dart';
import '../../remote/response-request/room_post/all_find_fast_motel.dart';
import '../../remote/response-request/room_post/all_reservation_motel_res.dart';
import '../../remote/response-request/room_post/all_room_post_res.dart';
import '../../remote/response-request/room_post/reservation_motel_res.dart';
import '../../remote/response-request/service_sell/all_category_res.dart';
import '../../remote/response-request/service_sell/all_order_res.dart';
import '../../remote/response-request/service_sell/category_res.dart';
import '../../remote/response-request/service_sell/order_res.dart';
import '../../remote/response-request/user_manage/all_bills_res.dart';
import '../../remote/response-request/user_manage/all_problem_res.dart';
import '../../remote/response-request/user_manage/all_request_withdrawals_res.dart';
import '../../remote/response-request/user_manage/all_wallet_history_res.dart';
import '../../remote/response-request/user_manage/request_withdrawals_res.dart';
import '../../remote/response-request/wallet/withdraw.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class AdminManageRepository {
  Future<AllProblemRes?> getAllProblemAdmin(
      {required int page,
      int? status,
      int? userId,
      String? dateFrom,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllProblemAdmin(page, dateFrom, dateTo, status, userId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllContractRes?> getAllContractAdmin(
      {required int page,
      int? status,
      String? search,
      String? representName,
      String? phoneNumber,
      String? dateFrom,
      int? userId,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager().service!.getAllContractAdmin(page,
          status, search, representName, phoneNumber, dateFrom, dateTo, userId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllBillsRes?> getAllBillAdmin(
      {required int page,
      int? status,
      int? userId,
      String? search,
      String? dateFrom,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllBillAdmin(page, search, status, dateFrom, dateTo, userId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AdminBadgesRes?> getAdminBadges() async {
    try {
      var res = await SahaServiceManager().service!.getAdminBadges();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllMotelRoomRes?> getAllAdminMotelRoom(
      {required int page,
      String? search,
      int? status,
      int? userId,
      bool? hasContract,
      int? towerId,
      bool? isHaveTower,
      bool? isSupporter}) async {
    try {
      var res = await SahaServiceManager().service!.getAllAdminMotelRoom(
          page,
          status,
          search,
          userId,
          hasContract,
          towerId,
          isHaveTower,
          isSupporter);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<MotelRoomRes?> updateMotelRoomHiddenStatus({
    required int motelId,
    required int status,
    required int towerMotelId,
  }) async {
    try {
      var res = await SahaServiceManager().service!.updateMotelHiddenStatus({
        "motel_id": motelId,
        "status": status,
        "tower_motel_id": towerMotelId,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<MotelRoomRes?> getAdminMotelRoom({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getAdminMotelRoom(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteAdminMotelRoom({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.deleteAdminMotelRoom(id);
      return res;
    } on Exception catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<AllUserRes?> getAllUsers(
      {String? ranked,
      int? page,
      bool? isHost,
      String? search,
      bool? isRented,
      bool? isAdmin}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllUsers(ranked, page, isHost, search, isRented, isAdmin);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<UserRes?> getUsers({required int userId}) async {
    try {
      var res = await SahaServiceManager().service!.getUsers(userId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<UserRes?> updateUser({required int userId, required User user}) async {
    try {
      var res =
          await SahaServiceManager().service!.updateUser(userId, user.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteUsers({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.deleteUser(id);
      return res;
    } on Exception catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<AllServiceSellRes?> getAllServiceSell(
      {required int page, int? categoryId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllServiceSell(page, categoryId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ServiceSellRes?> addServiceSell(
      {required ServiceSell serviceSell}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addServiceSell(serviceSell.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ServiceSellRes?> getServiceSell({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getServiceSell(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteServiceSell({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.deleteServiceSell(id);
      return res;
    } on Exception catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<ServiceSellRes?> updateServiceSell(
      {required int id, required ServiceSell serviceSell}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateServiceSell(id, serviceSell.toJson());
      return res;
    } on Exception catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<AllRoomPost?> getAllMotelPost(
      {required int page, int? status, String? search, int? userId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllMotelPost(page, status, search, userId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RoomPostRes?> getMotelPost({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getMotelPost(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteMotelPost({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.deleteMotelPost(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RoomPostRes?> approvePost({required int id, required int stt}) async {
    try {
      var res =
          await SahaServiceManager().service!.approvePost(id, {"status": stt});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RoomPostRes?> verify(
      {required int id, required bool adminVerified}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .approvePost(id, {"admin_verified": adminVerified});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllBannerRes?> getAllBanner({int? page}) async {
    try {
      var res = await SahaServiceManager().service!.getAllBanner(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllBannerRes?> addBanner({required Banners banner}) async {
    try {
      var res = await SahaServiceManager().service!.addBanner(banner.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<BannerRes?> getBanner({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getBanner(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<BannerRes?> updateBanner(
      {required int id, required Banners banner}) async {
    try {
      var res =
          await SahaServiceManager().service!.updateBanner(id, banner.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteBanner({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.deleteBanner({
        "list_id_banner": [id]
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllAdminDiscoverRes?> getAllAdminDiscover() async {
    try {
      var res = await SahaServiceManager().service!.getAllAdminDiscover();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllAdminDiscoverItemRes?> getAllAdminDiscoverItem(
      {required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getAllAdminDiscoverItem(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AdminDiscoverRes?> addDiscover(
      {required AdminDiscover adminDiscover}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addDiscover(adminDiscover.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteDiscover({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.deleteDiscover({
        "list_id_discover_ui": [id]
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AdminDiscoverItemRes?> addDiscoverItem(
      {required AdminDiscoverItem adminDiscoverItem}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addDiscoverItem(adminDiscoverItem.toJson());

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteDiscoverItem({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.deleteDiscoverItem({
        "list_id_item_discover_ui": [id]
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AdminDiscoverItemRes?> getDiscoverItem({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getDiscoverItem(id);

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AdminDiscoverItemRes?> updateDiscoverItem(
      {required int id, required AdminDiscoverItem adminDiscoverItem}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateDiscoverItem(id, adminDiscoverItem.toJson());

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AdminDiscoverRes?> updateDiscover(
      {required int id, required AdminDiscover adminDiscover}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateDiscover(id, adminDiscover.toJson());

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AdminContactRes?> getAdminContact() async {
    try {
      var res = await SahaServiceManager().service!.getAdminContact();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AdminContactRes?> updateAdminContact(
      {required Contact contact}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateAdminContact(contact.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  /// order

  Future<AllOrderRes?> getAllOrderAdmin(
      {required int page, String? search, required int orderStatus}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllOrderAdmin(page, search, orderStatus);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<OrderRes?> getOrderAdmin({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getOrderAdmin(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<OrderRes?> updateOrderAdmin(
      {required int orderId, required int orderStatus}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateOrderAdmin(orderId, {'order_status': orderStatus});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteOrderAdmin({required int orderId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteOrderAdmin(orderId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ///help post

  Future<AllAdminCategoryHelpPostRes?> getAllAdminCategoryHelpPost(
      {required int page}) async {
    try {
      var res =
          await SahaServiceManager().service!.getAllAdminCategoryHelpPost(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CategoryHelpPostRes?> addCategoryHelpPost(
      {required CategoryHelpPost categoryHelpPost}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addCategoryHelpPost(categoryHelpPost.toJson());

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllHelpPostRes?> getAllAdminHelpPost({required int page}) async {
    try {
      var res = await SahaServiceManager().service!.getAllAdminHelpPost(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> addHelpPost(
      {required HelpPostRequest helpPostRequest}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addHelpPost(helpPostRequest.toJson());

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<HelpPostDataRes?> getHelpPost({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getHelpPost(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<HelpPostRes?> updateHelpPost(
      {required int id, required HelpPostRequest helpPostRequest}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateHelpPost(id, helpPostRequest.toJson());

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  /// find fast motel

  Future<AllFindFastMotelRes?> getAllFindFastMotel({
    required int page,
    String? search,
    int? status,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllFindFastMotel(page, status, search);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<FindFastMotelRes?> getFindFastMotel({
    required int idFindFast,
  }) async {
    try {
      var res =
          await SahaServiceManager().service!.getFindFastMotel(idFindFast);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  /// reservation motel host

  Future<AllReservationMotelRes?> getReservationMotelHost({
    required int page,
    String? search,
    int? status,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getReservationMotelHost(page, status, search);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<FindFastMotelRes?> updateFindFastMotel({
    required int findFastMotelId,
    required int status,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateFindFastMotel(findFastMotelId, {"status": status});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReservationMotelRes?> updateReservationMotel({
    required int reservationId,
    required int status,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateReservationMotel(reservationId, {"status": status});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteReservationMotel({
    required int reservationId,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteReservationMotel(reservationId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteFindFastMotel({
    required int findFastMotelId,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteFindFastMotel(findFastMotelId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteHelpPost({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.deleteHelpPost(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CategoryHelpPostRes?> getCategoryHelp({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getCategoryHelp(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CategoryHelpPostRes?> updateCategoryHelp(
      {required int id, required CategoryHelpPost categoryHelpPost}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateCategoryHelp(id, categoryHelpPost.toJson());

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteCategoryHelp({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.deleteCategoryHelp(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllReservationMotelRes?> getReservationMotelAdmin({
    required int page,
    String? search,
    int? status,
    int? userId,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getReservationMotelAdmin(page, status, search, userId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ///report violation post
  Future<AllReportPostViolationRes?> getAllReportViolationPost({
    required int page,
    String? search,
    int? status,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllReportViolationPost(page, status, search);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteReportPostViolation({required int id}) async {
    try {
      var res =
          await SahaServiceManager().service!.deleteReportPostViolation(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportViolationPostRes?> updateReportPostViolation({
    required int id,
    required int status,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateReportPostViolation(id, {"status": status});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  /////noti admin
  Future<SuccessResponse?> sendAdminNotification({
    required AdminNotification adminNoti,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .sendAdminNotification(adminNoti.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  //////Decentralization

  Future<AllDecentralizationRes?> getAllDecentralization(
      {required int page}) async {
    try {
      var res =
          await SahaServiceManager().service!.getAllDecentralization(page);

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<DecentralizationRes?> addDecentralization(
      {required Decentralization decentralization}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addDecentralization(decentralization.toJson());

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<DecentralizationRes?> getDecentralization({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getDecentralization(id);

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<DecentralizationRes?> updateDecentralization({
    required int id,
    required Decentralization decentralization,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateDecentralization(id, decentralization.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteDecentralization({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.deleteDecentralization(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> decentralizationAdmin(
      {required int userId, required int decentralizationId}) async {
    try {
      var res = await SahaServiceManager().service!.decentralizationAdmin(
          {"user_id": userId, "system_permission_id": decentralizationId});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  /////Admin renter

  Future<AllRenterRes?> getAllAdminRenter(
      {required int page,
      bool? isRenter,
      String? search,
      int? userId,
      DateTime? fromDate,
      DateTime? toDate}) async {
    try {
      var res = await SahaServiceManager().service!.getAllAdminRenter(
          page,
          isRenter,
          search,
          userId,
          fromDate == null ? null : DateFormat('dd-MM-yyyy').format(fromDate),
          toDate == null ? null : DateFormat('dd-MM-yyyy').format(toDate));

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

///////// . admin withdrawal
  Future<AllRequestWithdrawalsRes?> getAllWithdrawalAdmin(
      {required int page,
      int? status,
      String? dateFrom,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllWithdrawalAdmin(page, status, dateFrom, dateTo);

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RequestWithdrawalsRes?> getWithdrawalAdmin({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getWithdrawalAdmin(id);

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RequestWithdrawalsRes?> verifyWithdrawal({required int id, int? status
      //required RequestWithdrawals requestWithdrawals,
      }) async {
    try {
      var res = await SahaServiceManager().service!.verifyWithdrawal(id, {
        "status": status,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteWithdrawal({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.deleteWithdrawal(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ////Referral

  Future<AllUserRes?> getAllReferral({required int page}) async {
    try {
      var res = await SahaServiceManager().service!.getAllReferral(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllUserRes?> getAllUserReferral(
      {required int page, String? code}) async {
    try {
      var res =
          await SahaServiceManager().service!.getAllUserReferral(page, code);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllWalletHistoryRes?> getAllHistoriesCollaborator(
      {required int page, int? id}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllHistoriesCollaborator(page, id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllHistoryReceiveCommissionRes?> getAllHistoryReceiveCommission(
      {required int page}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllHistoryReceiveCommission(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllCommissionManageRes?> getAllCommissionAdmin(
      {required int page,
      int? status,
      int? statusCommissionCollaborator,
      String? dateFrom,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager().service!.getAllCommissionAdmin(
          page, status, statusCommissionCollaborator, dateFrom, dateTo);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CommissionManageRes?> getCommissionAdmin({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getCommissionAdmin(id);

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CommissionManageRes?> confirmCommissionAdmin(
      {required int id, int? status
      //required RequestWithdrawals requestWithdrawals,
      }) async {
    try {
      var res = await SahaServiceManager().service!.confirmCommissionAdmin(id, {
        "status": status,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CommissionManageRes?> confirmCommissionUser(
      {required int id, int? status
      //required RequestWithdrawals requestWithdrawals,
      }) async {
    try {
      var res = await SahaServiceManager().service!.confirmCommissionUser(id, {
        "status_commission_collaborator": status,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  /////post find room
  Future<AllPostFindRoomRes?> getAllAdminPostFindRoom(
      {required int page, int? status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllAdminPostFindRoom(page, status);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostFindRoomRes?> getAdminPostFindRoom(
      {required int postFindRoomId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAdminPostFindRoom(postFindRoomId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostFindRoomRes?> updateAdminPostFindRoom(
      {required int postFindRoomId, required PostFindRoom postFindRoom}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateAdminPostFindRoom(postFindRoomId, postFindRoom.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostFindRoomRes?> updateStatusAdminPostFindRoom(
      {required int postFindRoomId, required int status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateStatusAdminPostFindRoom(postFindRoomId, {"status": status});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteAdminPostFindRoom(
      {required int postFindRoomId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteAdminPostFindRoom(postFindRoomId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ////post roommate

  Future<AllPostRoommateRes?> getAllAdminPostRoommate(
      {required int page, int? status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllAdminPostRoommate(page, status);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostRoommateRes?> getAdminPostRoommate(
      {required int postRoommateId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAdminPostRoommate(postRoommateId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostRoommateRes?> updateAdminPostRoommate(
      {required int postRoommateId, required PostRoommate postRoommate}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateAdminPostRoommate(postRoommateId, postRoommate.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostRoommateRes?> updateStatusAdminPostRoommate(
      {required int postRoommateId, required int status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateStatusAdminPostRoommate(postRoommateId, {"status": status});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteAdminPostRoommate(
      {required int postRoommateId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteAdminPostRoommate(postRoommateId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AdminConfigRes?> addConfig({required AdminConfig adminConfig}) async {
    try {
      var res =
          await SahaServiceManager().service!.addConfig(adminConfig.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AdminConfigRes?> getAdminConfig() async {
    try {
      var res = await SahaServiceManager().service!.getAdminConfig();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteToken(
      {required int userId, required String deviceToken}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteToken({"user_id": userId, "device_token": deviceToken});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllCategoryRes?> getAllAdminCategory({required int page}) async {
    try {
      var res = await SahaServiceManager().service!.getAllAdminCategory(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CategoryRes?> getAdminCategory({required int idCategory}) async {
    try {
      var res =
          await SahaServiceManager().service!.getAdminCategory(idCategory);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CategoryRes?> addCategory({required Category category}) async {
    try {
      var res =
          await SahaServiceManager().service!.addCategory(category.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CategoryRes?> updateAdminCategory(
      {required Category category, required int idCategory}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateAdminCategory(idCategory, category.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteAdminCategory(
      {required int idCategory}) async {
    try {
      var res =
          await SahaServiceManager().service!.deleteAdminCategory(idCategory);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<DashboardRes?> getDashboard() async {
    try {
      var res = await SahaServiceManager().service!.getDashboard();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<WithdrawRes?> confirmPaymentStatus(int? transactionId) async {
    try {
      var res = await SahaServiceManager().service!.confirmPaymentStatus({
        'wallet_transaction_id': transactionId
      });
      return res;
    } catch(err) {
      handleError(err);
    }

    return null;
  }

  Future<GraphRes?> getDataForGraph({int? year, String? type}) async {
    try {
      var res = await SahaServiceManager().service!.getDataForGraph(year, type);
      return res;
    } catch(err) {
      handleError(err);
    }
    return null;
  }
}

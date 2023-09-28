import 'package:gohomy/data/remote/response-request/account/badge_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_admin_category_help_post_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_help_post_res.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/help_post_data_res.dart';
import 'package:gohomy/data/remote/response-request/motel_room/motal_room_res.dart';
import 'package:gohomy/data/remote/response-request/room_post/all_room_post_res.dart';
import 'package:gohomy/data/remote/response-request/room_post/room_post_res.dart';
import 'package:gohomy/data/remote/response-request/success/success_response.dart';
import 'package:gohomy/data/remote/response-request/user_manage/all_bills_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/request_withdrawals_res.dart';
import 'package:gohomy/data/remote/response-request/user_manage/summary_motel_res.dart';
import 'package:gohomy/model/bill.dart';
import 'package:gohomy/model/problem.dart';
import 'package:gohomy/model/report_post_violation.dart';

import '../../../model/post_find_room.dart';
import '../../../model/post_roommate.dart';
import '../../../model/report_post_find_room.dart';
import '../../../model/report_post_roommate.dart';
import '../../remote/response-request/admin_manage/report_post_find_room_res.dart';
import '../../remote/response-request/admin_manage/report_post_roommate_res.dart';
import '../../remote/response-request/admin_manage/report_violation_post_res.dart';
import '../../remote/response-request/customer_manage/all_post_find_room_res.dart';
import '../../remote/response-request/customer_manage/all_post_roommate_res.dart';
import '../../remote/response-request/customer_manage/post_find_room.dart';
import '../../remote/response-request/customer_manage/post_rommmate_res.dart';
import '../../remote/response-request/manage/all_contract_res.dart';
import '../../remote/response-request/manage/bill_res.dart';
import '../../remote/response-request/manage/contract_res.dart';
import '../../remote/response-request/user_manage/all_history_potential_res.dart';
import '../../remote/response-request/user_manage/all_potential_user_res.dart';
import '../../remote/response-request/user_manage/all_problem_res.dart';
import '../../remote/response-request/user_manage/all_request_withdrawals_res.dart';
import '../../remote/response-request/user_manage/all_wallet_history_res.dart';
import '../../remote/response-request/user_manage/old_bill_res.dart';
import '../../remote/response-request/user_manage/potential_user_res.dart';
import '../../remote/response-request/user_manage/problem_res.dart';
import '../../remote/response-request/user_manage/user_bill_res.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class UserManageRepository {
  Future<AllBillsRes?> getAllBill(
      {required int page,
      int? status,
      String? search,
      String? dateFrom,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllBill(page, search, status, dateFrom, dateTo);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<BillRes?> getOneBill({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getOneBill(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<OldBillRes?> getBillRoom({required int roomId}) async {
    try {
      var res = await SahaServiceManager().service!.getBillRoom(roomId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllBillsRes?> getUserAllBill(
      {required int page,
      int? status,
      String? search,
      String? dateFrom,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getUserAllBill(page, search, status, dateFrom, dateTo);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<UserBillRes?> getUserBill({required int billId}) async {
    try {
      var res = await SahaServiceManager().service!.getUserBill(billId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllProblemRes?> getAllProblem(
      {required int page,
      int? status,
      String? dateFrom,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllProblem(page, dateFrom, dateTo, status);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ProblemRes?> addProblem({required Problem problem}) async {
    try {
      var res =
          await SahaServiceManager().service!.addProblem(problem.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ProblemRes?> updateProblem(
      {required int problemId, required Problem problem}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateProblem(problemId, problem.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteProblem({required int problemId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteProblem(problemId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ProblemRes?> getProblem({required int problemId}) async {
    try {
      var res = await SahaServiceManager().service!.getProblem(problemId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  /// contract

  Future<AllContractRes?> getAllContractUser(
      {required int page,
      int? status,
      String? search,
      String? dateFrom,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllContractUser(page, status, search, dateFrom, dateTo);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ContractRes?> getContractUser({required int contractId}) async {
    try {
      var res = await SahaServiceManager().service!.getContractUser(contractId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ContractRes?> updateContractUser(
      {required int contractId,
      required bool isConfirmed,
      List<String>? listImagepayment,
      double? depositAmountpaid}) async {
    try {
      var res =
          await SahaServiceManager().service!.updateContractUser(contractId, {
        "is_confirmed": isConfirmed,
        "images_deposit": listImagepayment,
        "deposit_amount_paid": depositAmountpaid
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<Bill?> putUserPayment({
    required int billId,
    required Bill bill,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .putUserPayment(billId, bill.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<BadgesRes?> getBadge() async {
    try {
      var res = await SahaServiceManager().service!.getBadge();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SummaryRes?> getSummary() async {
    try {
      var res = await SahaServiceManager().service!.getSummary();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllMotelRoomRes?> getUserMotelRoom(
      {required int page,
      String? search,
      bool? hasContract,
      int? status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getUserMotelRoom(page, search, hasContract, status);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ///Favourite post
  Future<AllRoomPost?> getAllFavouritePost({required int page}) async {
    try {
      var res = await SahaServiceManager().service!.getAllFavouritePost(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RoomPostRes?> setFavouritePost(
      {required int id, bool? isFavourite}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .setFavourite(id, ({"is_favorite": isFavourite}));
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

////// Help post
  Future<AllHelpPostRes?> getAllHelpPost(
      {required int page, int? typeCategory, String? search}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllHelpPost(page, typeCategory, search);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllAdminCategoryHelpPostRes?> getAllCategoryHelpPost(
      {required int page, String? search}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllCategoryHelpPost(page, search);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<HelpPostDataRes?> getOneHelpPost({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getOneHelpPost(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportViolationPostRes?> addReportPostViolation(
      {required ReportPostViolation reportPostViolation}) async {
    try {
      var res = await SahaServiceManager().service!.addReportPostViolation({
        "mo_post_id": reportPostViolation.moPostId,
        "reason": reportPostViolation.reason,
        "description": reportPostViolation.description
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ////////withdrawal
  Future<AllWalletHistoryRes?> getAllWalletHistories(
      {required int page, String? search}) async {
    try {
      var res = await SahaServiceManager().service!.getAllWalletHistories(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RequestWithdrawalsRes?> requestWithdrawal(
      {required double money}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .requestWithdrawal({"amount_money": money});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllRequestWithdrawalsRes?> getAllRequestWithdrawal(
      {required int page}) async {
    try {
      var res =
          await SahaServiceManager().service!.getAllRequestWithdrawal(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RequestWithdrawalsRes?> getWithdrawalUser({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getWithdrawalUser(id);

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RequestWithdrawalsRes?> updateWithdrawal(
      {required int id, double? money, int? status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateWithdrawal(id, {"amount_money": money, "status": status});

      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ///Potential user
  Future<AllPotentialUserRes?> getAllPotentialUser(
      {required int page, int? status, String? textSearch}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllPotentialUser(page, status, textSearch);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PotentialUserRes?> getPotentialUser({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getPotentialUser(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllHistoryPotentialRes?> getAllHistoryPotential(
      {required int page, int? userGuestId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllHistoryPotential(page, userGuestId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PotentialUserRes?> updatePotentialUser(
      {required int status, required int idPotential}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updatePotentialUser(idPotential, {"status": status});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deletePotentialUser(
      {required int idPotential}) async {
    try {
      var res =
          await SahaServiceManager().service!.deletePotentialUser(idPotential);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PotentialUserRes?> addPotentialUser(
      {required int postId, required int typeFrom}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addPotentialUser({"mo_post_id": postId, "type_from": typeFrom});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllPostRoommateRes?> getAllPostRoommate(
      {required int page, int? status, String? search,
    int? wards,
    int? district,
    int? province,

    ///Tien nghi
    bool? hasWc,
    bool? hasMezzanine,
    bool? hasBalcony,
    bool? hasFingerprint, ////
    bool? hasOwnOwner,
    bool? hasPet,
    ////Noi that
    bool? hasAirConditioner,
    bool? hasWaterHeater,
    bool? hasKitchen,
    bool? hasWindow,
    bool? hasSecurity,
    bool? hasFreeMove,
    bool? hasFridge,
    bool? hasBed,
    bool? hasWashingMachine,
    bool? hasKitchenStuff, ////
    bool? hasTable, /////
    bool? hasDecorativeLights, /////
    bool? hasPicture, /////
    bool? hasTree, /////
    bool? hasPillow, ////
    bool? hasWardrobe,
    bool? hasMattress, ////
    bool? hasShoesRacks, ////
    bool? hasCurtain, ////
    bool? hasCeilingFans, ////
    bool? hasMirror, ////
    bool? hasSofa,

    ///
    bool? hasTivi,
    double? fromMoney,
    double? maxMoney,
    bool? descending,
    String? sortBy,
    String? phoneNumber,
    String? listType,
    bool? isAll}) async {
    try {
      var res =
          await SahaServiceManager().service!.getAllPostRoommate(page, search,
            wards,
            district,
            province,
            hasPet,
            hasTivi,
            hasWc,
            hasWindow,
            hasSecurity,
            hasFreeMove,
            hasOwnOwner,
            hasAirConditioner,
            hasWaterHeater,
            hasKitchen,
            hasFridge,
            hasWashingMachine,
            hasMezzanine,
            hasBed,
            hasWardrobe,
            hasBalcony,
            hasFingerprint,
            hasKitchenStuff,
            hasCeilingFans,
            hasCurtain,
            hasDecorativeLights,
            hasMattress,
            hasMirror,
            hasSofa,
            hasPicture,
            hasPillow,
            hasTable,
            hasShoesRacks,
            hasTree,
            fromMoney,
            maxMoney,
            descending,
            sortBy,
            phoneNumber,
            listType, status,isAll);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostRoommateRes?> getPostRoommate(
      {required int idPostRoommate}) async {
    try {
      var res =
          await SahaServiceManager().service!.getPostRoommate(idPostRoommate);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostRoommateRes?> addPostRoommate(
      {required PostRoommate postRoommate}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addPostRoommate(postRoommate.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostRoommateRes?> updatePostRoommate(
      {required PostRoommate postRoommate, required int postRoommateId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updatePostRoommate(postRoommateId, postRoommate.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ///post find room

  Future<AllPostFindRoomRes?> getAllPostFindRoom(
      {required int page, int? status,int? province,int? district,int? wards,String? search,bool? isAll,String? phoneNumber,
       bool? hasWc,
    bool? hasMezzanine,
    bool? hasBalcony,
    bool? hasFingerprint, ////
    bool? hasOwnOwner,
    bool? hasPet,
    ////Noi that
    bool? hasAirConditioner,
    bool? hasWaterHeater,
    bool? hasKitchen,
    bool? hasWindow,
    bool? hasSecurity,
    bool? hasFreeMove,
    bool? hasFridge,
    bool? hasBed,
    bool? hasWashingMachine,
    bool? hasKitchenStuff, ////
    bool? hasTable, /////
    bool? hasDecorativeLights, /////
    bool? hasPicture, /////
    bool? hasTree, /////
    bool? hasPillow, ////
    bool? hasWardrobe,
    bool? hasMattress, ////
    bool? hasShoesRacks, ////
    bool? hasCurtain, ////
    bool? hasCeilingFans, ////
    bool? hasMirror, ////
    bool? hasSofa,

    ///
    bool? hasTivi,
    double? fromMoney,
    double? maxMoney,
    bool? descending,
    String? sortBy,
   
    String? listType,
      }) async {
    try {
      var res =
          await SahaServiceManager().service!.getAllPostFindRoom(page, status,province,district,wards,search,isAll,phoneNumber,  hasPet,
            hasTivi,
            hasWc,
            hasWindow,
            hasSecurity,
            hasFreeMove,
            hasOwnOwner,
            hasAirConditioner,
            hasWaterHeater,
            hasKitchen,
            hasFridge,
            hasWashingMachine,
            hasMezzanine,
            hasBed,
            hasWardrobe,
            hasBalcony,
            hasFingerprint,
            hasKitchenStuff,
            hasCeilingFans,
            hasCurtain,
            hasDecorativeLights,
            hasMattress,
            hasMirror,
            hasSofa,
            hasPicture,
            hasPillow,
            hasTable,
            hasShoesRacks,
            hasTree,
            fromMoney,
            maxMoney,
            descending,
            sortBy,
           
            listType);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostFindRoomRes?> getPostFindRoom(
      {required int idPostFindRoom}) async {
    try {
      var res =
          await SahaServiceManager().service!.getPostFindRoom(idPostFindRoom);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostFindRoomRes?> addPostFindRoom(
      {required PostFindRoom postFindRoom}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addPostFindRoom(postFindRoom.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<PostFindRoomRes?> updatePostFindRoom(
      {required PostFindRoom postFindRoom, required int idPostFindRoom}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updatePostFindRoom(idPostFindRoom, postFindRoom.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ReportPostFindRoomRes?> reportPostFindRoom(
      {required ReportPostFindRoom reportPostFindRoom,
      }) async {
    try {
      var res = await SahaServiceManager().service!.reportPostFindRoom(
       reportPostFindRoom.toJson()
      );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
   Future<ReportPostRoommateRes?> reportPostRoommate(
      {required ReportPostRoommate reportPostRoommate,
      }) async {
    try {
      var res = await SahaServiceManager().service!.reportPostRoommate(
       reportPostRoommate.toJson()
      );
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}

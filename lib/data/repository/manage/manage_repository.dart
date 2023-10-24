import 'package:gohomy/model/commission_manage.dart';
import 'package:gohomy/model/contract.dart';
import 'package:gohomy/model/renter.dart';
import 'package:intl/intl.dart';

import '../../../model/bill.dart';
import '../../../model/motel_post.dart';
import '../../../model/motel_room.dart';
import '../../../model/service.dart';
import '../../../model/support_manage_tower.dart';
import '../../../model/tower.dart';
import '../../remote/response-request/manage/all_commission_manage_res.dart';
import '../../remote/response-request/manage/all_contract_res.dart';
import '../../remote/response-request/manage/all_motel_post_res.dart';
import '../../remote/response-request/manage/all_renter_res.dart';
import '../../remote/response-request/manage/all_tower_res.dart';
import '../../remote/response-request/manage/bill_res.dart';
import '../../remote/response-request/manage/commission_manage_res.dart';
import '../../remote/response-request/manage/contract_res.dart';
import '../../remote/response-request/manage/motel_post_res.dart';
import '../../remote/response-request/manage/renter_res.dart';
import '../../remote/response-request/manage/tower_res.dart';
import '../../remote/response-request/motel_room/all_motal_room_res.dart';
import '../../remote/response-request/motel_room/motal_room_res.dart';
import '../../remote/response-request/room_post/all_reservation_motel_res.dart';
import '../../remote/response-request/service/all_service_res.dart';
import '../../remote/response-request/service/service_res.dart';
import '../../remote/response-request/success/success_response.dart';
import '../../remote/response-request/support_manage_motel/all_support_manage_tower_res.dart';
import '../../remote/response-request/support_manage_motel/support_manage_tower_res.dart';
import '../../remote/response-request/user_manage/all_problem_res.dart';
import '../../remote/response-request/user_manage/problem_res.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class ManageRepository {
  /// Contract
  Future<AllContractRes?> getAllContract(
      {required int page,
      int? status,
      String? search,
      String? representName,
      String? phoneNumber,
      String? dateFrom,
        int? towerId,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager().service!.getAllContract(
          page, status, search, representName, phoneNumber, dateFrom, dateTo, towerId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ContractRes?> getContract({required int contractId}) async {
    try {
      var res = await SahaServiceManager().service!.getContract(contractId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ContractRes?> addContract({required Contract contract}) async {
    try {
      var res =
          await SahaServiceManager().service!.addContract(contract.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ContractRes?> updateContract({
    required int contractId,
    required Contract contract,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateContract(contractId, contract.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ContractRes?> confirmDeposit({
    required int contractId,
    required int status,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .confirmDeposit(contractId, {"status": status});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteContract({required int contractId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteContract(contractId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ///Renter
  Future<AllRenterRes?> getAllRenter(
      {required int page,
      bool? isRenter,
      int? renterStatus,
      String? search,
      int? userId,
      DateTime? fromDate,
      DateTime? toDate}) async {
    try {
      var res = await SahaServiceManager().service!.getAllRenter(
          page,
          isRenter,
          renterStatus,
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

  Future<RenterRes?> getRenter({required int renterId}) async {
    try {
      var res = await SahaServiceManager().service!.getRenter(renterId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RenterRes?> updateRenter({
    required int renterId,
    required Renter renter,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateRenter(renterId, renter.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<RenterRes?> addRenter({required Renter renter}) async {
    try {
      var res = await SahaServiceManager().service!.addRenter(renter.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteRenter({required int renterId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteRenter(renterId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ///Service
  Future<AllServiceRes?> getAllService() async {
    try {
      var res = await SahaServiceManager().service!.getAllService();
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ServiceRes?> addService({required Service service}) async {
    try {
      var res =
          await SahaServiceManager().service!.addService(service.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ServiceRes?> updateService(
      {required int serviceId, required Service service}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateService(serviceId, service.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteService({required int serviceId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteService(serviceId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ///Motel Room
  Future<AllMotelRoomRes?> getAllMotelRoom(
      {required int page,
      String? search,
      bool? hasContract,
      int? status,
      bool? hasPost,
      int? towerId,
      bool? isHaveTower,
      int? limit,
      int? floorFrom,
      int? floorTo,
      bool? isSupporterManage,
      bool? isHaveSupperter,
      int? manageSupporterId,
      bool? isSupporter}) async {
    try {
      var res = await SahaServiceManager().service!.getAllMotelRoom(
          page,
          search,
          hasContract,
          status,
          hasPost,
          towerId,
          isHaveTower,
          limit,
          floorFrom,
          floorTo,
          isSupporterManage,
          isHaveSupperter,
          manageSupporterId,
          isSupporter);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllMotelRoomRes?> getAllMotelSupport(
      {required int page,
      String? search,
      bool? hasContract,
      int? status,
      bool? hasPost,
      int? towerId,
      bool? isHaveTower,
      int? limit,
      int? floorFrom,
      int? floorTo,
      bool? isSupporterManage,
      bool? isHaveSupperter,
      int? manageSupporterId,
      bool? isSupporter}) async {
    try {
      var res = await SahaServiceManager().service!.getAllMotelSupport(
          page,
          search,
          hasContract,
          status,
          hasPost,
          towerId,
          isHaveTower,
          limit,
          floorFrom,
          floorTo,
          isSupporterManage,
          isHaveSupperter,
          manageSupporterId,
          isSupporter);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<MotelRoomRes?> addMotelRoom({required MotelRoom motelRoom}) async {
    try {
      var res =
          await SahaServiceManager().service!.addMotelRoom(motelRoom.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<MotelRoomRes?> updateMotelRoom(
      {required int motelRoomId, required MotelRoom motelRoom}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateMotelRoom(motelRoomId, motelRoom.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteMotelRoom({required int motelRoomId}) async {
    try {
      var res =
          await SahaServiceManager().service!.deleteMotelRoom(motelRoomId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<MotelRoomRes?> getMotelRoom({required int motelRoomId}) async {
    try {
      var res = await SahaServiceManager().service!.getMotelRoom(motelRoomId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  ///Post management
  Future<AllMotelPostRes?> getAllPostManagement(
      {required int page,
      int? status,
      String? search,
      String? moneyFrom,
      String? moneyTo,
      int? province,
      int? district}) async {
    try {
      var res = await SahaServiceManager().service!.getAllPostManagement(
          page, status, search, moneyFrom, moneyTo, district, province);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<MotelPostRes?> getPostManagement({
    required int id,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getPostManagement(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<MotelPostRes?> addPostManagement(
      {required MotelPost motelPost}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addPostManagement(motelPost.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<BillRes?> addBill({required Bill bill}) async {
    try {
      var res = await SahaServiceManager().service!.addBill(bill.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<BillRes?> updateBill({required int billId, required Bill bill}) async {
    try {
      var res =
          await SahaServiceManager().service!.updateBill(billId, bill.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteBill({required int billId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteBill(billId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<BillRes?> billStatus(
      {required int billId, required int status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .billStatus(billId, {'status': status});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<MotelPostRes?> updatePostManagement(
      {required int postManagementId, required MotelPost motelPost}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updatePostManagement(postManagementId, motelPost.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<MotelPostRes?> changePostStatus(
      {required int postManagementId, required int status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .changePostStatus(postManagementId, {"status": status});
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deletePostManagement(
      {required int postManagementId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deletePostManagement(postManagementId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  /// problem

  Future<AllProblemRes?> getAllProblemOwner(
      {required int page,
      int? status,
      String? dateFrom,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllProblemOwner(page, dateFrom, dateTo, status);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ProblemRes?> updateProblemOwner(
      {required int problemId, required int status}) async {
    try {
      var res =
          await SahaServiceManager().service!.updateProblemOwner(problemId, {
        'status': status,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteProblemOwner({required int problemId}) async {
    try {
      var res =
          await SahaServiceManager().service!.deleteProblemOwner(problemId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ProblemRes?> getProblemOwner({required int problemId}) async {
    try {
      var res = await SahaServiceManager().service!.getProblemOwner(problemId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

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

  /////manage commission
  Future<AllCommissionManageRes?> getAllCommissionManage(
      {required int page,
      int? status,
      String? dateFrom,
      String? dateTo}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllCommissionManage(page, status, dateFrom, dateTo);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CommissionManageRes?> getCommissionManage({required int id}) async {
    try {
      var res = await SahaServiceManager().service!.getCommissionManage(id);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<CommissionManageRes?> confirmCommissionManage(
      {required int id, required CommissionManage commissionManage}) async {
    try {
      var res =
          await SahaServiceManager().service!.confirmCommissionManage(id, {
        'status': commissionManage.status,
        'images_host_paid': commissionManage.imagesHostPaid
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllTowerRes?> getAllTower({required int page, String? search}) async {
    try {
      var res = await SahaServiceManager().service!.getAllTower(page, search);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllTowerRes?> getAllAdminTowers({required int page, int? userId}) async {
    try {
      var res = await SahaServiceManager().service!.getAllAdminTowers(page, userId!);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<TowerRes?> addTower({required Tower tower}) async {
    try {
      var res = await SahaServiceManager().service!.addTower(tower.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<TowerRes?> updateTower(
      {required Tower tower, required int towerId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateTower(towerId, tower.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<TowerRes?> getTower({required int towerId}) async {
    try {
      var res = await SahaServiceManager().service!.getTower(towerId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteTower({required int towerId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteTower(towerId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<AllSupportManageTowerRes?> getAllSupportManageTower(
      {required int page}) async {
    try {
      var res =
          await SahaServiceManager().service!.getAllSupportManageTower(page);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SupportManageTowerRes?> addSupportManageTower(
      {required SupportManageTower supportManageTower}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addSupportManageTower(supportManageTower.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SupportManageTowerRes?> getSupportManageTower(
      {required int supportId}) async {
    try {
      var res =
          await SahaServiceManager().service!.getSupportManageTower(supportId);
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SupportManageTowerRes?> updateSupportManageTower(
      {required int supportId,
      required SupportManageTower supportManageTower}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateSupportManageTower(supportId, supportManageTower.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteSupportManageTower(
      {required int supportId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteSupportManageTower({
        "support_manage_tower_ids": [supportId]
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<SuccessResponse?> deleteTowerSupportManage(
      {required int towerId,required int supportId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteTowerSupportManage({
        "tower_ids": [towerId],
        "supporter_manage_tower_id":supportId
      });
      return res;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}

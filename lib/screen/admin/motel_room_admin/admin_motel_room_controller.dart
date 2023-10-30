import 'dart:developer';

import 'package:get/get.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/motel_room.dart';
import '../../../model/user.dart';
import '../../data_app_controller.dart';

class AdminMotelRoomController extends GetxController {
  var listMotelRoom = RxList<MotelRoom>();
  int currentPage = 1;
  int? status;
  bool isEnd = false;
  var loadInit = true.obs;
  String? textSearch;
  var isLoading = false.obs;
  var hasContract = false.obs;
  var userChoose = User().obs;
  bool? isTower;
  int? towerId;
  bool? isSupportTower;
  bool? isFromTower;
  var total = 0.obs;

  AdminMotelRoomController(
      {this.isTower, this.towerId, this.isSupportTower, this.isFromTower}) {
    userChoose.value = Get.find<DataAppController>().currentUser.value;
    getAllAdminMotelRoom(isRefresh: true);
  }

  Future<void> getAllAdminMotelRoom({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }
    try {
      if (isEnd == false) {
        //isLoading.value = true;
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository
            .getAllAdminMotelRoom(
                page: currentPage,
                search: textSearch,
                userId: isFromTower == true ? null : userChoose.value.id,
                hasContract: status == null ? hasContract.value : null,
                status: status,
                towerId: towerId,
                isHaveTower: isTower,
                isSupporter: isSupportTower);
        total.value = data!.data!.total!;
        log('Total::::::::::::::: $total');

        if (isRefresh == true) {
          listMotelRoom(data.data!.data!);
          listMotelRoom.refresh();
        } else {
          listMotelRoom.addAll(data.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      loadInit.value = false;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateMotelRoomHiddenStatus({
    required int motelId,
    required int status,
    required int towerMotelId,
  }) async {
    try {
      var res = await RepositoryManager.adminManageRepository.updateMotelRoomHiddenStatus(
        motelId: motelId,
        status: status,
        towerMotelId: towerMotelId,
      );
      if (res != null && res.code == 200) {
        SahaAlert.showSuccess(message: "Thành công");
      }
      listMotelRoom.clear();
      getAllAdminMotelRoom(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

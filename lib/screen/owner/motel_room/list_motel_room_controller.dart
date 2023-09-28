import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/motel_room.dart';

import '../../../model/tower.dart';

class ListMotelRoomController extends GetxController {
  var listMotelRoom = RxList<MotelRoom>();
  int currentPage = 1;
  int? status;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  String? textSearch;
  var hasContract = false.obs;

  bool? isTower;
  int? towerId;
  Tower? towerInput;
  bool? isSupportTower;
  ListMotelRoomController({this.isTower, this.towerId, this.towerInput,this.isSupportTower}) {
    getAllMotelRoom(isRefresh: true);
  }

  Future<void> getAllMotelRoom({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.manageRepository.getAllMotelRoom(
            page: currentPage,
            search: textSearch,
            hasContract: status == null ? hasContract.value : null,
            status: status,
            towerId: towerId,
            
            isHaveTower: isTower,isSupporter: isSupportTower);

        if (isRefresh == true) {
          listMotelRoom(data!.data!.data!);
          listMotelRoom.refresh();
        } else {
          listMotelRoom.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteMotelRoom({required int motelRoomId}) async {
    try {
      var data = await RepositoryManager.manageRepository
          .deleteMotelRoom(motelRoomId: motelRoomId);
      listMotelRoom.removeWhere((element) => motelRoomId == element.id);
      Get.back();
      SahaAlert.showSuccess(message: "Đã xoá phòng trọ");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }
}

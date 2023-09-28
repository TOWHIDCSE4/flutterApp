import 'package:get/get.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/motel_room.dart';
import '../../../../../model/tower.dart';

class MotelManageController extends GetxController{
  var listMotelRoom = RxList<MotelRoom>();
  int currentPage = 1;
  int? status;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  String? textSearch;
  var hasContract = false.obs;
   final int supportId;

  bool? isTower;
  int? towerId;
  Tower? towerInput;
  bool? isSupportTower;
  MotelManageController({this.isTower, this.towerId, this.towerInput,this.isSupportTower,required this.supportId}) {
    getAllMotelSupport(isRefresh: true);
  }

  Future<void> getAllMotelSupport({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.manageRepository.getAllMotelSupport(
          page: currentPage,
            towerId: towerId,
            hasContract: hasContract.value,
            isHaveTower: true,
            isHaveSupperter: true,
            manageSupporterId: supportId);

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
}
import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/account/all_user_res.dart';
import 'package:gohomy/data/remote/saha_service_manager.dart';
import 'package:gohomy/data/repository/chat/chat_repository.dart';
import 'package:gohomy/model/user.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/tower.dart';

class TowerController extends GetxController {
  var listTower = RxList<Tower>();
  int currentPage = 1;
  bool isEnd = false;
  var loadInit = true.obs;
  var isLoading = false.obs;
  var userChoose = User().obs;
  bool? isAdmin;
  TowerController({this.isAdmin}) {
    userChoose.value = Get.find<DataAppController>().currentUser.value;
    // if (userChoose.value.id ==
    //     Get.find<DataAppController>().currentUser.value.id) {
    //   userChoose.value.name = 'Admin';
    // }
    getAllTower(isRefresh: true);
  }

  Future<void> getAllTower({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }
    print('hehehe');
    try {
      if (isEnd == false) {
        //isLoading.value = true;
        isLoading.value = true;
        if (isAdmin == true) {
          var data = await RepositoryManager.manageRepository.getAllAdminTowers(
            page: currentPage,
            userId: userChoose.value.id,
          );
          if (isRefresh == true) {
            listTower(data!.data!.data!);
            listTower.refresh();
          } else {
            listTower.addAll(data!.data!.data!);
          }
          if (data.data!.nextPageUrl == null) {
            isEnd = true;
          } else {
            isEnd = false;
            currentPage = currentPage + 1;
          }
        } else {
          var data = await RepositoryManager.manageRepository.getAllTower(
            page: currentPage,
          );
          if (isRefresh == true) {
            listTower(data!.data!.data!);
            listTower.refresh();
          } else {
            listTower.addAll(data!.data!.data!);
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
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteTower({required int towerId}) async {
    try {
      var res = await RepositoryManager.manageRepository
          .deleteTower(towerId: towerId);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

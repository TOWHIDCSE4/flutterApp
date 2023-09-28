import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/tower.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';

class TowerFilterController extends GetxController {
  var listTower = RxList<Tower>();
  int currentPage = 1;
  bool isEnd = false;
  var loadInit = true.obs;
  var isLoading = false.obs;
  String? search;
  bool? isRented;

  TowerFilterController() {
    getAllTowers(isRefresh: true);
  }

  Future<void> getAllTowers({
    bool? isRefresh,
    int? userId,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }
    try {
      if (isEnd == false) {
        isLoading.value = true;
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
        loadInit.value = false;
        isLoading.value = false;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

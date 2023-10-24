import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/tower.dart';

class ChooseTowerManageController extends GetxController {
  var listTower = RxList<Tower>();
 
  int currentPage = 1;
   var isSearch = false.obs;

  bool isEnd = false;
  var loadInit = true.obs;
  String? textSearch;
  var isLoading = false.obs;
  TextEditingController searchEdit = TextEditingController();

  ChooseTowerManageController() {
   
    getAllTower(isRefresh: true);
  }

  Future<void> getAllTower({
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
        var data = await RepositoryManager.manageRepository.getAllTower(
          page: currentPage,
          search: textSearch
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
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

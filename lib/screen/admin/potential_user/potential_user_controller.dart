import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/potential_user.dart';
import '../../../model/user.dart';

class PotentialUserController extends GetxController {
  var listPotential = RxList<PotentialUser>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var status = 0.obs;
  var isLoading = false.obs;
  var loadInit = true.obs;
  var isSearch = false.obs;
  TextEditingController searchEdit = TextEditingController();
  // var fromDay = DateTime.now().obs;
  // var toDay = DateTime.now().obs;
  // DateTime? fromDateOption;
  // DateTime? toDateOption;
  // var checkSelected = false.obs;
  // String? dateFrom;
  // String? dateTo;
  var userChoose = User().obs;

  PotentialUserController() {
    // userChoose.value = Get.find<DataAppController>().currentUser.value;
    // if (userChoose.value.id ==
    //     Get.find<DataAppController>().currentUser.value.id) {
    //   userChoose.value.name = 'Admin';
    // }
    getAllPotentialUser(isRefresh: true);
  }

  Future<void> getAllPotentialUser({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
      loadInit.value = true;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.userManageRepository
            .getAllPotentialUser(
                page: currentPage,
                status: status.value,
                textSearch: textSearch);

        if (isRefresh == true) {
          listPotential(data!.data!.data!);
        } else {
          listPotential.addAll(data!.data!.data!);
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

  Future<void> updatePotentialUser(
      {required int status, required int idPotential}) async {
    try {
      var res = await RepositoryManager.userManageRepository
          .updatePotentialUser(status: status, idPotential: idPotential);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deletePotentialUser({required int idPotential}) async {
    try {
      var res = await RepositoryManager.userManageRepository
          .deletePotentialUser(idPotential: idPotential);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

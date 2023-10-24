import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/user.dart';

class ChooseHostController extends GetxController {
  var listUser = RxList<User>();
  int currentPage = 1;
  bool isEnd = false;
  var loadInit = true.obs;
  var isLoading = false.obs;
  bool? isHost;
  String? search;
  var isSearch = false.obs;
  bool? isRented;
  TextEditingController searchEdit = TextEditingController();

  ChooseHostController() {
    getAllUsers(isRefresh: true);
  }

  Future<void> getAllUsers({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }
    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository.getAllUsers(
            page: currentPage,
            isHost: isHost,
            search: search,
            isRented: isRented);

        if (isRefresh == true) {
          listUser(data!.data!.data!);
        } else {
          listUser.addAll(data!.data!.data!);
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

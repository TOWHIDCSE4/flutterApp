import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/model/user.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class UserController extends GetxController {
  var listUser = RxList<User>();
  int currentPage = 1;
  bool isEnd = false;
  var loadInit = true.obs;
  var isLoading = false.obs;
  int? status;
  bool? isHost;
  String? search;


  var isSearch = false.obs;
  bool? isRented;
  TextEditingController searchEdit = TextEditingController();
  Future<void> getAllUsers({
    bool? isRefresh,
    String? ranked,
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
            isRented: isRented,
            ranked: ranked);

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

  Future<void> getUser(int userId) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .getUsers(userId: userId);
      var index = listUser.indexWhere((e) => e.id == res!.data!.id);
      if (index != -1) {
        listUser[index] = res!.data!;
        listUser.refresh();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> banUser({required int id, required int status}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateUser(userId: id, user: User(status: status));
      SahaAlert.showSuccess(message: "Thành công");
      getUser(id);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

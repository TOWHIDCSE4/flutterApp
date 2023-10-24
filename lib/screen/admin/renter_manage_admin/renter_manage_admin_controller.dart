import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/chat/chat_list/chat_list_screen.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/renter.dart';
import '../../../model/user.dart';
import '../../data_app_controller.dart';

class RenterManageAdminController extends GetxController {
  var listRenter = RxList<Renter>();
  String? textSearch;
  var status = 0.obs;
  bool isRented = true;
  int currentPage = 1;
  var loadInit = true.obs;
  var isLoading = false.obs;
  bool isEnd = false;
  var userChoose = User().obs;

  DateTime? fromDate;
  DateTime? toDate;
  var fromDateController = TextEditingController();
  var toDateController = TextEditingController();
  var isSearch = false.obs;

  RenterManageAdminController() {
    userChoose.value = Get.find<DataAppController>().currentUser.value;
    if (userChoose.value.id ==
        Get.find<DataAppController>().currentUser.value.id) {
      userChoose.value.name = 'Admin';
    }
    getAllAdminRenter(isRefresh: true);
  }
  Future<void> getAllAdminRenter({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository
            .getAllAdminRenter(
                page: currentPage,
                search: textSearch,
                isRenter: isRented,
                userId: userChoose.value.id,
                fromDate: fromDate,
                toDate: toDate);

        if (isRefresh == true) {
          listRenter(data!.data!.data!);
          listRenter.refresh();
        } else {
          listRenter.addAll(data!.data!.data!);
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
  //////////////// Tìm user theo sđt để sang màn chat

  var listUser = RxList<User>();
  int currentPage1 = 1;
  bool isEnd1 = false;
  var loadInit1 = false.obs;
  var isLoading1 = false.obs;
  int? status1;
  bool? isHost;
  String? search;
  //var isSearch = false.obs;
  bool? isRented1;
  TextEditingController searchEdit = TextEditingController();
  Future<void> getAllUsers({
    bool? isRefresh,
    String? ranked,
  }) async {
    if (isRefresh == true) {
      currentPage1 = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading1.value = true;
        loadInit1.value = true;
        var data = await RepositoryManager.adminManageRepository.getAllUsers(
            page: currentPage1,
            isHost: isHost,
            search: search,
            isRented: isRented1,
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
      if (listUser.isEmpty) {
        SahaAlert.showError(message: 'Người dùng này chưa sử dụng app');
      } else {
        Get.to(() => ChatListScreen(
              toUser: listUser[0],
            ));
      }

      isLoading1.value = false;
      loadInit1.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteRenter({required int renterId}) async {
    try {
      var data = await RepositoryManager.manageRepository
          .deleteRenter(renterId: renterId);

      SahaAlert.showSuccess(message: "Đã xoá thành công");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }
}

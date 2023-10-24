import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/motel_post.dart';

class ChooseRoomChatController extends GetxController {
  var listPostManagement = RxList<MotelPost>();
  int currentPage = 1;
  bool isEnd = false;
  var status = 0.obs;
  var isLoading = false.obs;
  var loadInit = true.obs;
  var listRoomChoosed = RxList<MotelPost>();
  String? textSearch;
  var isSearch = false.obs;
  TextEditingController searchEdit = TextEditingController();
  int? province;
  int? district;
  String? moneyFrom;
  String? moneyTo;
  var provicenName = TextEditingController();
  var districtName = TextEditingController();
  var rangePriceValue = const RangeValues(0, 0).obs;
  ChooseRoomChatController() {
    getPostManagement(isRefresh: true);
  }

  Future<void> getPostManagement({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.manageRepository
            .getAllPostManagement(
                page: currentPage, status:2, search: textSearch,district: district,province: province,moneyFrom: moneyFrom,moneyTo: moneyTo);

        if (isRefresh == true) {
          listPostManagement(data!.data!.data!);
        } else {
          listPostManagement.addAll(data!.data!.data!);
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

  Future<void> deletePostManagement({required int postManagementId}) async {
    try {
      var data = await RepositoryManager.manageRepository
          .deletePostManagement(postManagementId: postManagementId);
      listPostManagement
          .removeWhere((element) => postManagementId == element.motelId);
      Get.back();
      SahaAlert.showSuccess(message: "Đã xoá bài đăng");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }

  Future<void> updatePostManagement(MotelPost motelPost) async {
    try {
      var data = await RepositoryManager.manageRepository.updatePostManagement(
        postManagementId: motelPost.id!,
        motelPost: motelPost,
      );
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

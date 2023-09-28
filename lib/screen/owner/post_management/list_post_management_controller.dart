import 'dart:developer';

import 'package:get/get.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/motel_post.dart';

class ListPostManagementController extends GetxController {
  var listPostManagement = RxList<MotelPost>();
  int currentPage = 1;
  bool isEnd = false;
  var status = 0.obs;
  var isLoading = false.obs;
  var loadInit = true.obs;
  String? textSearch;
  int? initTab;
  var total = 0.obs;
  ListPostManagementController({this.initTab}) {
    if (initTab == null) {
      getPostManagement(isRefresh: true);
    }
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
                page: currentPage, status: status.value, search: textSearch);
        total.value = data!.data!.total!;
        log('Total::::::::::::::: $total');

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

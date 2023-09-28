import 'dart:developer';

import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/post_find_room.dart';

class FindRoomPostAdminController extends GetxController {
  var listPostFindRoom = RxList<PostFindRoom>();
  var loadInit = true.obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  var status = 0.obs;
  String? textSearch;
  var total = 0.obs;

  FindRoomPostAdminController() {
    getAllAdminPostFindRoom(isRefresh: true);
  }

  Future<void> getAllAdminPostFindRoom({
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
            .getAllAdminPostFindRoom(page: currentPage, status: status.value);
        total.value = data!.data!.total!;
        log('Total::::::::::::::: $total');

        if (isRefresh == true) {
          listPostFindRoom(data!.data!.data!);
          listPostFindRoom.refresh();
        } else {
          listPostFindRoom.addAll(data!.data!.data!);
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

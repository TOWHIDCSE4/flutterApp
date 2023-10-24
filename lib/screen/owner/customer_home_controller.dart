import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/user_manage/summary_motel_res.dart';

import '../../components/arlert/saha_alert.dart';
import '../../data/repository/repository_manager.dart';
import '../../model/badge.dart';
import '../../model/motel_post.dart';

class CustormerHomeController extends GetxController {
  var changeHeight = 35.0.obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  var listAllRoomPost = RxList<MotelPost>();
  var badge = Badge().obs;
  var summary = Summary().obs;

  void changeHeightAppbar(double va) {
    changeHeight.value = va;
  }

  CustormerHomeController() {
    getAllRoomPost(isRefresh: true);
    getSummary();
  }

  Future<void> getAllRoomPost({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.roomPostRepository.getAllRoomPost(
          page: currentPage,
        );

        if (isRefresh == true) {
          listAllRoomPost(data!.data!.data!);
          listAllRoomPost.refresh();
        } else {
          listAllRoomPost.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getBadge() async {
    try {
      var res = await RepositoryManager.userManageRepository.getBadge();
      badge.value = res!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getSummary() async {
    try {
      var res = await RepositoryManager.userManageRepository.getSummary();
      summary.value = res!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

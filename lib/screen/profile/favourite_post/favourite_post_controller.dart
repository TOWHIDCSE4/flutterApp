import 'dart:developer';

import 'package:get/get.dart';
import 'package:gohomy/model/motel_post.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class FavouritePostController extends GetxController {
  var favouritePost = RxList<MotelPost>();
  var loadInit = true.obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  var total = 0.obs;

  Future<void> getAllMotelPost({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data =
            await RepositoryManager.userManageRepository.getAllFavouritePost(
          page: currentPage,
        );
        total.value = data!.data!.total!;
        log('Total::::::::::::::: $total');

        if (isRefresh == true) {
          favouritePost(data!.data!.data!);
          favouritePost.refresh();
        } else {
          favouritePost.addAll(data!.data!.data!);
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

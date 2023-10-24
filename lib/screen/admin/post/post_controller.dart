import 'dart:developer';

import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/motel_post.dart';
import 'package:gohomy/model/user.dart';

import '../../../components/arlert/saha_alert.dart';

class PostController extends GetxController {
  var listPost = RxList<MotelPost>();
  String? textSearch;
  var status = 0.obs;
  int currentPage = 1;
  var loadInit = true.obs;
  var isLoading = false.obs;
  bool isEnd = false;
  var userChoose = User().obs;
  var total = 0.obs;

  PostController({bool showToast = true}) {
    getAllMotelPost(isRefresh: true, showToast: showToast);
  }
  Future<void> getAllMotelPost({
    bool? isRefresh,
    bool? showToast,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data =
            await RepositoryManager.adminManageRepository.getAllMotelPost(
          page: currentPage,
          search: textSearch,
          status: status.value,
              userId: userChoose.value.id,
        );
        total.value = data!.data!.total!;
        log('Total::::::::::::::: $total');

        if (isRefresh == true) {
          listPost(data!.data!.data!);
          listPost.refresh();
        } else {
          listPost.addAll(data!.data!.data!);
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
      if (showToast == true) {
        SahaAlert.showError(message: err.toString());
      }
    }
  }
}
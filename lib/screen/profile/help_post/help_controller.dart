import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_help_post_res.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/category_help_post.dart';

class HelpController extends GetxController {
  var listCategoryHelpPost = RxList<CategoryHelpPost>();
  var listHelpPost = RxList<HelpPostData>();
  var allPost = false.obs;
  TextEditingController searchEdit = TextEditingController();
  var idChoose = 0.obs;
  int currentPage = 1;
  var loadInit = true.obs;
  var isLoading = false.obs;
  bool isEnd = false;
  var isSearch = false.obs;
  var search = ''.obs;

  HelpController() {
    getAllCategoryHelpPost(isRefresh: true);
    getAllHelpPost(isRefresh: true);
  }

  Future<void> getAllCategoryHelpPost({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.userManageRepository
            .getAllCategoryHelpPost(page: currentPage, search: search.value);

        if (isRefresh == true) {
          listCategoryHelpPost(data!.data!.data!);
          listCategoryHelpPost.refresh();
        } else {
          listCategoryHelpPost.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      // idChoose.value =
      //     listCategoryHelpPost.isEmpty ? -2 : listCategoryHelpPost[0].id!;
      // choose = listCategoryHelpPost.isEmpty
      //     ? -2
      //     : listCategoryHelpPost[0].id!;
      isLoading.value = false;
      //loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllHelpPost({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.userManageRepository.getAllHelpPost(
            page: currentPage,
            typeCategory: idChoose.value == 0 ? null : idChoose.value,
            search: search.value);

        if (isRefresh == true) {
          listHelpPost(data!.data!.data!);
          listHelpPost.refresh();
        } else {
          listHelpPost.addAll(data!.data!.data!);
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

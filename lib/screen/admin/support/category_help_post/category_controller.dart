import 'package:get/get.dart';
import 'package:gohomy/model/category_help_post.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';

class CategoryController extends GetxController {
  var listCategoryHelpPost = RxList<CategoryHelpPost>();

  int currentPage = 1;
  var loadInit = true.obs;
  var isLoading = false.obs;
  bool isEnd = false;
  CategoryController() {
    getAllAdminCategoryHelpPost(isRefresh: true);
  }
  Future<void> getAllAdminCategoryHelpPost({
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
            .getAllAdminCategoryHelpPost(page: currentPage);

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
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

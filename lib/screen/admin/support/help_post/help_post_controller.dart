import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_help_post_res.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';

class HelpPostController extends GetxController {
  var listHelpPost = RxList<HelpPostData>();
  int currentPage = 1;
  var loadInit = true.obs;
  var isLoading = false.obs;
  bool isEnd = false;

  HelpPostController() {
    getAllAdminHelpPost(isRefresh: true);
  }
  Future<void> getAllAdminHelpPost({
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
            .getAllAdminHelpPost(page: currentPage);

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

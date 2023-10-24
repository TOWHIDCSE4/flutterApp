import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/user.dart';

class ManageAdminController extends GetxController {
  var listAdmin = RxList<User>();
  int currentPage = 1;
  bool isEnd = false;
  var loadInit = true.obs;
  var isLoading = false.obs;

  var isSearch = false.obs;
  ManageAdminController() {
    getAllAdmin(isRefresh: true);
  }
  Future<void> getAllAdmin({
    bool? isRefresh,
    String? ranked,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository.getAllUsers(
          page: currentPage,
          isAdmin: true,
        );

        if (isRefresh == true) {
          listAdmin(data!.data!.data!);
        } else {
          listAdmin.addAll(data!.data!.data!);
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

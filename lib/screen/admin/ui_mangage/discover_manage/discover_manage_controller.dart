import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/admin_discover.dart';

import '../../../../components/arlert/saha_alert.dart';

class DiscoverManageController extends GetxController {
  var listAdminDiscover = RxList<AdminDiscover>();
  var loadInit = true.obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  DiscoverManageController() {
    getAllAdminDiscover(isRefresh: true);
  }
  Future<void> getAllAdminDiscover({
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
            await RepositoryManager.adminManageRepository.getAllAdminDiscover();

        if (isRefresh == true) {
          listAdminDiscover(data!.data!);
        } else {
          listAdminDiscover.addAll(data!.data!);
        }

        // if (data.data!.nextPageUrl == null) {
        //   isEnd = true;
        // } else {
        //   isEnd = false;
        //   currentPage = currentPage + 1;
        // }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteDiscover({required int id}) async {
    try {
      var res =
          await RepositoryManager.adminManageRepository.deleteDiscover(id: id);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

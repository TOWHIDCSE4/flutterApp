import 'package:get/get.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/admin_discover_item.dart';

class DiscoverItemController extends GetxController {
  var listAdminDiscoverItem = RxList<AdminDiscoverItem>();

  var loadInit = true.obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  int? id;

  Future<void> getAllAdminDiscoverItem({
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
            .getAllAdminDiscoverItem(id: id!);

        if (isRefresh == true) {
          listAdminDiscoverItem(data!.data!);
        } else {
          listAdminDiscoverItem.addAll(data!.data!);
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
      var res = RepositoryManager.adminManageRepository.deleteDiscover(id: id);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

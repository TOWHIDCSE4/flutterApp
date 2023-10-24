import 'package:get/get.dart';
import 'package:gohomy/model/category.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/service_sell.dart';

class ServicesSellController extends GetxController {
  var listCategory = RxList<Category>();
  int currentPage = 1;
  bool isEnd = false;

  var isLoading = false.obs;
  var loadInit = true.obs;
  ServicesSellController() {
    getAllAdminCategory(isRefresh: true);
  }
  Future<void> getAllAdminCategory({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        //loadInit.value = true;
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository
            .getAllAdminCategory(page: currentPage);

        if (isRefresh == true) {
          listCategory(data!.data!.data!);
          listCategory.refresh();
        } else {
          listCategory.addAll(data!.data!.data!);
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

  Future<void> deleteAdminCategory({required int idCategory}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .deleteAdminCategory(idCategory: idCategory);
      SahaAlert.showSuccess(message: "Thành công");
      getAllAdminCategory(isRefresh: true);
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

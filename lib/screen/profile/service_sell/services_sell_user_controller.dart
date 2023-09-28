import 'package:get/get.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/category.dart';

class ServicesSellUserController extends GetxController{
  var listCategory = RxList<Category>();
  int currentPage = 1;
  bool isEnd = false;

  var isLoading = false.obs;
  var loadInit = true.obs;
  ServicesSellUserController() {
    getAllCategory(isRefresh: true);
  }
  Future<void> getAllCategory({
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
        var data = await RepositoryManager.serviceSellRepository
            .getAllCategory(page: currentPage);

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
}
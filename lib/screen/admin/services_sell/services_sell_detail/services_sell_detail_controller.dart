import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/service_sell.dart';

class ServicesSellDetailController extends GetxController{
  var listServiceSell = RxList<ServiceSell>();
  int currentPage = 1;
  bool isEnd = false;
  int? categoryId;
  var isLoading = false.obs;
  var loadInit = true.obs;
  ServicesSellDetailController({this.categoryId}) {
    getAllServiceSell(isRefresh: true);
  }
  Future<void> getAllServiceSell({
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
            .getAllServiceSell(page: currentPage,categoryId: categoryId);

        if (isRefresh == true) {
          listServiceSell(data!.data!.data!);
          listServiceSell.refresh();
        } else {
          listServiceSell.addAll(data!.data!.data!);
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
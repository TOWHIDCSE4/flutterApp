import 'package:get/get.dart';
import 'package:gohomy/model/support_manage_tower.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/motel_post.dart';

class TowerManagerController extends GetxController{
  var listSupportManager = RxList<SupportManageTower>();
   var isSearch = false.obs;
  int currentPage = 1;
  bool isEnd = false;
 
  var isLoading = false.obs;
  var loadInit = true.obs;
  String? textSearch;

  TowerManagerController() {
    getAllSupportManageTower(isRefresh: true);
  }

  Future<void> getAllSupportManageTower({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.manageRepository
            .getAllSupportManageTower(
                page: currentPage,);

        if (isRefresh == true) {
          listSupportManager(data!.data!.data!);
        } else {
          listSupportManager.addAll(data!.data!.data!);
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
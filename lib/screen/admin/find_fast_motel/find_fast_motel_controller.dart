import 'package:get/get.dart';
import 'package:gohomy/model/find_fast_motel.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class FindFastMotelController extends GetxController {
  var listFindFastMotel = RxList<FindFastMotel>();
  int currentPage = 1;
  var status = 0.obs;
  bool isEnd = false;
  var loadInit = true.obs;
  String? textSearch;
  var isLoading = false.obs;

  FindFastMotelController() {
    getAllFindFastMotel(isRefresh: true);
  }

  Future<void> getAllFindFastMotel({
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
            await RepositoryManager.adminManageRepository.getAllFindFastMotel(
          page: currentPage,
          search: textSearch,
          status: status.value,
        );

        if (isRefresh == true) {
          listFindFastMotel(data!.data!.data!);
          listFindFastMotel.refresh();
        } else {
          listFindFastMotel.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      loadInit.value = false;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateFindFastMotel({
    required int findFastMotelId,
    required int status,
  }) async {
    try {
      var data =
          await RepositoryManager.adminManageRepository.updateFindFastMotel(
        findFastMotelId: findFastMotelId,
        status: status,
      );
      SahaAlert.showSuccess(message: 'Thành công');
      getAllFindFastMotel(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteFindFastMotel({
    required int findFastMotelId,
  }) async {
    try {
      var data =
          await RepositoryManager.adminManageRepository.deleteFindFastMotel(
        findFastMotelId: findFastMotelId,
      );
      SahaAlert.showSuccess(message: 'Đã xoá');
      getAllFindFastMotel(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

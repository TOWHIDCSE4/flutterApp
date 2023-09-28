import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_history_receive_commission_res.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class HistoryReceiveCommissionController extends GetxController {
  var listHistoryReceive = RxList<HistoryReceiveCommission>();

  int currentPage = 1;
  bool isEnd = false;
  var loadInit = true.obs;
  var isLoading = false.obs;

  String? search;
  var isSearch = false.obs;
  HistoryReceiveCommissionController() {
    getAllHistoryReceiveCommission(isRefresh: true);
  }
  Future<void> getAllHistoryReceiveCommission({
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
        var data = await RepositoryManager.adminManageRepository
            .getAllHistoryReceiveCommission(
          page: currentPage,
        );

        if (isRefresh == true) {
          listHistoryReceive(data!.data!.data!);
        } else {
          listHistoryReceive.addAll(data!.data!.data!);
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

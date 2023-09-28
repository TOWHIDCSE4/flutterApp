import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/request_withdrawals.dart';

class WithdrawalHistoriesController extends GetxController {
  var listWithdrawal = RxList<RequestWithdrawals>();
  int currentPage = 1;

  bool isEnd = false;

  var isLoading = false.obs;
  var loadInit = true.obs;

  WithdrawalHistoriesController() {
    getAllRequestWithdrawal(isRefresh: true);
  }

  Future<void> getAllRequestWithdrawal({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.userManageRepository
            .getAllRequestWithdrawal(
          page: currentPage,
        );

        if (isRefresh == true) {
          listWithdrawal(data!.data!.data!);
        } else {
          listWithdrawal.addAll(data!.data!.data!);
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

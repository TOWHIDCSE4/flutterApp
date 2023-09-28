import 'package:get/get.dart';
import 'package:gohomy/model/wallet_histories.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class EWalletHistoriesController extends GetxController {
  var listWallet = RxList<WalletHistory>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isScroll = false.obs;
  double? money;
  var isLoading = false.obs;
  var loadInit = true.obs;

  EWalletHistoriesController() {
    getAllWalletHistories(isRefresh: true);
  }

  Future<void> getAllWalletHistories({
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
            await RepositoryManager.userManageRepository.getAllWalletHistories(
          search: textSearch,
          page: currentPage,
        );

        if (isRefresh == true) {
          listWallet(data!.data!.data!);
        } else {
          listWallet.addAll(data!.data!.data!);
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

  Future<void> requestWithdrawal() async {
    if (money == null || money == 0) {
      SahaAlert.showError(message: "Mời bạn nhập lại số tiền");
      return;
    }
    if (money! >
        num.parse(Get.find<DataAppController>()
                .currentUser
                .value
                .eWalletCollaborator
                ?.accountBalance
                .toString() ??
            '0')) {
      SahaAlert.showError(
          message: "Bạn đã nhập số tiền lớn hơn số tiền trong ví");
      return;
    }

    try {
      var res = await RepositoryManager.userManageRepository
          .requestWithdrawal(money: money!);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      print(e.toString());
      SahaAlert.showError(message: e.toString());
    }
  }
}

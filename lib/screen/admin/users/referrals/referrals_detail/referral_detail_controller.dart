import 'package:get/get.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/user.dart';
import '../../../../../model/wallet_histories.dart';

class ReferralDetailController extends GetxController {
  var listReferral = RxList<User>();
  int currentPage = 1;
  bool isEnd = false;
  var loadInit = true.obs;
  var isLoading = false.obs;

  Future<void> getAllUserReferral(
      {bool? isRefresh, String? ranked, required String code}) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository
            .getAllUserReferral(page: currentPage, code: code);

        if (isRefresh == true) {
          listReferral(data!.data!.data!);
        } else {
          listReferral.addAll(data!.data!.data!);
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

  ///////////////////////////////////
  var listWallet = RxList<WalletHistory>();
  int currentPage1 = 1;
  String? textSearch;
  bool isEnd1 = false;

  var isLoading1 = false.obs;
  var loadInit1 = true.obs;

  Future<void> getAllHistoriesCollaborator({bool? isRefresh, int? id}) async {
    if (isRefresh == true) {
      currentPage1 = 1;
      isEnd1 = false;
    }

    try {
      if (isEnd1 == false) {
        isLoading1.value = true;
        var data = await RepositoryManager.adminManageRepository
            .getAllHistoriesCollaborator(
          id: id,
          page: currentPage,
        );

        if (isRefresh == true) {
          listWallet(data!.data!.data!);
        } else {
          listWallet.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd1 = true;
        } else {
          isEnd1 = false;
          currentPage1 = currentPage + 1;
        }
      }
      isLoading1.value = false;
      loadInit1.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

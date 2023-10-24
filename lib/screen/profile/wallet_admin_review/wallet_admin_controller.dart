

import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/dashboard.dart';
import 'package:gohomy/model/deposit.dart';
import 'package:gohomy/model/withdraw.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/data/deposit_withdraw_repository.dart';
import 'package:gohomy/screen/profile/wallet_admin_review/repository/wallet_admin_repository.dart';

class WalletAdminController extends GetxController {
  var dashboard = Dashboard().obs;
  int currentDepositPage = 1;
  int currentWithdrawPage = 1;
  var listDeposits = RxList<Deposit>();
  var listWithdraws = RxList<Withdraw>();
  var isLoading = false.obs;
  var isLoadingWithdraw = false.obs;
  bool isEndWithdraw = false;
  bool isEnd = false;

  WalletAdminController() {
    getDashboard();
    getListWithdraws(isRefresh: true);
  }

  Future<void> getDashboard() async {
    try {
      var res = await RepositoryManager.adminManageRepository.getDashboard();
      dashboard.value = res!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getListDeposits({
  bool? isRefresh}) async {
    try {
      if (isEnd == false) {
        //isLoading.value = true;
        isLoading.value = true;
        var data = await WalletAdminRepository.instance
            .getDepositHistory(
            page: currentDepositPage);
        if (isRefresh == true) {
          listDeposits(data!.data!.data!);
          listDeposits.refresh();
        } else {
          listDeposits.addAll(data!.data!.data!);
        }

        if (data?.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentDepositPage = currentDepositPage + 1;
        }
      }
    } catch(err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getListWithdraws({
    bool? isRefresh}) async {
    try {
      if (isEndWithdraw == false) {
        //isLoading.value = true;
        isLoadingWithdraw.value = true;
        var data = await WalletAdminRepository.instance
            .getWithdrawHistory(
            page: currentWithdrawPage);
        if (isRefresh == true) {
          listWithdraws(data!.data!.data!);
          listWithdraws.refresh();
        } else {
          listWithdraws.addAll(data!.data!.data!);
        }

        if (data?.data!.nextPageUrl == null) {
          isEndWithdraw = true;
        } else {
          isEndWithdraw = false;
          currentWithdrawPage = currentWithdrawPage + 1;
        }
      }
    } catch(err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
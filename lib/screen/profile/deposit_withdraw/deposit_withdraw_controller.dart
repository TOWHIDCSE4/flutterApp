

import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/dashboard.dart';
import 'package:gohomy/model/deposit.dart';
import 'package:gohomy/model/withdraw.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/data/deposit_withdraw_repository.dart';
import 'package:gohomy/screen/profile/wallet_admin_review/repository/wallet_admin_repository.dart';

class DepositWithdrawController extends GetxController {
  var dashboard = Dashboard().obs;
  int currentPage = 1;
  var listDeposits = RxList<Deposit>().obs;
  var listWithdraws = RxList<Withdraw>().obs;
  var isLoading = false.obs;
  bool isEnd = false;
  var userId = Get.find<DataAppController>().currentUser.value.id;

  DepositWithdrawController() {
    getListWithdraws(isRefresh: true);
  }

  Future<void> getListDeposits({
    bool? isRefresh}) async {
    try {
      if (isEnd == false) {
        //isLoading.value = true;
        isLoading.value = true;
        var data = await DepositWithDrawRepository.instance
            .getUserDepositHistory(
            page: currentPage,
            userId: userId
        );
        if (isRefresh == true) {
          listDeposits.value(data?.data!.data!);
          listDeposits.refresh();
        } else {
          listDeposits.value.addAll(data?.data!.data! as Iterable<Deposit>);
        }

        if (data?.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
    } catch(err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getListWithdraws({
    bool? isRefresh}) async {
    try {
      if (isEnd == false) {
        //isLoading.value = true;
        isLoading.value = true;
        var data = await DepositWithDrawRepository.instance
            .getUserWithdrawHistory(
            page: currentPage,
            userId: userId
        );
        if (isRefresh == true) {
          listWithdraws.value(data?.data!.data!);
          listWithdraws.refresh();
        } else {
          listWithdraws.value.addAll(data?.data!.data! as Iterable<Withdraw>);
        }

        if (data?.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
    } catch(err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
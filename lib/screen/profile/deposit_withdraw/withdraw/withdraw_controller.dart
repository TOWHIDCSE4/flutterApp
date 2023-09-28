import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/bank.dart';
import 'package:gohomy/model/withdraw.dart';


class WithdrawController extends GetxController {
  TextEditingController withdrawValue = TextEditingController();
  TextEditingController bankCode = TextEditingController();
  TextEditingController bankAccountNumber = TextEditingController();
  TextEditingController bankAccountHolderName = TextEditingController();
  TextEditingController otp = TextEditingController();

  var listBank = RxList<BankInfo>();
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;

  Future<void> getListBankUser({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.walletRepository.getUserBankList(
            page: currentPage);

        if (isRefresh == true) {
          listBank(data!.data!.data!);
          listBank.refresh();
        } else {
          listBank.addAll(data!.data!.data!);
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

  Future<void> addBankInfo() async {
    try {
      getListBankUser(isRefresh: true);
    } catch (error) {
      SahaAlert.showError(message: error.toString());
    }
  }

  Future<Withdraw?> createWithdrawRequest() async {
    try {
      var data = await RepositoryManager.walletRepository
          .createWithdrawRequest(
          withdrawAmount: int.parse(withdrawValue.value.text),
          accountNumber: bankAccountNumber.value.text,
          bankCode: bankCode.value.text,
          accountHolderName: bankAccountHolderName.value.text);
      if (data!.data != null) {
        return data.data;
      }
    } catch (error) {
      SahaAlert.showError(message: error.toString());
    }
    return null;
  }
}

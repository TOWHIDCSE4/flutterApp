import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/wallet/bank.dart';
import 'package:gohomy/data/remote/response-request/wallet/deposit.dart';
import 'package:gohomy/data/remote/response-request/wallet/withdraw.dart';
import 'package:gohomy/data/remote/saha_service_manager.dart';
import 'package:gohomy/data/repository/handle_error.dart';
import 'package:gohomy/screen/data_app_controller.dart';

class WalletRepository {
  Future<DepositRes?> createDepositRequest(
      {required depositAmount, String? bankCode = "BIDV"}) async {
    try {
      var res = await SahaServiceManager().service!.createDepositRequest({
        "deposit_money": depositAmount,
        "bank_code": bankCode,
      });
      return res;
    } catch (error) {
      handleError(error);
    }
    return null;
  }

  Future<ListBankInfoRes?> getUserBankList({int page = 1}) async {
    int? userId = Get.find<DataAppController>().currentUser.value.id;
    try {
      var res =
          await SahaServiceManager().service!.getListBankUser(page, userId!);
      return res;
    } catch (error) {
      handleError(error);
    }
    return null;
  }

  Future<WithdrawRes?> createWithdrawRequest(
      {required withdrawAmount,
      required accountNumber,
      required bankCode,
      required accountHolderName,
      String? withdrawContent}) async {
    try {
      var res = await SahaServiceManager().service!.createWithdrawRequest({
        "withdraw_money": withdrawAmount,
        "account_number": accountNumber,
        "bank_account_holder_name": accountHolderName,
        "bank_name": bankCode,
        "withdraw_content": withdrawContent
      });
      return res;
    } catch (error) {
      handleError(error);
    }
    return null;
  }
}

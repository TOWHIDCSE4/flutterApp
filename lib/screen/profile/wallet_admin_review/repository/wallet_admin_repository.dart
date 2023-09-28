import 'package:gohomy/data/remote/response-request/wallet/withdraw.dart';
import 'package:gohomy/data/remote/saha_service_manager.dart';
import 'package:gohomy/data/repository/handle_error.dart';

import '../../../../data/remote/response-request/wallet/deposit.dart';

class WalletAdminRepository {
  WalletAdminRepository._();
  static WalletAdminRepository instance = WalletAdminRepository._();

  Future<ListDepositsRes?> getDepositHistory({int page = 1}) async {
    try {
      var info = await SahaServiceManager().service!.getDepositHistoryData(page);
      return info;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ListWithdrawsRes?> getWithdrawHistory({int page = 1}) async {
    try {
      var info = await SahaServiceManager().service!.getWithdrawHistoryData(page);
      return info;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}
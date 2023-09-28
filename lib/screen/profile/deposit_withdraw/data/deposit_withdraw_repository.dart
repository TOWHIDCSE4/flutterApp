import 'package:gohomy/data/remote/response-request/wallet/withdraw.dart';
import 'package:gohomy/data/remote/saha_service_manager.dart';
import 'package:gohomy/data/repository/handle_error.dart';

import '../../../../data/remote/response-request/wallet/deposit.dart';

class DepositWithDrawRepository {
  DepositWithDrawRepository._();

  static DepositWithDrawRepository instance = DepositWithDrawRepository._();

  Future<ListDepositsRes?> getUserDepositHistory(
      {int page = 1, int? userId}) async {
    try {
      var info = await SahaServiceManager()
          .service!
          .getUserDepositHistory(page, userId!);
      return info;
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  Future<ListWithdrawsRes?> getUserWithdrawHistory(
      {int page = 1, int? userId}) async {
    try {
      var info = await SahaServiceManager()
          .service!
          .getUserWithdrawHistory(page, userId!);
      return info;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}

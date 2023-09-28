import 'package:get/get.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/request_withdrawals.dart';
import '../../../../data_app_controller.dart';

class UserWithdrawalDetailController extends GetxController {
  var withdrawal = RequestWithdrawals().obs;
  int id;
  var loadInit = true.obs;

  UserWithdrawalDetailController({required this.id}) {
    getWithdrawalUser(id: id);
  }
  Future<void> getWithdrawalUser({required int id}) async {
    try {
      var res = await RepositoryManager.userManageRepository
          .getWithdrawalUser(id: id);
      withdrawal.value = res!.data!;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
    loadInit.value = false;
  }

  Future<void> updateWithdrawal({required int id, int? status}) async {
    if (withdrawal.value.amountMoney == null ||
        withdrawal.value.amountMoney == 0) {
      SahaAlert.showError(message: "Mời bạn nhập lại số tiền");
      return;
    }
    if (withdrawal.value.amountMoney! >
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
      var res = await RepositoryManager.userManageRepository.updateWithdrawal(
          id: id, money: withdrawal.value.amountMoney, status: status);
      withdrawal.value = res!.data!;
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/request_withdrawals.dart';

class WithdrawalDetailsController extends GetxController {
  var withdrawal = RequestWithdrawals().obs;
  int id;
  var loadInit = true.obs;
  WithdrawalDetailsController({required this.id}) {
    getWithdrawalAdmin(id: id);
  }
  Future<void> getWithdrawalAdmin({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .getWithdrawalAdmin(id: id);
      withdrawal.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> verifyWithdrawal({int? status}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .verifyWithdrawal(id: id, status: status);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deleteWithdrawal() async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .deleteWithdrawal(id: id);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

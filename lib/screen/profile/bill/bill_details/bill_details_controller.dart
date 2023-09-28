import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/bill.dart';

class BillDetailsController extends GetxController {
  var bill = Bill().obs;
  var loadInit = true.obs;
  int billId;

  BillDetailsController({required this.billId}) {
    getOneBill(id: billId);
  }

  Future<void> getOneBill({required int id}) async {
    try {
      var res = await RepositoryManager.userManageRepository.getOneBill(id: id);
      bill.value = res!.data!;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteBill(int billId) async {
    try {
      var res =
          await RepositoryManager.manageRepository.deleteBill(billId: billId);
      SahaAlert.showSuccess(message: "Đã xoá hoá đơn");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> billStatus(int billId, int status) async {
    try {
      var res = await RepositoryManager.manageRepository
          .billStatus(billId: billId, status: status);
      SahaAlert.showSuccess(message: "Đã thanh toán đơn");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

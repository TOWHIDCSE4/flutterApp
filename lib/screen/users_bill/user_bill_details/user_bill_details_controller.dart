import 'package:get/get.dart';
import 'package:gohomy/model/bill.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class UserBillDetailsController extends GetxController {
  var bill = Bill().obs;
  var isLoading = true.obs;

  Future<void> getUserBill(int billId) async {
    try {
      var res = await RepositoryManager.userManageRepository
          .getUserBill(billId: billId);
      bill.value = res!.bill!;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

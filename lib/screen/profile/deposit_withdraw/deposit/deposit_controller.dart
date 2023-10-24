import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/deposit.dart';

class DepositController extends GetxController {
  TextEditingController depositValue = TextEditingController();
  var isLoading = false;

  Future<Deposit?> createDepositRequest() async {
    try {
      isLoading = true;

      var data = await RepositoryManager.walletRepository
          .createDepositRequest(depositAmount: int.parse(depositValue.text));

      if (data!.data != null) {
        return data.data;
      }
    } catch (error) {
      SahaAlert.showError(message: error.toString());
    }
    isLoading = false;
    return null;
  }
}

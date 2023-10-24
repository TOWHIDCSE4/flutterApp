import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import '../../../../components/arlert/saha_alert.dart';
import '../../../../model/service_sell.dart';

class ServiceSellDetailsController extends GetxController {
  var serviceSell = ServiceSell().obs;
  var isLoading = true.obs;
  var description = TextEditingController();
  Future<void> getServiceSell(int id) async {
    try {
      var res =
          await RepositoryManager.adminManageRepository.getServiceSell(id: id);
      serviceSell.value = res!.data!;
      description.text = serviceSell.value.description ?? '';
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteServiceSell(int id) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .deleteServiceSell(id: id);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

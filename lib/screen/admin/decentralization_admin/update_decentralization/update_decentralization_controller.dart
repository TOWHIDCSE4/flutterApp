import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../model/decentralization.dart';

class UpdateDecentralizationController extends GetxController {
  var decentralization = Decentralization().obs;
  var loadInit = true.obs;
  var nameEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();
  int id;
  UpdateDecentralizationController({required this.id}) {
    getDecentralization(id: id);
  }
  Future<void> getDecentralization({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .getDecentralization(id: id);
      decentralization.value = res!.data!;
      loadInit.value = false;
      nameEditingController.text = decentralization.value.name ?? '';
      desEditingController.text = decentralization.value.description ?? '';
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateDecentralization({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateDecentralization(
              id: id, decentralization: decentralization.value);
      Get.back();
      SahaAlert.showSuccess(message: "Thành công");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../model/image_assset.dart';
import '../../../../model/service_sell.dart';

class UpdateServiceSellController extends GetxController {
  var serviceSell = ServiceSell().obs;
  var listImages = RxList<ImageData>([]);
  var description = TextEditingController();
  Future<void> updateServiceSell(
      {required int id, required ServiceSell serviceSell}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateServiceSell(id: id, serviceSell: serviceSell);
      Get.back();
      Get.back();
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

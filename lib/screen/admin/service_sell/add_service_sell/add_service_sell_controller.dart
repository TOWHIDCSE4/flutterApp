import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../model/image_assset.dart';
import '../../../../model/service_sell.dart';

class AddServiceSellController extends GetxController {

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController desController = TextEditingController();

  var listImages = RxList<ImageData>([]);
  var serviceSell = ServiceSell().obs;

  Future<void> addServiceSell() async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .addServiceSell(serviceSell: serviceSell.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/address_order.dart';

import '../../../../../model/order.dart';

class OrderDetailController extends GetxController {
  var order = Order().obs;
  
  String orderCode;
  var loadInit = true.obs;
  OrderDetailController({required this.orderCode}) {
    getOneOrder(orderCode: orderCode);
  }
  Future<void> getOneOrder({required String orderCode}) async {
    try {
      var res = await RepositoryManager.serviceSellRepository
          .getOneOrder(orderCode: orderCode);
      order.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateStatusOrder() async {
    try {
      var res = await RepositoryManager.serviceSellRepository
          .updateStatusOrder(orderCode: orderCode, status: 1);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

   Future<void> reOrder() async {
    try {
      var res = await RepositoryManager.serviceSellRepository
          .reOrder(orderCode: orderCode);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }


}

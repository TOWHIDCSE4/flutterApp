import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/service_sell.dart';

class ProductDetailController extends GetxController{
   var serviceSell = ServiceSell().obs;
   int productId;
  var loadInit = false.obs;
  var description = TextEditingController();

  ProductDetailController({required this.productId}){
    getServiceSell();
  }
  Future<void> getServiceSell() async {
    loadInit.value = true;
    try {
      var res =
          await RepositoryManager.adminManageRepository.getServiceSell(id: productId);
      serviceSell.value = res!.data!;
      description.text = serviceSell.value.description ?? '';
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteServiceSell() async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .deleteServiceSell(id: productId);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
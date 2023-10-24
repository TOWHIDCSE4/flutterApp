import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../model/image_assset.dart';
import '../../../../../model/service_sell.dart';

class AddProductController extends GetxController{
  int categoryId;
  int? productId;

  var doneUploadImage = true.obs;
  var listImages = RxList<ImageData>([]);
  var nameProduct = TextEditingController();
  var priceProduct = TextEditingController();
  var description = TextEditingController();
  var serviceSellReq = ServiceSell().obs;
  var loadInit = false.obs;

  AddProductController({required this.categoryId,this.productId}){
    serviceSellReq.value.categoryServiceSellId = categoryId;
    if(productId != null){
      getServiceSell();
    }
    

  }


   Future<void> addServiceSell() async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .addServiceSell(serviceSell: serviceSellReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
   Future<void> getServiceSell() async {
    loadInit.value = true;
    try {
      var res =
          await RepositoryManager.adminManageRepository.getServiceSell(id: productId!);
      serviceSellReq.value = res!.data!;
      convertRes();
     
     loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

    Future<void> updateServiceSell(
     ) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateServiceSell(id: productId!, serviceSell: serviceSellReq.value);
      Get.back();
      
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void convertRes(){
    listImages((serviceSellReq.value.images ?? [])
        .map((e) => ImageData(linkImage: e))
        .toList());
    nameProduct.text = serviceSellReq.value.name ?? "";
    priceProduct.text = serviceSellReq.value.price == null ? "" : SahaStringUtils().convertToUnit(serviceSellReq.value.price);
    description.text = serviceSellReq.value.description ?? "";

  }
}
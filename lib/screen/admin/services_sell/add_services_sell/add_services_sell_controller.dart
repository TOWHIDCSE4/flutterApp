import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/category.dart';

class AddServicesSellController extends GetxController {
  var nameService = TextEditingController();
  var categoryReq = Category().obs;
  var loadInit = false.obs;
  int? categoryId;
  AddServicesSellController({this.categoryId}){
    if(categoryId != null){
      getAdminCategory();
    }
  }
  Future<void> addCategory() async {
    if (categoryReq.value.name == null) {
      SahaAlert.showError(message: "Bạn chưa nhập tên");
      return;
    }
    if (categoryReq.value.image == null) {
      SahaAlert.showError(message: "Bạn chọn ảnh");
      return;
    }
    try {
      var res = await RepositoryManager.adminManageRepository
          .addCategory(category: categoryReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> getAdminCategory() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.adminManageRepository
          .getAdminCategory(idCategory: categoryId!);
      categoryReq.value = res!.data!;
      nameService.text = categoryReq.value.name ?? '';
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

    Future<void> updateAdminCategory() async {
       if (categoryReq.value.name == null) {
      SahaAlert.showError(message: "Bạn chưa nhập tên");
      return;
    }
    if (categoryReq.value.image == null) {
      SahaAlert.showError(message: "Bạn chọn ảnh");
      return;
    }
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateAdminCategory(category: categoryReq.value,idCategory: categoryId!);
      categoryReq.value = res!.data!;
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

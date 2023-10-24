import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/renter.dart';

class AddUpdateTenantController extends GetxController {
  var nameTextEditingController = TextEditingController();
  var phoneNumberTextEditingController = TextEditingController();
  var emailTextEditingController = TextEditingController();
  var cmndNumberTextEditingController = TextEditingController();
  var addressTextEditingController = TextEditingController();
  Renter? renterInput;
  int? status;
  var isLoadingUpdate = false.obs;
  var renterRequest = Renter().obs;

  AddUpdateTenantController({this.renterInput, this.status}) {
    if (renterInput != null) {
      renterRequest.value = renterInput!;
      nameTextEditingController.text = renterInput!.name ?? "";
      phoneNumberTextEditingController.text = renterInput!.phoneNumber ?? "";
      cmndNumberTextEditingController.text = renterInput!.cmndNumber ?? "";
      emailTextEditingController.text = renterInput!.email ?? "";
      addressTextEditingController.text = renterInput!.address ?? "";
    }
  }

  Future<void> addTenant() async {
    if (renterRequest.value.cmndFrontImageUrl == null) {
      SahaAlert.showError(message: "Chưa chọn CMND/CCCD mặt trước");
      return;
    }
    if (renterRequest.value.cmndBackImageUrl == null) {
      SahaAlert.showError(message: "Chưa chọn CMND/CCCD mặt sau");
      return;
    }
    try {
      var data = await RepositoryManager.manageRepository.addRenter(
        renter: renterRequest.value,
      );
      SahaAlert.showSuccess(message: "Thêm thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateTenant() async {
    if (renterRequest.value.cmndFrontImageUrl == null) {
      SahaAlert.showError(message: "Chưa chọn CMND/CCCD mặt trước");
      return;
    }
    if (renterRequest.value.cmndBackImageUrl == null) {
      SahaAlert.showError(message: "Chưa chọn CMND/CCCD mặt sau");
      return;
    }
    isLoadingUpdate.value = true;
    try {
      var data = await RepositoryManager.manageRepository.updateRenter(
        renter: renterRequest.value,
        renterId: renterInput!.id!,
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }
}

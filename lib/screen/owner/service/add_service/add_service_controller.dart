import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/service.dart';

import 'add_service_screen.dart';

class AddServiceController extends GetxController {
  var serviceTextEditingController = TextEditingController();
  var imageTextEditingController = TextEditingController();
  var typeTextEditingController = TextEditingController();
  var unitTextEditingController = TextEditingController();
  var chargeTextEditingController = TextEditingController();
  var noteTextEditingController = TextEditingController();
  Service? serviceInput;
  var isLoadingUpdate = false.obs;
  var serviceRequest = Service().obs;

  AddServiceController({this.serviceInput}) {
    if (serviceInput != null) {
      serviceRequest.value = serviceInput!;
      serviceTextEditingController.text = serviceInput!.serviceName ?? "";
      imageTextEditingController.text = serviceInput!.serviceIcon ?? "";
      unitTextEditingController.text = serviceInput!.serviceUnit ?? "";
      typeTextEditingController.text =
          convertServiceType(serviceInput!.typeUnit ?? 0);

      chargeTextEditingController.text =
          removeDecimalZeroFormat(serviceInput!.serviceCharge!).toString();
      noteTextEditingController.text = serviceInput!.note ?? "";
    }
  }
  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  Future<void> deleteService({required int serviceId}) async {
    try {
      var data = await RepositoryManager.manageRepository
          .deleteService(serviceId: serviceId);
      SahaAlert.showSuccess(message: "Đã xoá dịch vụ");
      Get.back();
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }

  Future<void> addService() async {
    if (serviceRequest.value.serviceIcon == null) {
      SahaAlert.showError(message: 'Bạn chưa chọn icon');
      return;
    }
    try {
      var data = await RepositoryManager.manageRepository.addService(
        service: serviceRequest.value,
      );
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateService() async {
    if (serviceRequest.value.serviceIcon == null) {
      SahaAlert.showError(message: 'Bạn chưa chọn icon');
      return;
    }
    isLoadingUpdate.value = true;
    try {
      var data = await RepositoryManager.manageRepository.updateService(
        serviceId: serviceInput!.id!,
        service: serviceRequest.value,
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/support_manage_tower.dart';

import '../../../../model/tower.dart';

class AddMotelManagerController extends GetxController {
  var supportManageTowerReq = SupportManageTower(towers: []).obs;
  int? supportId;


  AddMotelManagerController({this.supportId}){
    if(supportId != null){
      getSupportManageTower();
    }
  }
  var loadInit = false.obs;
  var nameManager = TextEditingController();
  var phoneNumber = TextEditingController();
  var email = TextEditingController();
  var listTower = RxList<Tower>();

  Future<void> addSupportManageTower() async {
    if(supportManageTowerReq.value.name == null || supportManageTowerReq.value.name == ""){
      SahaAlert.showError(message: "Chưa nhập tên");
      return;
    }
     if(supportManageTowerReq.value.phoneNumber == null || supportManageTowerReq.value.phoneNumber == ""){
      SahaAlert.showError(message: "Chưa nhập số điện thoại");
      return;
    }
    if(supportManageTowerReq.value.towers!.isEmpty){
       SahaAlert.showError(message: "Chưa chọn toà nhà nào");
       return;
    }
    try {
      var res = await RepositoryManager.manageRepository.addSupportManageTower(
          supportManageTower: supportManageTowerReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

    Future<void> updateSupportManageTower() async {
       if(supportManageTowerReq.value.name == null || supportManageTowerReq.value.name == ""){
      SahaAlert.showError(message: "Chưa nhập tên");
      return;
    }
     if(supportManageTowerReq.value.phoneNumber == null || supportManageTowerReq.value.phoneNumber == ""){
      SahaAlert.showError(message: "Chưa nhập số điện thoại");
      return;
    }
     if(supportManageTowerReq.value.towers!.isEmpty){
       SahaAlert.showError(message: "Chưa chọn toà nhà nào");
       return;
    }
    try {
      var res = await RepositoryManager.manageRepository.updateSupportManageTower(supportId: supportId!,
          supportManageTower: supportManageTowerReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

   Future<void> getSupportManageTower() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.manageRepository.getSupportManageTower(
          supportId: supportId!);
      supportManageTowerReq.value = res!.data!;
      loadInit.value = false;
      convertInfo();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

   Future<void> deleteSupportManageTower() async {
   
    try {
      var res = await RepositoryManager.manageRepository.deleteSupportManageTower(
          supportId: supportId!);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void convertInfo(){
    nameManager.text = supportManageTowerReq.value.name ?? '';
    phoneNumber.text = supportManageTowerReq.value.phoneNumber ?? '';
    email.text = supportManageTowerReq.value.email ?? '';
  }
}

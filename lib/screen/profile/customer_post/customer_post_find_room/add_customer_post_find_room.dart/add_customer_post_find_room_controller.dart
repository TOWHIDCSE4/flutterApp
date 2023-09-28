import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../model/location_address.dart';
import '../../../../../model/post_find_room.dart';

class AddCustomerPostFindRoomController extends GetxController {
  var postReq = PostFindRoom(
    sex: 0,
  ).obs;
  var loadInit = false.obs;
  int? idPostFindRoom;
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;
  var rangePriceValue = const RangeValues(0, 0).obs;

  var addressTextEditingController = TextEditingController();
  var title = TextEditingController();
  var phoneNumberTextEditingController = TextEditingController();
  var noteTextEditingController = TextEditingController();
  var capacity = TextEditingController();

  AddCustomerPostFindRoomController({this.idPostFindRoom}) {
    if (idPostFindRoom != null) {
      getPostFindRoom();
    }
  }

  Future<void> getPostFindRoom() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.userManageRepository
          .getPostFindRoom(idPostFindRoom: idPostFindRoom!);

      postReq.value = res!.data!;
      convertRes();
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> addPostFindRoom() async {
    if (postReq.value.title == null) {
      SahaAlert.showError(message: "Chưa nhập tiêu đề");
      return;
    }
    if (postReq.value.district == null ||
        postReq.value.wards == null ||
        postReq.value.province == null) {
      SahaAlert.showError(message: "Bạn chưa chọn địa chỉ");
      return;
    }
    if (postReq.value.phoneNumber == null) {
      SahaAlert.showError(message: "Chưa nhập số điện thoại");
      return;
    }
    // if (postReq.value.capacity == null) {
    //   SahaAlert.showError(message: "Chưa nhập số điện thoại");
    //   return;
    // }
    if (postReq.value.moneyFrom == null || postReq.value.moneyTo == null) {
      SahaAlert.showError(message: "Chưa nhập khoảng tiền");
      return;
    }
    if (postReq.value.type == null) {
      SahaAlert.showError(message: "Chưa chọn loại phòng");
      return;
    }
    try {
      var res = await RepositoryManager.userManageRepository
          .addPostFindRoom(postFindRoom: postReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updatePostFindRoom() async {
    if (postReq.value.title == null) {
      SahaAlert.showError(message: "Chưa nhập tiêu đề");
      return;
    }
    if (postReq.value.district == null ||
        postReq.value.wards == null ||
        postReq.value.province == null) {
      SahaAlert.showError(message: "Bạn chưa chọn địa chỉ");
      return;
    }
    if (postReq.value.phoneNumber == null) {
      SahaAlert.showError(message: "Chưa nhập số điện thoại");
      return;
    }
    // if (postReq.value.capacity == null) {
    //   SahaAlert.showError(message: "Chưa nhập số người");
    //   return;
    // }
    if (postReq.value.moneyFrom == null || postReq.value.moneyTo == null) {
      SahaAlert.showError(message: "Chưa nhập khoảng tiền");
      return;
    }
    if (postReq.value.type == null) {
      SahaAlert.showError(message: "Chưa chọn loại phòng");
      return;
    }
    try {
      var res = await RepositoryManager.userManageRepository.updatePostFindRoom(
          idPostFindRoom: idPostFindRoom!, postFindRoom: postReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void convertRes() {
    addressTextEditingController.text = (postReq.value.wardsName == null ||
            postReq.value.districtName == null ||
            postReq.value.provinceName == null)
        ? ""
        : "${postReq.value.wardsName} - ${postReq.value.districtName} - ${postReq.value.provinceName}";
    title.text = postReq.value.title ?? '';
    phoneNumberTextEditingController.text = postReq.value.phoneNumber ?? '';
    noteTextEditingController.text = postReq.value.note ?? '';
    capacity.text =  postReq.value.capacity == null ? '':postReq.value.capacity.toString(); 
    rangePriceValue.value = RangeValues(
        postReq.value.moneyFrom ?? 0, postReq.value.moneyTo ?? 20000000);
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/motel_room.dart';
import 'package:gohomy/model/post_roommate.dart';
import 'package:gohomy/utils/string_utils.dart';

import '../../../../../model/image_assset.dart';
import '../../../../../model/location_address.dart';

class AddCustomerPostRoommateController extends GetxController {
  var postReq = PostRoommate(sex: 0).obs;
  var loadInit = false.obs;
  var motelChoose = MotelRoom().obs;
  

  int? idPostRoommate;
  
  AddCustomerPostRoommateController({this.idPostRoommate}) {
    if (idPostRoommate != null) {
      getPostRoommate();
    }
  }
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;
  ////
  var title = TextEditingController();
  var numberFindTenant = TextEditingController();
  var addressTextEditingController = TextEditingController();
  var areaTextEditingController = TextEditingController();
  var quantityVehicleParked = TextEditingController();
  var numberFloor = TextEditingController();
  var phoneNumberTextEditingController = TextEditingController();
  var moneyTextEditingController = TextEditingController();
  var depositTextEditingController = TextEditingController();
  var numberTenantCurrent = TextEditingController();

  var doneUploadImage = true.obs;
  var listImages = RxList<ImageData>([]);
  File? file;

  Future<void> addPostRoommate() async {
    if (postReq.value.title == null || postReq.value.title!.isEmpty) {
      SahaAlert.showError(message: "Chưa nhập tiêu đề bài đăng");
      return;
    }
    if (postReq.value.title!.length > 50) {
      SahaAlert.showError(
          message: 'Tiêu đề bài đăng không được vượt quá 50 ký tự');
      return;
    }
    if (postReq.value.type == null) {
      SahaAlert.showError(message: "Bạn chưa chọn loại phòng");
      return;
    }
    if ((postReq.value.images ?? []).isEmpty) {
      SahaAlert.showError(message: 'Bài đăng chưa có ảnh');
      return;
    }
    if (postReq.value.area == null) {
      SahaAlert.showError(message: "Chưa nhập diện tích");
      return;
    }
    if (postReq.value.numberFloor == null) {
      SahaAlert.showError(message: "Chưa nhập số tầng");
      return;
    }
    if (postReq.value.phoneNumber == null) {
      SahaAlert.showError(message: "Chưa nhập số diện thoại");
      return;
    }
    if (postReq.value.money == null) {
      SahaAlert.showError(message: "Chưa nhập giá phòng");
      return;
    }
    if (postReq.value.deposit == null) {
      SahaAlert.showError(message: "Chưa nhập tiền đặt cọc");
      return;
    }
    try {
      var res = await RepositoryManager.userManageRepository
          .addPostRoommate(postRoommate: postReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> getPostRoommate() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.userManageRepository
          .getPostRoommate(idPostRoommate: idPostRoommate!);

      postReq.value = res!.data!;
      loadInit.value = false;
      motelChoose.value = MotelRoom(id: postReq.value.motelId,motelName: postReq.value.motelName);
      convertInfo();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updatePostRoommate() async {
    if (postReq.value.title == null || postReq.value.title!.isEmpty) {
      SahaAlert.showError(message: "Chưa nhập tiêu đề bài đăng");
      return;
    }
    if (postReq.value.title!.length > 50) {
      SahaAlert.showError(
          message: 'Tiêu đề bài đăng không được vượt quá 50 ký tự');
      return;
    }
    if (postReq.value.type == null) {
      SahaAlert.showError(message: "Bạn chưa chọn loại phòng");
      return;
    }
    if ((postReq.value.images ?? []).isEmpty) {
      SahaAlert.showError(message: 'Bài đăng chưa có ảnh');
      return;
    }
    if (postReq.value.area == null) {
      SahaAlert.showError(message: "Chưa nhập diện tích");
      return;
    }
    if (postReq.value.numberFloor == null) {
      SahaAlert.showError(message: "Chưa nhập số tầng");
      return;
    }
    if (postReq.value.phoneNumber == null) {
      SahaAlert.showError(message: "Chưa nhập số diện thoại");
      return;
    }
    if (postReq.value.money == null) {
      SahaAlert.showError(message: "Chưa nhập giá phòng");
      return;
    }
    if (postReq.value.deposit == null) {
      SahaAlert.showError(message: "Chưa nhập tiền đặt cọc");
      return;
    }
    try {
      var res = await RepositoryManager.userManageRepository.updatePostRoommate(
          postRoommateId: idPostRoommate!, postRoommate: postReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void convertInfo() {
    //motelChoose.value = MotelRoom(id:postReq.value.motelId,motelName: postReq.value.motelName);
    title.text = postReq.value.title ?? '';
    numberFindTenant.text = postReq.value.numberFindTenant == null
        ? ''
        : postReq.value.numberFindTenant.toString();
    addressTextEditingController.text = (postReq.value.addressDetail == null ||
            postReq.value.wardsName == null ||
            postReq.value.districtName == null ||
            postReq.value.provinceName == null)
        ? ''
        : '${postReq.value.addressDetail} - ${postReq.value.wardsName} - ${postReq.value.districtName} - ${postReq.value.provinceName}';
    areaTextEditingController.text =
        postReq.value.area == null ? '' : postReq.value.area.toString();
    quantityVehicleParked.text = postReq.value.quantityVehicleParked == null
        ? ''
        : postReq.value.quantityVehicleParked.toString();
    numberFloor.text = postReq.value.numberFloor == null
        ? ''
        : postReq.value.numberFloor.toString();
    phoneNumberTextEditingController.text = postReq.value.phoneNumber ?? '';
    moneyTextEditingController.text = postReq.value.money == null
        ? ''
        : SahaStringUtils().convertToUnit(postReq.value.money);
    depositTextEditingController.text = postReq.value.deposit == null
        ? ''
        : SahaStringUtils().convertToUnit(postReq.value.deposit);
    listImages((postReq.value.images ?? [])
        .map((e) => ImageData(linkImage: e))
        .toList());
  }

  void convertRoomToPost(MotelRoom motel) {
    postReq.value = PostRoommate(
        status: postReq.value.status,
        title: title.text,
        motelId: motel.id,
        type: motel.type,
        phoneNumber: motel.phoneNumber,
        images: motel.images,
        money: motel.money,
        deposit: motel.deposit,
        addressDetail: motel.addressDetail,
        wards: motel.wards,
        district: motel.district,
        province: motel.province,
        description: motel.description,
        area: motel.area,
        quantityVehicleParked: motel.quantityVehicleParked,
        sex: motel.sex,
        wardsName: motel.wardsName,
        districtName: motel.districtName,
        provinceName: motel.provinceName,
        moServices: motel.moServices,
        hasAirConditioner: motel.hasAirConditioner,
        hasBalcony: motel.hasBalcony,
        hasBed: motel.hasBed,
        hasCeilingFans: motel.hasCeilingFans,
        hasCurtain: motel.hasCurtain,
        hasDecorativeLights: motel.hasDecorativeLights,
        hasFingerPrint: motel.hasFingerprint,
        hasFreeMove: motel.hasFreeMove,
        hasFridge: motel.hasFridge,
        hasKitchen: motel.hasKitchen,
        hasKitchenStuff: motel.hasKitchenStuff,
        hasMattress: motel.hasMattress,
        hasMezzanine: motel.hasMezzanine,
        hasMirror: motel.hasMirror,
        hasOwnOwner: motel.hasOwnOwner,
        hasPark: motel.hasPark,
        hasPet: motel.hasPet,
        hasPicture: motel.hasPicture,
        hasPillow: motel.hasPillow,
        hasSecurity: motel.hasSecurity,
        hasShoesRasks: motel.hasShoesRacks,
        hasSofa: motel.hasSofa,
        hasTable: motel.hasTable,
        hasTivi: motel.hasTivi,
        hasTree: motel.hasTree,
        hasWardrobe: motel.hasWardrobe,
        hasWashingMachine: motel.hasWashingMachine,
        hasWaterHeater: motel.hasWaterHeater,
        hasWc: motel.hasWc,
        hasWifi: motel.hasWifi,
        hasWindow: motel.hasWindow,
        numberFloor: motel.numberFloor,

        );

    convertInfo();
  }
}

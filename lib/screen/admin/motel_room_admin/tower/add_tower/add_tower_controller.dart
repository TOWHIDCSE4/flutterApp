import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../components/loading/loading_widget.dart';
import '../../../../../const/type_image.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/furniture.dart';
import '../../../../../model/image_assset.dart';
import '../../../../../model/location_address.dart';
import '../../../../../model/service.dart';
import '../../../../../model/tower.dart';
import '../../../../data_app_controller.dart';

class AddTowerController extends GetxController {
  var towerReq = Tower().obs;
  var loadInit = false.obs;
  int? towerId;

  var doneUploadImage = true.obs;
  var listImages = RxList<ImageData>([]);
  ////
  var phoneNumberTextEditingController = TextEditingController(
      text: Get.find<DataAppController>().currentUser.value.phoneNumber);
  var titleTextEditingController = TextEditingController();
  var descriptionTextEditingController = TextEditingController();
  var towerNameTextEditingController = TextEditingController();

  var addressTextEditingController = TextEditingController();
  var quantityVehicleParked = TextEditingController();

  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;
  var furniture = Furniture().obs;

  var isLoading = false.obs;
  var listService = <Service>[];
  File? file;


  AddTowerController({this.towerId}) {
    towerReq.value.images = [];

    if (towerId != null) {
      getTower();
      getAllService();
    } else {
      towerReq.value.phoneNumber =
          Get.find<DataAppController>().currentUser.value.phoneNumber ?? '';
      towerReq.value.images = [];
      towerReq.value.moServicesReq = [];
      towerReq.value.furniture = [];
      getAllService();
    }
  }

  Future<void> getAllService() async {
    try {
      isLoading.value = true;
      var data = await RepositoryManager.manageRepository.getAllService();
      if (towerId == null) {
        towerReq.value.moServicesReq = [];
        towerReq.value.moServicesReq!.addAll(data!.data!);
         listService.addAll(data.data!);
      }

     
      towerReq.refresh();
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addTower() async {
    if (towerReq.value.images!.isEmpty) {
      SahaAlert.showError(message: "Chọn tối thiểu 1 ảnh");
      return;
    }
    if (towerReq.value.type == null) {
      SahaAlert.showError(message: "Chưa chọn loại phòng, mời bạn chọn lại");
      return;
    }

    if (towerReq.value.towerName == null || towerReq.value.towerName == '') {
      SahaAlert.showError(message: "Chưa đặt tên phòng");
      return;
    }
    if (towerReq.value.addressDetail == null) {
      SahaAlert.showError(message: "Chưa nhập địa chỉ");
      return;
    }
    if (towerReq.value.quantityVehicleParked == null) {
      SahaAlert.showError(message: "Chưa nhập số chỗ để xe");
      return;
    }

    if (towerReq.value.phoneNumber == null ||
        towerReq.value.phoneNumber == '') {
      SahaAlert.showError(message: "Chưa nhập số diện thoại");
      return;
    }

    try {
        if (file != null) {
        showDialogSuccess('Đang tạo video');
        await upVideo();
        Get.back();
      }
      var res = await RepositoryManager.manageRepository
          .addTower(tower: towerReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> getTower() async {
    loadInit.value = true;
    try {
    
      var res =
          await RepositoryManager.manageRepository.getTower(towerId: towerId!);
      towerReq.value = res!.data!;
      convertInfo();
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateTower() async {
    if (towerReq.value.images!.isEmpty) {
      SahaAlert.showError(message: "Chọn tối thiểu 1 ảnh");
      return;
    }
    if (towerReq.value.type == null) {
      SahaAlert.showError(message: "Chưa chọn loại phòng, mời bạn chọn lại");
      return;
    }

    if (towerReq.value.towerName == null || towerReq.value.towerName == '') {
      SahaAlert.showError(message: "Chưa đặt tên phòng");
      return;
    }
    if (towerReq.value.addressDetail == null) {
      SahaAlert.showError(message: "Chưa nhập địa chỉ");
      return;
    }

    if (towerReq.value.numberFloor == null) {
      SahaAlert.showError(message: "Chưa nhập tầng");
      return;
    }
    if (towerReq.value.phoneNumber == null) {
      SahaAlert.showError(message: "Chưa nhập số diện thoại");
      return;
    }
    if (towerReq.value.quantityVehicleParked == null) {
      SahaAlert.showError(message: "Chưa nhập số chỗ để xe");
      return;
    }
    try {
      if (file != null) {
        showDialogSuccess('Đang tạo video');
        await upVideo();
        Get.back();
      }
      var res = await RepositoryManager.manageRepository
          .updateTower(towerId: towerId!, tower: towerReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void convertInfo() {
    listService = towerReq.value.moServicesReq ?? [];
    phoneNumberTextEditingController.text = towerReq.value.phoneNumber ?? '';
    descriptionTextEditingController.text = towerReq.value.description ?? '';
    towerNameTextEditingController.text = towerReq.value.towerName ?? '';
    addressTextEditingController.text = towerReq.value.addressDetail == null
        ? 'Chưa có thông tin'
        : '${towerReq.value.addressDetail} - ${towerReq.value.wardsName} - ${towerReq.value.districtName} - ${towerReq.value.provinceName}';
    quantityVehicleParked.text = towerReq.value.quantityVehicleParked == null
        ? ''
        : towerReq.value.quantityVehicleParked.toString();

    listImages((towerReq.value.images ?? [])
        .map((e) => ImageData(linkImage: e))
        .toList());
  }
   void showDialogSuccess(String title) {
    var alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Colors.grey[200],
      elevation: 0.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SahaLoadingWidget(),
          const SizedBox(
            height: 1,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ),
        ],
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext c) {
          return alert;
        });
  }

  Future<String?> upVideo() async {
    try {
      var link = await RepositoryManager.imageRepository
          .uploadVideo(video: file, type: MOTEL_FILES_FOLDER);
      towerReq.value.videoLink = link;
      return link;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:intl/intl.dart';

import '../../../../model/motel_room.dart';
import '../../../../model/renter.dart';
import '../../../../model/tower.dart';

class RenterDetailController extends GetxController {
  var renterReq = Renter().obs;
  final int renterId;
  var loadInit = false.obs;
  
  RenterDetailController({required this.renterId}) {
    getRenter();
  }

  var nameTower = TextEditingController();
  var roomName = TextEditingController();
  var priceExpected = TextEditingController();
  var intendTimeHire = TextEditingController();
  var intendDayHire = TextEditingController();

  var name = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();

  Tower? towerSelected;
  MotelRoom? motelRoomSelected;

  Future<void> getRenter() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.manageRepository
          .getRenter(renterId: renterId);
      renterReq.value = res!.data!;
      convertInfo();
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void convertInfo() {
    towerSelected = Tower(id: renterReq.value.towerId);
    motelRoomSelected = renterReq.value.motelRoom;
    nameTower.text = renterReq.value.nameTowerExpected ?? '';
    roomName.text = renterReq.value.motelName ?? '';
    priceExpected.text = renterReq.value.priceExpected == null
        ? ''
        : '${SahaStringUtils().convertToUnit(renterReq.value.priceExpected)}';
    intendTimeHire.text = renterReq.value.estimateRentalPeriod ?? '';
    intendDayHire.text = renterReq.value.estimateRentalDate == null
        ? ""
        : DateFormat('dd-MM-yyyy').format(renterReq.value.estimateRentalDate!);
    name.text = renterReq.value.name ?? '';
    phone.text = renterReq.value.phoneNumber ?? '';
    email.text = renterReq.value.email ?? '';
  }

  Future<void> updateTenant() async {
    try {
      var data = await RepositoryManager.manageRepository.updateRenter(
        renter: renterReq.value,
        renterId: renterReq.value.id!,
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteRenter({required int renterId}) async {
    try {
      var data = await RepositoryManager.manageRepository
          .deleteRenter(renterId: renterId);
      Get.back();
      SahaAlert.showSuccess(message: "Đã xoá thành công");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }
}

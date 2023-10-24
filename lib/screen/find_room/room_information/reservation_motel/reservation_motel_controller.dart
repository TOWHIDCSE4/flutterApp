import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import '../../../../model/location_address.dart';
import '../../../../model/reservation_motel.dart';

class ReservationMotelController extends GetxController {
  var nameEdit = TextEditingController();
  var phoneEdit = TextEditingController();
  var addressEdit = TextEditingController();
  var noteEdit = TextEditingController();

  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;

  var reservationMotel = ReservationMotel().obs;
  DataAppController dataAppController = Get.find();

  int moPostId;
  int hostId;

  ReservationMotelController({required this.moPostId, required this.hostId}) {
    reservationMotel.value.moPostId = moPostId;
    reservationMotel.value.hostId = hostId;
    nameEdit.text = dataAppController.badge.value.user?.name ?? "";
    phoneEdit.text = dataAppController.badge.value.user?.phoneNumber ?? "";
  }

  Future<void> addReservationMotelMotel() async {
    reservationMotel.value.province = locationProvince.value.id;
    reservationMotel.value.district = locationDistrict.value.id;
    reservationMotel.value.wards = locationWard.value.id;
    reservationMotel.value.name = nameEdit.text;
    reservationMotel.value.phoneNumber = phoneEdit.text;
    try {
      var data = await RepositoryManager.roomPostRepository
          .addReservationMotel(reservationMotel: reservationMotel.value);
      SahaAlert.showSuccess(
          message:
              "Đã gửi yêu cầu tìm phòng chủ nhà sẽ liên hệ lại trong thời gian sớm nhất!");
      Future.delayed(const Duration(milliseconds: 2000), () {
        Get.back();
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

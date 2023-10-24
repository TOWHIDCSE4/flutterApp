import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/find_fast_motel.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import '../../../model/location_address.dart';

class FindNowController extends GetxController {
  var nameEdit = TextEditingController();
  var phoneEdit = TextEditingController();
  var addressEdit = TextEditingController();
  var noteEdit = TextEditingController();
  var price = TextEditingController();
  var capacity = TextEditingController();
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;

  var findFast = FindFastMotel().obs;
  DataAppController dataAppController = Get.find();

  FindNowController() {
    nameEdit.text = dataAppController.badge.value.user?.name ?? "";
    phoneEdit.text = dataAppController.badge.value.user?.phoneNumber ?? "";
  }

  Future<void> addFindFastMotel() async {
    findFast.value.province = locationProvince.value.id;
    findFast.value.district = locationDistrict.value.id;
    findFast.value.wards = locationWard.value.id;
    findFast.value.name = nameEdit.text;
    findFast.value.phoneNumber = phoneEdit.text;
    try {
      var data = await RepositoryManager.roomPostRepository
          .addFindFastMotel(findFastMotel: findFast.value);
      SahaAlert.showSuccess(
          message:
              "Đã gửi yêu cầu tìm phòng Tư vấn viên sẽ liên hệ lại trong thời gian sớm nhất!");
      Future.delayed(const Duration(milliseconds: 2000), () {
        Get.back();
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/dialog/dialog.dart';
import 'package:gohomy/screen/owner/contract/add_contract/add_contract_screen.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/motel_room.dart';
import '../../../../model/potential_user.dart';
import '../../../../model/renter.dart';
import '../../../../model/tower.dart';

class AddRenterController extends GetxController {
  //////
  var nameTower = TextEditingController();
  var roomName = TextEditingController();
  var priceExpected = TextEditingController();
  var intendTimeHire = TextEditingController();
  var intendDayHire = TextEditingController();

  var name = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();

  PotentialUser? userPotential;
  bool? isFromDetailScreen;
  var renterReq = Renter().obs;

  AddRenterController({required this.userPotential, this.isFromDetailScreen}) {
    if (userPotential != null) {
      convertInfoFromUserPotential();
    }
  }

  Tower? towerSelected;
  MotelRoom? motelRoomSelected;

  Future<void> addRenter() async {
    if (renterReq.value.name == null || renterReq.value.name == '') {
      SahaAlert.showError(message: "Bạn chưa nhập tên");
      return;
    }
    if (renterReq.value.phoneNumber == null ||
        renterReq.value.phoneNumber == '') {
      SahaAlert.showError(message: "Bạn chưa nhập số điện thoại");
      return;
    }

    if (renterReq.value.motelName == null || renterReq.value.motelId == null) {
      SahaAlert.showError(message: "Bạn chưa chọn phòng nào");
      return;
    }
    try {
      var res = await RepositoryManager.manageRepository.addRenter(
        renter: renterReq.value,
      );
      SahaAlert.showSuccess(message: "Thêm thành công");
      SahaDialogApp.showDialogYesNo(
          mess: "Bạn có muốn làm hợp đồng cho khách thuê này không?",
          onOK: () {
            Get.to(() => AddContractScreen());
          },
          onClose: () {
            SahaDialogApp.showDialogOneButton(
                title: "Thông báo",
                mess:
                    "Nếu sau 48 giờ bạn không tạo hợp đồng cho khách thuê thì sẽ bị trừ điểm tín nhiệm. Hãy hoàn thành hợp đồng sớm nha",
                onClose: () {});
          });
      if (isFromDetailScreen == true) {
        Get.back();
        Get.back();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void convertInfoFromUserPotential() {
    renterReq.value = Renter(
      name: userPotential?.userGuest?.name,
      phoneNumber: userPotential?.userGuest?.phoneNumber,
      email: userPotential?.userGuest?.email,
    );
    name.text = userPotential?.userGuest?.name ?? '';
    phone.text = userPotential?.userGuest?.phoneNumber ?? '';
    email.text = userPotential?.userGuest?.email ?? '';
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/user.dart';

class EditProfileController extends GetxController {
  final int? sexIndexInput;
  var referralCode = TextEditingController();
  var bankAccount = TextEditingController();
  var nameAccount = TextEditingController();
  var bankName = TextEditingController();
  var cmndNumber = TextEditingController();
  var onTapInfoBank = false.obs;
  User users;
  var user = User().obs;
  EditProfileController({this.sexIndexInput, required this.users}) {
    user.value = users;
    bankAccount.text = user.value.bankAccountNumber ?? '';
    nameAccount.text = user.value.bankAccountName ?? '';
    bankName.text = user.value.bankName ?? '';
    cmndNumber.text = user.value.cmndNumber ?? '';

    onChangeSexPicker(sexIndexInput ?? 0);
  }

  var linkAvatar = "".obs;
  var dateOfBirth = DateTime.now().obs;
  var sex = "".obs;
  var sexIndex = 0;

  void onChangeSexPicker(int value) {
    if (value == 0) {
      sex.value = "Khác";
      user.value.sex = 0;
    } else {
      if (value == 1) {
        sex.value = "Nam";
        user.value.sex = 1;
      } else {
        sex.value = "Nữ";
        user.value.sex = 2;
      }
    }
  }

  Future<void> updateProfile() async {
    try {
      var res = await RepositoryManager.accountRepository
          .updateProfile(user: user.value);
      Get.find<DataAppController>().getBadge();
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class ChangePasswordController extends GetxController {
  var resting = false.obs;
  var newPassInputting = false.obs;

  TextEditingController textEditingControllerNewPass = TextEditingController();
  TextEditingController textEditingControllerOldPass = TextEditingController();

  Future<void> onChange() async {
    resting.value = true;
    try {
      var loginData = await RepositoryManager.accountRepository.changePassword(
        newPass: textEditingControllerNewPass.text,
        oldPass: textEditingControllerOldPass.text,
      );

      SahaAlert.showSuccess(message: "Thay đổi mật khẩu thành công");
      Get.back();
      resting.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      resting.value = false;
    }
    resting.value = false;
  }
}

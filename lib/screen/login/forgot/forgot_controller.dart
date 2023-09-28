import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import 'otp/otp_forgot_screen.dart';

class ForgotController extends GetxController {
  TextEditingController textEditingControllerPhone = TextEditingController();
  TextEditingController textEditingControllerNewPass = TextEditingController();
  var otp = '';
  var loading = false.obs;
  var resting = false.obs;

  Future<void> checkHasPhoneNumber() async {
    try {
      var data = await RepositoryManager.accountRepository.checkExists(
        emailOrPhoneNumber: textEditingControllerPhone.text,
      );
      SahaAlert.showError(message: 'Số điện thoại không tồn tại');
    } catch (err) {
      Get.to(() => OtpForgotScreen());
    }
  }

  Future<void> onReset() async {
    resting.value = true;
    try {
      var loginData = (await RepositoryManager.accountRepository.resetPassword(
        emailOrPhoneNumber: textEditingControllerPhone.text,
        pass: textEditingControllerNewPass.text,
        otp: otp,
      ))!;

      SahaAlert.showSuccess(
          message: "Lấy lại mật khẩu thành công, vui lòng đăng nhập lại");
      Get.back();
      Get.back(result: {
        "success": true,
        "phone": textEditingControllerPhone.text,
        "pass": textEditingControllerNewPass.text
      });
      resting.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      resting.value = false;
    }
    resting.value = false;
  }
}

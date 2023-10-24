import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../data_app_controller.dart';
import '../../navigator/navigator_screen.dart';
import '../choose_type_user/choose_type_user_screen.dart';

class UpdatePhoneController extends GetxController {
  TextEditingController phoneEdit = TextEditingController();

  Future<void> updatePhoneProfile() async {
    try {
      var data = await RepositoryManager.accountRepository
          .updatePhoneProfile(phoneEdit.text);
      Get.find<DataAppController>().isLogin.value = true;

      if (Get.find<DataAppController>().badge.value.user?.isHost == null) {
        Get.to(() => ChooseTypeUserScreen());
        return;
      }

      Get.offAll(NavigatorApp());
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

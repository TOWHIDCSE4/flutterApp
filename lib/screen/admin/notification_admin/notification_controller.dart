import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/const/admin_notification.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/admin_notification.dart';

class AdminNotificationController extends GetxController {
  var adminNoti = AdminNotification();
  var title = TextEditingController();
  var content = TextEditingController();
  var role = TextEditingController();
  AdminNotificationController() {
    adminNoti.role = USER_NORMAL;
    role.text = "Người thuê";
  }
  Future<void> sendAdminNotification() async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .sendAdminNotification(adminNoti: adminNoti);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

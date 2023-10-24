import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/admin_discover.dart';

class UpdateAdminDiscoverController extends GetxController {
  var adminDiscover = AdminDiscover().obs;
  TextEditingController contentController = TextEditingController();
  var linkUrl = "".obs;
  Future<void> udpateDiscover({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateDiscover(id: id, adminDiscover: adminDiscover.value);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

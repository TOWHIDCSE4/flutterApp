import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../model/report_post_roommate.dart';

class ReportPostRoommateController extends GetxController{
  var report = ReportPostRoommate();

   TextEditingController reasonController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> reportPostRoommate() async {
    try {
      var res = await RepositoryManager.userManageRepository
          .reportPostRoommate(reportPostRoommate: report);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
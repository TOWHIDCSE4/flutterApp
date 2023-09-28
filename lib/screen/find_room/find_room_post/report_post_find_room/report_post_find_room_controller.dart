import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/report_post_find_room.dart';

class ReportPostFindRoomController extends GetxController {
  var report = ReportPostFindRoom();

   TextEditingController reasonController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> reportPostFindRoom() async {
    try {
      var res = await RepositoryManager.userManageRepository
          .reportPostFindRoom(reportPostFindRoom: report);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

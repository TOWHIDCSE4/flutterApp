import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/report_post_violation.dart';

class ReportViolationPostController extends GetxController {
  var reportPostViolation = ReportPostViolation().obs;
  TextEditingController reasonController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Future<void> addReportPostViolation() async {
    try {
      var res = await RepositoryManager.userManageRepository
          .addReportPostViolation(
              reportPostViolation: reportPostViolation.value);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

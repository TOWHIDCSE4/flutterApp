import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_help_post_res.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../../model/category_help_post.dart';

class AddHelpPostController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  var linkUrl = "".obs;
  var helpPostRequest = HelpPostRequest().obs;
  var listCategorySelected = RxList<CategoryHelpPost>();

  Future<void> addHelpPost() async {
    if (helpPostRequest.value.imageUrl == null ||
        helpPostRequest.value.imageUrl == '') {
      SahaAlert.showError(message: 'Chưa chọn ảnh');
      return;
    }
    try {
      var res = await RepositoryManager.adminManageRepository
          .addHelpPost(helpPostRequest: helpPostRequest.value);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

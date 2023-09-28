import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/category_help_post.dart';

class AddCategoryController extends GetxController {
  var categoryPost = CategoryHelpPost().obs;
  var linkUrl = "".obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> addCategoryHelpPost() async {
    if (categoryPost.value.imageUrl == null ||
        categoryPost.value.imageUrl == '') {
      SahaAlert.showError(message: 'Chưa chọn ảnh');
      return;
    }
    try {
      var res = await RepositoryManager.adminManageRepository
          .addCategoryHelpPost(categoryHelpPost: categoryPost.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

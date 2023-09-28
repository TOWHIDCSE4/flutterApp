import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../../model/category_help_post.dart';

class UpdateCategoryController extends GetxController {
  var categoryPost = CategoryHelpPost().obs;
  var linkUrl = "".obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var loadInit = true.obs;

  Future<void> getCategoryHelp({required int id}) async {
    try {
      var res =
          await RepositoryManager.adminManageRepository.getCategoryHelp(id: id);
      categoryPost.value = res!.data!;
      titleController.text = categoryPost.value.title ?? '';
      descriptionController.text = categoryPost.value.description ?? '';
      linkUrl.value = categoryPost.value.imageUrl ?? '';
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateCategoryHelp({required int id}) async {
    if (categoryPost.value.imageUrl == null ||
        categoryPost.value.imageUrl == '') {
      SahaAlert.showError(message: 'Chưa chọn ảnh');
      return;
    }
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateCategoryHelp(id: id, categoryHelpPost: categoryPost.value);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deleteCategoryHelp({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .deleteCategoryHelp(id: id);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

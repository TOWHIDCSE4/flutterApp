import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_help_post_res.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../../model/category_help_post.dart';

class UpdateHelpPostController extends GetxController {
  var helpPost = HelpPostData().obs;
  var loadInit = true.obs;
  var linkUrl = "".obs;
  var helpPostRequest = HelpPostRequest().obs;
  var listCategorySelected = RxList<CategoryHelpPost>();
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<void> getHelpPost({required int id}) async {
    try {
      var res =
          await RepositoryManager.adminManageRepository.getHelpPost(id: id);
      helpPost.value = res!.data!;
      categoryNameController.text =
          helpPost.value.categoryHelpPost?.title ?? '';
      titleController.text = helpPost.value.helpPost?.title ?? '';
      contentController.text = helpPost.value.helpPost?.content ?? '';
      summaryController.text = helpPost.value.helpPost?.summary ?? '';
      linkUrl.value = helpPost.value.helpPost?.imageUrl ?? '';
      //////
      helpPostRequest.value.categoryHelpPostId =
          helpPost.value.categoryHelpPost?.id;
      helpPostRequest.value.content = helpPost.value.helpPost?.content;
      helpPostRequest.value.imageUrl = helpPost.value.helpPost?.imageUrl;
      helpPostRequest.value.summary = helpPost.value.helpPost?.summary;
      helpPostRequest.value.title = helpPost.value.helpPost?.title;
      /////

      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateHelpPost({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateHelpPost(id: id, helpPostRequest: helpPostRequest.value);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deleteHelpPost({required int id}) async {
    try {
      var res =
          await RepositoryManager.adminManageRepository.deleteHelpPost(id: id);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

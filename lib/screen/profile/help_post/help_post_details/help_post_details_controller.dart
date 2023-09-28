import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/all_help_post_res.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

class HelpPostDetailsController extends GetxController {
  var helpPost = HelpPostData().obs;
  var loadInit = true.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  Future<void> getOneHelpPost({required int id}) async {
    try {
      var res =
          await RepositoryManager.userManageRepository.getOneHelpPost(id: id);
      helpPost.value = res!.data!;
      categoryNameController.text =
          helpPost.value.categoryHelpPost?.title ?? '';
      titleController.text = helpPost.value.helpPost?.title ?? '';
      contentController.text = helpPost.value.helpPost?.content ?? '';
      summaryController.text = helpPost.value.helpPost?.summary ?? '';
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

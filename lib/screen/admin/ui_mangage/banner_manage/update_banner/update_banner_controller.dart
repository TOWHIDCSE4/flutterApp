import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/banners.dart';

import '../../../../../components/arlert/saha_alert.dart';

class UpdateBannerController extends GetxController {
  var banner = Banners().obs;
  var loadInit = true.obs;
  var linkUrl = "".obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController actionLinkController = TextEditingController();

  Future<void> getBanner({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository.getBanner(id: id);
      banner.value = res!.data!;
      loadInit.value = false;
      titleController.text = banner.value.title ?? '';
      actionLinkController.text = banner.value.actionLink ?? '';
      linkUrl.value = banner.value.imageUrl ?? '';
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateBanner({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateBanner(id: id, banner: banner.value);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteBanner({required int id}) async {
    try {
      var res =
          await RepositoryManager.adminManageRepository.deleteBanner(id: id);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

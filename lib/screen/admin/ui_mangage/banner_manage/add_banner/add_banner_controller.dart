import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../../components/arlert/saha_alert.dart';

import '../../../../../model/banners.dart';

class AddBannerController extends GetxController {
  var banner = Banners().obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController actionLinkController = TextEditingController();

  var linkUrl = "".obs;
  Future<void> addBanner() async {
    try {
      if (banner.value.imageUrl == null || banner.value.imageUrl == '') {
        SahaAlert.showError(message: 'Chưa chọn ảnh');
        return;
      }
      var res = await RepositoryManager.adminManageRepository
          .addBanner(banner: banner.value);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

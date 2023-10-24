import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/admin_discover_item.dart';

class UpdateDiscoverItemController extends GetxController {
  var discoverItem = AdminDiscoverItem().obs;
  TextEditingController contentController = TextEditingController();
  var linkUrl = "".obs;
  Future<void> getDiscoverItem({required int id}) async {
    try {
      var res =
          await RepositoryManager.adminManageRepository.getDiscoverItem(id: id);
      discoverItem.value = res!.data!;
      contentController.text = discoverItem.value.content ?? '';
      linkUrl.value = discoverItem.value.image ?? '';
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deleteDiscoverItem({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .deleteDiscoverItem(id: id);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateDiscoverItem({required int id}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateDiscoverItem(id: id, adminDiscoverItem: discoverItem.value);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

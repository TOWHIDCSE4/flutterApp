import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../../model/post_find_room.dart';

class FindRoomPostAdminDetailController extends GetxController {
  var loadInit = false.obs;
  int postFindRoomId;

  var postRes = PostFindRoom().obs;

  FindRoomPostAdminDetailController({required this.postFindRoomId}) {
    getAdminPostFindRoom();
  }
  Future<void> getAdminPostFindRoom() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.adminManageRepository
          .getAdminPostFindRoom(postFindRoomId: postFindRoomId);
      postRes.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateStatusAdminPostFindRoom({required int status}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateStatusAdminPostFindRoom(
              postFindRoomId: postFindRoomId, status: status);
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deleteAdminPostFindRoom() async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .deleteAdminPostFindRoom(postFindRoomId: postFindRoomId);
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

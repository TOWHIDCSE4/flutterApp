import 'package:get/get.dart';
import 'package:gohomy/model/post_roommate.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';

class PostRoommateAdminDetailController extends GetxController {
  var loadInit = false.obs;
  int postRoommateId;

  var postRes = PostRoommate().obs;

  PostRoommateAdminDetailController({required this.postRoommateId}) {
    getAdminPostRoommate();
  }
  Future<void> getAdminPostRoommate() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.adminManageRepository
          .getAdminPostRoommate(postRoommateId: postRoommateId);
      postRes.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateStatusAdminPostRoommate({required int status}) async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .updateStatusAdminPostRoommate(
              postRoommateId: postRoommateId, status: status);
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deleteAdminPostRoommate() async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .deleteAdminPostRoommate(postRoommateId: postRoommateId);
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

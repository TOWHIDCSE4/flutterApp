import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../../model/find_fast_motel.dart';

class FindFastMotelDetailController extends GetxController {
  var findFastMotel = FindFastMotel().obs;
  int idFindFast;
  var loadInit = false.obs;
  FindFastMotelDetailController({required this.idFindFast}) {
    getFindFastMotel();
  }
  Future<void> getFindFastMotel() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.adminManageRepository
          .getFindFastMotel(idFindFast: idFindFast);
      findFastMotel.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateFindFastMotel({
    required int findFastMotelId,
    required int status,
  }) async {
    try {
      var data =
          await RepositoryManager.adminManageRepository.updateFindFastMotel(
        findFastMotelId: findFastMotelId,
        status: status,
      );
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteFindFastMotel({
    required int findFastMotelId,
  }) async {
    try {
      var data =
          await RepositoryManager.adminManageRepository.deleteFindFastMotel(
        findFastMotelId: findFastMotelId,
      );
      SahaAlert.showSuccess(message: 'Đã xoá');
      Get.back()
;    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

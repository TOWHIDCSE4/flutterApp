import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/admin_config.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

class IntroManageController extends GetxController {
  var adminConfig = AdminConfig().obs;
  var loadInit = false.obs;
  IntroManageController(){
    getAdminConfig();
  }
  Future<void> getAdminConfig() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.adminManageRepository.getAdminConfig();
      adminConfig.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> addConfig() async {
    try {
      var res = await RepositoryManager.adminManageRepository.addConfig(adminConfig: adminConfig.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

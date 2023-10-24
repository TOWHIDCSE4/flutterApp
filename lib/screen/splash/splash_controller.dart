import 'package:get/get.dart';

import '../../components/arlert/saha_alert.dart';
import '../../data/remote/response-request/admin_manage/admin_config.dart';
import '../../data/repository/repository_manager.dart';

class SplashController extends GetxController{
  SplashController(){
    getAdminConfig();
  }
  var adminConfig = AdminConfig().obs;
  var loadInit = false.obs;
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
}
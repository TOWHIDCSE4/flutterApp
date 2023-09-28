import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import '../../data_app_controller.dart';
import '../../navigator/navigator_screen.dart';

class ChooseTypeUserController extends GetxController {
  var isHost = false.obs;

  Future<void> updateHost() async {
    try {
      var data =
          await RepositoryManager.accountRepository.updateHost(isHost.value);
      await Get.find<DataAppController>().getBadge();
      Get.offAll(NavigatorApp());
      Get.find<DataAppController>().isLogin.value = true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

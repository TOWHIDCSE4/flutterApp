import 'package:get/get.dart';

import '../../components/arlert/saha_alert.dart';
import '../../data/repository/repository_manager.dart';

class NavigatorController extends GetxController {
  var selectedIndex = 0.obs;
  NavigatorController({required int selecteIndex}) {
    selectedIndex.value = selecteIndex;
  }
  Future<void> readAllNotification({bool? isRefresh}) async {
    try {
      var res =
          await RepositoryManager.notificationRepository.readAllNotification();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

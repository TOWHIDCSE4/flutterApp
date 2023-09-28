import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/admin_manage/admin_badges_res.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../components/arlert/saha_alert.dart';

class AdminController extends GetxController {
  var adminBadges = AdminBadges().obs;

  Future<void> getAdminBadges() async {
    try {
      var res = await RepositoryManager.adminManageRepository.getAdminBadges();
      adminBadges.value = res!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

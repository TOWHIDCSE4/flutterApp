import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/decentralization.dart';

class AddDecentralizationController extends GetxController {
  var decentralization = Decentralization().obs;

  Future<void> addDecentralization() async {
    try {
      var res = await RepositoryManager.adminManageRepository
          .addDecentralization(decentralization: decentralization.value);
      SahaAlert.showSuccess(message: 'Thành công');
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

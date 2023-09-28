import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/user_manage/summary_motel_res.dart';
import 'package:gohomy/screen/data_app_controller.dart';

import '../../components/arlert/saha_alert.dart';
import '../../data/repository/repository_manager.dart';

class ProFileController extends GetxController {
  var summary = Summary().obs;
  DataAppController dataAppController = Get.find();



  ProFileController();
  Future<void> getSummary() async {
    try {
      var res = await RepositoryManager.userManageRepository.getSummary();
      summary.value = res!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

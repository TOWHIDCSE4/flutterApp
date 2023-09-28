import 'package:get/get.dart';
import 'package:gohomy/model/service.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class ServiceController extends GetxController {
  var listService = RxList<Service>();
  var isLoading = false.obs;

  ServiceController() {
    getAllService();
  }

  Future<void> getAllService() async {
    try {
      isLoading.value = true;
      var data = await RepositoryManager.manageRepository.getAllService();
      listService(data!.data!);
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

}

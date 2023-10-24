import 'package:get/get.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/service.dart';

class ChooseServiceController extends GetxController {
  var listService = <Service>[].obs;

  var listServiceSelected = RxList<Service>();
  var isLoading = false.obs;
  String? textSearch;
  List<Service> serviceInput;
  List<Service>? listServiceInput;
  ChooseServiceController({this.listServiceInput, required this.serviceInput}) {
    listService.value = serviceInput;
    if (listServiceInput != null) {
      listServiceSelected(listServiceInput);
    }
    //getAllService();
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

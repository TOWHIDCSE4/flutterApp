import 'package:get/get.dart';

import '../../../../../components/arlert/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/decentralization.dart';

class ChooseDecentralizationController extends GetxController {
  var listDecentralization = RxList<Decentralization>();
  int currentPage = 1;
  var decentralizationChoose = Decentralization().obs;
  bool isEnd = false;
  var loadInit = true.obs;

  var isLoading = false.obs;

  ChooseDecentralizationController() {
    getAllDecentralization(isRefresh: true);
  }

  Future<void> getAllDecentralization({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        //isLoading.value = true;
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository
            .getAllDecentralization(
          page: currentPage,
        );

        if (isRefresh == true) {
          listDecentralization(data!.data!.data!);
          listDecentralization.refresh();
        } else {
          listDecentralization.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      loadInit.value = false;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

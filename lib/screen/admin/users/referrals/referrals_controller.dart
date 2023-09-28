import 'package:get/get.dart';
import 'package:gohomy/model/user.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';

class ReferralController extends GetxController {
  var listReferral = RxList<User>();
  int currentPage = 1;
  bool isEnd = false;
  var loadInit = true.obs;
  var isLoading = false.obs;

  String? search;
  var isSearch = false.obs;
  ReferralController() {
    getAllReferral(isRefresh: true);
  }
  Future<void> getAllReferral({
    bool? isRefresh,
    String? ranked,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository.getAllReferral(
          page: currentPage,
        );

        if (isRefresh == true) {
          listReferral(data!.data!.data!);
        } else {
          listReferral.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

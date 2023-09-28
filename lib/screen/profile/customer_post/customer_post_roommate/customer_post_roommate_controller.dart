import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/post_roommate.dart';

class CustomerPostRoommateController extends GetxController {
  var listPostRoommate = RxList<PostRoommate>();
  var loadInit = true.obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  var status = 0.obs;
  String? textSearch;

  CustomerPostRoommateController() {
    getAllPostRoommate(isRefresh: true);
  }

  Future<void> getAllPostRoommate({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.userManageRepository
            .getAllPostRoommate(page: currentPage, status: status.value);

        if (isRefresh == true) {
          listPostRoommate(data!.data!.data!);
          listPostRoommate.refresh();
        } else {
          listPostRoommate.addAll(data!.data!.data!);
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

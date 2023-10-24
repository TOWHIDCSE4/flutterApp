import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';
import 'package:gohomy/model/potential_user.dart';

class PotentialDetailController extends GetxController {
  var potentialUser = PotentialUser().obs;
  var loadInit = false.obs;

  var listHistory = RxList<HistoryUserPotential>();
  int currentPage = 1;
  var isEndList = false.obs;

  bool isEnd = false;

  var isLoading = false.obs;
  var loadInitHistory = true.obs;

  int idPotential;
  int userGuestId;

  PotentialDetailController(
      {required this.idPotential, required this.userGuestId}) {
    getPotentialUser();
    getAllHistoryPotential(isRefresh: true);
  }

  Future<void> getPotentialUser() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.userManageRepository
          .getPotentialUser(id: idPotential);
      potentialUser.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  ////
  ///
  Future<void> getAllHistoryPotential({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data =
            await RepositoryManager.userManageRepository.getAllHistoryPotential(
          page: currentPage,
          userGuestId: userGuestId,
        );

        if (isRefresh == true) {
          listHistory(data!.data!.data!);
        } else {
          listHistory.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
          isEndList.value = true;
        } else {
          isEnd = false;
          isEndList.value = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInitHistory.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updatePotentialUser({required int status}) async {
    try {
      var res = await RepositoryManager.userManageRepository
          .updatePotentialUser(status: status, idPotential: idPotential);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deletePotentialUser() async {
    try {
      var res = await RepositoryManager.userManageRepository
          .deletePotentialUser(idPotential: idPotential);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}

const TYPE_FROM_LIKE = 0;
const TYPE_FROM_RESERVATION = 1;
const TYPE_FROM_SENT_MESSAGE = 2;
const TYPE_FROM_CALL = 3;

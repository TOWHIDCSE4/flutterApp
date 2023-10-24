import 'package:get/get.dart';
import 'package:gohomy/model/reservation_motel.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/user.dart';
import '../../data_app_controller.dart';

class ReservationMotelAdminController extends GetxController {
  var listReservationMotel = RxList<ReservationMotel>();
  int currentPage = 1;
  var status = 0.obs;
  bool isEnd = false;
  var loadInit = true.obs;
  String? textSearch;
  var isLoading = false.obs;
  var userChoose = User().obs;


  ReservationMotelAdminController() {
    userChoose.value = Get.find<DataAppController>().currentUser.value;
    if (userChoose.value.id ==
        Get.find<DataAppController>().currentUser.value.id) {
      userChoose.value.name = 'Admin';
    }
    getReservationMotelAdmin(isRefresh: true);
  }

  Future<void> getReservationMotelAdmin({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository
            .getReservationMotelAdmin(
          page: currentPage,
          search: textSearch,
          status: status.value,
            userId: userChoose.value.id
        );

        if (isRefresh == true) {
          listReservationMotel(data!.data!.data!);
          listReservationMotel.refresh();
        } else {
          listReservationMotel.addAll(data!.data!.data!);
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

  Future<void> updateReservationMotel({
    required int reservationId,
    required int status,
  }) async {
    try {
      var data =
          await RepositoryManager.adminManageRepository.updateReservationMotel(
        reservationId: reservationId,
        status: status,
      );
      getReservationMotelAdmin(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteReservationMotel({
    required int reservationId,
  }) async {
    try {
      var data =
          await RepositoryManager.adminManageRepository.deleteReservationMotel(
        reservationId: reservationId,
      );
      SahaAlert.showSuccess(message: 'Đã xoá');
      getReservationMotelAdmin(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

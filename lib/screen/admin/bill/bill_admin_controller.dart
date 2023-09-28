import 'package:get/get.dart';
import 'package:gohomy/model/bill.dart';
import 'package:intl/intl.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/user.dart';

class BillAdminController extends GetxController {
  var listBill = RxList<Bill>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var status = 0.obs;
  var isLoading = false.obs;
  var loadInit = true.obs;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  DateTime? fromDateOption;
  DateTime? toDateOption;
  var checkSelected = false.obs;
  String? dateFrom;
  String? dateTo;
  var userChoose = User().obs;

  BillAdminController() {
    // userChoose.value = Get.find<DataAppController>().currentUser.value;
    // if(userChoose.value.id == Get.find<DataAppController>().currentUser.value.id) {
    //   userChoose.value.name = 'Admin';
    // }
    getAllBill(isRefresh: true);
  }

  Future<void> getAllBill({
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
            .getAllBillAdmin(
                search: textSearch,
                userId: userChoose.value.id,
                page: currentPage,
                status: status.value,
                dateFrom: dateFrom,
                dateTo: dateTo);

        if (isRefresh == true) {
          listBill(data!.data!.data!);
        } else {
          listBill.addAll(data!.data!.data!);
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

  void onOkChooseTime(DateTime startDate, DateTime endDate) {
    checkSelected.value = true;
    fromDay.value = startDate;
    toDay.value = endDate;
    fromDateOption = startDate;
    toDateOption = endDate;
    dateFrom = DateFormat('yyyy-MM-dd').format(startDate);
    dateTo = DateFormat('yyyy-MM-dd').format(endDate);
    Get.back();
  }
}

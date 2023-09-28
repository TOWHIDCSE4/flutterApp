import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../components/arlert/saha_alert.dart';
import '../../data/repository/repository_manager.dart';
import '../../model/bill.dart';

class UserBillController extends GetxController {
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
  UserBillController() {
    getUserAllBill(isRefresh: true);
  }

  Future<void> getUserAllBill({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        //loadInit.value = true;
        isLoading.value = true;
        var data = await RepositoryManager.userManageRepository.getUserAllBill(
            search: textSearch,
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

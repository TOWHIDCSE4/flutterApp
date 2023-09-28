import 'package:get/get.dart';
import 'package:gohomy/model/contract.dart';
import 'package:intl/intl.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/user.dart';
import '../../data_app_controller.dart';

class ContractAdminController extends GetxController {
  var listContract = RxList<Contract>();
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
  int? initTab;

  ContractAdminController({this.initTab}) {
    userChoose.value = Get.find<DataAppController>().currentUser.value;
    if (userChoose.value.id ==
        Get.find<DataAppController>().currentUser.value.id) {
      userChoose.value.name = Get.find<DataAppController>().currentUser.value.name ?? '';
    }
    if (initTab == 1) {
      status.value = 2;
    }
    getAllContract(isRefresh: true);
  }

  Future<void> getAllContract({
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
            .getAllContractAdmin(
                search: textSearch,
                page: currentPage,
                status: status.value,
                dateFrom: dateFrom,
                userId: userChoose.value.id,
                dateTo: dateTo);

        if (isRefresh == true) {
          listContract(data!.data!.data!);
        } else {
          listContract.addAll(data!.data!.data!);
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

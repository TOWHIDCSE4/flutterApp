import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/report/report_commission_res.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';

class ReportCommissionController extends GetxController {
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var page = 0.obs;
  int indexTabTime = 0;
  int indexChooseTime = 0;

  var timeNow = DateTime.now().obs;
  var indexOption = 0.obs;
  var isTotalChart = true.obs;
  var isLoading = false.obs;
  DateTime? fromDateInput;
  DateTime? toDateInput;
  var reportCommission = ReportCommission().obs;
  var indexChart = 0.obs;
  ReportCommissionController({
    this.fromDateInput,
    this.toDateInput,
  }) {
    if (fromDateInput != null) {
      fromDay.value = fromDateInput!;
    } else {
      fromDay.value = timeNow.value;
    }
    if (toDateInput != null) {
      toDay.value = toDateInput!;
    } else {
      toDay.value = timeNow.value;
    }

    // getReports();
  }

  Future<void> getReportCommission() async {
    isLoading.value = true;
    try {
      var res = await RepositoryManager.reportRepository.getReportCommission(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );

      reportCommission(res!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  void changeTypeChart(int index) {
    indexChart.value = index;
  }

  List<String> listMonth = [
    "Tháng 1",
    "Tháng 2",
    "Tháng 3",
    "Tháng 4",
    "Tháng 5",
    "Tháng 6",
    "Tháng 7",
    "Tháng 8",
    "Tháng 9",
    "Tháng 10",
    "Tháng 11",
    "Tháng 12",
  ];
}

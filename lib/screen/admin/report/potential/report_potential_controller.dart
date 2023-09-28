import 'package:get/get.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../components/arlert/saha_alert.dart';

import '../../../../data/remote/response-request/report/report_static_potential_res.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/chart_order.dart';

import '../order/option_report/chart_business.dart';

class ReportPotentialController extends GetxController {
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var fromDayCP = DateTime.now().obs;
  var toDayCP = DateTime.now().obs;
  var page = 0.obs;
  int indexTabTime = 0;
  int indexChooseTime = 0;

  var timeNow = DateTime.now().obs;
  var listChart = RxList<ChartOrder>();
  var indexOption = 0.obs;
  var isTotalChart = true.obs;
  var isOpenOrderDetail = false.obs;
  var isLoading = false.obs;

  var indexChart = 0.obs;

  List<String> listNameChartType = ["Doanh thu:", "Số đơn:", "số CTV:"];
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

  var listLineChart = RxList<LineSeries<SalesData?, String>>();

  DateTime? fromDateInput;
  DateTime? toDateInput;

  var reportPotential = ReportStaticPotential().obs;

  ReportPotentialController({
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

  @override
  Future<void> refresh() async {
    fromDay.value = timeNow.value;
    toDay.value = timeNow.value;
    getReportStaticPotential();
  }

  void changeTypeChart(int index) {
    indexChart.value = index;
  }

  void openAndCloseOrderDetail() {
    isOpenOrderDetail.value = !isOpenOrderDetail.value;
  }

  Future<void> getReportStaticPotential() async {
    isLoading.value = true;
    try {
      var res =
          await RepositoryManager.reportRepository.getReportStaticPotential(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );

      reportPotential(res!.data!);

      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}

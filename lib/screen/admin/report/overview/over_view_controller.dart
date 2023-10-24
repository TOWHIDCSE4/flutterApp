import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/report/report_find_fast_motel_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_motel_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_renter_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_reservation_motels_res.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../order/option_report/chart_business.dart';

class OverviewReportController extends GetxController {
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var page = 0.obs;
  int indexTabTime = 0;
  int indexChooseTime = 0;

  var timeNow = DateTime.now().obs;
  var indexOption = 0.obs;
  var isTotalChart = true.obs;
  var isLoading = false.obs;



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

  var reportRenter = ReportRenter().obs;
  var reportMotel = ReportMotel().obs;
  var reportFindFastMotel = ReportFindFastMotel().obs;
  var reportReservationMotel = ReportReservationMotel().obs;

  var indexChartRenter = 0.obs;
  var indexChartMotel = 0.obs;
  var indexChartFindFastMotel = 0.obs;
  var indexChartReservationMotel = 0.obs;

  OverviewReportController({
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
    getReportRenter();
    getReportMotel();
    getReportReservationMotel();
    getReportFindFastMotel();
  }

  void changeTypeChartRenter(int index) {
    indexChartRenter.value = index;
  }
  void changeTypeChartMotel(int index) {
    indexChartMotel.value = index;
  }
  void changeTypeChartFindFastMotel(int index) {
    indexChartFindFastMotel.value = index;
  }
  void changeTypeChartReservationMotel(int index) {
    indexChartReservationMotel.value = index;
  }

  Future<void> getReportRenter() async {
    isLoading.value = true;
    try {
      var res = await RepositoryManager.reportRepository.getReportRenter(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );

      reportRenter(res!.data!);

    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> getReportMotel() async {
    isLoading.value = true;
    try {
      var res = await RepositoryManager.reportRepository.getReportMotel(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );

      reportMotel(res!.data!);

    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> getReportFindFastMotel() async {
    isLoading.value = true;
    try {
      var res = await RepositoryManager.reportRepository.getReportFindFastMotel(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );

      reportFindFastMotel(res!.data!);

    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> getReportReservationMotel() async {
    isLoading.value = true;
    try {
      var res = await RepositoryManager.reportRepository.getReportReservationMotel(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );

      reportReservationMotel(res!.data!);

    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }
}

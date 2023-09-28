import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/report/report_order_res.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/remote/response-request/report/report_service_sell_res.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/chart_order.dart';
import 'option_report/chart_business.dart';

class OrderReportController extends GetxController {
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

  var reportOrder = ReportOrder().obs;

  OrderReportController({
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
    getReports();
  }

  void changeTypeChart(int index) {
    indexChart.value = index;
  }

  void openAndCloseOrderDetail() {
    isOpenOrderDetail.value = !isOpenOrderDetail.value;
  }

  Future<void> getReports() async {
    isLoading.value = true;
    try {
      var res = await RepositoryManager.reportRepository.getReportOrder(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );

      reportOrder(res!.data!);

      getServiceSellReport();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  /// chart_product

  var listTopSellingService = RxList<TopSellingService>();
  var listTopRevenueService = RxList<TopRevenueService>();

  var listNameServiceTop = RxList<String>();
  var listPropertiesTop = RxList<double>();
  var listServiceInChart = RxList<List<dynamic>>();
  var listChooseChartProduct = RxList<bool>([true, false, false, false]);
  var indexTypeChart = 0.obs;

  List<String> listNameChartProduct = [
    "Top số lượng bán:",
    "Top doanh thu:",
  ];

  void changeChooseChartProduct(int index) {
    listChooseChartProduct([false, false, false, false]);
    listChooseChartProduct[index] = true;
    listChooseChartProduct.refresh();
    indexTypeChart.value = index;
  }

  Future<void> getServiceSellReport() async {
    try {
      var res = await RepositoryManager.reportRepository.getServiceSellReport(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );
      listTopSellingService(res!.data!.topSellingServices);
      listTopRevenueService(res.data!.topRevenueServices);

      listNameServiceTop([
        listTopSellingService.isEmpty
            ? ""
            : listTopSellingService[0].serviceSell?.name ?? '',
        listTopRevenueService.isEmpty
            ? ""
            : listTopRevenueService[0].serviceSell?.name ?? "",
      ]);
      listPropertiesTop([
        listTopSellingService.isEmpty
            ? 0
            : (listTopSellingService[0].quantity ?? 0).toDouble(),
        listTopRevenueService.isEmpty
            ? 0
            : listTopRevenueService[0].totalPrice ?? 0,
      ]);
      listServiceInChart([listTopSellingService, listTopRevenueService]);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
    isLoading.refresh();
    print("===============");
  }
}

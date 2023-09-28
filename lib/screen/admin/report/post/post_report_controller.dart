import 'package:get/get.dart';
import 'package:gohomy/data/remote/response-request/report/report_post_find_room_res.dart';
import 'package:gohomy/data/remote/response-request/report/report_post_roommate_res.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/remote/response-request/report/report_post_badge_res.dart';
import '../../../../data/remote/response-request/report/report_post_res.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/chart_order.dart';
import '../../../../model/report_post_find_room.dart';
import '../order/option_report/chart_business.dart';

class PostReportController extends GetxController {
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
  var indexChartPostFindRoom = 0.obs;
  var indexChartPostRoommate = 0.obs;

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

  var reportPost = ReportPost().obs;
  var reportPostFindRoom = ReportStaticPostFindRoom().obs;
  var reportPostRoommate = ReportStaticPostRoommate().obs;

  PostReportController({
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
    getReportPost();
  }

  void changeTypeChart(int index) {
    indexChart.value = index;
  }

   void changeTypeChartPostFindRoom(int index) {
    indexChartPostFindRoom.value = index;
  }

    void changeTypeChartPostRoommate(int index) {
    indexChartPostRoommate.value = index;
  }

  void openAndCloseOrderDetail() {
    isOpenOrderDetail.value = !isOpenOrderDetail.value;
  }

  Future<void> getReportPost() async {
    isLoading.value = true;
    try {
      var res = await RepositoryManager.reportRepository.getReportPost(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );

      reportPost(res!.data!);

      getReportPostBadge();
      getReportPostFindRoom();
      getReportPostRoommate();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getReportPostFindRoom() async {
    
    try {
      var res = await RepositoryManager.reportRepository.getReportPostFindRoom(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );

      reportPostFindRoom(res!.data!);

    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }


  Future<void> getReportPostRoommate() async {
    
    try {
      var res = await RepositoryManager.reportRepository.getReportPostRoommate(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );

      reportPostRoommate(res!.data!);

    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  /// chart_Post

  var listTopPost = RxList<TopMoPost>();
  var listTopFavorite = RxList<TopMoPost>();

  var listNamePostTop = RxList<String>();
  var listPropertiesTop = RxList<double>();
  var listPostInChart = RxList<List<dynamic>>();
  var listChooseChartPost = RxList<bool>([true, false, false, false]);
  var indexTypeChart = 0.obs;

  List<String> listNameChartPost = [
    "Top lượt xem:",
    "Top yêu thích:",
  ];

  void changeChooseChartPostTop(int index) {
    listChooseChartPost([false, false, false, false]);
    listChooseChartPost[index] = true;
    listChooseChartPost.refresh();
    indexTypeChart.value = index;
  }

  Future<void> getReportPostBadge() async {
    try {
      var res = await RepositoryManager.reportRepository.getReportPostBadge(
        timeFrom: fromDay.value,
        timeTo: toDay.value,
      );
      listTopPost(res!.data!.topViewMoPost);
      listTopFavorite(res.data!.topFavoritesMoPost);

      listNamePostTop([
        listTopPost.isEmpty ? "" : listTopPost[0].moPost?.title ?? '',
        listTopFavorite.isEmpty ? "" : listTopFavorite[0].moPost?.title ?? "",
      ]);
      listPropertiesTop([
        listTopPost.isEmpty ? 0 : (listTopPost[0].quantity ?? 0).toDouble(),
        listTopFavorite.isEmpty
            ? 0
            : (listTopFavorite[0].quantity ?? 0).toDouble(),
      ]);
      listPostInChart([listTopPost, listTopFavorite]);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
    isLoading.refresh();
    print("===============");
  }
}
